#----------------------------------------------------------------------
# Title      : Example top level constraints for UltraScale+ RF Data Converter
#----------------------------------------------------------------------
# File       : usp_rf_data_converter_0_example_design.xdc
#----------------------------------------------------------------------
# Description: Xilinx Constraint file for the example design for
#              UltraScale+ RF Data Converter core
#---------------------------------------------------------------------
#
# DISCLAIMER
# This disclaimer is not a license and does not grant any
# rights to the materials distributed herewith. Except as
# otherwise provided in a valid license issued to you by
# Xilinx, and to the maximum extent permitted by applicable
# law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
# WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
# AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
# BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
# INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
# (2) Xilinx shall not be liable (whether in contract or tort,
# including negligence, or under any other theory of
# liability) for any loss or damage of any kind or nature
# related to, arising under or in connection with these
# materials, including for any direct, or any indirect,
# special, incidental, or consequential loss or damage
# (including loss of data, profits, goodwill, or any type of
# loss or damage suffered as a result of any action brought
# by a third party) even if such damage or loss was
# reasonably foreseeable or Xilinx had been advised of the
# possibility of the same.
# 
# CRITICAL APPLICATIONS
# Xilinx products are not designed or intended to be fail-
# safe, or for use in any application requiring fail-safe
# performance, such as life-support or safety devices or
# systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any
# other applications that could lead to death, personal
# injury, or severe property or environmental damage
# (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and
# liability of any use of Xilinx products in Critical
# Applications, subject only to applicable laws and
# regulations governing limitations on product liability.
# 
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
# PART OF THIS FILE AT ALL TIMES. 
#
#---------------------------------------------------------------------

#------------------------------------------
# TIMING CONSTRAINTS
#------------------------------------------
# Set AXI-Lite Clock to 57.5MHz
# create_clock -period 17.391 -name usp_rf_data_converter_0_axi_aclk [get_pins axi_aclk_i/CFGMCLK]

# ADC Reference Clock for Tile 0 running at 409.600 MHz
create_clock -period 2.441 -name usp_rf_data_converter_0_adc0_clk [get_ports adc0_clk_clk_p]

# ADC Reference Clock for Tile 1 running at 409.600 MHz
create_clock -period 2.441 -name usp_rf_data_converter_0_adc1_clk [get_ports adc1_clk_clk_p]

# ADC Reference Clock for Tile 2 running at 409.600 MHz
create_clock -period 2.441 -name usp_rf_data_converter_0_adc2_clk [get_ports adc2_clk_clk_p]

# ADC Reference Clock for Tile 3 running at 409.600 MHz
create_clock -period 2.441 -name usp_rf_data_converter_0_adc3_clk [get_ports adc3_clk_clk_p]

# DAC Reference Clock for Tile 0 running at 409.600 MHz
create_clock -period 2.441 -name usp_rf_data_converter_0_dac0_clk [get_ports dac0_clk_clk_p]

# DAC Reference Clock for Tile 1 running at 409.600 MHz
create_clock -period 2.441 -name usp_rf_data_converter_0_dac1_clk [get_ports dac1_clk_clk_p]

set_multicycle_path -to [get_pins -filter {REF_PIN_NAME== D} -of [get_cells -hier -filter {name =~ *block_design_i/ex_design/usp_rf_data_converter_0/inst/IP2Bus_Data_reg*}]] -setup 2
set_multicycle_path -to [get_pins -filter {REF_PIN_NAME== D} -of [get_cells -hier -filter {name =~ *block_design_i/ex_design/usp_rf_data_converter_0/inst/IP2Bus_Data_reg*}]] -hold 1
###############################################################################
# False paths
# For debug in synth use
# report_timing_summary -setup -slack_lesser_than 0
###############################################################################
# Data generator/capture constraints
set rfa_from_list   [get_cells -hier -regexp .*rf(?:da|ad)c_exdes_ctrl_i\/(?:da|ad)c_exdes_cfg_i\/.+num_samples_reg.*]
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_00/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_01/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_02/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_03/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_10/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_11/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_12/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_dac_signal_list [get_cells -hier -filter {name=~*dg_slice_13/addrb_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_dac_signal_list
set rfa_from_list   [get_cells -hier -regexp .*rf(?:da|ad)c_exdes_ctrl_i\/(?:da|ad)c_exdes_cfg_i\/.+num_samples_reg.*]
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_00*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_00*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_00*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_00*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_01*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_01*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_01*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_01*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_02*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_02*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_02*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_02*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_03*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_03*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_03*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_03*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_10*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_10*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_10*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_10*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_11*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_11*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_11*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_11*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_12*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_12*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_12*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_12*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_13*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_13*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_13*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_13*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_20*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_20*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_20*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_20*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_21*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_21*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_21*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_21*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_22*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_22*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_22*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_22*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_23*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_23*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_23*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_23*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_30*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_30*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_30*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_30*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_31*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_31*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_31*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_31*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_32*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_32*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_32*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_32*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_33*addra_reg[*]}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_33*working_i_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_33*cap_complete_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
set rfa_adc_signal_list [get_cells -hier -filter {name=~*ds_slice_33*wea_r_reg}]
set_false_path -from $rfa_from_list -to $rfa_adc_signal_list
