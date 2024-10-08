//=================================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_rst.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0(����)
//
//=================================================================
// Import
//=================================================================
// None
//=================================================================
// Module
//=================================================================
module ptmch_rst(
    // Reset/Clock
    input   logic         RESET_N,
    input   logic         CLK160M,
    input   logic         CS_EDGE_N,
    output  logic         PTMCH_RST_N
);
//=================================================================
//  Internal Signal
//=================================================================
// none
//=================================================================
//  assign
//=================================================================
//    assign PTMCH_RST_N = RESET_N & CS_EDGE_N;
//=================================================================
//  Structural coding
//=================================================================
    always_ff @(posedge CLK160M) begin
        PTMCH_RST_N = RESET_N & CS_EDGE_N;
    end

endmodule
