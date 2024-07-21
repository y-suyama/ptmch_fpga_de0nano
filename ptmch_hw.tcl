# TCL File Generated by Component Editor 18.1
# Sun Jul 21 14:10:14 JST 2024
# DO NOT MODIFY


# 
# ptmch "ptmch" v1.0
#  2024.07.21.14:10:14
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module ptmch
# 
set_module_property DESCRIPTION ""
set_module_property NAME ptmch
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME ptmch
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL ptmch_top
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file ptmch_top.sv SYSTEM_VERILOG PATH rtl/ptmch/ptmch_top.sv TOP_LEVEL_FILE
add_fileset_file ptmch_cnt.sv SYSTEM_VERILOG PATH rtl/ptmch/ptmch_cnt.sv
add_fileset_file ptmch_reg.sv SYSTEM_VERILOG PATH rtl/ptmch/ptmch_reg.sv
add_fileset_file ptmch_trg.sv SYSTEM_VERILOG PATH rtl/ptmch/ptmch_trg.sv


# 
# parameters
# 


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock ""
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset RESET_N reset_n Input 1


# 
# connection point reg
# 
add_interface reg avalon end
set_interface_property reg addressUnits WORDS
set_interface_property reg associatedClock ""
set_interface_property reg associatedReset reset
set_interface_property reg bitsPerSymbol 8
set_interface_property reg burstOnBurstBoundariesOnly false
set_interface_property reg burstcountUnits WORDS
set_interface_property reg explicitAddressSpan 0
set_interface_property reg holdTime 0
set_interface_property reg linewrapBursts false
set_interface_property reg maximumPendingReadTransactions 0
set_interface_property reg maximumPendingWriteTransactions 0
set_interface_property reg readLatency 0
set_interface_property reg readWaitTime 1
set_interface_property reg setupTime 0
set_interface_property reg timingUnits Cycles
set_interface_property reg writeWaitTime 0
set_interface_property reg ENABLED true
set_interface_property reg EXPORT_OF ""
set_interface_property reg PORT_NAME_MAP ""
set_interface_property reg CMSIS_SVD_VARIABLES ""
set_interface_property reg SVD_ADDRESS_GROUP ""

add_interface_port reg REG_BEGINTRANSFER begintransfer Input 1
add_interface_port reg REG_ADDRESS address Input 16
add_interface_port reg REG_READ read Input 1
add_interface_port reg REG_WRITE write Input 1
add_interface_port reg REG_READDATA readdata Output 32
add_interface_port reg REG_WRITEDATA writedata Input 32
add_interface_port reg REG_WAITREQUEST waitrequest Output 1
add_interface_port reg REG_CS chipselect Input 1
set_interface_assignment reg embeddedsw.configuration.isFlash 0
set_interface_assignment reg embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment reg embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment reg embeddedsw.configuration.isPrintableDevice 0


# 
# connection point SPI_Other_Signal
# 
add_interface SPI_Other_Signal conduit end
set_interface_property SPI_Other_Signal associatedClock ""
set_interface_property SPI_Other_Signal associatedReset ""
set_interface_property SPI_Other_Signal ENABLED true
set_interface_property SPI_Other_Signal EXPORT_OF ""
set_interface_property SPI_Other_Signal PORT_NAME_MAP ""
set_interface_property SPI_Other_Signal CMSIS_SVD_VARIABLES ""
set_interface_property SPI_Other_Signal SVD_ADDRESS_GROUP ""

add_interface_port SPI_Other_Signal CLK160M pllclk Input 1
add_interface_port SPI_Other_Signal CLK100M internalclk Input 1
add_interface_port SPI_Other_Signal SPI_CS spics Input 1
add_interface_port SPI_Other_Signal SPI_CLK spiclk Input 1
add_interface_port SPI_Other_Signal SPI_MOSI spimosi Input 1
add_interface_port SPI_Other_Signal TRG_PLS readdata Output 5

