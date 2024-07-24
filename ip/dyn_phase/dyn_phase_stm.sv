//==================================================================================================
//  Company name        : 
//  Date                : 
//  File Name           : dyn_phase_stm.sv
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

module dyn_phase_stm(
    // Reset/Clock
    input  logic       CLK50M,
    input  logic       RESET_N,
    // Register Interface
    input  logic [3:0] COUNTER,
    input  logic [1:0] DYN_PHASE,          /**** PLL PhaseShift Enable ****/
                                           //0x0:do nothing
                                           //0x1:1 Phase stepup
                                           //0x2:do nothing
                                           //0x3:1 Phase stepdown
    // From PLL
    input  logic       PHASEDONE,
    // To PLL
    output logic [3:0] PHASECOUNTERSELECT, /**** PLL Phase Counter Select ****/
                                           //     0x0:ALL Output Counters
                                           //     0x1:M  Counters
                                           //     0x2:C0 Counters
                                           //     0x3:C1 Counters
                                           //     0x4:C2 Counters
                                           //     0x5:C3 Counters
                                           //     0x6:C4 Counters
    output logic       PHASEUPDOWN,
    output logic       PHASESTEP
//    output [1:0] NEXT_STATE,
    );

//=======================================================
//  Internal Signal
//=======================================================
    logic [1:0] r_state;
    logic [1:0] r_next_state;
    logic [2:0] r_count;
    logic       r_step;
//=======================================================
//  PARAMETER declarations
//=======================================================
    parameter  p_phase_up   =2'b01;
    parameter  p_phase_down =2'b10;
    parameter  p_do_nothing =2'b00;
    parameter  p_up         =1'b1;
    parameter  p_down       =1'b0;
//=======================================================
//  output Port
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
   // STATE INCREMENT
    always_ff @(posedge CLK50M or negedge RESET_N) begin
        if (!RESET_N) begin
            r_state <= p_do_nothing;
        end
        else
            r_state <= r_next_state;
    end
   // NEXT STATE
    always_ff @(posedge CLK50M or negedge RESET_N) begin
        if (!RESET_N) begin
            r_next_state <= p_do_nothing;
        end
        else begin
            case (DYN_PHASE)
                2'b01:
                    r_next_state <= p_phase_up;
                2'b10:
                    r_next_state <= p_phase_down;
                default:
                    r_next_state <= p_do_nothing;
            endcase
        end
    end
    // PLL Phase Shift STATE MACHINE
    always_ff @ (posedge CLK50M or negedge RESET_N) begin
        if (!RESET_N) begin
            r_count     <= 3'b000;
            PHASESTEP   <= 1'b0;
            PHASEUPDOWN <= 1'b0;
        end
        else begin
            if (r_state !=  p_do_nothing && r_count == 3'b000 && PHASEDONE) begin // START PHASESTEP
                case (r_state)
                    p_phase_up: begin
                        r_step    <= p_up;        //Phase Shift up
                        PHASESTEP <= 1'b1;
                        r_count   <= r_count + 1'b1;
                    end
                    p_phase_down: begin
                        r_step    <= p_down;      //Phase Shift Down
                        PHASESTEP <= 1'b1;
                        r_count   <= r_count + 1'b1;
                    end
                endcase
            end
                case (r_count)
                    3'b001: begin
                        PHASEUPDOWN        <= r_step;
                        PHASECOUNTERSELECT <= COUNTER;
                        r_count            <= r_count + 1'b1;
                    end
                    3'b010: begin
//                        PHASESTEP          <= 1'b0;
                        r_count            <= r_count + 1'b1;
                    end
                    3'b011: begin
                        PHASEUPDOWN        <= 1'b0;
                        PHASECOUNTERSELECT <= COUNTER;
                        r_count            <= r_count + 1'b1;
                    end
                    3'b100: begin
                        PHASESTEP          <= 1'b0;
                        r_count            <= 3'b000;
                    end
                endcase
        end
    end
endmodule

