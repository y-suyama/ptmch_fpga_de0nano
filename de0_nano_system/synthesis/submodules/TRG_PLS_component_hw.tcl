# TCL File Generated by Component Editor 18.1
# Sun Jul 28 13:42:38 JST 2024
# DO NOT MODIFY


# 
# TRG_PLS_component "TRG_PLS_component" v1.9
#  2024.07.28.13:42:38
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module TRG_PLS_component
# 
set_module_property DESCRIPTION ""
set_module_property NAME TRG_PLS_component
set_module_property VERSION 1.9
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP USER_IP
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME TRG_PLS_component
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
add_fileset_file ptmch_cnt.sv SYSTEM_VERILOG PATH ptmch_cnt.sv
add_fileset_file ptmch_reg.sv SYSTEM_VERILOG PATH ptmch_reg.sv
add_fileset_file ptmch_top.sv SYSTEM_VERILOG PATH ptmch_top.sv TOP_LEVEL_FILE
add_fileset_file ptmch_trg.sv SYSTEM_VERILOG PATH ptmch_trg.sv
add_fileset_file TRG_PLS_component_hw.tcl OTHER PATH TRG_PLS_component_hw.tcl


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
set_interface_property reset synchronousEdges NONE
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
set_interface_property reg associatedClock CLK100M
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
add_interface_port reg REG_ADDRESS address Input 13
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
# connection point CLK100M
# 
add_interface CLK100M clock end
set_interface_property CLK100M clockRate 100000000
set_interface_property CLK100M ENABLED true
set_interface_property CLK100M EXPORT_OF ""
set_interface_property CLK100M PORT_NAME_MAP ""
set_interface_property CLK100M CMSIS_SVD_VARIABLES ""
set_interface_property CLK100M SVD_ADDRESS_GROUP ""

add_interface_port CLK100M CLK100M clk Input 1


# 
# connection point CLK160M
# 
add_interface CLK160M clock end
set_interface_property CLK160M clockRate 160000000
set_interface_property CLK160M ENABLED true
set_interface_property CLK160M EXPORT_OF ""
set_interface_property CLK160M PORT_NAME_MAP ""
set_interface_property CLK160M CMSIS_SVD_VARIABLES ""
set_interface_property CLK160M SVD_ADDRESS_GROUP ""

add_interface_port CLK160M CLK160M clk Input 1


# 
# connection point SPI_CLK
# 
add_interface SPI_CLK clock end
set_interface_property SPI_CLK clockRate 100000000
set_interface_property SPI_CLK ENABLED true
set_interface_property SPI_CLK EXPORT_OF ""
set_interface_property SPI_CLK PORT_NAME_MAP ""
set_interface_property SPI_CLK CMSIS_SVD_VARIABLES ""
set_interface_property SPI_CLK SVD_ADDRESS_GROUP ""

add_interface_port SPI_CLK SPI_CLK clk Input 1


# 
# connection point SPI_CS
# 
add_interface SPI_CS conduit end
set_interface_property SPI_CS associatedClock SPI_CLK
set_interface_property SPI_CS associatedReset reset
set_interface_property SPI_CS ENABLED true
set_interface_property SPI_CS EXPORT_OF ""
set_interface_property SPI_CS PORT_NAME_MAP ""
set_interface_property SPI_CS CMSIS_SVD_VARIABLES ""
set_interface_property SPI_CS SVD_ADDRESS_GROUP ""

add_interface_port SPI_CS SPI_CS spi Input 1


# 
# connection point SPI_MOSI
# 
add_interface SPI_MOSI conduit end
set_interface_property SPI_MOSI associatedClock SPI_CLK
set_interface_property SPI_MOSI associatedReset reset
set_interface_property SPI_MOSI ENABLED true
set_interface_property SPI_MOSI EXPORT_OF ""
set_interface_property SPI_MOSI PORT_NAME_MAP ""
set_interface_property SPI_MOSI CMSIS_SVD_VARIABLES ""
set_interface_property SPI_MOSI SVD_ADDRESS_GROUP ""

add_interface_port SPI_MOSI SPI_MOSI spi Input 1


# 
# connection point TRG_PLS
# 
add_interface TRG_PLS conduit end
set_interface_property TRG_PLS associatedClock CLK160M
set_interface_property TRG_PLS associatedReset reset
set_interface_property TRG_PLS ENABLED true
set_interface_property TRG_PLS EXPORT_OF ""
set_interface_property TRG_PLS PORT_NAME_MAP ""
set_interface_property TRG_PLS CMSIS_SVD_VARIABLES ""
set_interface_property TRG_PLS SVD_ADDRESS_GROUP ""

add_interface_port TRG_PLS TRG_PLS triggersignal Output 5

