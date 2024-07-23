//==================================================================================================
//  Company name        : 
//  Date                : 
//  File Name           : dyn_phase_top.sv
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
module dyn_phase_top(
    // Reset/Clock
    input  logic        RESET_N,
    input  logic        CLK100M,
    input  logic        CLK50M,
    // From PLL
    input  logic        PHASEDONE,
    // To PLL
    output logic [ 3:0] PHASECOUNTERSELECT,/**** PLL Phase Counter Select ****/
                                          //    0x0:ALL Output Counters
                                          //    0x1:M  Counters
                                          //    0x2:C0 Counters
                                          //    0x3:C1 Counters
                                          //    0x4:C2 Counters
                                          //    0x5:C3 Counters
                                          //    0x6:C4 Counters
    output logic        PHASEUPDOWN,
    output logic        PHASESTEP,
    // Avalone Slave I/F
    input  logic        AV_BEGINTRANSFER,
    input  logic [12:0] AV_ADDRESS,
    input  logic        AV_CS,
    input  logic        AV_READ,
    input  logic        AV_WRITE,
    output logic [31:0] AV_READDATA,
    input  logic [31:0] AV_WRITEDATA,
    output logic        AV_WAITREQUEST
);

//=======================================================
//  PARAMETER declarations
//=======================================================
//    parameter p_addrexpander   = 16'h3000;
//=======================================================
//  Internal Signal
//=======================================================
    logic [ 3:0] w_counter;
    logic [ 1:0] w_dyn_phase;
    logic [15:0] w_reg_address;

//=======================================================
//  output Port
//=======================================================
    assign w_reg_address = {AV_ADDRESS,2'b00};
//=======================================================
//  Structural coding
//=======================================================

dyn_phase_stm stm_inst(
    .CLK50M(CLK50M),
    .RESET_N(RESET_N),
    .COUNTER(w_counter),
    .DYN_PHASE(w_dyn_phase),
    .PHASEDONE(PHASEDONE),
    .PHASECOUNTERSELECT(PHASECOUNTERSELECT),
    .PHASEUPDOWN(PHASEUPDOWN),
    .PHASESTEP(PHASESTEP)
);

dyn_phase_reg reg_inst(
    .RESET_N(RESET_N),
    .CLK100M(CLK100M),
    .CLK50M(CLK50M),
    .COUNTER(w_counter),
    .DYN_PHASE(w_dyn_phase),
    .REG_BEGINTRANSFER(AV_BEGINTRANSFER),
    .REG_ADDRESS(w_reg_address),
    .REG_CS(AV_CS),
    .REG_READ(AV_READ),
    .REG_WRITE(AV_WRITE),
    .REG_READDATA(AV_READDATA),
    .REG_WRITEDATA(AV_WRITEDATA),
    .REG_WAITREQUEST(AV_WAITREQUEST)
);

endmodule
