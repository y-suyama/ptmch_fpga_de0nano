//=================================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_cnt.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0(èâî≈)
//
//=================================================================
// Import
//=================================================================
// None
//=================================================================
// Module
//=================================================================
module ptmch_cnt(
    // Reset/Clock
    input   logic         RESET_N,
    input   logic         CLK100M,
    // TRG PLS Register Interface
    output  logic [31: 0] PRGEXCT,
    output  logic [31: 0] RDSTAT,
    output  logic [31: 0] BLKERS,
    output  logic [31: 0] PDREAD,
<<<<<<< HEAD
    output  logic [31: 0] WRSTAT,
=======
//    output  logic [31: 0] WRSTAT,
>>>>>>> origin/main
    // TRG_PLS INPUT
    input   logic [ 4: 0] TRG_PLS
);
//=================================================================
//  Internal Signal
//=================================================================
    // Clock Transfer 1d
    logic  [ 4: 0]  ar_trg_pls_1d;
    // Clock Transfer 2d
    logic  [ 4: 0]  sr_trg_pls_2d;
    // Clock Transfer 3d
    logic  [ 4: 0]  sr_trg_pls_3d;
    // Clock Transfer 4d
    logic  [ 4: 0]  sr_trg_pls_4d;
<<<<<<< HEAD
    // Clock Transfer 5d
    logic  [ 4: 0]  sr_trg_pls_5d;
=======
>>>>>>> origin/main
    // TRG PLS Edge Detect
    logic  [ 4: 0]  c_pls_rise;
    // TRG PLS Counter(PRGEXCT)
    logic  [31: 0]  sr_prgexct_counter;
    // TRG PLS Counter(RDSTAT)
    logic  [31: 0]  sr_rdstat_counter;
    // TRG PLS Counter(BLKERS)
    logic  [31: 0]  sr_blkers_counter;
    // TRG PLS Counter(PDREAD)
    logic  [31: 0]  sr_pdread_counter;
<<<<<<< HEAD
    // TRG PLS Counter(WRSTAT)
    logic  [31: 0]  sr_wrstat_counter;
=======
//    // TRG PLS Counter(WRSTAT)
//    logic  [31: 0]  sr_wrstat_counter;
>>>>>>> origin/main

//=================================================================
//  assign
//=================================================================
    // Rise Edge Pulse
<<<<<<< HEAD
    assign c_pls_rise[0] = sr_trg_pls_4d[0] & ~sr_trg_pls_5d[0] ;
    assign c_pls_rise[1] = sr_trg_pls_4d[1] & ~sr_trg_pls_5d[1] ;
    assign c_pls_rise[2] = sr_trg_pls_4d[2] & ~sr_trg_pls_5d[2] ;
    assign c_pls_rise[3] = sr_trg_pls_4d[3] & ~sr_trg_pls_5d[3] ;
    assign c_pls_rise[4] = sr_trg_pls_4d[4] & ~sr_trg_pls_5d[4] ;
=======
    assign c_pls_rise[0] = sr_trg_pls_3d[0] & ~sr_trg_pls_4d[0] ;
    assign c_pls_rise[1] = sr_trg_pls_3d[1] & ~sr_trg_pls_4d[1] ;
    assign c_pls_rise[2] = sr_trg_pls_3d[2] & ~sr_trg_pls_4d[2] ;
    assign c_pls_rise[3] = sr_trg_pls_3d[3] & ~sr_trg_pls_4d[3] ;
//    assign c_pls_rise[4] = sr_trg_pls_3d[4] & ~sr_trg_pls_4d[4] ;
>>>>>>> origin/main
    // TRG PLS Register Interface
    assign PRGEXCT = sr_prgexct_counter;
    assign RDSTAT  = sr_rdstat_counter;
    assign BLKERS  = sr_blkers_counter;
    assign PDREAD  = sr_pdread_counter;
<<<<<<< HEAD
    assign WRSTAT  = sr_wrstat_counter;
=======
//    assign WRSTAT  = sr_wrstat_counter;
>>>>>>> origin/main

