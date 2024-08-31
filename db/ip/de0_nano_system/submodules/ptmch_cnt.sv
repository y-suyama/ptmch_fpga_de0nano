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
    output  logic [31: 0] WRSTAT,
    // 240830
    input   logic [ 2: 0] PAGEADDR_SEL,
    output  logic [ 5: 0] PADDR_CNT,
    // TRG_PLS INPUT
    input   logic [ 4: 0] TRG_PLS,
    output  logic         PLS_RISE
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
    // Clock Transfer 5d
    logic  [ 4: 0]  sr_trg_pls_5d;
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
    // TRG PLS Counter(WRSTAT)
    logic  [31: 0]  sr_wrstat_counter;

//=================================================================
//  assign
//=================================================================
    // Rise Edge Pulse
    assign c_pls_rise[0] = sr_trg_pls_4d[0] & ~sr_trg_pls_5d[0] ;
    assign c_pls_rise[1] = sr_trg_pls_4d[1] & ~sr_trg_pls_5d[1] ;
    assign c_pls_rise[2] = sr_trg_pls_4d[2] & ~sr_trg_pls_5d[2] ;
    assign c_pls_rise[3] = sr_trg_pls_4d[3] & ~sr_trg_pls_5d[3] ;
    assign c_pls_rise[4] = sr_trg_pls_4d[4] & ~sr_trg_pls_5d[4] ;
    // TRG PLS Register Interface
    assign PRGEXCT = sr_prgexct_counter;
    assign RDSTAT  = sr_rdstat_counter;
    assign BLKERS  = sr_blkers_counter;
    assign PDREAD  = sr_pdread_counter;
    assign WRSTAT  = sr_wrstat_counter;

//=================================================================
//  Structural coding
//=================================================================
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

    // Page Address Selsect
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PLS_RISE <= 1'h0;
        else begin
            case(PAGEADDR_SEL) 
                3'b000  : PLS_RISE <= c_pls_rise[0]; // 0x0:program excute
                3'b001  : PLS_RISE <= c_pls_rise[1]; // 0x1:readstatus
                3'b010  : PLS_RISE <= c_pls_rise[2]; // 0x2:128kb_blockerase
                3'b011  : PLS_RISE <= c_pls_rise[3]; // 0x3:pagedata_read
                3'b100  : PLS_RISE <= c_pls_rise[4]; // 0x4:writestatus
                default : PLS_RISE <= c_pls_rise[0];
            endcase
        end
    end

    // Page Address Selsect
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PADDR_CNT <= 6'h0;
        else begin
            case(PAGEADDR_SEL) 
                3'b000  : PADDR_CNT <= sr_prgexct_counter[ 5: 0]; // 0x0:program excute
                3'b001  : PADDR_CNT <= sr_rdstat_counter[ 5: 0];  // 0x1:readstatus
                3'b010  : PADDR_CNT <= sr_blkers_counter[ 5: 0];  // 0x2:128kb_blockerase
                3'b011  : PADDR_CNT <= sr_pdread_counter[ 5: 0];  // 0x3:pagedata_read
                3'b100  : PADDR_CNT <= sr_wrstat_counter[ 5: 0];  // 0x4:writestatus
                default : PADDR_CNT <= sr_prgexct_counter[ 5: 0];
            endcase
        end
    end

endmodule
