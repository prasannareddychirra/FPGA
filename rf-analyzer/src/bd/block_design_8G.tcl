
################################################################
# This is a generated script based on design: block_design
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source block_design_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# exdes_rfadc_data_bram_capture, exdes_rfdac_data_bram_stim, mux_sel, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm, exdes_signal_lost_fsm

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu27dr-ffvg1517-1-e
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name block_design

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:jtag_axi:1.2\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:zynq_ultra_ps_e:3.3\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:usp_rf_data_converter:2.1\
xilinx.com:ip:axi_quad_spi:3.2\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:util_vector_logic:2.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
exdes_rfadc_data_bram_capture\
exdes_rfdac_data_bram_stim\
mux_sel\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
exdes_signal_lost_fsm\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: signal_detect
proc create_hier_cell_signal_detect { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_signal_detect() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 Res
  create_bd_pin -dir O -from 0 -to 0 Res1
  create_bd_pin -dir O -from 0 -to 0 Res2
  create_bd_pin -dir O -from 0 -to 0 Res3
  create_bd_pin -dir O -from 0 -to 0 Res4
  create_bd_pin -dir O -from 0 -to 0 Res5
  create_bd_pin -dir O -from 0 -to 0 Res6
  create_bd_pin -dir O -from 0 -to 0 Res7
  create_bd_pin -dir I -type clk adc_axis_aclk
  create_bd_pin -dir I -type clk adc_axis_aclk1
  create_bd_pin -dir I -type clk adc_axis_aclk2
  create_bd_pin -dir I -type clk adc_axis_aclk3
  create_bd_pin -dir I -type rst adc_axis_aresetn
  create_bd_pin -dir I -type rst adc_axis_aresetn1
  create_bd_pin -dir I -type rst adc_axis_aresetn2
  create_bd_pin -dir I -type rst adc_axis_aresetn3
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata1
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata2
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata3
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata4
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata5
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata6
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata7
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata8
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata9
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata10
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata11
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata12
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata13
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata14
  create_bd_pin -dir I -from 127 -to 0 adc_axis_tdata15
  create_bd_pin -dir I adc_axis_tvalid
  create_bd_pin -dir I adc_axis_tvalid1
  create_bd_pin -dir I adc_axis_tvalid2
  create_bd_pin -dir I adc_axis_tvalid3
  create_bd_pin -dir I adc_axis_tvalid4
  create_bd_pin -dir I adc_axis_tvalid5
  create_bd_pin -dir I adc_axis_tvalid6
  create_bd_pin -dir I adc_axis_tvalid7
  create_bd_pin -dir I adc_axis_tvalid8
  create_bd_pin -dir I adc_axis_tvalid9
  create_bd_pin -dir I adc_axis_tvalid10
  create_bd_pin -dir I adc_axis_tvalid11
  create_bd_pin -dir I adc_axis_tvalid12
  create_bd_pin -dir I adc_axis_tvalid13
  create_bd_pin -dir I adc_axis_tvalid14
  create_bd_pin -dir I adc_axis_tvalid15
  create_bd_pin -dir I -type clk s_axi_aclk

  # Create instance: signal_lost_fsm_adc00, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc00
  if { [catch {set signal_lost_fsm_adc00 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc00 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc00

  # Create instance: signal_lost_fsm_adc01, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc01
  if { [catch {set signal_lost_fsm_adc01 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc01 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc01

  # Create instance: signal_lost_fsm_adc02, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc02
  if { [catch {set signal_lost_fsm_adc02 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc02 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc02

  # Create instance: signal_lost_fsm_adc03, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc03
  if { [catch {set signal_lost_fsm_adc03 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc03 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc03

  # Create instance: signal_lost_fsm_adc10, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc10
  if { [catch {set signal_lost_fsm_adc10 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc10 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc10

  # Create instance: signal_lost_fsm_adc11, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc11
  if { [catch {set signal_lost_fsm_adc11 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc11 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc11

  # Create instance: signal_lost_fsm_adc12, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc12
  if { [catch {set signal_lost_fsm_adc12 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc12 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc12

  # Create instance: signal_lost_fsm_adc13, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc13
  if { [catch {set signal_lost_fsm_adc13 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc13 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc13

  # Create instance: signal_lost_fsm_adc20, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc20
  if { [catch {set signal_lost_fsm_adc20 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc20 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc20

  # Create instance: signal_lost_fsm_adc21, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc21
  if { [catch {set signal_lost_fsm_adc21 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc21 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc21

  # Create instance: signal_lost_fsm_adc22, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc22
  if { [catch {set signal_lost_fsm_adc22 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc22 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc22

  # Create instance: signal_lost_fsm_adc23, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc23
  if { [catch {set signal_lost_fsm_adc23 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc23 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc23

  # Create instance: signal_lost_fsm_adc30, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc30
  if { [catch {set signal_lost_fsm_adc30 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc30 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc30

  # Create instance: signal_lost_fsm_adc31, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc31
  if { [catch {set signal_lost_fsm_adc31 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc31 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc31

  # Create instance: signal_lost_fsm_adc32, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc32
  if { [catch {set signal_lost_fsm_adc32 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc32 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc32

  # Create instance: signal_lost_fsm_adc33, and set properties
  set block_name exdes_signal_lost_fsm
  set block_cell_name signal_lost_fsm_adc33
  if { [catch {set signal_lost_fsm_adc33 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $signal_lost_fsm_adc33 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.INPUT_WIDTH {128} \
 ] $signal_lost_fsm_adc33

  # Create instance: util_vector_logic_cal_freeze_0_01, and set properties
  set util_vector_logic_cal_freeze_0_01 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_0_01 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_0_01

  # Create instance: util_vector_logic_cal_freeze_0_23, and set properties
  set util_vector_logic_cal_freeze_0_23 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_0_23 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_0_23

  # Create instance: util_vector_logic_cal_freeze_1_01, and set properties
  set util_vector_logic_cal_freeze_1_01 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_1_01 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_1_01

  # Create instance: util_vector_logic_cal_freeze_1_23, and set properties
  set util_vector_logic_cal_freeze_1_23 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_1_23 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_1_23

  # Create instance: util_vector_logic_cal_freeze_2_01, and set properties
  set util_vector_logic_cal_freeze_2_01 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_2_01 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_2_01

  # Create instance: util_vector_logic_cal_freeze_2_23, and set properties
  set util_vector_logic_cal_freeze_2_23 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_2_23 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_2_23

  # Create instance: util_vector_logic_cal_freeze_3_01, and set properties
  set util_vector_logic_cal_freeze_3_01 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_3_01 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_3_01

  # Create instance: util_vector_logic_cal_freeze_3_23, and set properties
  set util_vector_logic_cal_freeze_3_23 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_cal_freeze_3_23 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $util_vector_logic_cal_freeze_3_23

  # Create port connections
  connect_bd_net -net Net [get_bd_pins adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc00/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc01/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc02/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc03/adc_axis_aclk]
  connect_bd_net -net Net6 [get_bd_pins adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc00/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc01/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc02/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc03/adc_axis_aresetn]
  connect_bd_net -net adc_axis_aclk1_1 [get_bd_pins adc_axis_aclk1] [get_bd_pins signal_lost_fsm_adc10/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc11/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc12/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc13/adc_axis_aclk]
  connect_bd_net -net adc_axis_aclk2_1 [get_bd_pins adc_axis_aclk2] [get_bd_pins signal_lost_fsm_adc20/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc21/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc22/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc23/adc_axis_aclk]
  connect_bd_net -net adc_axis_aclk3_1 [get_bd_pins adc_axis_aclk3] [get_bd_pins signal_lost_fsm_adc30/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc31/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc32/adc_axis_aclk] [get_bd_pins signal_lost_fsm_adc33/adc_axis_aclk]
  connect_bd_net -net adc_axis_aresetn1_1 [get_bd_pins adc_axis_aresetn1] [get_bd_pins signal_lost_fsm_adc10/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc11/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc12/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc13/adc_axis_aresetn]
  connect_bd_net -net adc_axis_aresetn2_1 [get_bd_pins adc_axis_aresetn2] [get_bd_pins signal_lost_fsm_adc20/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc21/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc22/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc23/adc_axis_aresetn]
  connect_bd_net -net adc_axis_aresetn3_1 [get_bd_pins adc_axis_aresetn3] [get_bd_pins signal_lost_fsm_adc30/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc31/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc32/adc_axis_aresetn] [get_bd_pins signal_lost_fsm_adc33/adc_axis_aresetn]
  connect_bd_net -net adc_axis_tdata10_1 [get_bd_pins adc_axis_tdata10] [get_bd_pins signal_lost_fsm_adc22/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata11_1 [get_bd_pins adc_axis_tdata11] [get_bd_pins signal_lost_fsm_adc23/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata12_1 [get_bd_pins adc_axis_tdata12] [get_bd_pins signal_lost_fsm_adc30/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata13_1 [get_bd_pins adc_axis_tdata13] [get_bd_pins signal_lost_fsm_adc31/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata14_1 [get_bd_pins adc_axis_tdata14] [get_bd_pins signal_lost_fsm_adc32/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata15_1 [get_bd_pins adc_axis_tdata15] [get_bd_pins signal_lost_fsm_adc33/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata1_1 [get_bd_pins adc_axis_tdata1] [get_bd_pins signal_lost_fsm_adc01/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata2_1 [get_bd_pins adc_axis_tdata2] [get_bd_pins signal_lost_fsm_adc02/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata3_1 [get_bd_pins adc_axis_tdata3] [get_bd_pins signal_lost_fsm_adc03/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata4_1 [get_bd_pins adc_axis_tdata4] [get_bd_pins signal_lost_fsm_adc10/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata5_1 [get_bd_pins adc_axis_tdata5] [get_bd_pins signal_lost_fsm_adc11/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata6_1 [get_bd_pins adc_axis_tdata6] [get_bd_pins signal_lost_fsm_adc12/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata7_1 [get_bd_pins adc_axis_tdata7] [get_bd_pins signal_lost_fsm_adc13/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata8_1 [get_bd_pins adc_axis_tdata8] [get_bd_pins signal_lost_fsm_adc20/adc_axis_tdata]
  connect_bd_net -net adc_axis_tdata9_1 [get_bd_pins adc_axis_tdata9] [get_bd_pins signal_lost_fsm_adc21/adc_axis_tdata]
  connect_bd_net -net adc_axis_tvalid10_1 [get_bd_pins adc_axis_tvalid10] [get_bd_pins signal_lost_fsm_adc22/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid11_1 [get_bd_pins adc_axis_tvalid11] [get_bd_pins signal_lost_fsm_adc23/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid12_1 [get_bd_pins adc_axis_tvalid12] [get_bd_pins signal_lost_fsm_adc30/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid13_1 [get_bd_pins adc_axis_tvalid13] [get_bd_pins signal_lost_fsm_adc31/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid14_1 [get_bd_pins adc_axis_tvalid14] [get_bd_pins signal_lost_fsm_adc32/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid15_1 [get_bd_pins adc_axis_tvalid15] [get_bd_pins signal_lost_fsm_adc33/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid1_1 [get_bd_pins adc_axis_tvalid1] [get_bd_pins signal_lost_fsm_adc01/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid2_1 [get_bd_pins adc_axis_tvalid2] [get_bd_pins signal_lost_fsm_adc02/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid3_1 [get_bd_pins adc_axis_tvalid3] [get_bd_pins signal_lost_fsm_adc03/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid4_1 [get_bd_pins adc_axis_tvalid4] [get_bd_pins signal_lost_fsm_adc10/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid5_1 [get_bd_pins adc_axis_tvalid5] [get_bd_pins signal_lost_fsm_adc11/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid6_1 [get_bd_pins adc_axis_tvalid6] [get_bd_pins signal_lost_fsm_adc12/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid7_1 [get_bd_pins adc_axis_tvalid7] [get_bd_pins signal_lost_fsm_adc13/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid8_1 [get_bd_pins adc_axis_tvalid8] [get_bd_pins signal_lost_fsm_adc20/adc_axis_tvalid]
  connect_bd_net -net adc_axis_tvalid9_1 [get_bd_pins adc_axis_tvalid9] [get_bd_pins signal_lost_fsm_adc21/adc_axis_tvalid]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins signal_lost_fsm_adc00/axi_clk] [get_bd_pins signal_lost_fsm_adc01/axi_clk] [get_bd_pins signal_lost_fsm_adc02/axi_clk] [get_bd_pins signal_lost_fsm_adc03/axi_clk] [get_bd_pins signal_lost_fsm_adc10/axi_clk] [get_bd_pins signal_lost_fsm_adc11/axi_clk] [get_bd_pins signal_lost_fsm_adc12/axi_clk] [get_bd_pins signal_lost_fsm_adc13/axi_clk] [get_bd_pins signal_lost_fsm_adc20/axi_clk] [get_bd_pins signal_lost_fsm_adc21/axi_clk] [get_bd_pins signal_lost_fsm_adc22/axi_clk] [get_bd_pins signal_lost_fsm_adc23/axi_clk] [get_bd_pins signal_lost_fsm_adc30/axi_clk] [get_bd_pins signal_lost_fsm_adc31/axi_clk] [get_bd_pins signal_lost_fsm_adc32/axi_clk] [get_bd_pins signal_lost_fsm_adc33/axi_clk]
  connect_bd_net -net signal_lost_fsm_adc00_signal_lost [get_bd_pins signal_lost_fsm_adc00/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_0_01/Op1]
  connect_bd_net -net signal_lost_fsm_adc01_signal_lost [get_bd_pins signal_lost_fsm_adc01/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_0_01/Op2]
  connect_bd_net -net signal_lost_fsm_adc02_signal_lost [get_bd_pins signal_lost_fsm_adc02/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_0_23/Op1]
  connect_bd_net -net signal_lost_fsm_adc03_signal_lost [get_bd_pins signal_lost_fsm_adc03/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_0_23/Op2]
  connect_bd_net -net signal_lost_fsm_adc10_signal_lost [get_bd_pins signal_lost_fsm_adc10/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_1_01/Op1]
  connect_bd_net -net signal_lost_fsm_adc11_signal_lost [get_bd_pins signal_lost_fsm_adc11/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_1_01/Op2]
  connect_bd_net -net signal_lost_fsm_adc12_signal_lost [get_bd_pins signal_lost_fsm_adc12/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_1_23/Op1]
  connect_bd_net -net signal_lost_fsm_adc13_signal_lost [get_bd_pins signal_lost_fsm_adc13/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_1_23/Op2]
  connect_bd_net -net signal_lost_fsm_adc20_signal_lost [get_bd_pins signal_lost_fsm_adc20/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_2_01/Op1]
  connect_bd_net -net signal_lost_fsm_adc21_signal_lost [get_bd_pins signal_lost_fsm_adc21/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_2_01/Op2]
  connect_bd_net -net signal_lost_fsm_adc22_signal_lost [get_bd_pins signal_lost_fsm_adc22/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_2_23/Op1]
  connect_bd_net -net signal_lost_fsm_adc23_signal_lost [get_bd_pins signal_lost_fsm_adc23/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_2_23/Op2]
  connect_bd_net -net signal_lost_fsm_adc30_signal_lost [get_bd_pins signal_lost_fsm_adc30/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_3_01/Op1]
  connect_bd_net -net signal_lost_fsm_adc31_signal_lost [get_bd_pins signal_lost_fsm_adc31/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_3_01/Op2]
  connect_bd_net -net signal_lost_fsm_adc32_signal_lost [get_bd_pins signal_lost_fsm_adc32/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_3_23/Op1]
  connect_bd_net -net signal_lost_fsm_adc33_signal_lost [get_bd_pins signal_lost_fsm_adc33/signal_lost] [get_bd_pins util_vector_logic_cal_freeze_3_23/Op2]
  connect_bd_net -net usp_rf_data_converter_0_m00_axis_tdata [get_bd_pins adc_axis_tdata] [get_bd_pins signal_lost_fsm_adc00/adc_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m00_axis_tvalid [get_bd_pins adc_axis_tvalid] [get_bd_pins signal_lost_fsm_adc00/adc_axis_tvalid]
  connect_bd_net -net util_vector_logic_cal_freeze_0_01_Res [get_bd_pins Res] [get_bd_pins util_vector_logic_cal_freeze_0_01/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_0_23_Res [get_bd_pins Res1] [get_bd_pins util_vector_logic_cal_freeze_0_23/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_1_01_Res [get_bd_pins Res2] [get_bd_pins util_vector_logic_cal_freeze_1_01/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_1_23_Res [get_bd_pins Res3] [get_bd_pins util_vector_logic_cal_freeze_1_23/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_2_01_Res [get_bd_pins Res4] [get_bd_pins util_vector_logic_cal_freeze_2_01/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_2_23_Res [get_bd_pins Res5] [get_bd_pins util_vector_logic_cal_freeze_2_23/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_3_01_Res [get_bd_pins Res6] [get_bd_pins util_vector_logic_cal_freeze_3_01/Res]
  connect_bd_net -net util_vector_logic_cal_freeze_3_23_Res [get_bd_pins Res7] [get_bd_pins util_vector_logic_cal_freeze_3_23/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type rst SYS_Rst
  create_bd_pin -dir I -type clk s_axi_aclk

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: lmx2594
proc create_hier_cell_lmx2594 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_lmx2594() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 AXI_LITE


  # Create pins
  create_bd_pin -dir O -type intr ip2intc_irpt
  create_bd_pin -dir O -from 2 -to 0 lmx2594_spi_cs_n
  create_bd_pin -dir I -from 2 -to 0 lmx2594_spi_miso
  create_bd_pin -dir O lmx2594_spi_mosi
  create_bd_pin -dir O lmx2594_spi_sck
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: mux_miso, and set properties
  set block_name mux_sel
  set block_cell_name mux_miso
  if { [catch {set mux_miso [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mux_miso eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.N {3} \
 ] $mux_miso

  # Create instance: spi, and set properties
  set spi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 spi ]
  set_property -dict [ list \
   CONFIG.C_NUM_SS_BITS {3} \
 ] $spi

  # Create interface connections
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins AXI_LITE] [get_bd_intf_pins spi/AXI_LITE]

  # Create port connections
  connect_bd_net -net axi_quad_spi_0_io0_o [get_bd_pins lmx2594_spi_mosi] [get_bd_pins spi/io0_o]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt [get_bd_pins ip2intc_irpt] [get_bd_pins spi/ip2intc_irpt]
  connect_bd_net -net axi_quad_spi_0_sck_o [get_bd_pins lmx2594_spi_sck] [get_bd_pins spi/sck_o]
  connect_bd_net -net axi_quad_spi_0_ss_o [get_bd_pins lmx2594_spi_cs_n] [get_bd_pins mux_miso/cs_n] [get_bd_pins spi/ss_o]
  connect_bd_net -net lmx2594_spi_miso_1 [get_bd_pins lmx2594_spi_miso] [get_bd_pins mux_miso/I]
  connect_bd_net -net mux_sel_0_O [get_bd_pins mux_miso/O] [get_bd_pins spi/io1_i]
  connect_bd_net -net rst_ps8_0_99M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins spi/s_axi_aresetn]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins s_axi_aclk] [get_bd_pins spi/ext_spi_clk] [get_bd_pins spi/s_axi_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: lmk04208
proc create_hier_cell_lmk04208 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_lmk04208() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 AXI_LITE


  # Create pins
  create_bd_pin -dir O -type intr ip2intc_irpt
  create_bd_pin -dir O -from 0 -to 0 lmk04208_spi_cs_n
  create_bd_pin -dir I lmk04208_spi_miso
  create_bd_pin -dir O lmk04208_spi_mosi
  create_bd_pin -dir O lmk04208_spi_sck
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: spi, and set properties
  set spi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 spi ]
  set_property -dict [ list \
   CONFIG.C_NUM_SS_BITS {1} \
 ] $spi

  # Create interface connections
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins AXI_LITE] [get_bd_intf_pins spi/AXI_LITE]

  # Create port connections
  connect_bd_net -net axi_quad_spi_0_io0_o [get_bd_pins lmk04208_spi_mosi] [get_bd_pins spi/io0_o]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt [get_bd_pins ip2intc_irpt] [get_bd_pins spi/ip2intc_irpt]
  connect_bd_net -net axi_quad_spi_0_sck_o [get_bd_pins lmk04208_spi_sck] [get_bd_pins spi/sck_o]
  connect_bd_net -net lmk04208_spi_miso_1 [get_bd_pins lmk04208_spi_miso] [get_bd_pins spi/io1_i]
  connect_bd_net -net rst_ps8_0_99M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins spi/s_axi_aresetn]
  connect_bd_net -net spi_ss_o [get_bd_pins lmk04208_spi_cs_n] [get_bd_pins spi/ss_o]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins s_axi_aclk] [get_bd_pins spi/ext_spi_clk] [get_bd_pins spi/s_axi_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ex_design
proc create_hier_cell_ex_design { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_ex_design() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M07_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S01_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc0_clk

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc1_clk

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc2_clk

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc3_clk

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dac0_clk

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dac1_clk

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m00_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m01_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m02_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m03_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m10_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m11_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m12_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m13_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m20_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m21_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m22_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m23_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m30_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m31_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m32_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m33_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s00_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s01_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s02_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s03_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s10_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s11_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s12_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s13_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_usp_rf_data_converter:diff_pins_rtl:1.0 sysref_in

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin0_01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin0_23

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin1_01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin1_23

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin2_01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin2_23

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin3_01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin3_23

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout02

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout03

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout10

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout11

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout12

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout13


  # Create pins
  create_bd_pin -dir O -type clk clk_adc0
  create_bd_pin -dir O -type clk clk_adc1
  create_bd_pin -dir O -type clk clk_adc2
  create_bd_pin -dir O -type clk clk_adc3
  create_bd_pin -dir O -type clk clk_dac0
  create_bd_pin -dir O -type clk clk_dac1
  create_bd_pin -dir I -type clk m0_axis_aclk
  create_bd_pin -dir I -type rst m0_axis_aresetn
  create_bd_pin -dir I -type clk m1_axis_aclk
  create_bd_pin -dir I -type rst m1_axis_aresetn
  create_bd_pin -dir I -type clk m2_axis_aclk
  create_bd_pin -dir I -type rst m2_axis_aresetn
  create_bd_pin -dir I -type clk m3_axis_aclk
  create_bd_pin -dir I -type rst m3_axis_aresetn
  create_bd_pin -dir I -type clk s0_axis_aclk
  create_bd_pin -dir I -type rst s0_axis_aresetn
  create_bd_pin -dir I -type clk s1_axis_aclk
  create_bd_pin -dir I -type rst s1_axis_aresetn
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn
  create_bd_pin -dir I user_select_00_0
  create_bd_pin -dir I user_select_01_0
  create_bd_pin -dir I user_select_02_0
  create_bd_pin -dir I user_select_03_0
  create_bd_pin -dir I user_select_10_0
  create_bd_pin -dir I user_select_11_0
  create_bd_pin -dir I user_select_12_0
  create_bd_pin -dir I user_select_13_0

  # Create instance: adc_sink_i, and set properties
  set block_name exdes_rfadc_data_bram_capture
  set block_cell_name adc_sink_i
  if { [catch {set adc_sink_i [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $adc_sink_i eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.axi_addr_top {19} \
   CONFIG.mem_size {262144} \
   CONFIG.use_div2_clk_0 {0} \
   CONFIG.use_div2_clk_1 {0} \
   CONFIG.use_div2_clk_2 {0} \
   CONFIG.use_div2_clk_3 {0} \
 ] $adc_sink_i

  set_property -dict [ list \
   CONFIG.CLK_DOMAIN {block_design_zynq_ultra_ps_e_0_0_pl_clk0} \
 ] [get_bd_pins /ex_design/adc_sink_i/s_axi_aclk]

  # Create instance: dac_source_i, and set properties
  set block_name exdes_rfdac_data_bram_stim
  set block_cell_name dac_source_i
  if { [catch {set dac_source_i [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $dac_source_i eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.axi_addr_top {18} \
   CONFIG.mem_size {262144} \
 ] $dac_source_i

  set_property -dict [ list \
   CONFIG.CLK_DOMAIN {block_design_zynq_ultra_ps_e_0_0_pl_clk0} \
 ] [get_bd_pins /ex_design/dac_source_i/s_axi_aclk]

  # Create instance: signal_detect
  create_hier_cell_signal_detect $hier_obj signal_detect

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {10} \
   CONFIG.NUM_SI {2} \
 ] $smartconnect_0

  # Create instance: usp_rf_data_converter_0, and set properties
  set usp_rf_data_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:usp_rf_data_converter:2.1 usp_rf_data_converter_0 ]
  set_property -dict [ list \
   CONFIG.ADC0_Band {0} \
   CONFIG.ADC0_Clock_Dist {0} \
   CONFIG.ADC0_Clock_Source {0} \
   CONFIG.ADC0_Enable {1} \
   CONFIG.ADC0_Fabric_Freq {512.000} \
   CONFIG.ADC0_Link_Coupling {0} \
   CONFIG.ADC0_Multi_Tile_Sync {false} \
   CONFIG.ADC0_Outclk_Freq {256.000} \
   CONFIG.ADC0_Outdiv {3} \
   CONFIG.ADC0_PLL_Enable {true} \
   CONFIG.ADC0_Refclk_Div {1} \
   CONFIG.ADC0_Refclk_Freq {409.600} \
   CONFIG.ADC0_Sampling_Rate {4.096} \
   CONFIG.ADC1_Band {0} \
   CONFIG.ADC1_Clock_Dist {0} \
   CONFIG.ADC1_Clock_Source {1} \
   CONFIG.ADC1_Enable {1} \
   CONFIG.ADC1_Fabric_Freq {512.000} \
   CONFIG.ADC1_Link_Coupling {0} \
   CONFIG.ADC1_Multi_Tile_Sync {false} \
   CONFIG.ADC1_Outclk_Freq {256.000} \
   CONFIG.ADC1_Outdiv {3} \
   CONFIG.ADC1_PLL_Enable {true} \
   CONFIG.ADC1_Refclk_Div {1} \
   CONFIG.ADC1_Refclk_Freq {409.600} \
   CONFIG.ADC1_Sampling_Rate {4.096} \
   CONFIG.ADC224_En {false} \
   CONFIG.ADC225_En {false} \
   CONFIG.ADC226_En {false} \
   CONFIG.ADC227_En {false} \
   CONFIG.ADC2_Band {0} \
   CONFIG.ADC2_Clock_Dist {0} \
   CONFIG.ADC2_Clock_Source {2} \
   CONFIG.ADC2_Enable {1} \
   CONFIG.ADC2_Fabric_Freq {512.000} \
   CONFIG.ADC2_Link_Coupling {0} \
   CONFIG.ADC2_Multi_Tile_Sync {false} \
   CONFIG.ADC2_Outclk_Freq {256.000} \
   CONFIG.ADC2_Outdiv {3} \
   CONFIG.ADC2_PLL_Enable {true} \
   CONFIG.ADC2_Refclk_Div {1} \
   CONFIG.ADC2_Refclk_Freq {409.600} \
   CONFIG.ADC2_Sampling_Rate {4.096} \
   CONFIG.ADC3_Band {0} \
   CONFIG.ADC3_Clock_Dist {0} \
   CONFIG.ADC3_Clock_Source {3} \
   CONFIG.ADC3_Enable {1} \
   CONFIG.ADC3_Fabric_Freq {512.000} \
   CONFIG.ADC3_Link_Coupling {0} \
   CONFIG.ADC3_Multi_Tile_Sync {false} \
   CONFIG.ADC3_Outclk_Freq {256.000} \
   CONFIG.ADC3_Outdiv {3} \
   CONFIG.ADC3_PLL_Enable {true} \
   CONFIG.ADC3_Refclk_Div {1} \
   CONFIG.ADC3_Refclk_Freq {409.600} \
   CONFIG.ADC3_Sampling_Rate {4.096} \
   CONFIG.ADC_Bypass_BG_Cal00 {false} \
   CONFIG.ADC_Bypass_BG_Cal01 {false} \
   CONFIG.ADC_Bypass_BG_Cal02 {false} \
   CONFIG.ADC_Bypass_BG_Cal03 {false} \
   CONFIG.ADC_Bypass_BG_Cal10 {false} \
   CONFIG.ADC_Bypass_BG_Cal11 {false} \
   CONFIG.ADC_Bypass_BG_Cal12 {false} \
   CONFIG.ADC_Bypass_BG_Cal13 {false} \
   CONFIG.ADC_Bypass_BG_Cal20 {false} \
   CONFIG.ADC_Bypass_BG_Cal21 {false} \
   CONFIG.ADC_Bypass_BG_Cal22 {false} \
   CONFIG.ADC_Bypass_BG_Cal23 {false} \
   CONFIG.ADC_Bypass_BG_Cal30 {false} \
   CONFIG.ADC_Bypass_BG_Cal31 {false} \
   CONFIG.ADC_Bypass_BG_Cal32 {false} \
   CONFIG.ADC_Bypass_BG_Cal33 {false} \
   CONFIG.ADC_CalOpt_Mode00 {1} \
   CONFIG.ADC_CalOpt_Mode01 {1} \
   CONFIG.ADC_CalOpt_Mode02 {1} \
   CONFIG.ADC_CalOpt_Mode03 {1} \
   CONFIG.ADC_CalOpt_Mode10 {1} \
   CONFIG.ADC_CalOpt_Mode11 {1} \
   CONFIG.ADC_CalOpt_Mode12 {1} \
   CONFIG.ADC_CalOpt_Mode13 {1} \
   CONFIG.ADC_CalOpt_Mode20 {1} \
   CONFIG.ADC_CalOpt_Mode21 {1} \
   CONFIG.ADC_CalOpt_Mode22 {1} \
   CONFIG.ADC_CalOpt_Mode23 {1} \
   CONFIG.ADC_CalOpt_Mode30 {1} \
   CONFIG.ADC_CalOpt_Mode31 {1} \
   CONFIG.ADC_CalOpt_Mode32 {1} \
   CONFIG.ADC_CalOpt_Mode33 {1} \
   CONFIG.ADC_Coarse_Mixer_Freq00 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq01 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq02 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq03 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq10 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq11 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq12 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq13 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq20 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq21 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq22 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq23 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq30 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq31 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq32 {0} \
   CONFIG.ADC_Coarse_Mixer_Freq33 {0} \
   CONFIG.ADC_Data_Type00 {1} \
   CONFIG.ADC_Data_Type01 {1} \
   CONFIG.ADC_Data_Type02 {1} \
   CONFIG.ADC_Data_Type03 {1} \
   CONFIG.ADC_Data_Type10 {1} \
   CONFIG.ADC_Data_Type11 {1} \
   CONFIG.ADC_Data_Type12 {1} \
   CONFIG.ADC_Data_Type13 {1} \
   CONFIG.ADC_Data_Type20 {1} \
   CONFIG.ADC_Data_Type21 {1} \
   CONFIG.ADC_Data_Type22 {1} \
   CONFIG.ADC_Data_Type23 {1} \
   CONFIG.ADC_Data_Type30 {1} \
   CONFIG.ADC_Data_Type31 {1} \
   CONFIG.ADC_Data_Type32 {1} \
   CONFIG.ADC_Data_Type33 {1} \
   CONFIG.ADC_Data_Width00 {8} \
   CONFIG.ADC_Data_Width01 {8} \
   CONFIG.ADC_Data_Width02 {8} \
   CONFIG.ADC_Data_Width03 {8} \
   CONFIG.ADC_Data_Width10 {8} \
   CONFIG.ADC_Data_Width11 {8} \
   CONFIG.ADC_Data_Width12 {8} \
   CONFIG.ADC_Data_Width13 {8} \
   CONFIG.ADC_Data_Width20 {8} \
   CONFIG.ADC_Data_Width21 {8} \
   CONFIG.ADC_Data_Width22 {8} \
   CONFIG.ADC_Data_Width23 {8} \
   CONFIG.ADC_Data_Width30 {8} \
   CONFIG.ADC_Data_Width31 {8} \
   CONFIG.ADC_Data_Width32 {8} \
   CONFIG.ADC_Data_Width33 {8} \
   CONFIG.ADC_Debug {false} \
   CONFIG.ADC_Decimation_Mode00 {1} \
   CONFIG.ADC_Decimation_Mode01 {1} \
   CONFIG.ADC_Decimation_Mode02 {1} \
   CONFIG.ADC_Decimation_Mode03 {1} \
   CONFIG.ADC_Decimation_Mode10 {1} \
   CONFIG.ADC_Decimation_Mode11 {1} \
   CONFIG.ADC_Decimation_Mode12 {1} \
   CONFIG.ADC_Decimation_Mode13 {1} \
   CONFIG.ADC_Decimation_Mode20 {1} \
   CONFIG.ADC_Decimation_Mode21 {1} \
   CONFIG.ADC_Decimation_Mode22 {1} \
   CONFIG.ADC_Decimation_Mode23 {1} \
   CONFIG.ADC_Decimation_Mode30 {1} \
   CONFIG.ADC_Decimation_Mode31 {1} \
   CONFIG.ADC_Decimation_Mode32 {1} \
   CONFIG.ADC_Decimation_Mode33 {1} \
   CONFIG.ADC_Dither00 {true} \
   CONFIG.ADC_Dither01 {true} \
   CONFIG.ADC_Dither02 {true} \
   CONFIG.ADC_Dither03 {true} \
   CONFIG.ADC_Dither10 {true} \
   CONFIG.ADC_Dither11 {true} \
   CONFIG.ADC_Dither12 {true} \
   CONFIG.ADC_Dither13 {true} \
   CONFIG.ADC_Dither20 {true} \
   CONFIG.ADC_Dither21 {true} \
   CONFIG.ADC_Dither22 {true} \
   CONFIG.ADC_Dither23 {true} \
   CONFIG.ADC_Dither30 {true} \
   CONFIG.ADC_Dither31 {true} \
   CONFIG.ADC_Dither32 {true} \
   CONFIG.ADC_Dither33 {true} \
   CONFIG.ADC_LM00 {0} \
   CONFIG.ADC_LM01 {0} \
   CONFIG.ADC_LM02 {0} \
   CONFIG.ADC_LM03 {0} \
   CONFIG.ADC_LM10 {0} \
   CONFIG.ADC_LM11 {0} \
   CONFIG.ADC_LM12 {0} \
   CONFIG.ADC_LM13 {0} \
   CONFIG.ADC_LM20 {0} \
   CONFIG.ADC_LM21 {0} \
   CONFIG.ADC_LM22 {0} \
   CONFIG.ADC_LM23 {0} \
   CONFIG.ADC_LM30 {0} \
   CONFIG.ADC_LM31 {0} \
   CONFIG.ADC_LM32 {0} \
   CONFIG.ADC_LM33 {0} \
   CONFIG.ADC_Mixer_Mode00 {0} \
   CONFIG.ADC_Mixer_Mode01 {0} \
   CONFIG.ADC_Mixer_Mode02 {0} \
   CONFIG.ADC_Mixer_Mode03 {0} \
   CONFIG.ADC_Mixer_Mode10 {0} \
   CONFIG.ADC_Mixer_Mode11 {0} \
   CONFIG.ADC_Mixer_Mode12 {0} \
   CONFIG.ADC_Mixer_Mode13 {0} \
   CONFIG.ADC_Mixer_Mode20 {0} \
   CONFIG.ADC_Mixer_Mode21 {0} \
   CONFIG.ADC_Mixer_Mode22 {0} \
   CONFIG.ADC_Mixer_Mode23 {0} \
   CONFIG.ADC_Mixer_Mode30 {0} \
   CONFIG.ADC_Mixer_Mode31 {0} \
   CONFIG.ADC_Mixer_Mode32 {0} \
   CONFIG.ADC_Mixer_Mode33 {0} \
   CONFIG.ADC_Mixer_Type00 {2} \
   CONFIG.ADC_Mixer_Type01 {2} \
   CONFIG.ADC_Mixer_Type02 {2} \
   CONFIG.ADC_Mixer_Type03 {2} \
   CONFIG.ADC_Mixer_Type10 {2} \
   CONFIG.ADC_Mixer_Type11 {2} \
   CONFIG.ADC_Mixer_Type12 {2} \
   CONFIG.ADC_Mixer_Type13 {2} \
   CONFIG.ADC_Mixer_Type20 {2} \
   CONFIG.ADC_Mixer_Type21 {2} \
   CONFIG.ADC_Mixer_Type22 {2} \
   CONFIG.ADC_Mixer_Type23 {2} \
   CONFIG.ADC_Mixer_Type30 {2} \
   CONFIG.ADC_Mixer_Type31 {2} \
   CONFIG.ADC_Mixer_Type32 {2} \
   CONFIG.ADC_Mixer_Type33 {2} \
   CONFIG.ADC_NCO_Freq00 {0.0} \
   CONFIG.ADC_NCO_Freq01 {0.0} \
   CONFIG.ADC_NCO_Freq02 {0} \
   CONFIG.ADC_NCO_Freq03 {0} \
   CONFIG.ADC_NCO_Freq10 {0.0} \
   CONFIG.ADC_NCO_Freq11 {0.0} \
   CONFIG.ADC_NCO_Freq12 {0} \
   CONFIG.ADC_NCO_Freq13 {0} \
   CONFIG.ADC_NCO_Freq20 {0.0} \
   CONFIG.ADC_NCO_Freq21 {0.0} \
   CONFIG.ADC_NCO_Freq22 {0} \
   CONFIG.ADC_NCO_Freq23 {0} \
   CONFIG.ADC_NCO_Freq30 {0.0} \
   CONFIG.ADC_NCO_Freq31 {0.0} \
   CONFIG.ADC_NCO_Freq32 {0} \
   CONFIG.ADC_NCO_Freq33 {0} \
   CONFIG.ADC_NCO_Phase00 {0} \
   CONFIG.ADC_NCO_Phase01 {0} \
   CONFIG.ADC_NCO_Phase02 {0} \
   CONFIG.ADC_NCO_Phase03 {0} \
   CONFIG.ADC_NCO_Phase10 {0} \
   CONFIG.ADC_NCO_Phase11 {0} \
   CONFIG.ADC_NCO_Phase12 {0} \
   CONFIG.ADC_NCO_Phase13 {0} \
   CONFIG.ADC_NCO_Phase20 {0} \
   CONFIG.ADC_NCO_Phase21 {0} \
   CONFIG.ADC_NCO_Phase22 {0} \
   CONFIG.ADC_NCO_Phase23 {0} \
   CONFIG.ADC_NCO_Phase30 {0} \
   CONFIG.ADC_NCO_Phase31 {0} \
   CONFIG.ADC_NCO_Phase32 {0} \
   CONFIG.ADC_NCO_Phase33 {0} \
   CONFIG.ADC_NCO_RTS {false} \
   CONFIG.ADC_Neg_Quadrature00 {false} \
   CONFIG.ADC_Neg_Quadrature01 {false} \
   CONFIG.ADC_Neg_Quadrature02 {false} \
   CONFIG.ADC_Neg_Quadrature03 {false} \
   CONFIG.ADC_Neg_Quadrature10 {false} \
   CONFIG.ADC_Neg_Quadrature11 {false} \
   CONFIG.ADC_Neg_Quadrature12 {false} \
   CONFIG.ADC_Neg_Quadrature13 {false} \
   CONFIG.ADC_Neg_Quadrature20 {false} \
   CONFIG.ADC_Neg_Quadrature21 {false} \
   CONFIG.ADC_Neg_Quadrature22 {false} \
   CONFIG.ADC_Neg_Quadrature23 {false} \
   CONFIG.ADC_Neg_Quadrature30 {false} \
   CONFIG.ADC_Neg_Quadrature31 {false} \
   CONFIG.ADC_Neg_Quadrature32 {false} \
   CONFIG.ADC_Neg_Quadrature33 {false} \
   CONFIG.ADC_Nyquist00 {0} \
   CONFIG.ADC_Nyquist01 {0} \
   CONFIG.ADC_Nyquist02 {0} \
   CONFIG.ADC_Nyquist03 {0} \
   CONFIG.ADC_Nyquist10 {0} \
   CONFIG.ADC_Nyquist11 {0} \
   CONFIG.ADC_Nyquist12 {0} \
   CONFIG.ADC_Nyquist13 {0} \
   CONFIG.ADC_Nyquist20 {0} \
   CONFIG.ADC_Nyquist21 {0} \
   CONFIG.ADC_Nyquist22 {0} \
   CONFIG.ADC_Nyquist23 {0} \
   CONFIG.ADC_Nyquist30 {0} \
   CONFIG.ADC_Nyquist31 {0} \
   CONFIG.ADC_Nyquist32 {0} \
   CONFIG.ADC_Nyquist33 {0} \
   CONFIG.ADC_RTS {false} \
   CONFIG.ADC_Slice00_Enable {true} \
   CONFIG.ADC_Slice01_Enable {true} \
   CONFIG.ADC_Slice02_Enable {true} \
   CONFIG.ADC_Slice03_Enable {true} \
   CONFIG.ADC_Slice10_Enable {true} \
   CONFIG.ADC_Slice11_Enable {true} \
   CONFIG.ADC_Slice12_Enable {true} \
   CONFIG.ADC_Slice13_Enable {true} \
   CONFIG.ADC_Slice20_Enable {true} \
   CONFIG.ADC_Slice21_Enable {true} \
   CONFIG.ADC_Slice22_Enable {true} \
   CONFIG.ADC_Slice23_Enable {true} \
   CONFIG.ADC_Slice30_Enable {true} \
   CONFIG.ADC_Slice31_Enable {true} \
   CONFIG.ADC_Slice32_Enable {true} \
   CONFIG.ADC_Slice33_Enable {true} \
   CONFIG.AMS_Factory_Var {0} \
   CONFIG.Analog_Detection {1} \
   CONFIG.Auto_Calibration_Freeze {false} \
   CONFIG.Axiclk_Freq {57.5} \
   CONFIG.Calibration_Freeze {true} \
   CONFIG.Calibration_Time {10} \
   CONFIG.Clock_Forwarding {false} \
   CONFIG.Converter_Setup {1} \
   CONFIG.DAC0_Band {0} \
   CONFIG.DAC0_Clock_Dist {0} \
   CONFIG.DAC0_Clock_Source {4} \
   CONFIG.DAC0_Enable {1} \
   CONFIG.DAC0_Fabric_Freq {409.625} \
   CONFIG.DAC0_Multi_Tile_Sync {false} \
   CONFIG.DAC0_Outclk_Freq {409.625} \
   CONFIG.DAC0_Outdiv {2} \
   CONFIG.DAC0_PLL_Enable {true} \
   CONFIG.DAC0_Refclk_Div {1} \
   CONFIG.DAC0_Refclk_Freq {409.625} \
   CONFIG.DAC0_Sampling_Rate {6.554} \
   CONFIG.DAC1_Band {0} \
   CONFIG.DAC1_Clock_Dist {0} \
   CONFIG.DAC1_Clock_Source {5} \
   CONFIG.DAC1_Enable {1} \
   CONFIG.DAC1_Fabric_Freq {409.625} \
   CONFIG.DAC1_Multi_Tile_Sync {false} \
   CONFIG.DAC1_Outclk_Freq {409.625} \
   CONFIG.DAC1_Outdiv {2} \
   CONFIG.DAC1_PLL_Enable {true} \
   CONFIG.DAC1_Refclk_Div {1} \
   CONFIG.DAC1_Refclk_Freq {409.625} \
   CONFIG.DAC1_Sampling_Rate {6.554} \
   CONFIG.DAC228_En {false} \
   CONFIG.DAC229_En {false} \
   CONFIG.DAC230_En {false} \
   CONFIG.DAC231_En {false} \
   CONFIG.DAC2_Band {0} \
   CONFIG.DAC2_Clock_Dist {0} \
   CONFIG.DAC2_Clock_Source {6} \
   CONFIG.DAC2_Enable {0} \
   CONFIG.DAC2_Fabric_Freq {0.0} \
   CONFIG.DAC2_Multi_Tile_Sync {false} \
   CONFIG.DAC2_Outclk_Freq {50.000} \
   CONFIG.DAC2_Outdiv {2} \
   CONFIG.DAC2_PLL_Enable {false} \
   CONFIG.DAC2_Refclk_Div {1} \
   CONFIG.DAC2_Refclk_Freq {6400.000} \
   CONFIG.DAC2_Sampling_Rate {6.4} \
   CONFIG.DAC3_Band {0} \
   CONFIG.DAC3_Clock_Dist {0} \
   CONFIG.DAC3_Clock_Source {7} \
   CONFIG.DAC3_Enable {0} \
   CONFIG.DAC3_Fabric_Freq {0.0} \
   CONFIG.DAC3_Multi_Tile_Sync {false} \
   CONFIG.DAC3_Outclk_Freq {50.000} \
   CONFIG.DAC3_Outdiv {2} \
   CONFIG.DAC3_PLL_Enable {false} \
   CONFIG.DAC3_Refclk_Div {1} \
   CONFIG.DAC3_Refclk_Freq {6400.000} \
   CONFIG.DAC3_Sampling_Rate {6.4} \
   CONFIG.DAC_Coarse_Mixer_Freq00 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq01 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq02 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq03 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq10 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq11 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq12 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq13 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq20 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq21 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq22 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq23 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq30 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq31 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq32 {0} \
   CONFIG.DAC_Coarse_Mixer_Freq33 {0} \
   CONFIG.DAC_Data_Type00 {0} \
   CONFIG.DAC_Data_Type01 {0} \
   CONFIG.DAC_Data_Type02 {0} \
   CONFIG.DAC_Data_Type03 {0} \
   CONFIG.DAC_Data_Type10 {0} \
   CONFIG.DAC_Data_Type11 {0} \
   CONFIG.DAC_Data_Type12 {0} \
   CONFIG.DAC_Data_Type13 {0} \
   CONFIG.DAC_Data_Type20 {0} \
   CONFIG.DAC_Data_Type21 {0} \
   CONFIG.DAC_Data_Type22 {0} \
   CONFIG.DAC_Data_Type23 {0} \
   CONFIG.DAC_Data_Type30 {0} \
   CONFIG.DAC_Data_Type31 {0} \
   CONFIG.DAC_Data_Type32 {0} \
   CONFIG.DAC_Data_Type33 {0} \
   CONFIG.DAC_Data_Width00 {16} \
   CONFIG.DAC_Data_Width01 {16} \
   CONFIG.DAC_Data_Width02 {16} \
   CONFIG.DAC_Data_Width03 {16} \
   CONFIG.DAC_Data_Width10 {16} \
   CONFIG.DAC_Data_Width11 {16} \
   CONFIG.DAC_Data_Width12 {16} \
   CONFIG.DAC_Data_Width13 {16} \
   CONFIG.DAC_Data_Width20 {16} \
   CONFIG.DAC_Data_Width21 {16} \
   CONFIG.DAC_Data_Width22 {16} \
   CONFIG.DAC_Data_Width23 {16} \
   CONFIG.DAC_Data_Width30 {16} \
   CONFIG.DAC_Data_Width31 {16} \
   CONFIG.DAC_Data_Width32 {16} \
   CONFIG.DAC_Data_Width33 {16} \
   CONFIG.DAC_Debug {false} \
   CONFIG.DAC_Decoder_Mode00 {0} \
   CONFIG.DAC_Decoder_Mode01 {0} \
   CONFIG.DAC_Decoder_Mode02 {0} \
   CONFIG.DAC_Decoder_Mode03 {0} \
   CONFIG.DAC_Decoder_Mode10 {0} \
   CONFIG.DAC_Decoder_Mode11 {0} \
   CONFIG.DAC_Decoder_Mode12 {0} \
   CONFIG.DAC_Decoder_Mode13 {0} \
   CONFIG.DAC_Decoder_Mode20 {0} \
   CONFIG.DAC_Decoder_Mode21 {0} \
   CONFIG.DAC_Decoder_Mode22 {0} \
   CONFIG.DAC_Decoder_Mode23 {0} \
   CONFIG.DAC_Decoder_Mode30 {0} \
   CONFIG.DAC_Decoder_Mode31 {0} \
   CONFIG.DAC_Decoder_Mode32 {0} \
   CONFIG.DAC_Decoder_Mode33 {0} \
   CONFIG.DAC_Interpolation_Mode00 {1} \
   CONFIG.DAC_Interpolation_Mode01 {1} \
   CONFIG.DAC_Interpolation_Mode02 {1} \
   CONFIG.DAC_Interpolation_Mode03 {1} \
   CONFIG.DAC_Interpolation_Mode10 {1} \
   CONFIG.DAC_Interpolation_Mode11 {1} \
   CONFIG.DAC_Interpolation_Mode12 {1} \
   CONFIG.DAC_Interpolation_Mode13 {1} \
   CONFIG.DAC_Interpolation_Mode20 {0} \
   CONFIG.DAC_Interpolation_Mode21 {0} \
   CONFIG.DAC_Interpolation_Mode22 {0} \
   CONFIG.DAC_Interpolation_Mode23 {0} \
   CONFIG.DAC_Interpolation_Mode30 {0} \
   CONFIG.DAC_Interpolation_Mode31 {0} \
   CONFIG.DAC_Interpolation_Mode32 {0} \
   CONFIG.DAC_Interpolation_Mode33 {0} \
   CONFIG.DAC_Invsinc_Ctrl00 {false} \
   CONFIG.DAC_Invsinc_Ctrl01 {false} \
   CONFIG.DAC_Invsinc_Ctrl02 {false} \
   CONFIG.DAC_Invsinc_Ctrl03 {false} \
   CONFIG.DAC_Invsinc_Ctrl10 {false} \
   CONFIG.DAC_Invsinc_Ctrl11 {false} \
   CONFIG.DAC_Invsinc_Ctrl12 {false} \
   CONFIG.DAC_Invsinc_Ctrl13 {false} \
   CONFIG.DAC_Invsinc_Ctrl20 {false} \
   CONFIG.DAC_Invsinc_Ctrl21 {false} \
   CONFIG.DAC_Invsinc_Ctrl22 {false} \
   CONFIG.DAC_Invsinc_Ctrl23 {false} \
   CONFIG.DAC_Invsinc_Ctrl30 {false} \
   CONFIG.DAC_Invsinc_Ctrl31 {false} \
   CONFIG.DAC_Invsinc_Ctrl32 {false} \
   CONFIG.DAC_Invsinc_Ctrl33 {false} \
   CONFIG.DAC_LM00 {0} \
   CONFIG.DAC_LM01 {0} \
   CONFIG.DAC_LM02 {0} \
   CONFIG.DAC_LM03 {0} \
   CONFIG.DAC_LM10 {0} \
   CONFIG.DAC_LM11 {0} \
   CONFIG.DAC_LM12 {0} \
   CONFIG.DAC_LM13 {0} \
   CONFIG.DAC_LM20 {0} \
   CONFIG.DAC_LM21 {0} \
   CONFIG.DAC_LM22 {0} \
   CONFIG.DAC_LM23 {0} \
   CONFIG.DAC_LM30 {0} \
   CONFIG.DAC_LM31 {0} \
   CONFIG.DAC_LM32 {0} \
   CONFIG.DAC_LM33 {0} \
   CONFIG.DAC_Mixer_Mode00 {2} \
   CONFIG.DAC_Mixer_Mode01 {2} \
   CONFIG.DAC_Mixer_Mode02 {2} \
   CONFIG.DAC_Mixer_Mode03 {2} \
   CONFIG.DAC_Mixer_Mode10 {2} \
   CONFIG.DAC_Mixer_Mode11 {2} \
   CONFIG.DAC_Mixer_Mode12 {2} \
   CONFIG.DAC_Mixer_Mode13 {2} \
   CONFIG.DAC_Mixer_Mode20 {2} \
   CONFIG.DAC_Mixer_Mode21 {2} \
   CONFIG.DAC_Mixer_Mode22 {2} \
   CONFIG.DAC_Mixer_Mode23 {2} \
   CONFIG.DAC_Mixer_Mode30 {2} \
   CONFIG.DAC_Mixer_Mode31 {2} \
   CONFIG.DAC_Mixer_Mode32 {2} \
   CONFIG.DAC_Mixer_Mode33 {2} \
   CONFIG.DAC_Mixer_Type00 {0} \
   CONFIG.DAC_Mixer_Type01 {0} \
   CONFIG.DAC_Mixer_Type02 {0} \
   CONFIG.DAC_Mixer_Type03 {0} \
   CONFIG.DAC_Mixer_Type10 {0} \
   CONFIG.DAC_Mixer_Type11 {0} \
   CONFIG.DAC_Mixer_Type12 {0} \
   CONFIG.DAC_Mixer_Type13 {0} \
   CONFIG.DAC_Mixer_Type20 {3} \
   CONFIG.DAC_Mixer_Type21 {3} \
   CONFIG.DAC_Mixer_Type22 {3} \
   CONFIG.DAC_Mixer_Type23 {3} \
   CONFIG.DAC_Mixer_Type30 {3} \
   CONFIG.DAC_Mixer_Type31 {3} \
   CONFIG.DAC_Mixer_Type32 {3} \
   CONFIG.DAC_Mixer_Type33 {3} \
   CONFIG.DAC_Mode00 {0} \
   CONFIG.DAC_Mode01 {0} \
   CONFIG.DAC_Mode02 {0} \
   CONFIG.DAC_Mode03 {0} \
   CONFIG.DAC_Mode10 {0} \
   CONFIG.DAC_Mode11 {0} \
   CONFIG.DAC_Mode12 {0} \
   CONFIG.DAC_Mode13 {0} \
   CONFIG.DAC_Mode20 {0} \
   CONFIG.DAC_Mode21 {0} \
   CONFIG.DAC_Mode22 {0} \
   CONFIG.DAC_Mode23 {0} \
   CONFIG.DAC_Mode30 {0} \
   CONFIG.DAC_Mode31 {0} \
   CONFIG.DAC_Mode32 {0} \
   CONFIG.DAC_Mode33 {0} \
   CONFIG.DAC_NCO_Freq00 {0.0} \
   CONFIG.DAC_NCO_Freq01 {0.0} \
   CONFIG.DAC_NCO_Freq02 {0.0} \
   CONFIG.DAC_NCO_Freq03 {0.0} \
   CONFIG.DAC_NCO_Freq10 {0.0} \
   CONFIG.DAC_NCO_Freq11 {0.0} \
   CONFIG.DAC_NCO_Freq12 {0.0} \
   CONFIG.DAC_NCO_Freq13 {0.0} \
   CONFIG.DAC_NCO_Freq20 {0.0} \
   CONFIG.DAC_NCO_Freq21 {0.0} \
   CONFIG.DAC_NCO_Freq22 {0.0} \
   CONFIG.DAC_NCO_Freq23 {0.0} \
   CONFIG.DAC_NCO_Freq30 {0.0} \
   CONFIG.DAC_NCO_Freq31 {0.0} \
   CONFIG.DAC_NCO_Freq32 {0.0} \
   CONFIG.DAC_NCO_Freq33 {0.0} \
   CONFIG.DAC_NCO_Phase00 {0} \
   CONFIG.DAC_NCO_Phase01 {0} \
   CONFIG.DAC_NCO_Phase02 {0} \
   CONFIG.DAC_NCO_Phase03 {0} \
   CONFIG.DAC_NCO_Phase10 {0} \
   CONFIG.DAC_NCO_Phase11 {0} \
   CONFIG.DAC_NCO_Phase12 {0} \
   CONFIG.DAC_NCO_Phase13 {0} \
   CONFIG.DAC_NCO_Phase20 {0} \
   CONFIG.DAC_NCO_Phase21 {0} \
   CONFIG.DAC_NCO_Phase22 {0} \
   CONFIG.DAC_NCO_Phase23 {0} \
   CONFIG.DAC_NCO_Phase30 {0} \
   CONFIG.DAC_NCO_Phase31 {0} \
   CONFIG.DAC_NCO_Phase32 {0} \
   CONFIG.DAC_NCO_Phase33 {0} \
   CONFIG.DAC_NCO_RTS {false} \
   CONFIG.DAC_Neg_Quadrature00 {false} \
   CONFIG.DAC_Neg_Quadrature01 {false} \
   CONFIG.DAC_Neg_Quadrature02 {false} \
   CONFIG.DAC_Neg_Quadrature03 {false} \
   CONFIG.DAC_Neg_Quadrature10 {false} \
   CONFIG.DAC_Neg_Quadrature11 {false} \
   CONFIG.DAC_Neg_Quadrature12 {false} \
   CONFIG.DAC_Neg_Quadrature13 {false} \
   CONFIG.DAC_Neg_Quadrature20 {false} \
   CONFIG.DAC_Neg_Quadrature21 {false} \
   CONFIG.DAC_Neg_Quadrature22 {false} \
   CONFIG.DAC_Neg_Quadrature23 {false} \
   CONFIG.DAC_Neg_Quadrature30 {false} \
   CONFIG.DAC_Neg_Quadrature31 {false} \
   CONFIG.DAC_Neg_Quadrature32 {false} \
   CONFIG.DAC_Neg_Quadrature33 {false} \
   CONFIG.DAC_Nyquist00 {0} \
   CONFIG.DAC_Nyquist01 {0} \
   CONFIG.DAC_Nyquist02 {0} \
   CONFIG.DAC_Nyquist03 {0} \
   CONFIG.DAC_Nyquist10 {0} \
   CONFIG.DAC_Nyquist11 {0} \
   CONFIG.DAC_Nyquist12 {0} \
   CONFIG.DAC_Nyquist13 {0} \
   CONFIG.DAC_Nyquist20 {0} \
   CONFIG.DAC_Nyquist21 {0} \
   CONFIG.DAC_Nyquist22 {0} \
   CONFIG.DAC_Nyquist23 {0} \
   CONFIG.DAC_Nyquist30 {0} \
   CONFIG.DAC_Nyquist31 {0} \
   CONFIG.DAC_Nyquist32 {0} \
   CONFIG.DAC_Nyquist33 {0} \
   CONFIG.DAC_Output_Current {0} \
   CONFIG.DAC_RTS {false} \
   CONFIG.DAC_Slice00_Enable {true} \
   CONFIG.DAC_Slice01_Enable {true} \
   CONFIG.DAC_Slice02_Enable {true} \
   CONFIG.DAC_Slice03_Enable {true} \
   CONFIG.DAC_Slice10_Enable {true} \
   CONFIG.DAC_Slice11_Enable {true} \
   CONFIG.DAC_Slice12_Enable {true} \
   CONFIG.DAC_Slice13_Enable {true} \
   CONFIG.DAC_Slice20_Enable {false} \
   CONFIG.DAC_Slice21_Enable {false} \
   CONFIG.DAC_Slice22_Enable {false} \
   CONFIG.DAC_Slice23_Enable {false} \
   CONFIG.DAC_Slice30_Enable {false} \
   CONFIG.DAC_Slice31_Enable {false} \
   CONFIG.DAC_Slice32_Enable {false} \
   CONFIG.DAC_Slice33_Enable {false} \
   CONFIG.PL_Clock_Freq {100.0} \
   CONFIG.PRESET {None} \
   CONFIG.RF_Analyzer {1} \
   CONFIG.Sysref_Source {1} \
   CONFIG.VNC_Testing {false} \
   CONFIG.disable_bg_cal_en {0} \
   CONFIG.mADC_Band {0} \
   CONFIG.mADC_Bypass_BG_Cal00 {false} \
   CONFIG.mADC_Bypass_BG_Cal01 {false} \
   CONFIG.mADC_Bypass_BG_Cal02 {false} \
   CONFIG.mADC_Bypass_BG_Cal03 {false} \
   CONFIG.mADC_CalOpt_Mode00 {1} \
   CONFIG.mADC_CalOpt_Mode01 {1} \
   CONFIG.mADC_CalOpt_Mode02 {1} \
   CONFIG.mADC_CalOpt_Mode03 {1} \
   CONFIG.mADC_Coarse_Mixer_Freq00 {0} \
   CONFIG.mADC_Coarse_Mixer_Freq01 {0} \
   CONFIG.mADC_Coarse_Mixer_Freq02 {0} \
   CONFIG.mADC_Coarse_Mixer_Freq03 {0} \
   CONFIG.mADC_Data_Type00 {0} \
   CONFIG.mADC_Data_Type01 {0} \
   CONFIG.mADC_Data_Type02 {0} \
   CONFIG.mADC_Data_Type03 {0} \
   CONFIG.mADC_Data_Width00 {8} \
   CONFIG.mADC_Data_Width01 {8} \
   CONFIG.mADC_Data_Width02 {8} \
   CONFIG.mADC_Data_Width03 {8} \
   CONFIG.mADC_Decimation_Mode00 {0} \
   CONFIG.mADC_Decimation_Mode01 {0} \
   CONFIG.mADC_Decimation_Mode02 {0} \
   CONFIG.mADC_Decimation_Mode03 {0} \
   CONFIG.mADC_Dither00 {true} \
   CONFIG.mADC_Dither01 {true} \
   CONFIG.mADC_Dither02 {true} \
   CONFIG.mADC_Dither03 {true} \
   CONFIG.mADC_Enable {0} \
   CONFIG.mADC_Fabric_Freq {0.0} \
   CONFIG.mADC_LM00 {0} \
   CONFIG.mADC_LM01 {0} \
   CONFIG.mADC_LM02 {0} \
   CONFIG.mADC_LM03 {0} \
   CONFIG.mADC_Link_Coupling {0} \
   CONFIG.mADC_Mixer_Mode00 {2} \
   CONFIG.mADC_Mixer_Mode01 {2} \
   CONFIG.mADC_Mixer_Mode02 {2} \
   CONFIG.mADC_Mixer_Mode03 {2} \
   CONFIG.mADC_Mixer_Type00 {3} \
   CONFIG.mADC_Mixer_Type01 {3} \
   CONFIG.mADC_Mixer_Type02 {3} \
   CONFIG.mADC_Mixer_Type03 {3} \
   CONFIG.mADC_Multi_Tile_Sync {false} \
   CONFIG.mADC_NCO_Freq00 {0.0} \
   CONFIG.mADC_NCO_Freq01 {0.0} \
   CONFIG.mADC_NCO_Freq02 {0.0} \
   CONFIG.mADC_NCO_Freq03 {0.0} \
   CONFIG.mADC_NCO_Phase00 {0} \
   CONFIG.mADC_NCO_Phase01 {0} \
   CONFIG.mADC_NCO_Phase02 {0} \
   CONFIG.mADC_NCO_Phase03 {0} \
   CONFIG.mADC_Neg_Quadrature00 {false} \
   CONFIG.mADC_Neg_Quadrature01 {false} \
   CONFIG.mADC_Neg_Quadrature02 {false} \
   CONFIG.mADC_Neg_Quadrature03 {false} \
   CONFIG.mADC_Nyquist00 {0} \
   CONFIG.mADC_Nyquist01 {0} \
   CONFIG.mADC_Nyquist02 {0} \
   CONFIG.mADC_Nyquist03 {0} \
   CONFIG.mADC_Outclk_Freq {15.625} \
   CONFIG.mADC_PLL_Enable {false} \
   CONFIG.mADC_Refclk_Div {1} \
   CONFIG.mADC_Refclk_Freq {2000.000} \
   CONFIG.mADC_Sampling_Rate {2.0} \
   CONFIG.mADC_Slice00_Enable {false} \
   CONFIG.mADC_Slice01_Enable {false} \
   CONFIG.mADC_Slice02_Enable {false} \
   CONFIG.mADC_Slice03_Enable {false} \
   CONFIG.mDAC_Band {0} \
   CONFIG.mDAC_Coarse_Mixer_Freq00 {0} \
   CONFIG.mDAC_Coarse_Mixer_Freq01 {0} \
   CONFIG.mDAC_Coarse_Mixer_Freq02 {0} \
   CONFIG.mDAC_Coarse_Mixer_Freq03 {0} \
   CONFIG.mDAC_Data_Type00 {0} \
   CONFIG.mDAC_Data_Type01 {0} \
   CONFIG.mDAC_Data_Type02 {0} \
   CONFIG.mDAC_Data_Type03 {0} \
   CONFIG.mDAC_Data_Width00 {16} \
   CONFIG.mDAC_Data_Width01 {16} \
   CONFIG.mDAC_Data_Width02 {16} \
   CONFIG.mDAC_Data_Width03 {16} \
   CONFIG.mDAC_Decoder_Mode00 {0} \
   CONFIG.mDAC_Decoder_Mode01 {0} \
   CONFIG.mDAC_Decoder_Mode02 {0} \
   CONFIG.mDAC_Decoder_Mode03 {0} \
   CONFIG.mDAC_Enable {0} \
   CONFIG.mDAC_Fabric_Freq {0.0} \
   CONFIG.mDAC_Interpolation_Mode00 {0} \
   CONFIG.mDAC_Interpolation_Mode01 {0} \
   CONFIG.mDAC_Interpolation_Mode02 {0} \
   CONFIG.mDAC_Interpolation_Mode03 {0} \
   CONFIG.mDAC_Invsinc_Ctrl00 {false} \
   CONFIG.mDAC_Invsinc_Ctrl01 {false} \
   CONFIG.mDAC_Invsinc_Ctrl02 {false} \
   CONFIG.mDAC_Invsinc_Ctrl03 {false} \
   CONFIG.mDAC_LM00 {0} \
   CONFIG.mDAC_LM01 {0} \
   CONFIG.mDAC_LM02 {0} \
   CONFIG.mDAC_LM03 {0} \
   CONFIG.mDAC_Mixer_Mode00 {2} \
   CONFIG.mDAC_Mixer_Mode01 {2} \
   CONFIG.mDAC_Mixer_Mode02 {2} \
   CONFIG.mDAC_Mixer_Mode03 {2} \
   CONFIG.mDAC_Mixer_Type00 {3} \
   CONFIG.mDAC_Mixer_Type01 {3} \
   CONFIG.mDAC_Mixer_Type02 {3} \
   CONFIG.mDAC_Mixer_Type03 {3} \
   CONFIG.mDAC_Mode00 {0} \
   CONFIG.mDAC_Mode01 {0} \
   CONFIG.mDAC_Mode02 {0} \
   CONFIG.mDAC_Mode03 {0} \
   CONFIG.mDAC_Multi_Tile_Sync {false} \
   CONFIG.mDAC_NCO_Freq00 {0.0} \
   CONFIG.mDAC_NCO_Freq01 {0.0} \
   CONFIG.mDAC_NCO_Freq02 {0.0} \
   CONFIG.mDAC_NCO_Freq03 {0.0} \
   CONFIG.mDAC_NCO_Phase00 {0} \
   CONFIG.mDAC_NCO_Phase01 {0} \
   CONFIG.mDAC_NCO_Phase02 {0} \
   CONFIG.mDAC_NCO_Phase03 {0} \
   CONFIG.mDAC_Neg_Quadrature00 {false} \
   CONFIG.mDAC_Neg_Quadrature01 {false} \
   CONFIG.mDAC_Neg_Quadrature02 {false} \
   CONFIG.mDAC_Neg_Quadrature03 {false} \
   CONFIG.mDAC_Nyquist00 {0} \
   CONFIG.mDAC_Nyquist01 {0} \
   CONFIG.mDAC_Nyquist02 {0} \
   CONFIG.mDAC_Nyquist03 {0} \
   CONFIG.mDAC_Outclk_Freq {50.000} \
   CONFIG.mDAC_PLL_Enable {false} \
   CONFIG.mDAC_Refclk_Div {1} \
   CONFIG.mDAC_Refclk_Freq {6400.000} \
   CONFIG.mDAC_Sampling_Rate {6.4} \
   CONFIG.mDAC_Slice00_Enable {false} \
   CONFIG.mDAC_Slice01_Enable {false} \
   CONFIG.mDAC_Slice02_Enable {false} \
   CONFIG.mDAC_Slice03_Enable {false} \
   CONFIG.production_simulation {0} \
   CONFIG.tb_adc_fft {true} \
   CONFIG.tb_dac_fft {true} \
   CONFIG.use_bram {1} \
 ] $usp_rf_data_converter_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m02_0] [get_bd_intf_pins adc_sink_i/m02]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m01_0] [get_bd_intf_pins adc_sink_i/m01]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m00_0] [get_bd_intf_pins adc_sink_i/m00]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m03_0] [get_bd_intf_pins adc_sink_i/m03]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m13_0] [get_bd_intf_pins adc_sink_i/m13]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m12_0] [get_bd_intf_pins adc_sink_i/m12]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m10_0] [get_bd_intf_pins adc_sink_i/m10]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins m11_0] [get_bd_intf_pins adc_sink_i/m11]
  connect_bd_intf_net -intf_net Conn9 [get_bd_intf_pins m23_0] [get_bd_intf_pins adc_sink_i/m23]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins m30_0] [get_bd_intf_pins adc_sink_i/m30]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins m31_0] [get_bd_intf_pins adc_sink_i/m31]
  connect_bd_intf_net -intf_net Conn12 [get_bd_intf_pins m32_0] [get_bd_intf_pins adc_sink_i/m32]
  connect_bd_intf_net -intf_net Conn13 [get_bd_intf_pins m33_0] [get_bd_intf_pins adc_sink_i/m33]
  connect_bd_intf_net -intf_net Conn14 [get_bd_intf_pins m20_0] [get_bd_intf_pins adc_sink_i/m20]
  connect_bd_intf_net -intf_net Conn15 [get_bd_intf_pins m21_0] [get_bd_intf_pins adc_sink_i/m21]
  connect_bd_intf_net -intf_net Conn16 [get_bd_intf_pins m22_0] [get_bd_intf_pins adc_sink_i/m22]
  connect_bd_intf_net -intf_net Conn17 [get_bd_intf_pins s00_0] [get_bd_intf_pins dac_source_i/s00]
  connect_bd_intf_net -intf_net Conn18 [get_bd_intf_pins vout12] [get_bd_intf_pins usp_rf_data_converter_0/vout12]
  connect_bd_intf_net -intf_net Conn19 [get_bd_intf_pins vout13] [get_bd_intf_pins usp_rf_data_converter_0/vout13]
  connect_bd_intf_net -intf_net Conn20 [get_bd_intf_pins vin3_23] [get_bd_intf_pins usp_rf_data_converter_0/vin3_23]
  connect_bd_intf_net -intf_net Conn21 [get_bd_intf_pins vout00] [get_bd_intf_pins usp_rf_data_converter_0/vout00]
  connect_bd_intf_net -intf_net Conn22 [get_bd_intf_pins s10_0] [get_bd_intf_pins dac_source_i/s10]
  connect_bd_intf_net -intf_net Conn23 [get_bd_intf_pins s03_0] [get_bd_intf_pins dac_source_i/s03]
  connect_bd_intf_net -intf_net Conn24 [get_bd_intf_pins s02_0] [get_bd_intf_pins dac_source_i/s02]
  connect_bd_intf_net -intf_net Conn25 [get_bd_intf_pins s01_0] [get_bd_intf_pins dac_source_i/s01]
  connect_bd_intf_net -intf_net Conn26 [get_bd_intf_pins s13_0] [get_bd_intf_pins dac_source_i/s13]
  connect_bd_intf_net -intf_net Conn27 [get_bd_intf_pins s12_0] [get_bd_intf_pins dac_source_i/s12]
  connect_bd_intf_net -intf_net Conn28 [get_bd_intf_pins s11_0] [get_bd_intf_pins dac_source_i/s11]
  connect_bd_intf_net -intf_net Conn29 [get_bd_intf_pins vout01] [get_bd_intf_pins usp_rf_data_converter_0/vout01]
  connect_bd_intf_net -intf_net Conn30 [get_bd_intf_pins vout02] [get_bd_intf_pins usp_rf_data_converter_0/vout02]
  connect_bd_intf_net -intf_net Conn31 [get_bd_intf_pins vout03] [get_bd_intf_pins usp_rf_data_converter_0/vout03]
  connect_bd_intf_net -intf_net Conn32 [get_bd_intf_pins vout10] [get_bd_intf_pins usp_rf_data_converter_0/vout10]
  connect_bd_intf_net -intf_net Conn33 [get_bd_intf_pins vout11] [get_bd_intf_pins usp_rf_data_converter_0/vout11]
  connect_bd_intf_net -intf_net Conn34 [get_bd_intf_pins dac0_clk] [get_bd_intf_pins usp_rf_data_converter_0/dac0_clk]
  connect_bd_intf_net -intf_net Conn35 [get_bd_intf_pins dac1_clk] [get_bd_intf_pins usp_rf_data_converter_0/dac1_clk]
  connect_bd_intf_net -intf_net Conn36 [get_bd_intf_pins vin0_23] [get_bd_intf_pins usp_rf_data_converter_0/vin0_23]
  connect_bd_intf_net -intf_net Conn37 [get_bd_intf_pins vin0_01] [get_bd_intf_pins usp_rf_data_converter_0/vin0_01]
  connect_bd_intf_net -intf_net Conn38 [get_bd_intf_pins vin1_01] [get_bd_intf_pins usp_rf_data_converter_0/vin1_01]
  connect_bd_intf_net -intf_net Conn39 [get_bd_intf_pins vin1_23] [get_bd_intf_pins usp_rf_data_converter_0/vin1_23]
  connect_bd_intf_net -intf_net Conn40 [get_bd_intf_pins adc2_clk] [get_bd_intf_pins usp_rf_data_converter_0/adc2_clk]
  connect_bd_intf_net -intf_net Conn41 [get_bd_intf_pins adc3_clk] [get_bd_intf_pins usp_rf_data_converter_0/adc3_clk]
  connect_bd_intf_net -intf_net Conn42 [get_bd_intf_pins vin2_01] [get_bd_intf_pins usp_rf_data_converter_0/vin2_01]
  connect_bd_intf_net -intf_net Conn43 [get_bd_intf_pins adc1_clk] [get_bd_intf_pins usp_rf_data_converter_0/adc1_clk]
  connect_bd_intf_net -intf_net Conn44 [get_bd_intf_pins vin2_23] [get_bd_intf_pins usp_rf_data_converter_0/vin2_23]
  connect_bd_intf_net -intf_net Conn45 [get_bd_intf_pins vin3_01] [get_bd_intf_pins usp_rf_data_converter_0/vin3_01]
  connect_bd_intf_net -intf_net Conn46 [get_bd_intf_pins adc0_clk] [get_bd_intf_pins usp_rf_data_converter_0/adc0_clk]
  connect_bd_intf_net -intf_net Conn47 [get_bd_intf_pins sysref_in] [get_bd_intf_pins usp_rf_data_converter_0/sysref_in]
  connect_bd_intf_net -intf_net Conn48 [get_bd_intf_pins M03_AXI] [get_bd_intf_pins smartconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net Conn49 [get_bd_intf_pins M04_AXI] [get_bd_intf_pins smartconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net Conn50 [get_bd_intf_pins M05_AXI] [get_bd_intf_pins smartconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net Conn51 [get_bd_intf_pins M06_AXI] [get_bd_intf_pins smartconnect_0/M06_AXI]
  connect_bd_intf_net -intf_net Conn52 [get_bd_intf_pins M07_AXI] [get_bd_intf_pins smartconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net Conn53 [get_bd_intf_pins M08_AXI] [get_bd_intf_pins smartconnect_0/M08_AXI]
  connect_bd_intf_net -intf_net Conn54 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net Conn55 [get_bd_intf_pins S01_AXI] [get_bd_intf_pins smartconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net Conn56 [get_bd_intf_pins M09_AXI] [get_bd_intf_pins smartconnect_0/M09_AXI]
  connect_bd_intf_net -intf_net dac_source_i_m00 [get_bd_intf_pins dac_source_i/m00] [get_bd_intf_pins usp_rf_data_converter_0/s00_axis]
  connect_bd_intf_net -intf_net dac_source_i_m01 [get_bd_intf_pins dac_source_i/m01] [get_bd_intf_pins usp_rf_data_converter_0/s01_axis]
  connect_bd_intf_net -intf_net dac_source_i_m02 [get_bd_intf_pins dac_source_i/m02] [get_bd_intf_pins usp_rf_data_converter_0/s02_axis]
  connect_bd_intf_net -intf_net dac_source_i_m03 [get_bd_intf_pins dac_source_i/m03] [get_bd_intf_pins usp_rf_data_converter_0/s03_axis]
  connect_bd_intf_net -intf_net dac_source_i_m10 [get_bd_intf_pins dac_source_i/m10] [get_bd_intf_pins usp_rf_data_converter_0/s10_axis]
  connect_bd_intf_net -intf_net dac_source_i_m11 [get_bd_intf_pins dac_source_i/m11] [get_bd_intf_pins usp_rf_data_converter_0/s11_axis]
  connect_bd_intf_net -intf_net dac_source_i_m12 [get_bd_intf_pins dac_source_i/m12] [get_bd_intf_pins usp_rf_data_converter_0/s12_axis]
  connect_bd_intf_net -intf_net dac_source_i_m13 [get_bd_intf_pins dac_source_i/m13] [get_bd_intf_pins usp_rf_data_converter_0/s13_axis]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins usp_rf_data_converter_0/s_axi]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins dac_source_i/s_axi] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins adc_sink_i/s_axi] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins s0_axis_aclk] [get_bd_pins dac_source_i/m0_axis_clock] [get_bd_pins usp_rf_data_converter_0/s0_axis_aclk]
  connect_bd_net -net Net1 [get_bd_pins s1_axis_aclk] [get_bd_pins dac_source_i/m1_axis_clock] [get_bd_pins usp_rf_data_converter_0/s1_axis_aclk]
  connect_bd_net -net adc_axis_aresetn1_1 [get_bd_pins m1_axis_aresetn] [get_bd_pins signal_detect/adc_axis_aresetn1] [get_bd_pins usp_rf_data_converter_0/m1_axis_aresetn]
  connect_bd_net -net adc_axis_aresetn2_1 [get_bd_pins m2_axis_aresetn] [get_bd_pins signal_detect/adc_axis_aresetn2] [get_bd_pins usp_rf_data_converter_0/m2_axis_aresetn]
  connect_bd_net -net adc_axis_aresetn3_1 [get_bd_pins m3_axis_aresetn] [get_bd_pins signal_detect/adc_axis_aresetn3] [get_bd_pins usp_rf_data_converter_0/m3_axis_aresetn]
  connect_bd_net -net adc_axis_aresetn_1 [get_bd_pins m0_axis_aresetn] [get_bd_pins signal_detect/adc_axis_aresetn] [get_bd_pins usp_rf_data_converter_0/m0_axis_aresetn]
  connect_bd_net -net adc_sink_i_s00_tready [get_bd_pins adc_sink_i/s00_tready] [get_bd_pins usp_rf_data_converter_0/m00_axis_tready]
  connect_bd_net -net adc_sink_i_s01_tready [get_bd_pins adc_sink_i/s01_tready] [get_bd_pins usp_rf_data_converter_0/m01_axis_tready]
  connect_bd_net -net adc_sink_i_s02_tready [get_bd_pins adc_sink_i/s02_tready] [get_bd_pins usp_rf_data_converter_0/m02_axis_tready]
  connect_bd_net -net adc_sink_i_s03_tready [get_bd_pins adc_sink_i/s03_tready] [get_bd_pins usp_rf_data_converter_0/m03_axis_tready]
  connect_bd_net -net adc_sink_i_s10_tready [get_bd_pins adc_sink_i/s10_tready] [get_bd_pins usp_rf_data_converter_0/m10_axis_tready]
  connect_bd_net -net adc_sink_i_s11_tready [get_bd_pins adc_sink_i/s11_tready] [get_bd_pins usp_rf_data_converter_0/m11_axis_tready]
  connect_bd_net -net adc_sink_i_s12_tready [get_bd_pins adc_sink_i/s12_tready] [get_bd_pins usp_rf_data_converter_0/m12_axis_tready]
  connect_bd_net -net adc_sink_i_s13_tready [get_bd_pins adc_sink_i/s13_tready] [get_bd_pins usp_rf_data_converter_0/m13_axis_tready]
  connect_bd_net -net adc_sink_i_s20_tready [get_bd_pins adc_sink_i/s20_tready] [get_bd_pins usp_rf_data_converter_0/m20_axis_tready]
  connect_bd_net -net adc_sink_i_s21_tready [get_bd_pins adc_sink_i/s21_tready] [get_bd_pins usp_rf_data_converter_0/m21_axis_tready]
  connect_bd_net -net adc_sink_i_s22_tready [get_bd_pins adc_sink_i/s22_tready] [get_bd_pins usp_rf_data_converter_0/m22_axis_tready]
  connect_bd_net -net adc_sink_i_s23_tready [get_bd_pins adc_sink_i/s23_tready] [get_bd_pins usp_rf_data_converter_0/m23_axis_tready]
  connect_bd_net -net adc_sink_i_s30_tready [get_bd_pins adc_sink_i/s30_tready] [get_bd_pins usp_rf_data_converter_0/m30_axis_tready]
  connect_bd_net -net adc_sink_i_s31_tready [get_bd_pins adc_sink_i/s31_tready] [get_bd_pins usp_rf_data_converter_0/m31_axis_tready]
  connect_bd_net -net adc_sink_i_s32_tready [get_bd_pins adc_sink_i/s32_tready] [get_bd_pins usp_rf_data_converter_0/m32_axis_tready]
  connect_bd_net -net adc_sink_i_s33_tready [get_bd_pins adc_sink_i/s33_tready] [get_bd_pins usp_rf_data_converter_0/m33_axis_tready]
  connect_bd_net -net s0_axis_aresetn_1 [get_bd_pins s0_axis_aresetn] [get_bd_pins usp_rf_data_converter_0/s0_axis_aresetn]
  connect_bd_net -net s0_axis_clock_1 [get_bd_pins m0_axis_aclk] [get_bd_pins adc_sink_i/s0_axis_clock] [get_bd_pins adc_sink_i/s0_div2_axis_clock] [get_bd_pins signal_detect/adc_axis_aclk] [get_bd_pins usp_rf_data_converter_0/m0_axis_aclk]
  connect_bd_net -net s1_axis_aresetn_1 [get_bd_pins s1_axis_aresetn] [get_bd_pins usp_rf_data_converter_0/s1_axis_aresetn]
  connect_bd_net -net s1_axis_clock_1 [get_bd_pins m1_axis_aclk] [get_bd_pins adc_sink_i/s1_axis_clock] [get_bd_pins adc_sink_i/s1_div2_axis_clock] [get_bd_pins signal_detect/adc_axis_aclk1] [get_bd_pins usp_rf_data_converter_0/m1_axis_aclk]
  connect_bd_net -net s2_axis_clock_1 [get_bd_pins m2_axis_aclk] [get_bd_pins adc_sink_i/s2_axis_clock] [get_bd_pins adc_sink_i/s2_div2_axis_clock] [get_bd_pins signal_detect/adc_axis_aclk2] [get_bd_pins usp_rf_data_converter_0/m2_axis_aclk]
  connect_bd_net -net s3_axis_clock_1 [get_bd_pins m3_axis_aclk] [get_bd_pins adc_sink_i/s3_axis_clock] [get_bd_pins adc_sink_i/s3_div2_axis_clock] [get_bd_pins signal_detect/adc_axis_aclk3] [get_bd_pins usp_rf_data_converter_0/m3_axis_aclk]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins adc_sink_i/s_axi_aclk] [get_bd_pins dac_source_i/s_axi_aclk] [get_bd_pins signal_detect/s_axi_aclk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins usp_rf_data_converter_0/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins adc_sink_i/s_axi_aresetn] [get_bd_pins dac_source_i/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins usp_rf_data_converter_0/s_axi_aresetn]
  connect_bd_net -net signal_detect_Res [get_bd_pins signal_detect/Res] [get_bd_pins usp_rf_data_converter_0/adc0_01_int_cal_freeze]
  connect_bd_net -net signal_detect_Res1 [get_bd_pins signal_detect/Res1] [get_bd_pins usp_rf_data_converter_0/adc0_23_int_cal_freeze]
  connect_bd_net -net signal_detect_Res2 [get_bd_pins signal_detect/Res2] [get_bd_pins usp_rf_data_converter_0/adc1_01_int_cal_freeze]
  connect_bd_net -net signal_detect_Res3 [get_bd_pins signal_detect/Res3] [get_bd_pins usp_rf_data_converter_0/adc1_23_int_cal_freeze]
  connect_bd_net -net signal_detect_Res4 [get_bd_pins signal_detect/Res4] [get_bd_pins usp_rf_data_converter_0/adc2_01_int_cal_freeze]
  connect_bd_net -net signal_detect_Res5 [get_bd_pins signal_detect/Res5] [get_bd_pins usp_rf_data_converter_0/adc2_23_int_cal_freeze]
  connect_bd_net -net signal_detect_Res6 [get_bd_pins signal_detect/Res6] [get_bd_pins usp_rf_data_converter_0/adc3_01_int_cal_freeze]
  connect_bd_net -net signal_detect_Res7 [get_bd_pins signal_detect/Res7] [get_bd_pins usp_rf_data_converter_0/adc3_23_int_cal_freeze]
  connect_bd_net -net user_select_00_0_1 [get_bd_pins user_select_00_0] [get_bd_pins dac_source_i/user_select_00]
  connect_bd_net -net user_select_01_0_1 [get_bd_pins user_select_01_0] [get_bd_pins dac_source_i/user_select_01]
  connect_bd_net -net user_select_02_0_1 [get_bd_pins user_select_02_0] [get_bd_pins dac_source_i/user_select_02]
  connect_bd_net -net user_select_03_0_1 [get_bd_pins user_select_03_0] [get_bd_pins dac_source_i/user_select_03]
  connect_bd_net -net user_select_10_0_1 [get_bd_pins user_select_10_0] [get_bd_pins dac_source_i/user_select_10]
  connect_bd_net -net user_select_11_0_1 [get_bd_pins user_select_11_0] [get_bd_pins dac_source_i/user_select_11]
  connect_bd_net -net user_select_12_0_1 [get_bd_pins user_select_12_0] [get_bd_pins dac_source_i/user_select_12]
  connect_bd_net -net user_select_13_0_1 [get_bd_pins user_select_13_0] [get_bd_pins dac_source_i/user_select_13]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins clk_adc0] [get_bd_pins usp_rf_data_converter_0/clk_adc0]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc1 [get_bd_pins clk_adc1] [get_bd_pins usp_rf_data_converter_0/clk_adc1]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc2 [get_bd_pins clk_adc2] [get_bd_pins usp_rf_data_converter_0/clk_adc2]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc3 [get_bd_pins clk_adc3] [get_bd_pins usp_rf_data_converter_0/clk_adc3]
  connect_bd_net -net usp_rf_data_converter_0_clk_dac0 [get_bd_pins clk_dac0] [get_bd_pins usp_rf_data_converter_0/clk_dac0]
  connect_bd_net -net usp_rf_data_converter_0_clk_dac1 [get_bd_pins clk_dac1] [get_bd_pins usp_rf_data_converter_0/clk_dac1]
  connect_bd_net -net usp_rf_data_converter_0_m00_axis_tdata [get_bd_pins adc_sink_i/s00_tdata] [get_bd_pins signal_detect/adc_axis_tdata] [get_bd_pins usp_rf_data_converter_0/m00_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m00_axis_tvalid [get_bd_pins adc_sink_i/s00_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid] [get_bd_pins usp_rf_data_converter_0/m00_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m01_axis_tdata [get_bd_pins adc_sink_i/s01_tdata] [get_bd_pins signal_detect/adc_axis_tdata1] [get_bd_pins usp_rf_data_converter_0/m01_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m01_axis_tvalid [get_bd_pins adc_sink_i/s01_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid1] [get_bd_pins usp_rf_data_converter_0/m01_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m02_axis_tdata [get_bd_pins adc_sink_i/s02_tdata] [get_bd_pins signal_detect/adc_axis_tdata2] [get_bd_pins usp_rf_data_converter_0/m02_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m02_axis_tvalid [get_bd_pins adc_sink_i/s02_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid2] [get_bd_pins usp_rf_data_converter_0/m02_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m03_axis_tdata [get_bd_pins adc_sink_i/s03_tdata] [get_bd_pins signal_detect/adc_axis_tdata3] [get_bd_pins usp_rf_data_converter_0/m03_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m03_axis_tvalid [get_bd_pins adc_sink_i/s03_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid3] [get_bd_pins usp_rf_data_converter_0/m03_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m10_axis_tdata [get_bd_pins adc_sink_i/s10_tdata] [get_bd_pins signal_detect/adc_axis_tdata4] [get_bd_pins usp_rf_data_converter_0/m10_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m10_axis_tvalid [get_bd_pins adc_sink_i/s10_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid4] [get_bd_pins usp_rf_data_converter_0/m10_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m11_axis_tdata [get_bd_pins adc_sink_i/s11_tdata] [get_bd_pins signal_detect/adc_axis_tdata5] [get_bd_pins usp_rf_data_converter_0/m11_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m11_axis_tvalid [get_bd_pins adc_sink_i/s11_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid5] [get_bd_pins usp_rf_data_converter_0/m11_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m12_axis_tdata [get_bd_pins adc_sink_i/s12_tdata] [get_bd_pins signal_detect/adc_axis_tdata6] [get_bd_pins usp_rf_data_converter_0/m12_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m12_axis_tvalid [get_bd_pins adc_sink_i/s12_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid6] [get_bd_pins usp_rf_data_converter_0/m12_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m13_axis_tdata [get_bd_pins adc_sink_i/s13_tdata] [get_bd_pins signal_detect/adc_axis_tdata7] [get_bd_pins usp_rf_data_converter_0/m13_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m13_axis_tvalid [get_bd_pins adc_sink_i/s13_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid7] [get_bd_pins usp_rf_data_converter_0/m13_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m20_axis_tdata [get_bd_pins adc_sink_i/s20_tdata] [get_bd_pins signal_detect/adc_axis_tdata8] [get_bd_pins usp_rf_data_converter_0/m20_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m20_axis_tvalid [get_bd_pins adc_sink_i/s20_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid8] [get_bd_pins usp_rf_data_converter_0/m20_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m21_axis_tdata [get_bd_pins adc_sink_i/s21_tdata] [get_bd_pins signal_detect/adc_axis_tdata9] [get_bd_pins usp_rf_data_converter_0/m21_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m21_axis_tvalid [get_bd_pins adc_sink_i/s21_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid9] [get_bd_pins usp_rf_data_converter_0/m21_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m22_axis_tdata [get_bd_pins adc_sink_i/s22_tdata] [get_bd_pins signal_detect/adc_axis_tdata10] [get_bd_pins usp_rf_data_converter_0/m22_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m22_axis_tvalid [get_bd_pins adc_sink_i/s22_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid10] [get_bd_pins usp_rf_data_converter_0/m22_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m23_axis_tdata [get_bd_pins adc_sink_i/s23_tdata] [get_bd_pins signal_detect/adc_axis_tdata11] [get_bd_pins usp_rf_data_converter_0/m23_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m23_axis_tvalid [get_bd_pins adc_sink_i/s23_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid11] [get_bd_pins usp_rf_data_converter_0/m23_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m30_axis_tdata [get_bd_pins adc_sink_i/s30_tdata] [get_bd_pins signal_detect/adc_axis_tdata12] [get_bd_pins usp_rf_data_converter_0/m30_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m30_axis_tvalid [get_bd_pins adc_sink_i/s30_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid12] [get_bd_pins usp_rf_data_converter_0/m30_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m31_axis_tdata [get_bd_pins adc_sink_i/s31_tdata] [get_bd_pins signal_detect/adc_axis_tdata13] [get_bd_pins usp_rf_data_converter_0/m31_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m31_axis_tvalid [get_bd_pins adc_sink_i/s31_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid13] [get_bd_pins usp_rf_data_converter_0/m31_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m32_axis_tdata [get_bd_pins adc_sink_i/s32_tdata] [get_bd_pins signal_detect/adc_axis_tdata14] [get_bd_pins usp_rf_data_converter_0/m32_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m32_axis_tvalid [get_bd_pins adc_sink_i/s32_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid14] [get_bd_pins usp_rf_data_converter_0/m32_axis_tvalid]
  connect_bd_net -net usp_rf_data_converter_0_m33_axis_tdata [get_bd_pins adc_sink_i/s33_tdata] [get_bd_pins signal_detect/adc_axis_tdata15] [get_bd_pins usp_rf_data_converter_0/m33_axis_tdata]
  connect_bd_net -net usp_rf_data_converter_0_m33_axis_tvalid [get_bd_pins adc_sink_i/s33_tvalid] [get_bd_pins signal_detect/adc_axis_tvalid15] [get_bd_pins usp_rf_data_converter_0/m33_axis_tvalid]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: clocking_block
proc create_hier_cell_clocking_block { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_clocking_block() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi_lite5


  # Create pins
  create_bd_pin -dir I -type clk clk_in1
  create_bd_pin -dir I -type clk clk_in2
  create_bd_pin -dir I -type clk clk_in3
  create_bd_pin -dir I -type clk clk_in4
  create_bd_pin -dir I -type clk clk_in5
  create_bd_pin -dir I -type clk clk_in6
  create_bd_pin -dir O -type clk clk_out1
  create_bd_pin -dir O -type clk clk_out2
  create_bd_pin -dir O -type clk clk_out3
  create_bd_pin -dir O -type clk clk_out4
  create_bd_pin -dir O -type clk clk_out5
  create_bd_pin -dir O locked
  create_bd_pin -dir O locked1
  create_bd_pin -dir O locked2
  create_bd_pin -dir O locked3
  create_bd_pin -dir O locked4
  create_bd_pin -dir O locked5
  create_bd_pin -dir O -type clk s0_axis_aclk
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: clk_wiz_adc0, and set properties
  set clk_wiz_adc0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_adc0 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {512.000} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.PRIM_IN_FREQ {256.000} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
 ] $clk_wiz_adc0

  # Create instance: clk_wiz_adc1, and set properties
  set clk_wiz_adc1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_adc1 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {512.000} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.PRIM_IN_FREQ {256.000} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
 ] $clk_wiz_adc1

  # Create instance: clk_wiz_adc2, and set properties
  set clk_wiz_adc2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_adc2 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {512.000} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.PRIM_IN_FREQ {256.000} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
 ] $clk_wiz_adc2

  # Create instance: clk_wiz_adc3, and set properties
  set clk_wiz_adc3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_adc3 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {512.000} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.PRIM_IN_FREQ {256.000} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
 ] $clk_wiz_adc3

  # Create instance: clk_wiz_dac0, and set properties
  set clk_wiz_dac0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_dac0 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {409.625} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.PRIM_IN_FREQ {409.625} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
 ] $clk_wiz_dac0

  # Create instance: clk_wiz_dac1, and set properties
  set clk_wiz_dac1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_dac1 ]
  set_property -dict [ list \
   CONFIG.AXI_DRP {false} \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {409.625} \
   CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
   CONFIG.PRIM_IN_FREQ {409.625} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
 ] $clk_wiz_dac1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axi_lite1] [get_bd_intf_pins clk_wiz_dac1/s_axi_lite]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axi_lite2] [get_bd_intf_pins clk_wiz_adc0/s_axi_lite]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axi_lite3] [get_bd_intf_pins clk_wiz_adc1/s_axi_lite]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axi_lite4] [get_bd_intf_pins clk_wiz_adc2/s_axi_lite]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axi_lite5] [get_bd_intf_pins clk_wiz_adc3/s_axi_lite]
  connect_bd_intf_net -intf_net ex_design_M03_AXI [get_bd_intf_pins s_axi_lite] [get_bd_intf_pins clk_wiz_dac0/s_axi_lite]

  # Create port connections
  connect_bd_net -net clk_in2_1 [get_bd_pins clk_in2] [get_bd_pins clk_wiz_dac1/clk_in1]
  connect_bd_net -net clk_in3_1 [get_bd_pins clk_in3] [get_bd_pins clk_wiz_adc0/clk_in1]
  connect_bd_net -net clk_in4_1 [get_bd_pins clk_in4] [get_bd_pins clk_wiz_adc1/clk_in1]
  connect_bd_net -net clk_in5_1 [get_bd_pins clk_in5] [get_bd_pins clk_wiz_adc2/clk_in1]
  connect_bd_net -net clk_in6_1 [get_bd_pins clk_in6] [get_bd_pins clk_wiz_adc3/clk_in1]
  connect_bd_net -net clk_wiz_adc0_clk_out1 [get_bd_pins clk_out2] [get_bd_pins clk_wiz_adc0/clk_out1]
  connect_bd_net -net clk_wiz_adc0_locked [get_bd_pins locked2] [get_bd_pins clk_wiz_adc0/locked]
  connect_bd_net -net clk_wiz_adc1_clk_out1 [get_bd_pins clk_out3] [get_bd_pins clk_wiz_adc1/clk_out1]
  connect_bd_net -net clk_wiz_adc1_locked [get_bd_pins locked3] [get_bd_pins clk_wiz_adc1/locked]
  connect_bd_net -net clk_wiz_adc2_clk_out1 [get_bd_pins clk_out4] [get_bd_pins clk_wiz_adc2/clk_out1]
  connect_bd_net -net clk_wiz_adc2_locked [get_bd_pins locked4] [get_bd_pins clk_wiz_adc2/locked]
  connect_bd_net -net clk_wiz_adc3_clk_out1 [get_bd_pins clk_out5] [get_bd_pins clk_wiz_adc3/clk_out1]
  connect_bd_net -net clk_wiz_adc3_locked [get_bd_pins locked5] [get_bd_pins clk_wiz_adc3/locked]
  connect_bd_net -net clk_wiz_dac0_clk_out1 [get_bd_pins s0_axis_aclk] [get_bd_pins clk_wiz_dac0/clk_out1]
  connect_bd_net -net clk_wiz_dac0_locked [get_bd_pins locked] [get_bd_pins clk_wiz_dac0/locked]
  connect_bd_net -net clk_wiz_dac1_clk_out1 [get_bd_pins clk_out1] [get_bd_pins clk_wiz_dac1/clk_out1]
  connect_bd_net -net clk_wiz_dac1_locked [get_bd_pins locked1] [get_bd_pins clk_wiz_dac1/locked]
  connect_bd_net -net ex_design_clk_dac0 [get_bd_pins clk_in1] [get_bd_pins clk_wiz_dac0/clk_in1]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins s_axi_aclk] [get_bd_pins clk_wiz_adc0/s_axi_aclk] [get_bd_pins clk_wiz_adc1/s_axi_aclk] [get_bd_pins clk_wiz_adc2/s_axi_aclk] [get_bd_pins clk_wiz_adc3/s_axi_aclk] [get_bd_pins clk_wiz_dac0/s_axi_aclk] [get_bd_pins clk_wiz_dac1/s_axi_aclk]
  connect_bd_net -net rst_s_axi_aclk_57M_interconnect_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins clk_wiz_adc0/s_axi_aresetn] [get_bd_pins clk_wiz_adc1/s_axi_aresetn] [get_bd_pins clk_wiz_adc2/s_axi_aresetn] [get_bd_pins clk_wiz_adc3/s_axi_aresetn] [get_bd_pins clk_wiz_dac0/s_axi_aresetn] [get_bd_pins clk_wiz_dac1/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set adc0_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc0_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $adc0_clk

  set adc1_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc1_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $adc1_clk

  set adc2_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc2_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $adc2_clk

  set adc3_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc3_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {245760000.0} \
   ] $adc3_clk

  set dac0_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dac0_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $dac0_clk

  set dac1_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dac1_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $dac1_clk

  set sysref_in [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_usp_rf_data_converter:diff_pins_rtl:1.0 sysref_in ]

  set vin0_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin0_01 ]

  set vin0_23 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin0_23 ]

  set vin1_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin1_01 ]

  set vin1_23 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin1_23 ]

  set vin2_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin2_01 ]

  set vin2_23 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin2_23 ]

  set vin3_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin3_01 ]

  set vin3_23 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin3_23 ]

  set vout00 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout00 ]

  set vout01 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout01 ]

  set vout02 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout02 ]

  set vout03 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout03 ]

  set vout10 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout10 ]

  set vout11 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout11 ]

  set vout12 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout12 ]

  set vout13 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout13 ]


  # Create ports
  set lmk04208_spi_cs_n [ create_bd_port -dir O -from 0 -to 0 lmk04208_spi_cs_n ]
  set lmk04208_spi_miso [ create_bd_port -dir I lmk04208_spi_miso ]
  set lmk04208_spi_mosi [ create_bd_port -dir O lmk04208_spi_mosi ]
  set lmk04208_spi_sck [ create_bd_port -dir O lmk04208_spi_sck ]
  set lmx2594_spi_cs_n [ create_bd_port -dir O -from 2 -to 0 lmx2594_spi_cs_n ]
  set lmx2594_spi_miso [ create_bd_port -dir I -from 2 -to 0 lmx2594_spi_miso ]
  set lmx2594_spi_mosi [ create_bd_port -dir O lmx2594_spi_mosi ]
  set lmx2594_spi_sck [ create_bd_port -dir O lmx2594_spi_sck ]

  # Create instance: clocking_block
  create_hier_cell_clocking_block [current_bd_instance .] clocking_block

  # Create instance: ex_design
  create_hier_cell_ex_design [current_bd_instance .] ex_design

  # Create instance: gnd_0, and set properties
  set gnd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 gnd_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $gnd_0

  # Create instance: gnd_256, and set properties
  set gnd_256 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 gnd_256 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {256} \
 ] $gnd_256

  # Create instance: jtag_axi_0, and set properties
  set jtag_axi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0 ]

  # Create instance: lmk04208
  create_hier_cell_lmk04208 [current_bd_instance .] lmk04208

  # Create instance: lmx2594
  create_hier_cell_lmx2594 [current_bd_instance .] lmx2594

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_DBG_REG_ACCESS {1} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_S_AXI_ADDR_WIDTH {5} \
   CONFIG.C_USE_UART {1} \
 ] $mdm_1

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_I_LMB {1} \
   CONFIG.C_PVR {1} \
   CONFIG.C_PVR_USER1 {0x04} \
   CONFIG.C_USE_STACK_PROTECTION {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: rst_ps8_0_99M, and set properties
  set rst_ps8_0_99M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_0_99M ]

  # Create instance: rst_s_axi_aclk_57M, and set properties
  set rst_s_axi_aclk_57M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_s_axi_aclk_57M ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create instance: zynq_ultra_ps_e_0, and set properties
  set zynq_ultra_ps_e_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e_0 ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0x1FFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_POLARITY {Default} \
   CONFIG.PSU_MIO_18_DIRECTION {inout} \
   CONFIG.PSU_MIO_18_POLARITY {Default} \
   CONFIG.PSU_MIO_19_DIRECTION {inout} \
   CONFIG.PSU_MIO_19_POLARITY {Default} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_20_DIRECTION {inout} \
   CONFIG.PSU_MIO_20_POLARITY {Default} \
   CONFIG.PSU_MIO_21_DIRECTION {inout} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_22_DIRECTION {out} \
   CONFIG.PSU_MIO_22_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_23_DIRECTION {out} \
   CONFIG.PSU_MIO_23_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_23_POLARITY {Default} \
   CONFIG.PSU_MIO_24_DIRECTION {inout} \
   CONFIG.PSU_MIO_24_POLARITY {Default} \
   CONFIG.PSU_MIO_25_DIRECTION {inout} \
   CONFIG.PSU_MIO_25_POLARITY {Default} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_31_DIRECTION {out} \
   CONFIG.PSU_MIO_31_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_31_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_31_SLEW {fast} \
   CONFIG.PSU_MIO_34_DIRECTION {in} \
   CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_34_SLEW {fast} \
   CONFIG.PSU_MIO_35_DIRECTION {out} \
   CONFIG.PSU_MIO_35_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_43_DIRECTION {out} \
   CONFIG.PSU_MIO_43_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_43_POLARITY {Default} \
   CONFIG.PSU_MIO_44_DIRECTION {in} \
   CONFIG.PSU_MIO_44_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_44_POLARITY {Default} \
   CONFIG.PSU_MIO_44_PULLUPDOWN {pullup} \
   CONFIG.PSU_MIO_44_SLEW {fast} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_POLARITY {Default} \
   CONFIG.PSU_MIO_45_SLEW {fast} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_POLARITY {Default} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_POLARITY {Default} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_POLARITY {Default} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_51_POLARITY {Default} \
   CONFIG.PSU_MIO_52_DIRECTION {out} \
   CONFIG.PSU_MIO_52_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_52_POLARITY {Default} \
   CONFIG.PSU_MIO_53_DIRECTION {out} \
   CONFIG.PSU_MIO_53_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_53_POLARITY {Default} \
   CONFIG.PSU_MIO_54_DIRECTION {out} \
   CONFIG.PSU_MIO_54_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_54_POLARITY {Default} \
   CONFIG.PSU_MIO_55_DIRECTION {out} \
   CONFIG.PSU_MIO_55_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_55_POLARITY {Default} \
   CONFIG.PSU_MIO_56_DIRECTION {out} \
   CONFIG.PSU_MIO_56_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_56_POLARITY {Default} \
   CONFIG.PSU_MIO_57_DIRECTION {out} \
   CONFIG.PSU_MIO_57_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_57_POLARITY {Default} \
   CONFIG.PSU_MIO_58_DIRECTION {in} \
   CONFIG.PSU_MIO_58_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_58_POLARITY {Default} \
   CONFIG.PSU_MIO_58_SLEW {fast} \
   CONFIG.PSU_MIO_59_DIRECTION {in} \
   CONFIG.PSU_MIO_59_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_59_POLARITY {Default} \
   CONFIG.PSU_MIO_59_SLEW {fast} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_60_DIRECTION {in} \
   CONFIG.PSU_MIO_60_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_60_POLARITY {Default} \
   CONFIG.PSU_MIO_60_SLEW {fast} \
   CONFIG.PSU_MIO_61_DIRECTION {in} \
   CONFIG.PSU_MIO_61_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_61_POLARITY {Default} \
   CONFIG.PSU_MIO_61_SLEW {fast} \
   CONFIG.PSU_MIO_62_DIRECTION {in} \
   CONFIG.PSU_MIO_62_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_62_POLARITY {Default} \
   CONFIG.PSU_MIO_62_SLEW {fast} \
   CONFIG.PSU_MIO_63_DIRECTION {in} \
   CONFIG.PSU_MIO_63_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_63_POLARITY {Default} \
   CONFIG.PSU_MIO_63_SLEW {fast} \
   CONFIG.PSU_MIO_64_DIRECTION {in} \
   CONFIG.PSU_MIO_64_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_64_POLARITY {Default} \
   CONFIG.PSU_MIO_64_SLEW {fast} \
   CONFIG.PSU_MIO_65_DIRECTION {in} \
   CONFIG.PSU_MIO_65_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_65_POLARITY {Default} \
   CONFIG.PSU_MIO_65_SLEW {fast} \
   CONFIG.PSU_MIO_66_DIRECTION {inout} \
   CONFIG.PSU_MIO_66_POLARITY {Default} \
   CONFIG.PSU_MIO_67_DIRECTION {in} \
   CONFIG.PSU_MIO_67_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_67_POLARITY {Default} \
   CONFIG.PSU_MIO_67_SLEW {fast} \
   CONFIG.PSU_MIO_68_DIRECTION {inout} \
   CONFIG.PSU_MIO_68_POLARITY {Default} \
   CONFIG.PSU_MIO_69_DIRECTION {inout} \
   CONFIG.PSU_MIO_69_POLARITY {Default} \
   CONFIG.PSU_MIO_70_DIRECTION {out} \
   CONFIG.PSU_MIO_70_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_70_POLARITY {Default} \
   CONFIG.PSU_MIO_71_DIRECTION {inout} \
   CONFIG.PSU_MIO_71_POLARITY {Default} \
   CONFIG.PSU_MIO_72_DIRECTION {inout} \
   CONFIG.PSU_MIO_72_POLARITY {Default} \
   CONFIG.PSU_MIO_73_DIRECTION {inout} \
   CONFIG.PSU_MIO_73_POLARITY {Default} \
   CONFIG.PSU_MIO_74_DIRECTION {inout} \
   CONFIG.PSU_MIO_74_POLARITY {Default} \
   CONFIG.PSU_MIO_75_DIRECTION {inout} \
   CONFIG.PSU_MIO_75_POLARITY {Default} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash##Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#I2C 1#I2C 1######PCIE###UART 0#UART 0########SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#Gem 2#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#USB 1#MDIO 2#MDIO 2} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out##n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#sdio0_data_out[0]#sdio0_data_out[1]#sdio0_data_out[2]#sdio0_data_out[3]#sdio0_data_out[4]#sdio0_data_out[5]#sdio0_data_out[6]#sdio0_data_out[7]#sdio0_cmd_out#sdio0_clk_out#sdio0_bus_pow#scl_out#sda_out######reset_n###rxd#txd########sdio1_bus_pow#sdio1_wp#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#gem2_mdc#gem2_mdio_out} \
   CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {4} \
   CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1199.988037} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.988037} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {63} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {10} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {64} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {266.664001} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {299.997009} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {48} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {199.998001} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {49.999500} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {16} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {50} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {33.333000} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
   CONFIG.PSU__DDRC__CL {17} \
   CONFIG.PSU__DDRC__CWL {16} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {16384 MBits} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {17} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400T} \
   CONFIG.PSU__DDRC__T_FAW {30} \
   CONFIG.PSU__DDRC__T_RAS_MIN {35.0} \
   CONFIG.PSU__DDRC__T_RC {46.16} \
   CONFIG.PSU__DDRC__T_RCD {17} \
   CONFIG.PSU__DDRC__T_RP {17} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {600.000} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__ENET2__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET2__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET2__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET2__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__ENET2__PTP__ENABLE {0} \
   CONFIG.PSU__ENET2__TSU__ENABLE {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__GEM2_COHERENCY {0} \
   CONFIG.PSU__GEM2_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 24 .. 25} \
   CONFIG.PSU__PCIE__BAR0_64BIT {0} \
   CONFIG.PSU__PCIE__BAR0_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR0_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR0_SCALE {<Select>} \
   CONFIG.PSU__PCIE__BAR0_SIZE {<Select>} \
   CONFIG.PSU__PCIE__BAR0_TYPE {<Select>} \
   CONFIG.PSU__PCIE__BAR0_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR1_64BIT {0} \
   CONFIG.PSU__PCIE__BAR1_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR1_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR1_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR2_64BIT {0} \
   CONFIG.PSU__PCIE__BAR2_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR2_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR2_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR3_64BIT {0} \
   CONFIG.PSU__PCIE__BAR3_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR3_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR3_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR4_64BIT {0} \
   CONFIG.PSU__PCIE__BAR4_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR4_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR4_VAL {0x0} \
   CONFIG.PSU__PCIE__BAR5_64BIT {0} \
   CONFIG.PSU__PCIE__BAR5_ENABLE {0} \
   CONFIG.PSU__PCIE__BAR5_PREFETCHABLE {0} \
   CONFIG.PSU__PCIE__BAR5_VAL {0x0} \
   CONFIG.PSU__PCIE__BRIDGE_BAR_INDICATOR {<Select>} \
   CONFIG.PSU__PCIE__CLASS_CODE_BASE {0x06} \
   CONFIG.PSU__PCIE__CLASS_CODE_INTERFACE {0x0} \
   CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x04} \
   CONFIG.PSU__PCIE__CLASS_CODE_VALUE {0x60400} \
   CONFIG.PSU__PCIE__CRS_SW_VISIBILITY {1} \
   CONFIG.PSU__PCIE__DEVICE_ID {0xD011} \
   CONFIG.PSU__PCIE__DEVICE_PORT_TYPE {Root Port} \
   CONFIG.PSU__PCIE__EROM_ENABLE {0} \
   CONFIG.PSU__PCIE__EROM_VAL {0x0} \
   CONFIG.PSU__PCIE__INTX_GENERATION {1} \
   CONFIG.PSU__PCIE__INTX_PIN {<Select>} \
   CONFIG.PSU__PCIE__LANE0__ENABLE {1} \
   CONFIG.PSU__PCIE__LANE0__IO {GT Lane0} \
   CONFIG.PSU__PCIE__LANE1__ENABLE {1} \
   CONFIG.PSU__PCIE__LANE1__IO {GT Lane1} \
   CONFIG.PSU__PCIE__LANE2__ENABLE {1} \
   CONFIG.PSU__PCIE__LANE2__IO {GT Lane2} \
   CONFIG.PSU__PCIE__LANE3__ENABLE {1} \
   CONFIG.PSU__PCIE__LANE3__IO {GT Lane3} \
   CONFIG.PSU__PCIE__LINK_SPEED {5.0 Gb/s} \
   CONFIG.PSU__PCIE__MAXIMUM_LINK_WIDTH {x4} \
   CONFIG.PSU__PCIE__MAX_PAYLOAD_SIZE {256 bytes} \
   CONFIG.PSU__PCIE__MSIX_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_CAPABILITY {0} \
   CONFIG.PSU__PCIE__MSIX_PBA_BAR_INDICATOR {} \
   CONFIG.PSU__PCIE__MSIX_PBA_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_OFFSET {0} \
   CONFIG.PSU__PCIE__MSIX_TABLE_SIZE {0} \
   CONFIG.PSU__PCIE__MSI_64BIT_ADDR_CAPABLE {0} \
   CONFIG.PSU__PCIE__MSI_CAPABILITY {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_ENABLE {0} \
   CONFIG.PSU__PCIE__PERIPHERAL__ENDPOINT_IO {<Select>} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_ENABLE {1} \
   CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_IO {MIO 31} \
   CONFIG.PSU__PCIE__REF_CLK_FREQ {100} \
   CONFIG.PSU__PCIE__REF_CLK_SEL {Ref Clk0} \
   CONFIG.PSU__PCIE__RESET__POLARITY {Active High} \
   CONFIG.PSU__PCIE__REVISION_ID {0x0} \
   CONFIG.PSU__PCIE__SUBSYSTEM_ID {0x7} \
   CONFIG.PSU__PCIE__SUBSYSTEM_VENDOR_ID {0x10EE} \
   CONFIG.PSU__PCIE__VENDOR_ID {0x10EE} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;1|USB0:NonSecure;0|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;0|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;0|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;1|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;1|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;0|GEM2:NonSecure;1|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;0|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;1|LPD;USB3_1;FF9E0000;FF9EFFFF;1|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;0|LPD;USB3_0;FF9D0000;FF9DFFFF;0|LPD;UART1;FF010000;FF01FFFF;0|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;0|LPD;TTC2;FF130000;FF13FFFF;0|LPD;TTC1;FF120000;FF12FFFF;0|LPD;TTC0;FF110000;FF11FFFF;0|FPD;SWDT1;FD4D0000;FD4DFFFF;0|LPD;SWDT0;FF150000;FF15FFFF;0|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;1|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;1|FPD;PCIE_LOW;E0000000;EFFFFFFF;1|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;1|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;1|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;1|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;1|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;0|FPD;GPU;FD4B0000;FD4BFFFF;0|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;0|LPD;GEM2;FF0D0000;FF0DFFFF;1|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_GPV;FD700000;FD7FFFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;0|FPD;DPDMA;FD4C0000;FD4CFFFF;0|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;97FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;0|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|FPD;CCI_GPV;FD6E0000;FD6EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {0} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SD0_COHERENCY {0} \
   CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD0__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD0__GRP_CD__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_POW__ENABLE {1} \
   CONFIG.PSU__SD0__GRP_POW__IO {MIO 23} \
   CONFIG.PSU__SD0__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 22} \
   CONFIG.PSU__SD0__RESET__ENABLE {1} \
   CONFIG.PSU__SD0__SLOT_TYPE {eMMC} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {4Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 46 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 2.0} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 34 .. 35} \
   CONFIG.PSU__USB0__RESET__ENABLE {0} \
   CONFIG.PSU__USB1_COHERENCY {0} \
   CONFIG.PSU__USB1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB1__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__USB1__RESET__ENABLE {0} \
   CONFIG.PSU__USB2_1__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_1__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
   CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.SUBPRESET1 {Custom} \
 ] $zynq_ultra_ps_e_0

  # Create interface connections
  connect_bd_intf_net -intf_net adc0_clk_1 [get_bd_intf_ports adc0_clk] [get_bd_intf_pins ex_design/adc0_clk]
  connect_bd_intf_net -intf_net adc1_clk_1 [get_bd_intf_ports adc1_clk] [get_bd_intf_pins ex_design/adc1_clk]
  connect_bd_intf_net -intf_net adc2_clk_1 [get_bd_intf_ports adc2_clk] [get_bd_intf_pins ex_design/adc2_clk]
  connect_bd_intf_net -intf_net adc3_clk_1 [get_bd_intf_ports adc3_clk] [get_bd_intf_pins ex_design/adc3_clk]
  connect_bd_intf_net -intf_net dac0_clk_1 [get_bd_intf_ports dac0_clk] [get_bd_intf_pins ex_design/dac0_clk]
  connect_bd_intf_net -intf_net dac1_clk_1 [get_bd_intf_ports dac1_clk] [get_bd_intf_pins ex_design/dac1_clk]
  connect_bd_intf_net -intf_net ex_design_M03_AXI [get_bd_intf_pins clocking_block/s_axi_lite] [get_bd_intf_pins ex_design/M03_AXI]
  connect_bd_intf_net -intf_net ex_design_M04_AXI [get_bd_intf_pins clocking_block/s_axi_lite1] [get_bd_intf_pins ex_design/M04_AXI]
  connect_bd_intf_net -intf_net ex_design_M05_AXI [get_bd_intf_pins clocking_block/s_axi_lite2] [get_bd_intf_pins ex_design/M05_AXI]
  connect_bd_intf_net -intf_net ex_design_M06_AXI [get_bd_intf_pins clocking_block/s_axi_lite3] [get_bd_intf_pins ex_design/M06_AXI]
  connect_bd_intf_net -intf_net ex_design_M07_AXI [get_bd_intf_pins clocking_block/s_axi_lite4] [get_bd_intf_pins ex_design/M07_AXI]
  connect_bd_intf_net -intf_net ex_design_M08_AXI [get_bd_intf_pins clocking_block/s_axi_lite5] [get_bd_intf_pins ex_design/M08_AXI]
  connect_bd_intf_net -intf_net ex_design_M09_AXI [get_bd_intf_pins ex_design/M09_AXI] [get_bd_intf_pins mdm_1/S_AXI]
  connect_bd_intf_net -intf_net ex_design_vout00 [get_bd_intf_ports vout00] [get_bd_intf_pins ex_design/vout00]
  connect_bd_intf_net -intf_net ex_design_vout01 [get_bd_intf_ports vout01] [get_bd_intf_pins ex_design/vout01]
  connect_bd_intf_net -intf_net ex_design_vout02 [get_bd_intf_ports vout02] [get_bd_intf_pins ex_design/vout02]
  connect_bd_intf_net -intf_net ex_design_vout03 [get_bd_intf_ports vout03] [get_bd_intf_pins ex_design/vout03]
  connect_bd_intf_net -intf_net ex_design_vout10 [get_bd_intf_ports vout10] [get_bd_intf_pins ex_design/vout10]
  connect_bd_intf_net -intf_net ex_design_vout11 [get_bd_intf_ports vout11] [get_bd_intf_pins ex_design/vout11]
  connect_bd_intf_net -intf_net ex_design_vout12 [get_bd_intf_ports vout12] [get_bd_intf_pins ex_design/vout12]
  connect_bd_intf_net -intf_net ex_design_vout13 [get_bd_intf_ports vout13] [get_bd_intf_pins ex_design/vout13]
  connect_bd_intf_net -intf_net jtag_axi_0_M_AXI [get_bd_intf_pins ex_design/S00_AXI] [get_bd_intf_pins jtag_axi_0/M_AXI]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins ex_design/S01_AXI] [get_bd_intf_pins microblaze_0/M_AXI_DP]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins lmk04208/AXI_LITE] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins lmx2594/AXI_LITE] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net sysref_in_1 [get_bd_intf_ports sysref_in] [get_bd_intf_pins ex_design/sysref_in]
  connect_bd_intf_net -intf_net vin0_01_1 [get_bd_intf_ports vin0_01] [get_bd_intf_pins ex_design/vin0_01]
  connect_bd_intf_net -intf_net vin0_23_1 [get_bd_intf_ports vin0_23] [get_bd_intf_pins ex_design/vin0_23]
  connect_bd_intf_net -intf_net vin1_01_1 [get_bd_intf_ports vin1_01] [get_bd_intf_pins ex_design/vin1_01]
  connect_bd_intf_net -intf_net vin1_23_1 [get_bd_intf_ports vin1_23] [get_bd_intf_pins ex_design/vin1_23]
  connect_bd_intf_net -intf_net vin2_01_1 [get_bd_intf_ports vin2_01] [get_bd_intf_pins ex_design/vin2_01]
  connect_bd_intf_net -intf_net vin2_23_1 [get_bd_intf_ports vin2_23] [get_bd_intf_pins ex_design/vin2_23]
  connect_bd_intf_net -intf_net vin3_01_1 [get_bd_intf_ports vin3_01] [get_bd_intf_pins ex_design/vin3_01]
  connect_bd_intf_net -intf_net vin3_23_1 [get_bd_intf_ports vin3_23] [get_bd_intf_pins ex_design/vin3_23]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_0_M_AXI_HPM0_LPD [get_bd_intf_pins smartconnect_0/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e_0/M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net clk_wiz_adc0_clk_out1 [get_bd_pins clocking_block/clk_out2] [get_bd_pins ex_design/m0_axis_aclk]
  connect_bd_net -net clk_wiz_adc1_clk_out1 [get_bd_pins clocking_block/clk_out3] [get_bd_pins ex_design/m1_axis_aclk]
  connect_bd_net -net clk_wiz_adc2_clk_out1 [get_bd_pins clocking_block/clk_out4] [get_bd_pins ex_design/m2_axis_aclk]
  connect_bd_net -net clk_wiz_adc3_clk_out1 [get_bd_pins clocking_block/clk_out5] [get_bd_pins ex_design/m3_axis_aclk]
  connect_bd_net -net clk_wiz_dac0_clk_out1 [get_bd_pins clocking_block/s0_axis_aclk] [get_bd_pins ex_design/s0_axis_aclk]
  connect_bd_net -net clk_wiz_dac0_locked [get_bd_pins clocking_block/locked] [get_bd_pins ex_design/s0_axis_aresetn]
  connect_bd_net -net clk_wiz_dac1_clk_out1 [get_bd_pins clocking_block/clk_out1] [get_bd_pins ex_design/s1_axis_aclk]
  connect_bd_net -net ex_design_clk_adc0 [get_bd_pins clocking_block/clk_in3] [get_bd_pins ex_design/clk_adc0]
  connect_bd_net -net ex_design_clk_adc1 [get_bd_pins clocking_block/clk_in4] [get_bd_pins ex_design/clk_adc1]
  connect_bd_net -net ex_design_clk_adc2 [get_bd_pins clocking_block/clk_in5] [get_bd_pins ex_design/clk_adc2]
  connect_bd_net -net ex_design_clk_adc3 [get_bd_pins clocking_block/clk_in6] [get_bd_pins ex_design/clk_adc3]
  connect_bd_net -net ex_design_clk_dac0 [get_bd_pins clocking_block/clk_in1] [get_bd_pins ex_design/clk_dac0]
  connect_bd_net -net ex_design_clk_dac1 [get_bd_pins clocking_block/clk_in2] [get_bd_pins ex_design/clk_dac1]
  connect_bd_net -net gnd_0_dout [get_bd_pins ex_design/m00_0_tready] [get_bd_pins ex_design/m01_0_tready] [get_bd_pins ex_design/m02_0_tready] [get_bd_pins ex_design/m03_0_tready] [get_bd_pins ex_design/m10_0_tready] [get_bd_pins ex_design/m11_0_tready] [get_bd_pins ex_design/m12_0_tready] [get_bd_pins ex_design/m13_0_tready] [get_bd_pins ex_design/m20_0_tready] [get_bd_pins ex_design/m21_0_tready] [get_bd_pins ex_design/m22_0_tready] [get_bd_pins ex_design/m23_0_tready] [get_bd_pins ex_design/m30_0_tready] [get_bd_pins ex_design/m31_0_tready] [get_bd_pins ex_design/m32_0_tready] [get_bd_pins ex_design/m33_0_tready] [get_bd_pins ex_design/s00_0_tvalid] [get_bd_pins ex_design/s01_0_tvalid] [get_bd_pins ex_design/s02_0_tvalid] [get_bd_pins ex_design/s03_0_tvalid] [get_bd_pins ex_design/s10_0_tvalid] [get_bd_pins ex_design/s11_0_tvalid] [get_bd_pins ex_design/s12_0_tvalid] [get_bd_pins ex_design/s13_0_tvalid] [get_bd_pins ex_design/user_select_00_0] [get_bd_pins ex_design/user_select_01_0] [get_bd_pins ex_design/user_select_02_0] [get_bd_pins ex_design/user_select_03_0] [get_bd_pins ex_design/user_select_10_0] [get_bd_pins ex_design/user_select_11_0] [get_bd_pins ex_design/user_select_12_0] [get_bd_pins ex_design/user_select_13_0] [get_bd_pins gnd_0/dout]
  connect_bd_net -net gnd_256_dout [get_bd_pins ex_design/s00_0_tdata] [get_bd_pins ex_design/s01_0_tdata] [get_bd_pins ex_design/s02_0_tdata] [get_bd_pins ex_design/s03_0_tdata] [get_bd_pins ex_design/s10_0_tdata] [get_bd_pins ex_design/s11_0_tdata] [get_bd_pins ex_design/s12_0_tdata] [get_bd_pins ex_design/s13_0_tdata] [get_bd_pins gnd_256/dout]
  connect_bd_net -net lmk04208_ip2intc_irpt [get_bd_pins lmk04208/ip2intc_irpt] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net lmk04208_spi_miso_0_1 [get_bd_ports lmk04208_spi_miso] [get_bd_pins lmk04208/lmk04208_spi_miso]
  connect_bd_net -net lmx2594_ip2intc_irpt [get_bd_pins lmx2594/ip2intc_irpt] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net lmx2594_lmx2594_spi_cs_n [get_bd_ports lmx2594_spi_cs_n] [get_bd_pins lmx2594/lmx2594_spi_cs_n]
  connect_bd_net -net lmx2594_lmx2594_spi_mosi [get_bd_ports lmx2594_spi_mosi] [get_bd_pins lmx2594/lmx2594_spi_mosi]
  connect_bd_net -net lmx2594_lmx2594_spi_sck [get_bd_ports lmx2594_spi_sck] [get_bd_pins lmx2594/lmx2594_spi_sck]
  connect_bd_net -net lmx2594_spi_miso_0_1 [get_bd_ports lmx2594_spi_miso] [get_bd_pins lmx2594/lmx2594_spi_miso]
  connect_bd_net -net m0_axis_aresetn_1 [get_bd_pins clocking_block/locked2] [get_bd_pins ex_design/m0_axis_aresetn]
  connect_bd_net -net m1_axis_aresetn_1 [get_bd_pins clocking_block/locked3] [get_bd_pins ex_design/m1_axis_aresetn]
  connect_bd_net -net m2_axis_aresetn_1 [get_bd_pins clocking_block/locked4] [get_bd_pins ex_design/m2_axis_aresetn]
  connect_bd_net -net m3_axis_aresetn_1 [get_bd_pins clocking_block/locked5] [get_bd_pins ex_design/m3_axis_aresetn]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_s_axi_aclk_57M/mb_debug_sys_rst]
  connect_bd_net -net rf_clk_lmk04208_spi_cs_n [get_bd_ports lmk04208_spi_cs_n] [get_bd_pins lmk04208/lmk04208_spi_cs_n]
  connect_bd_net -net rf_clk_lmk04208_spi_mosi [get_bd_ports lmk04208_spi_mosi] [get_bd_pins lmk04208/lmk04208_spi_mosi]
  connect_bd_net -net rf_clk_lmk04208_spi_sck [get_bd_ports lmk04208_spi_sck] [get_bd_pins lmk04208/lmk04208_spi_sck]
  connect_bd_net -net rst_ps8_0_99M_interconnect_aresetn [get_bd_pins rst_ps8_0_99M/interconnect_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net rst_ps8_0_99M_peripheral_aresetn [get_bd_pins lmk04208/s_axi_aresetn] [get_bd_pins lmx2594/s_axi_aresetn] [get_bd_pins rst_ps8_0_99M/peripheral_aresetn]
  connect_bd_net -net rst_s_axi_aclk_57M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_s_axi_aclk_57M/bus_struct_reset]
  connect_bd_net -net rst_s_axi_aclk_57M_interconnect_aresetn [get_bd_pins clocking_block/s_axi_aresetn] [get_bd_pins rst_s_axi_aclk_57M/interconnect_aresetn]
  connect_bd_net -net rst_s_axi_aclk_57M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_s_axi_aclk_57M/mb_reset]
  connect_bd_net -net rst_s_axi_aclk_57M_peripheral_aresetn [get_bd_pins ex_design/s_axi_aresetn] [get_bd_pins jtag_axi_0/aresetn] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins rst_s_axi_aclk_57M/peripheral_aresetn]
  connect_bd_net -net s1_axis_aresetn_1 [get_bd_pins clocking_block/locked1] [get_bd_pins ex_design/s1_axis_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xlconcat_0/dout] [get_bd_pins zynq_ultra_ps_e_0/pl_ps_irq0]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_clk0 [get_bd_pins clocking_block/s_axi_aclk] [get_bd_pins ex_design/s_axi_aclk] [get_bd_pins jtag_axi_0/aclk] [get_bd_pins lmk04208/s_axi_aclk] [get_bd_pins lmx2594/s_axi_aclk] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_local_memory/s_axi_aclk] [get_bd_pins rst_ps8_0_99M/slowest_sync_clk] [get_bd_pins rst_s_axi_aclk_57M/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins zynq_ultra_ps_e_0/maxihpm0_lpd_aclk] [get_bd_pins zynq_ultra_ps_e_0/pl_clk0]
  connect_bd_net -net zynq_ultra_ps_e_0_pl_resetn0 [get_bd_pins rst_ps8_0_99M/ext_reset_in] [get_bd_pins rst_s_axi_aclk_57M/ext_reset_in] [get_bd_pins zynq_ultra_ps_e_0/pl_resetn0]

  # Create address segments
  create_bd_addr_seg -range 0x00100000 -offset 0xE0000000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs ex_design/adc_sink_i/s_axi/reg0] SEG_adc_sink_i_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44C40000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc0/s_axi_lite/Reg] SEG_clk_wiz_adc0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C50000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc1/s_axi_lite/Reg] SEG_clk_wiz_adc1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C60000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc2/s_axi_lite/Reg] SEG_clk_wiz_adc2_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C70000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc3/s_axi_lite/Reg] SEG_clk_wiz_adc3_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C00000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_dac0/s_axi_lite/Reg] SEG_clk_wiz_dac0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C10000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_dac1/s_axi_lite/Reg] SEG_clk_wiz_dac1_Reg
  create_bd_addr_seg -range 0x00100000 -offset 0xC0000000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs ex_design/dac_source_i/s_axi/reg0] SEG_dac_source_i_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs mdm_1/S_AXI/Reg] SEG_mdm_1_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0x44B00000 [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs ex_design/usp_rf_data_converter_0/s_axi/Reg] SEG_usp_rf_data_converter_0_Reg
  create_bd_addr_seg -range 0x00100000 -offset 0xE0000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs ex_design/adc_sink_i/s_axi/reg0] SEG_adc_sink_i_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44C40000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc0/s_axi_lite/Reg] SEG_clk_wiz_adc0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C50000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc1/s_axi_lite/Reg] SEG_clk_wiz_adc1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C60000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc2/s_axi_lite/Reg] SEG_clk_wiz_adc2_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C70000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_adc3/s_axi_lite/Reg] SEG_clk_wiz_adc3_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_dac0/s_axi_lite/Reg] SEG_clk_wiz_dac0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C10000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs clocking_block/clk_wiz_dac1/s_axi_lite/Reg] SEG_clk_wiz_dac1_Reg
  create_bd_addr_seg -range 0x00100000 -offset 0xC0000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs ex_design/dac_source_i/s_axi/reg0] SEG_dac_source_i_reg0
  create_bd_addr_seg -range 0x00080000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00080000 -offset 0x00000000 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_1/S_AXI/Reg] SEG_mdm_1_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0x44B00000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs ex_design/usp_rf_data_converter_0/s_axi/Reg] SEG_usp_rf_data_converter_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x80000000 [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs lmk04208/spi/AXI_LITE/Reg] SEG_spi_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x80001000 [get_bd_addr_spaces zynq_ultra_ps_e_0/Data] [get_bd_addr_segs lmx2594/spi/AXI_LITE/Reg] SEG_spi_Reg1


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