//=================================================================
//  Structural coding
//=================================================================
<<<<<<< HEAD
    // Clock Transfer (1d)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            ar_trg_pls_1d  <= 4'b0;
        else
            ar_trg_pls_1d  <= TRG_PLS;
    end
    // Clock Transfer (2d)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_2d  <= 4'b0;
        else
            sr_trg_pls_2d  <= ar_trg_pls_1d;
    end
    // Clock Transfer (3d)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_3d  <= 4'b0;
        else
            sr_trg_pls_3d  <= sr_trg_pls_2d;
    end


    // Clock Transfer (program_excute 4Clock)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[0]  <= 1'b0;
        else begin
        if (sr_trg_pls_2d[0] == sr_trg_pls_3d[0])
            sr_trg_pls_4d[0]  <= sr_trg_pls_3d[0];
        else
            sr_trg_pls_4d[0]  <= sr_trg_pls_4d[0];
        end
    end
    // Clock Transfer (p_readstatus 4Clock)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[1]  <= 1'b0;
        else begin
        if (sr_trg_pls_2d[1] == sr_trg_pls_3d[1])
            sr_trg_pls_4d[1]  <= sr_trg_pls_3d[1];
        else
            sr_trg_pls_4d[1]  <= sr_trg_pls_4d[1];
        end
    end
    // Clock Transfer (128kb_blockerase 4Clock)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[2]  <= 1'b0;
        else begin
        if (sr_trg_pls_2d[2] == sr_trg_pls_3d[2])
            sr_trg_pls_4d[2]  <= sr_trg_pls_3d[2];
        else
            sr_trg_pls_4d[2]  <= sr_trg_pls_4d[2];
        end
    end
    // Clock Transfer (pagedata_read 4Clock)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[3]  <= 1'b0;
        else begin
        if (sr_trg_pls_2d[3] == sr_trg_pls_3d[3])
            sr_trg_pls_4d[3]  <= sr_trg_pls_3d[3];
        else
            sr_trg_pls_4d[3]  <= sr_trg_pls_4d[3];
        end
    end
    // Clock Transfer (writestatus 4Clock)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[4]  <= 1'b0;
        else begin
        if (sr_trg_pls_2d[4] == sr_trg_pls_3d[4])
            sr_trg_pls_4d[4]  <= sr_trg_pls_3d[4];
        else
            sr_trg_pls_4d[4]  <= sr_trg_pls_4d[4];
        end
    end
    // Clock Transfer (5d)
    always @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_5d  <= 4'b0;
        else
            sr_trg_pls_5d  <= sr_trg_pls_4d;
    end

=======
    // Clock Transfer (program_excute 1Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            ar_trg_pls_1d[0]  <= 1'b0;
        else
            ar_trg_pls_1d[0]  <= TRG_PLS[0];
    end
    // Clock Transfer (p_readstatus 1Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            ar_trg_pls_1d[1]  <= 1'b0;
        else
            ar_trg_pls_1d[1]  <= TRG_PLS[1];
    end
    // Clock Transfer (128kb_blockerase 1Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            ar_trg_pls_1d[2]  <= 1'b0;
        else
            ar_trg_pls_1d[2]  <= TRG_PLS[2];
    end
    // Clock Transfer (pagedata_read 1Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            ar_trg_pls_1d[3]  <= 1'b0;
        else
            ar_trg_pls_1d[3]  <= TRG_PLS[3];
    end
//    // Clock Transfer (writestatus 1Clock)
//    always @(negedge CLK100M or negedge RESET_N) begin
//        if(!RESET_N)
//            ar_trg_pls_1d[4]  <= 1'b0;
//        else
//            ar_trg_pls_1d[4]  <= TRG_PLS[4];
//    end

    // Clock Transfer (program_excute 2Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_2d[0]  <= 1'b0;
        else
            sr_trg_pls_2d[0]  <= ar_trg_pls_1d[0];
    end
    // Clock Transfer (p_readstatus 2Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_2d[1]  <= 1'b0;
        else
            sr_trg_pls_2d[1]  <= ar_trg_pls_1d[1];
    end
    // Clock Transfer (128kb_blockerase 2Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_2d[2]  <= 1'b0;
        else
            sr_trg_pls_2d[2]  <= ar_trg_pls_1d[2];
    end
    // Clock Transfer (pagedata_read 2Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_2d[3]  <= 1'b0;
        else
            sr_trg_pls_2d[3]  <= ar_trg_pls_1d[3];
    end
//    // Clock Transfer (writestatus 2Clock)
//    always @(negedge CLK100M or negedge RESET_N) begin
//        if(!RESET_N)
//            sr_trg_pls_2d[4]  <= 1'b0;
//        else
//            sr_trg_pls_2d[4]  <= ar_trg_pls_1d[4];
//    end


    // Clock Transfer (program_excute 3Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_3d[0]  <= 1'b0;
        else
            sr_trg_pls_3d[0]  <= sr_trg_pls_2d[0];
    end
    // Clock Transfer (p_readstatus 3Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_3d[1]  <= 1'b0;
        else
            sr_trg_pls_3d[1]  <= sr_trg_pls_2d[1];
    end
    // Clock Transfer (128kb_blockerase 3Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_3d[2]  <= 1'b0;
        else
            sr_trg_pls_3d[2]  <= sr_trg_pls_2d[2];
    end
    // Clock Transfer (pagedata_read 3Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_3d[3]  <= 1'b0;
        else
            sr_trg_pls_3d[3]  <= sr_trg_pls_2d[3];
    end
