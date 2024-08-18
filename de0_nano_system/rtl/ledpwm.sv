//=======================================================
//  Company name        : 
//  Date                : 
//  File Name           : ledpwm.sv
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
module ledpwm(
    // Reset/Clock
    input  logic CLK50M,
    input  logic RESET_N,
    // LED
    output logic [ 7:0]LED
);
//=======================================================
//  PARAMETER declarations
//=======================================================
// none 
//=======================================================
//  REG/logic declarations
//=======================================================
    logic [26:0] r_counter;
    logic [ 5:0] r_pwm_adj;
    logic [12:0] r_pwm_width;
    logic [ 7:0] r_led;
//=======================================================
//  Structural coding
//=======================================================
    // PWM Counter
    always_ff @(posedge CLK50M or negedge RESET_N) begin
        if(!RESET_N)
            r_counter <= 27'b0;
        else
            r_counter <= r_counter + 1;
    end
    // LED Control
    always_ff @(posedge CLK50M or negedge RESET_N) begin
        if(!RESET_N)
            LED <= 8'b0;
         else begin
            LED[0] <= ~r_pwm_width[6];
            LED[1] <= ~r_pwm_width[6];
            LED[2] <= ~r_pwm_width[6];
            LED[3] <= ~r_pwm_width[6];
            LED[4] <=  r_pwm_width[6];
            LED[5] <=  r_pwm_width[6];
            LED[6] <=  r_pwm_width[6];
            LED[7] <=  r_pwm_width[6];
         end
    end
    //
    always_ff @(posedge CLK50M or negedge RESET_N) begin
        if(!RESET_N)
            r_pwm_adj <= 6'b0;
        else
        if(r_counter[26])
            r_pwm_adj <= r_counter[25:20];
        else
            r_pwm_adj <= ~ r_counter[25:20];
    end
    //
    always_ff @(posedge CLK50M or negedge RESET_N) begin
        if(!RESET_N)
            r_pwm_width <= 13'b0;
         else
            r_pwm_width <= r_pwm_width[5:0]+ r_pwm_adj;
    end
endmodule
