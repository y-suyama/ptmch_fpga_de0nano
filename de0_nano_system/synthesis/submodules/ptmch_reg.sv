//=======================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_reg.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0(èâî≈)
//
//=======================================================
// Import
//=======================================================
// None
//=======================================================
// Module
//=======================================================
module ptmch_reg(
    // Reset/Clock
    input  logic         RESET_N,
    input  logic         CLK100M,
    // TRG_PLS Counter Interface
    input  logic [31: 0] PRGEXCT,
    input  logic [31: 0] RDSTAT,
    input  logic [31: 0] BLKERS,
    input  logic [31: 0] PDREAD,
    input  logic [31: 0] WRSTAT,
    // Avalone Slave I/F
    input  logic         REG_BEGINTRANSFER,
    input  logic [15: 0] REG_ADDRESS,
    input  logic         REG_CS,
    input  logic         REG_READ,
    input  logic         REG_WRITE,
    output logic [31: 0] REG_READDATA,
    input  logic [31: 0] REG_WRITEDATA,
    output logic         REG_WAITREQUEST
);
//=======================================================
//  PARAMETER declarations
//=======================================================
    parameter p_rtlid_addr            = 16'h0000;
    parameter p_program_excute_addr   = 16'h0004;
    parameter p_readstatus_addr       = 16'h0008;
    parameter p_128kb_blockerase_addr = 16'h000C;
    parameter p_pagedata_read_addr    = 16'h0010;
    parameter p_writestatus_addr      = 16'h0014;
//=======================================================
//  Internal Signal
//=======================================================
    logic             w_reg_waitrequest;
    logic    [31: 0]  r_reg_readdata;
//=======================================================
//  output Port
//=======================================================
    assign   REG_READDATA    = r_reg_readdata;
    assign   REG_WAITREQUEST = REG_BEGINTRANSFER & REG_CS;
//=======================================================
//  Structural coding
//=======================================================
    // Avalone READ DATA
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            r_reg_readdata <= 32'h0000_0000;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_READ) begin
                case(REG_ADDRESS)
                    p_rtlid_addr            : r_reg_readdata <= 32'h5a5a_00ff;
                    p_program_excute_addr   : r_reg_readdata <= PRGEXCT;
                    p_readstatus_addr       : r_reg_readdata <= RDSTAT;
                    p_128kb_blockerase_addr : r_reg_readdata <= BLKERS;
                    p_pagedata_read_addr    : r_reg_readdata <= PDREAD;
                    p_writestatus_addr      : r_reg_readdata <= WRSTAT;
                    default                 : r_reg_readdata <= 32'h0000_0000;
                endcase
            end
        end
    end
endmodule