//    // Clock Transfer (writestatus 3Clock)
//    always @(negedge CLK100M or negedge RESET_N) begin
//        if(!RESET_N)
//            sr_trg_pls_3d[4]  <= 1'b0;
//        else
//            sr_trg_pls_3d[4]  <= sr_trg_pls_2d[4];
//    end


    // Clock Transfer (program_excute 4Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[0]  <= 1'b0;
        else
            sr_trg_pls_4d[0]  <= sr_trg_pls_3d[0];
    end
    // Clock Transfer (p_readstatus 4Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[1]  <= 1'b0;
        else
            sr_trg_pls_4d[1]  <= sr_trg_pls_3d[1];
    end
    // Clock Transfer (128kb_blockerase 4Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[2]  <= 1'b0;
        else
            sr_trg_pls_4d[2]  <= sr_trg_pls_3d[2];
    end
    // Clock Transfer (pagedata_read 4Clock)
    always @(negedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls_4d[3]  <= 1'b0;
        else
            sr_trg_pls_4d[3]  <= sr_trg_pls_3d[3];
    end
//    // Clock Transfer (writestatus 4Clock)
//    always @(negedge CLK100M or negedge RESET_N) begin
//        if(!RESET_N)
//            sr_trg_pls_4d[4]  <= 1'b0;
//        else
//            sr_trg_pls_4d[4]  <= sr_trg_pls_3d[4];
//    end
>>>>>>> origin/main


    // TRG PLS Counter(PRGEXCT)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_prgexct_counter  <= 32'h0;
        else begin
            if (sr_prgexct_counter == 32'hFFFF_FFFF) // STOP
                sr_prgexct_counter <= sr_prgexct_counter;
            else if(c_pls_rise[0] == 1'b1) // Count
                sr_prgexct_counter  <= sr_prgexct_counter + 1;
            else
                sr_prgexct_counter  <= sr_prgexct_counter;
        end
    end

    // TRG PLS Counter(RDSTAT)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_rdstat_counter  <= 32'h0;
        else begin
            if (sr_rdstat_counter == 32'hFFFF_FFFF) // STOP
                sr_rdstat_counter <= sr_rdstat_counter;
            else if(c_pls_rise[1] == 1'b1) // Count
                sr_rdstat_counter  <= sr_rdstat_counter + 1;
            else
                sr_rdstat_counter  <= sr_rdstat_counter;
        end
    end

    // TRG PLS Counter(BLKERS)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_blkers_counter  <= 32'h0;
        else begin
            if (sr_blkers_counter == 32'hFFFF_FFFF) // STOP
                sr_blkers_counter <= sr_rdstat_counter;
            else if(c_pls_rise[2] == 1'b1) // Count
                sr_blkers_counter  <= sr_blkers_counter + 1;
            else
                sr_blkers_counter  <= sr_blkers_counter;
        end
    end

    // TRG PLS Counter(PDREAD)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_pdread_counter  <= 32'h0;
        else begin
            if (sr_pdread_counter == 32'hFFFF_FFFF) // STOP
                sr_pdread_counter <= sr_pdread_counter;
            else if(c_pls_rise[3] == 1'b1) // Count
                sr_pdread_counter  <= sr_pdread_counter + 1;
            else
                sr_pdread_counter  <= sr_pdread_counter;
        end
    end

<<<<<<< HEAD
    // TRG PLS Counter(WRSTAT)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_wrstat_counter  <= 32'h0;
        else begin
            if (sr_wrstat_counter == 32'hFFFF_FFFF) // STOP
                sr_wrstat_counter <= sr_wrstat_counter;
            else if(c_pls_rise[4] == 1'b1) // Count
                sr_wrstat_counter  <= sr_wrstat_counter + 1;
            else
                sr_wrstat_counter  <= sr_wrstat_counter;
        end
    end
=======
//    // TRG PLS Counter(WRSTAT)
//    always_ff @(posedge CLK100M or negedge RESET_N) begin
//        if(!RESET_N)
//            sr_wrstat_counter  <= 32'h0;
//        else begin
//            if (sr_wrstat_counter == 32'hFFFF_FFFF) // STOP
//                sr_wrstat_counter <= sr_wrstat_counter;
//            else if(c_pls_rise[4] == 1'b1) // Count
//                sr_wrstat_counter  <= sr_wrstat_counter + 1;
//            else
//                sr_wrstat_counter  <= sr_wrstat_counter;
//        end
//    end
>>>>>>> origin/main

endmodule
