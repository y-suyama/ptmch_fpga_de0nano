"# ptmch_fpga_de0nano" 
# ptmch_fpga use DE0-nano only
NAND Flash Instaraction Detect & Trigger Pulse output

# Connection SPI Signal(MAX 100MHz)
3(JP1)  SPI_CLK
1(JP1)  SPI_CS
5(JP1)  SPI_MOSI

# use oscilloscope trigger signal
2(JP1) TRG_PLS[0] Write Excute
4(JP1) TRG_PLS[1] Read Status
6(JP1) TRG_PLS[2] 128KB Block Erase
8(JP1) TRG_PLS[3] Page Data Read
10(JP1) TRG_PLS[4] Write Status
