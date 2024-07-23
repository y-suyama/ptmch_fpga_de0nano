//==================================================================================================
//  Company name        : 
//  Date                : 
//  File Name           : de0_nano_top.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0
//
//==================================================================================================
// Import
//==================================================================================================
// None
//==================================================================================================
// Module
//==================================================================================================
module de0_nano_top(
    // Clock, Reset
    input   logic         CLK50M,
    // LED
    output  logic [ 7: 0] LED,
    // KEY
    input   logic [ 1: 0] KEY,
    // SW
    input   logic [ 3: 0] SW,
    // SDRAM
    output  logic [12: 0] DRAM_ADDR,
    output  logic [ 1: 0] DRAM_BA,
    output  logic         DRAM_CAS_N,
    output  logic         DRAM_CKE,
    output  logic         DRAM_CLK,
    output  logic         DRAM_CS_N,
    inout   logic [15: 0] DRAM_DQ,
    output  logic [ 1: 0] DRAM_DQM,
    output  logic         DRAM_RAS_N,
    output  logic         DRAM_WE_N,	
    // SPI Signal
    input   logic         SPI_CS,
    input   logic         SPI_CLK,
    input   logic         SPI_MOSI,
    output  logic [ 4: 0] TRG_PLS
);
//=======================================================
//  PARAMETER declarations
//=======================================================
// none
//=======================================================
//  Internal Signal
//=======================================================
logic w_reset_n;
logic w_clk100m;
logic [ 4: 0] w_trg_pls;
//=======================================================
//  assign
//=======================================================
assign w_reset_n = KEY[0];
assign TRG_PLS   = w_trg_pls;
//=======================================================
//  Structural coding
//=======================================================
de0_nano_system u0_inst (
    .reset_n                                   (w_reset_n),
    .in_port_to_the_key                        (KEY),
    .zs_addr_from_the_sdram                    (DRAM_ADDR),
    .zs_ba_from_the_sdram                      (DRAM_BA),
    .zs_cas_n_from_the_sdram                   (DRAM_CAS_N),
    .zs_cke_from_the_sdram                     (DRAM_CKE),
    .zs_cs_n_from_the_sdram                    (DRAM_CS_N),
    .zs_dq_to_and_from_the_sdram               (DRAM_DQ),
    .zs_dqm_from_the_sdram                     (DRAM_DQM),
    .zs_ras_n_from_the_sdram                   (DRAM_RAS_N),
    .zs_we_n_from_the_sdram                    (DRAM_WE_N),
    .in_port_to_the_sw                         (SW),
    .clk_50                                    (CLK50M),
    .trg_pls_component_0_spi_clk_clk           (SPI_CLK),
    .trg_pls_component_0_spi_cs_spi            (SPI_CS),
    .trg_pls_component_0_spi_mosi_spi          (SPI_MOSI),
    .trg_pls_component_0_trg_pls_triggersignal (w_trg_pls),
    .clk100m_clk_clk(w_clk100m)
);


ledpwm ledpwm_inst(
    .CLK50M(CLK50M),
    .RESET_N(w_reset_n),
    .LED(LED)
);

endmodule
