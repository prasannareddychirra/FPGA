# build_project.tcl: Tcl script for creating template Vivado Projects
#
#*****************************************************************************************

#we assume that the script is being called from the repo root directory

#module parameters
set part xczu27dr-ffvg1517-1-e
set topModule block_design_wrapper

#set Project Name
if {$argc >= 1} {
	set proj [lindex $argv 0]
} else {
	set proj krm-4zurf
}

if {$argc >= 2} {
    set bdPostFix [lindex $argv 1]
} else {
    puts "Enter Memory amount per channel in GB \[ 4 \| 8 \]"
    set memAmount [gets stdin]
    if {$memAmount == "4"} {
        set bdPostFix "_4G"
    } elseif {$memAmount == "8"} {
        set bdPostFix "_8G"
    } else {
        puts "Invalid Value, exiting"
        exit
    }
}

#set specific project and output directory for the selected algorithm
set projDir ./prj

#set default ipCache and IP_REPO directories
set ipCacheDir ./ip_cache
set ipRepoDir ./ip_repo

#create directories if they don't exist yet
file mkdir $projDir
file mkdir $ipCacheDir
file mkdir $ipRepoDir

#clean project directory
set files [glob -nocomplain "$projDir/*"]
if {[llength $files] != 0} {
    puts "deleting contents of $projDir"
    file delete -force {*}[glob -directory $projDir *]; # clear folder contents
} else {
    puts "$projDir is empty"
}

create_project -part $part $proj $projDir
set_property "target_language" "VHDL" [get_project $proj]
set_property "simulator_language" "MIXED" [get_project $proj]
set_property "ip_cache_permissions" "read write" [get_project $proj]
set_property "ip_output_repo" "$projDir/../ip_cache" [get_project $proj]
set_property "xpm_libraries" "XPM_CDC XPM_FIFO XPM_MEMORY" [get_project $proj]

#set up IP Repo Location
set_property IP_REPO_PATHS $ipRepoDir [current_fileset]
update_ip_catalog

#add source files to Vivado project
if {[llength [glob -nocomplain ./src/hdl/*.vhd]] != 0} {
    add_files -fileset [get_fileset sources_1] [glob ./src/hdl/*.vhd]
}
if {[llength [glob -nocomplain ./src/hdl/*.v]] != 0} {
    add_files -fileset [get_fileset sources_1] [glob ./src/hdl/*.v]
}
if {[llength [glob -nocomplain ./src/hdl/*.sv]] != 0} {
    add_files -fileset [get_fileset sources_1] [glob ./src/hdl/*.sv]
}
if {[llength [glob -nocomplain ./src/xdc/*.xdc]] != 0} {
    add_files -fileset [get_fileset constrs_1] [glob -nocomplain ./src/xdc/*.xdc]
}

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]
set_property "target_constrs_file" "./src/xdc/user_constraints.xdc" $obj

#run block design creation
source ./src/bd/block_design${bdPostFix}.tcl
make_wrapper -files [get_files [get_bd_designs].bd] -top -import

# add microblaze firmware
add_files -norecurse ./src/data/rf_analyzer.elf
set_property SCOPED_TO_REF block_design [get_files -all -of_objects [get_fileset sources_1] {./src/data/rf_analyzer.elf}]
set_property SCOPED_TO_CELLS { microblaze_0 } [get_files -all -of_objects [get_fileset sources_1] {./src/data/rf_analyzer.elf}]


#set top level module and update compile order
set_property top $topModule [current_fileset]
update_compile_order

#generate output products
generate_target all [get_files block_design.bd]

#create ooc synthesis runs
create_ip_run [get_files -of_objects [get_fileset sources_1] block_design.bd]

#set synthesis options
set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]

#set implementation options
set_property strategy "Performance_Retiming" [get_runs impl_1]
set_property STEPS.PHYS_OPT_DESIGN.IS_ENABLED true [get_runs impl_1]

puts "INFO: Project created:${proj}"
exit

