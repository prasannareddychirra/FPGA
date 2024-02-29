set_property PACKAGE_PIN AT5 [get_ports lmk04208_spi_sck];       # B84.12
set_property PACKAGE_PIN AU5 [get_ports lmk04208_spi_mosi];      # B84.13
set_property PACKAGE_PIN AP5 [get_ports {lmk04208_spi_miso}];    # B84.23
set_property PACKAGE_PIN AR6 [get_ports {lmk04208_spi_cs_n[0]}]; # B84.21
set_property PACKAGE_PIN AT6 [get_ports lmx2594_spi_sck];        # B84.15
set_property PACKAGE_PIN AV8 [get_ports lmx2594_spi_mosi];       # B84.17
set_property PACKAGE_PIN AV7 [get_ports {lmx2594_spi_miso[0]}];  # B84.19
set_property PACKAGE_PIN AU7 [get_ports {lmx2594_spi_miso[1]}];  # B84.18
set_property PACKAGE_PIN AP6 [get_ports {lmx2594_spi_miso[2]}];  # B84.22
set_property PACKAGE_PIN AT7 [get_ports {lmx2594_spi_cs_n[0]}];  # B84.14
set_property PACKAGE_PIN AU8 [get_ports {lmx2594_spi_cs_n[1]}];  # B84.16
set_property PACKAGE_PIN AR7 [get_ports {lmx2594_spi_cs_n[2]}];  # B84.20
    

set_property IOSTANDARD LVCMOS18 [get_ports lmk04208_spi_*]
set_property IOSTANDARD LVCMOS18 [get_ports lmx2594_spi_*]

#####################################################################################################
# lmk04208                                                                                          #
#####################################################################################################
## CCLK max delay is 6.7 ns ; refer Data sheet
## We need to consider the max delay for worst case analysis

## Following are the SPI device parameters
## Max Tco
## Min Tco
## Setup time requirement
## Hold time requirement

## Following are the board/trace delay numbers
## Assumption is that all Data lines are matched

### End of user provided delay numbers
create_generated_clock -name clk_lmk04208_sck -source [get_pins */lmk04208/spi/ext_spi_clk] -edges {3 5 7} [get_ports lmk04208_spi_sck]

## Data is captured into FPGA on the second rising edge of ext_spi_clk after the SCK falling edge
## Data is driven by the FPGA on every alternate rising_edge of ext_spi_clk
set_input_delay -clock clk_lmk04208_sck -clock_fall -max 7.450 [get_ports {lmk04208_spi_miso}]
set_input_delay -clock clk_lmk04208_sck -clock_fall -min 1.450 [get_ports {lmk04208_spi_miso}]
set_multicycle_path -setup -from clk_lmk04208_sck -to [get_clocks -of_objects [get_pins */lmk04208/spi/ext_spi_clk]] 2
set_multicycle_path -hold -end -from clk_lmk04208_sck -to [get_clocks -of_objects [get_pins */lmk04208/spi/ext_spi_clk]] 1

## Data is captured into SPI on the following rising edge of SCK
## Data is driven by the IP on alternate rising_edge of the ext_spi_clk
set_output_delay -clock clk_lmk04208_sck -max 2.050 [get_ports {lmk04208_spi_mosi {lmk04208_spi_cs_n[*]}}]
set_output_delay -clock clk_lmk04208_sck -min -2.950 [get_ports {lmk04208_spi_mosi {lmk04208_spi_cs_n[*]}}]
set_multicycle_path -setup -start -from [get_clocks -of_objects [get_pins */lmk04208/spi/ext_spi_clk]] -to clk_lmk04208_sck 2
set_multicycle_path -hold -from [get_clocks -of_objects [get_pins */lmk04208/spi/ext_spi_clk]] -to clk_lmk04208_sck 1



#####################################################################################################
# lmx2594                                                                                          #
#####################################################################################################
## CCLK max delay is 6.7 ns ; refer Data sheet
## We need to consider the max delay for worst case analysis

## Following are the SPI device parameters
## Max Tco
## Min Tco
## Setup time requirement
## Hold time requirement

## Following are the board/trace delay numbers
## Assumption is that all Data lines are matched

### End of user provided delay numbers
create_generated_clock -name clk_lmx2594_sck -source [get_pins */lmx2594/spi/ext_spi_clk] -edges {3 5 7} [get_ports lmx2594_spi_sck]

## Data is captured into FPGA on the second rising edge of ext_spi_clk after the SCK falling edge
## Data is driven by the FPGA on every alternate rising_edge of ext_spi_clk
set_input_delay -clock clk_lmx2594_sck -clock_fall -max 7.450 [get_ports {lmx2594_spi_miso[*]}]
set_input_delay -clock clk_lmx2594_sck -clock_fall -min 1.450 [get_ports {lmx2594_spi_miso[*]}]
set_multicycle_path -setup -from clk_lmx2594_sck -to [get_clocks -of_objects [get_pins */lmx2594/spi/ext_spi_clk]] 2
set_multicycle_path -hold -end -from clk_lmx2594_sck -to [get_clocks -of_objects [get_pins */lmx2594/spi/ext_spi_clk]] 1

## Data is captured into SPI on the following rising edge of SCK
## Data is driven by the IP on alternate rising_edge of the ext_spi_clk
set_output_delay -clock clk_lmx2594_sck -max 2.050 [get_ports {lmx2594_spi_mosi {lmx2594_spi_cs_n[*]}}]
set_output_delay -clock clk_lmx2594_sck -min -2.950 [get_ports {lmx2594_spi_mosi {lmx2594_spi_cs_n[*]}}]
set_multicycle_path -setup -start -from [get_clocks -of_objects [get_pins */lmx2594/spi/ext_spi_clk]] -to clk_lmx2594_sck 2
set_multicycle_path -hold -from [get_clocks -of_objects [get_pins */lmx2594/spi/ext_spi_clk]] -to clk_lmx2594_sck 1


