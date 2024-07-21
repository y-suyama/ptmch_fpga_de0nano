//=======================================================
//  Company name        : 
//  Date                : 
//  File Name           : dyn_phase_reg.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0
//
//=======================================================
// Import
//=======================================================
// None
//=======================================================
// Module
//=======================================================
module dyn_phase_reg(
    // Reset/Clock
    input  logic        CLK100M,
    input  logic        CLK50M,
    input  logic        RESET_N,
    // StateMachine Interface
    output logic [ 3:0] COUNTER,
    output logic [ 1:0] DYN_PHASE,
    // Avalone Slave I/F
    input  logic        REG_BEGINTRANSFER,
    input  logic [15:0] REG_ADDRESS,
    input  logic        REG_CS,
    input  logic        REG_READ,
    input  logic        REG_WRITE,
    output logic [31:0] REG_READDATA,
    input  logic [31:0] REG_WRITEDATA,
    output logic        REG_WAITREQUEST
);
//=======================================================
//  PARAMETER declarations
//=======================================================
    parameter p_counter_addr        = 16'h0000;
    parameter p_phasedirection_addr = 16'h0004;
//=======================================================
//  Internal Signal
//=======================================================
    logic [31: 0] r_reg_readdata;
    logic [ 1: 0] r_enable_counter;
    logic [ 1: 0] r_dyn_phase;
    logic [ 1: 0] r_dyn_phase_pls;
    logic [ 1: 0] r_dyn_phase_pls_d1;
    logic [ 1: 0] r_dyn_phase_pls_d2;
    logic [ 1: 0] r_dyn_phase_pls_d3;
    logic [ 1: 0] r_dyn_phase_pls_sync;
//=======================================================
//  output Port
//=======================================================
    // Debug
    assign COUNTER         = COUNTER;
    assign DYN_PHASE       = r_dyn_phase_pls_sync;
    assign REG_READDATA    = r_reg_readdata;
    assign REG_WAITREQUEST = REG_BEGINTRANSFER & REG_CS;
//=======================================================
//  Structural coding
//=======================================================
    // Phase Counter Register(0x0000)
    always @(posedge CLK100M or negedge RESET_N)
        begin
            if(!RESET_N)
                COUNTER <= 4'b0011;
            else begin
                if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_counter_addr))
                        COUNTER <= REG_WRITEDATA[3:0];
                 end
        end
    // DynPhase Register(0x0004)
    always @(posedge CLK100M or negedge RESET_N) begin
      if(!RESET_N)
        r_dyn_phase <= 2'b00;
      else begin
        if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_phasedirection_addr))
          r_dyn_phase <= REG_WRITEDATA[1:0];
           end
    end
    // DYN_PHASE Enable Pulse Counter
    always @(posedge CLK100M or negedge RESET_N)
        begin
            if(!RESET_N)
                r_enable_counter <= 2'b11;
            else begin
                if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_phasedirection_addr))
                    r_enable_counter <= 2'b00;
                else if (r_enable_counter == 2'b11)
                    r_enable_counter <= r_enable_counter;
                else
                    r_enable_counter <= r_enable_counter + 1'b1;
                 end
        end
    // DYN_PHASE Enable Pulse
    always @(posedge CLK100M or negedge RESET_N)
        begin
            if(!RESET_N)
                r_dyn_phase_pls <=2'b00;
            else begin
                if (r_enable_counter == 2'b00)
                    r_dyn_phase_pls <= r_dyn_phase;
                else if (r_enable_counter == 2'b11)
                    r_dyn_phase_pls <= 2'b00;
                else
                    r_dyn_phase_pls <= r_dyn_phase_pls;
                 end
        end
    // Clock Transfer(100MHz => 50MHz)
    // 1Clock
    always @(negedge CLK50M or negedge RESET_N)
        begin
            if(!RESET_N)
                r_dyn_phase_pls_d1  <= 2'b00;
            else
                r_dyn_phase_pls_d1  <= r_dyn_phase_pls;
        end
    // 2Clock
    always @(negedge CLK50M or negedge RESET_N) begin
      if(!RESET_N)
        r_dyn_phase_pls_d2  <= 2'b00;
      else
        r_dyn_phase_pls_d2  <= r_dyn_phase_pls_d1;
      end
    // 3Clock
    always @(negedge CLK50M or negedge RESET_N)
        begin
            if(!RESET_N)
                r_dyn_phase_pls_d3  <= 2'b00;
            else
                r_dyn_phase_pls_d3  <= r_dyn_phase_pls_d2;
        end
    // DYN_PHASE Enable Pulse Compera
    always @(negedge CLK50M or negedge RESET_N)
        begin
            if(!RESET_N)
                r_dyn_phase_pls_sync    <= 2'b00;
            else if({r_dyn_phase_pls_d3^r_dyn_phase_pls_d2 == 2'b00})
                r_dyn_phase_pls_sync    <= r_dyn_phase_pls_d3;
        end
    // Avalone READ DATA
    always @(posedge CLK100M or negedge RESET_N)
        begin
            if(!RESET_N)
                r_reg_readdata <= 32'h0000_0000;
            else begin
                if (REG_BEGINTRANSFER & REG_CS & REG_READ)
                begin
                    case(REG_ADDRESS)
                        p_counter_addr        : r_reg_readdata <= {28'd0,COUNTER};
                        p_phasedirection_addr : r_reg_readdata <= {30'd0,r_dyn_phase};
                        default               : r_reg_readdata <= 32'h0000_0000;
                    endcase
                end
                 end
        end

endmodule
