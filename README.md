"# ptmch_fpga_de0nano" 
# ptmch_fpga use DE0-nano only
NAND Flash Instaraction Detect & Trigger Pulse output

# Connection SPI Signal(MAX 100MHz)
[JP1.1]set_location_assignment PIN_A8 -to SPI_CLK
[JP1.3]set_location_assignment PIN_B8 -to SPI_CS
[JP1.5]set_location_assignment PIN_A2 -to SPI_MOSI

[JP1.14]set_location_assignment PIN_D5 -to TRG_PLS[0]
[JP1.4]set_location_assignment PIN_C3 -to TRG_PLS[1]
[JP1.6]set_location_assignment PIN_A3 -to TRG_PLS[2]
[JP1.8]set_location_assignment PIN_B4 -to TRG_PLS[3]
[JP1.10]set_location_assignment PIN_B5 -to TRG_PLS[4]
