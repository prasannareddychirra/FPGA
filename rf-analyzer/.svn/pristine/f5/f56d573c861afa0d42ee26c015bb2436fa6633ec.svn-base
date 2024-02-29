#!/bin/sh

vivado_ver=2019.1
proj_name=krm-4zurf-rf-analyzer

# To ask and to collect the version of Vivado being used
# echo "Which version of Vivado do you plan to use ? (201X.X)"
# read vivado_ver

# To ask and to collect the name of the project
# echo "What the name of the project"
# read proj_name

# Open Vivado in script mode
/opt/Xilinx/Vivado/$vivado_ver/bin/vivado -mode batch -source scripts/vivado_make_project.tcl -tclargs $proj_name
