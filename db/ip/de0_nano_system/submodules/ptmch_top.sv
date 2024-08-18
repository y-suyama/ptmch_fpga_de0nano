//==================================================================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_top.sv
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
module ptmch_top(
    // Reset/Clock
    input  logic          RESET_N,
    input  logic          CLK160M,
    input  logic          CLK100M,
    // SPI Interface
    input  logic          SPI_CS,
    input  logic          SPI_CLK,
    input  logic          SPI_MOSI,
    output logic [ 4: 0]  TRG_PLS,
    // Avalone Slave I/F
    input  logic          REG_BEGINTRANSFER,
    input  logic [12: 0]  REG_ADDRESS,
    input  logic          REG_CS,
    input  logic          REG_READ,
    input  logic          REG_WRITE,
    output logic [31: 0]  REG_READDATA,
    input  logic [31: 0]  REG_WRITEDATA,
    output logic          REG_WAITREQUEST
);
//==================================================================================================
//  PARAMETER declarations
//==================================================================================================
//    parameter p_addrexpander   = 16'h3000;
//==================================================================================================
//  Internal Signal
//==================================================================================================
    logic [ 4: 0] n_trg_pls;
    logic [31: 0] n_prgexct;
    logic [31: 0] n_rdstat;
    logic [31: 0] n_blkers;
    logic [31: 0] n_pdread;
    logic [31: 0] n_qrstat;
    
    logic [31: 0] n_reg_readdata;
    logic         n_reg_waitrequest;
    //Page Address Setting
    logic [23: 0] n_prgexct_low_addr;
    logic [23: 0] n_prgexct_high_addr;
    logic [23: 0] n_rdstat_low_addr;
    logic [23: 0] n_rdstat_high_addr;
    logic [23: 0] n_blkers_low_addr;
    logic [23: 0] n_blkers_high_addr;
    logic [23: 0] n_pdread_low_addr;
    logic [23: 0] n_pdread_high_addr;
    logic [23: 0] n_wrstat_low_addr;
    logic [23: 0] n_wrstat_high_addr;

    logic [15: 0] n_reg_address;

    logic         n_cs_edge_n;
    logic         n_ptmch_rst_n;

//==================================================================================================
//  assign
//==================================================================================================
    assign TRG_PLS = n_trg_pls;
    // Avalone Bus Interface
    assign REG_READDATA        = n_reg_readdata;
    assign REG_WAITREQUEST     = n_reg_waitrequest;
    assign n_reg_address       = {REG_ADDRESS,2'b00};

//==================================================================================================
//  Structural coding
//==================================================================================================
ptmch_rst rst_inst(
    .RESET_N(RESET_N),
    .CLK160M(CLK160M),
    .CS_EDGE_N(n_cs_edge_n),
    .PTMCH_RST_N(n_ptmch_rst_n)
);

ptmch_trg trg_inst(
    .RESET_N(RESET_N),
    .CS_EDGE_N(n_cs_edge_n),
    .PTMCH_RST_N(n_ptmch_rst_n),
    .CLK160M(CLK160M),
    .SPI_CS(SPI_CS),
    .SPI_CLK(SPI_CLK),
    .SPI_MOSI(SPI_MOSI),
    .TRG_PLS(n_trg_pls),
    .PRGEXCT_LOW_ADDR(n_prgexct_low_addr),
    .PRGEXCT_HIGH_ADDR(n_prgexct_high_addr),
    .RDSTAT_LOW_ADDR(n_rdstat_low_addr),
    .RDSTAT_HIGH_ADDR(n_rdstat_high_addr),
    .BLKERS_LOW_ADDR(n_blkers_low_addr),
    .BLKERS_HIGH_ADDR(n_blkers_high_addr),
    .PDREAD_LOW_ADDR(n_pdread_low_addr),
    .PDREAD_HIGH_ADDR(n_pdread_high_addr),
    .WRSTAT_LOW_ADDR(n_wrstat_low_addr),
    .WRSTAT_HIGH_ADDR(n_wrstat_high_addr)
);

ptmch_cnt cnt_inst(
    .RESET_N(RESET_N),
    .CLK100M(CLK100M),
    .PRGEXCT(n_prgexct),
    .RDSTAT(n_rdstat),
    .BLKERS(n_blkers),
    .PDREAD(n_pdread),
    .WRSTAT(n_qrstat),
    .TRG_PLS(n_trg_pls)
);

ptmch_reg reg_inst(
    .RESET_N(RESET_N),
    .CLK100M(CLK100M),
    .PRGEXCT(n_prgexct),
    .RDSTAT(n_rdstat),
    .BLKERS(n_blkers),
    .PDREAD(n_pdread),
    .WRSTAT(n_qrstat),
    .PRGEXCT_LOW_ADDR(n_prgexct_low_addr),
    .PRGEXCT_HIGH_ADDR(n_prgexct_high_addr),
    .RDSTAT_LOW_ADDR(n_rdstat_low_addr),
    .RDSTAT_HIGH_ADDR(n_rdstat_high_addr),
    .BLKERS_LOW_ADDR(n_blkers_low_addr),
    .BLKERS_HIGH_ADDR(n_blkers_high_addr),
    .PDREAD_LOW_ADDR(n_pdread_low_addr),
    .PDREAD_HIGH_ADDR(n_pdread_high_addr),
    .WRSTAT_LOW_ADDR(n_wrstat_low_addr),
    .WRSTAT_HIGH_ADDR(n_wrstat_high_addr),
    .REG_BEGINTRANSFER(REG_BEGINTRANSFER),
    .REG_ADDRESS(n_reg_address),
    .REG_CS(REG_CS),
    .REG_READ(REG_READ),
    .REG_WRITE(REG_WRITE),
    .REG_READDATA(n_reg_readdata),
    .REG_WRITEDATA(REG_WRITEDATA),
    .REG_WAITREQUEST(n_reg_waitrequest)
);
endmodule

