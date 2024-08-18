<<<<<<< HEAD
## Generated SDC file "DE0_Nano.out.sdc"

## Copyright (C) 2019  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.1 Build 646 04/11/2019 SJ Lite Edition"

## DATE    "Sat Aug 17 20:08:35 2024"

##
## DEVICE  "EP4CE22F17C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {CLK50M} -period 20.000 -waveform { 0.000 10.000 } [get_ports {CLK50M}]
create_clock -name {SPI_CLK} -period 10.000 -waveform { 0.000 5.000 } [get_ports {SPI_CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u0_inst|altpll_0|sd1|pll7|clk[0]} -source [get_pins {u0_inst|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {CLK50M} [get_pins {u0_inst|altpll_0|sd1|pll7|clk[0]}] 
create_generated_clock -name {u0_inst|altpll_0|sd1|pll7|clk[1]} -source [get_pins {u0_inst|altpll_0|sd1|pll7|inclk[0]}] -duty_cycle 50/1 -multiply_by 16 -divide_by 5 -master_clock {CLK50M} [get_pins {u0_inst|altpll_0|sd1|pll7|clk[1]}] 
=======
#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period 20 [get_ports CLK50M]
create_clock -period 10 [get_ports SPI_CLK]
#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks

>>>>>>> origin/main


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
<<<<<<< HEAD

set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {SPI_CLK}] -setup 0.110  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {SPI_CLK}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {SPI_CLK}] -setup 0.110  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {SPI_CLK}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {SPI_CLK}] -setup 0.110  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -rise_to [get_clocks {SPI_CLK}] -hold 0.090  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {SPI_CLK}] -setup 0.110  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -fall_to [get_clocks {SPI_CLK}] -hold 0.090  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK50M}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK50M}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK50M}] -setup 0.100  
set_clock_uncertainty -rise_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK50M}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK50M}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -rise_to [get_clocks {CLK50M}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK50M}] -setup 0.100  
set_clock_uncertainty -fall_from [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -fall_to [get_clocks {CLK50M}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {CLK50M}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {CLK50M}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -rise_from [get_clocks {CLK50M}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {CLK50M}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -rise_from [get_clocks {CLK50M}] -rise_to [get_clocks {CLK50M}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {CLK50M}] -fall_to [get_clocks {CLK50M}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLK50M}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {CLK50M}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -fall_from [get_clocks {CLK50M}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {CLK50M}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}] -hold 0.100  
set_clock_uncertainty -fall_from [get_clocks {CLK50M}] -rise_to [get_clocks {CLK50M}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {CLK50M}] -fall_to [get_clocks {CLK50M}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {SPI_CLK}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {SPI_CLK}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {SPI_CLK}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -setup 0.090  
set_clock_uncertainty -rise_from [get_clocks {SPI_CLK}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {SPI_CLK}] -rise_to [get_clocks {SPI_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {SPI_CLK}] -fall_to [get_clocks {SPI_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {SPI_CLK}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {SPI_CLK}] -rise_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {SPI_CLK}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -setup 0.090  
set_clock_uncertainty -fall_from [get_clocks {SPI_CLK}] -fall_to [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {SPI_CLK}] -rise_to [get_clocks {SPI_CLK}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {SPI_CLK}] -fall_to [get_clocks {SPI_CLK}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
=======
derive_clock_uncertainty

>>>>>>> origin/main


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

<<<<<<< HEAD
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
=======
>>>>>>> origin/main


#**************************************************************
# Set False Path
#**************************************************************

<<<<<<< HEAD
set_false_path  -from  [get_clocks {SPI_CLK}]  -to  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]
set_false_path  -from  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  -to  [get_clocks {SPI_CLK}]
set_false_path  -from  [get_clocks {SPI_CLK}]  -to  [get_clocks *]
set_false_path  -from  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  -to  [get_clocks {SPI_CLK}]
set_false_path  -from  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]  -to  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]
set_false_path  -from  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[1]}]  -to  [get_clocks {u0_inst|altpll_0|sd1|pll7|clk[0]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read}] -to [get_registers {*|alt_jtag_atlantic:*|read1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|tck_t_dav}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [get_registers *]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write}] -to [get_registers {*|alt_jtag_atlantic:*|write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_nios2_oci_break:the_de0_nano_system_cpu_cpu_nios2_oci_break|break_readreg*}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_tck:the_de0_nano_system_cpu_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_nios2_oci_debug:the_de0_nano_system_cpu_cpu_nios2_oci_debug|*resetlatch}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_tck:the_de0_nano_system_cpu_cpu_debug_slave_tck|*sr[33]}]
set_false_path -from [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_nios2_oci_debug:the_de0_nano_system_cpu_cpu_nios2_oci_debug|monitor_ready}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_tck:the_de0_nano_system_cpu_cpu_debug_slave_tck|*sr[0]}]
set_false_path -from [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_nios2_oci_debug:the_de0_nano_system_cpu_cpu_nios2_oci_debug|monitor_error}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_tck:the_de0_nano_system_cpu_cpu_debug_slave_tck|*sr[34]}]
set_false_path -from [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_nios2_ocimem:the_de0_nano_system_cpu_cpu_nios2_ocimem|*MonDReg*}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_tck:the_de0_nano_system_cpu_cpu_debug_slave_tck|*sr*}]
set_false_path -from [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_tck:the_de0_nano_system_cpu_cpu_debug_slave_tck|*sr*}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_sysclk:the_de0_nano_system_cpu_cpu_debug_slave_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_debug_slave_wrapper:the_de0_nano_system_cpu_cpu_debug_slave_wrapper|de0_nano_system_cpu_cpu_debug_slave_sysclk:the_de0_nano_system_cpu_cpu_debug_slave_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*de0_nano_system_cpu_cpu:*|de0_nano_system_cpu_cpu_nios2_oci:the_de0_nano_system_cpu_cpu_nios2_oci|de0_nano_system_cpu_cpu_nios2_oci_debug:the_de0_nano_system_cpu_cpu_nios2_oci_debug|monitor_go}]
=======
>>>>>>> origin/main


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************

<<<<<<< HEAD
set_max_delay -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}] 100.000
set_max_delay -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}] 100.000
=======
>>>>>>> origin/main


#**************************************************************
# Set Minimum Delay
#**************************************************************

<<<<<<< HEAD
set_min_delay -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}] -100.000
set_min_delay -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}] -100.000
=======
>>>>>>> origin/main


#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
<<<<<<< HEAD
# Set Net Delay
#**************************************************************

set_net_delay -max 2.000 -from [get_registers {*altera_avalon_st_clock_crosser:*|in_data_buffer*}] -to [get_registers {*altera_avalon_st_clock_crosser:*|out_data_buffer*}]
set_net_delay -max 2.000 -from [get_registers *] -to [get_registers {*altera_avalon_st_clock_crosser:*|altera_std_synchronizer_nocut:*|din_s1}]
=======
# Set Load
#**************************************************************



>>>>>>> origin/main
