//=================================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_trg.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0
//
//=================================================================
// Import
//=================================================================
// None
//=================================================================
// Module
//=================================================================
module ptmch_trg(
    // Reset/Clock
    input  logic          RESET_N,
    input  logic          CLK160M,
    input  logic          PTMCH_RST_N,
    output logic          CS_EDGE_N,
    // Logic Interface
    input  logic          SPI_CS,
    input  logic          SPI_CLK,
    input  logic          SPI_MOSI,
    output logic [ 4: 0]  TRG_PLS,
    //Page Address Setting
    input  logic [23: 0]  PRGEXCT_LOW_ADDR,
    input  logic [23: 0]  PRGEXCT_HIGH_ADDR,
    input  logic [23: 0]  RDSTAT_LOW_ADDR,
    input  logic [23: 0]  RDSTAT_HIGH_ADDR,
    input  logic [23: 0]  BLKERS_LOW_ADDR,
    input  logic [23: 0]  BLKERS_HIGH_ADDR,
    input  logic [23: 0]  PDREAD_LOW_ADDR,
    input  logic [23: 0]  PDREAD_HIGH_ADDR,
    input  logic [23: 0]  WRSTAT_LOW_ADDR,
    input  logic [23: 0]  WRSTAT_HIGH_ADDR
);
//=================================================================
//  PARAMETER declarations
//=================================================================
    parameter p_program_excute   = 8'h10;
    parameter p_readstatus1      = 8'h0f;
    parameter p_readstatus2      = 8'h05;
    parameter p_128kb_blockerase = 8'hd8;
    parameter p_pagedata_read    = 8'h13;
    parameter p_writestatus1     = 8'h1f;
    parameter p_writestatus2     = 8'h01;
//=================================================================
//  Internal Signal
//=================================================================
    logic [31: 0]  sr_inst_sht;
    logic [31: 0]  ar_inst_sht_160M_1d;
    logic [31: 0]  sr_inst_sht_160M_2d;
    logic [31: 0]  sr_inst_sht_160M_3d;
    logic [ 5: 0]  sr_inst_cnt;
    logic [ 5: 0]  ar_inst_cnt_160M_1d;
    logic [ 5: 0]  sr_inst_cnt_160M_2d;
    logic [ 5: 0]  sr_inst_cnt_160M_3d;
    logic [ 5: 0]  sr_inst_cnt_160M_sync;
    logic [31: 0]  sr_inst_chk;
    logic          c_inst_mch_n;
    logic          ar_inst_mch_n_1d;
    logic          sr_inst_mch_n_2d;
    logic          sr_inst_mch_n_3d;
    logic          sr_inst_edge_n;
    logic [ 3: 0]  sr_pls_cnt;
    logic          ar_spi_cs_1d;
    logic          sr_spi_cs_2d;
    logic          sr_spi_cs_3d;
    logic          sr_cs_edge_n;
    logic          sr_trg_pls;
    //program execute match
    logic          c_prgex_ins;
    logic          c_prgex_addr_l;
    logic          c_prgex_addr_h;
    logic          c_prgex_mch;
    //read status match
    logic          c_rdsts_ins;
    logic          c_rdsts_addr_l;
    logic          c_rdsts_addr_h;
    logic          c_rdsts_mch;
    //128KB Block Erase match
    logic          c_128kbbe_ins;
    logic          c_128kbbe_addr_l;
    logic          c_128kbbe_addr_h;
    logic          c_128kbbe_mch;
    //page data read match
    logic          c_pagedread_ins;
    logic          c_pagedread_addr_l;
    logic          c_pagedread_addr_h;
    logic          c_pagedread_mch;
    //write status match
    logic          c_wrsts_ins;
    logic          c_wrsts_addr_l;
    logic          c_wrsts_addr_h;
    logic          c_wrsts_mch;


    logic [23: 0]  ar_prgexct_low_addr_1d;
    logic [23: 0]  ar_prgexct_high_addr_1d;
    logic [23: 0]  ar_rdstat_low_addr_1d;
    logic [23: 0]  ar_rdstat_high_addr_1d;
    logic [23: 0]  ar_blkers_low_addr_1d;
    logic [23: 0]  ar_blkers_high_addr_1d;
    logic [23: 0]  ar_pdread_low_addr_1d;
    logic [23: 0]  ar_pdread_high_addr_1d;
    logic [23: 0]  ar_wrstat_low_addr_1d;
    logic [23: 0]  ar_wrstat_high_addr_1d;

    logic [23: 0]  sr_prgexct_low_addr_2d;
    logic [23: 0]  sr_prgexct_high_addr_2d;
    logic [23: 0]  sr_rdstat_low_addr_2d;
    logic [23: 0]  sr_rdstat_high_addr_2d;
    logic [23: 0]  sr_blkers_low_addr_2d;
    logic [23: 0]  sr_blkers_high_addr_2d;
    logic [23: 0]  sr_pdread_low_addr_2d;
    logic [23: 0]  sr_pdread_high_addr_2d;
    logic [23: 0]  sr_wrstat_low_addr_2d;
    logic [23: 0]  sr_wrstat_high_addr_2d;

    logic [23: 0]  sr_prgexct_low_addr_3d;
    logic [23: 0]  sr_prgexct_high_addr_3d;
    logic [23: 0]  sr_rdstat_low_addr_3d;
    logic [23: 0]  sr_rdstat_high_addr_3d;
    logic [23: 0]  sr_blkers_low_addr_3d;
    logic [23: 0]  sr_blkers_high_addr_3d;
    logic [23: 0]  sr_pdread_low_addr_3d;
    logic [23: 0]  sr_pdread_high_addr_3d;
    logic [23: 0]  sr_wrstat_low_addr_3d;
    logic [23: 0]  sr_wrstat_high_addr_3d;

    logic [23: 0]  sr_prgexct_low_addr_sync;
    logic [23: 0]  sr_prgexct_high_addr_sync;
    logic [23: 0]  sr_rdstat_low_addr_sync;
    logic [23: 0]  sr_rdstat_high_addr_sync;
    logic [23: 0]  sr_blkers_low_addr_sync;
    logic [23: 0]  sr_blkers_high_addr_sync;
    logic [23: 0]  sr_pdread_low_addr_sync;
    logic [23: 0]  sr_pdread_high_addr_sync;
    logic [23: 0]  sr_wrstat_low_addr_sync;
    logic [23: 0]  sr_wrstat_high_addr_sync;

//=================================================================
//  output Port
//=================================================================
    // SPI CS Edge Detect
    assign   CS_EDGE_N          = sr_cs_edge_n;

    //program execute match
    assign   c_prgex_ins        = (p_program_excute  == sr_inst_chk[31:24]);
    assign   c_prgex_addr_l     = (sr_inst_chk[23:0]>=sr_prgexct_low_addr_sync);
    assign   c_prgex_addr_h     = (sr_inst_chk[23:0]<=sr_prgexct_high_addr_sync);
    assign   c_prgex_mch        = (c_prgex_ins & c_prgex_addr_l & c_prgex_addr_h);
    //read status match
    assign   c_rdsts_ins        = (p_readstatus1 == sr_inst_chk[31:24])|(p_readstatus2 == sr_inst_chk[31:24]);
    assign   c_rdsts_addr_l     = (sr_inst_chk[23:0]>=sr_rdstat_low_addr_sync);
    assign   c_rdsts_addr_h     = (sr_inst_chk[23:0]<=sr_rdstat_high_addr_sync);
    assign   c_rdsts_mch        = (c_rdsts_ins & c_rdsts_addr_l & c_rdsts_addr_h);
    //128KB Block Erase match
    assign   c_128kbbe_ins      = (p_128kb_blockerase == sr_inst_chk[31:24]);
    assign   c_128kbbe_addr_l   = (sr_inst_chk[23:0]>=sr_blkers_low_addr_sync);
    assign   c_128kbbe_addr_h   = (sr_inst_chk[23:0]<=sr_blkers_high_addr_sync);
    assign   c_128kbbe_mch      = (c_128kbbe_ins & c_128kbbe_addr_l & c_128kbbe_addr_h);
    //page data read match
    assign   c_pagedread_ins    = (p_pagedata_read == sr_inst_chk[31:24]);
    assign   c_pagedread_addr_l = (sr_inst_chk[23:0]>=sr_pdread_low_addr_sync);
    assign   c_pagedread_addr_h = (sr_inst_chk[23:0]<=sr_pdread_high_addr_sync);
    assign   c_pagedread_mch    = (c_pagedread_ins & c_pagedread_addr_l & c_pagedread_addr_h);
    //write status match
    assign   c_wrsts_ins        = (p_writestatus1    == sr_inst_chk[31:24])|(p_writestatus2 == sr_inst_chk[31:24]);
    assign   c_wrsts_addr_l     = (sr_inst_chk[23:0]>=sr_wrstat_low_addr_sync);
    assign   c_wrsts_addr_h     = (sr_inst_chk[23:0]<=sr_wrstat_high_addr_sync);
    assign   c_wrsts_mch        = (c_wrsts_ins & c_wrsts_addr_l & c_wrsts_addr_h);

    assign   c_inst_mch_n       = ~(c_prgex_mch | c_rdsts_mch | c_128kbbe_mch | c_pagedread_mch | c_wrsts_mch);

//=================================================================
//  Structural coding
//=================================================================
    // Addr Setting (1d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N) begin
            ar_prgexct_low_addr_1d  <= 24'b0;
            ar_prgexct_high_addr_1d <= 24'b0;
            ar_rdstat_low_addr_1d   <= 24'b0;
            ar_rdstat_high_addr_1d  <= 24'b0;
            ar_blkers_low_addr_1d   <= 24'b0;
            ar_blkers_high_addr_1d  <= 24'b0;
            ar_pdread_low_addr_1d   <= 24'b0;
            ar_pdread_high_addr_1d  <= 24'b0;
            ar_wrstat_low_addr_1d   <= 24'b0;
            ar_wrstat_high_addr_1d  <= 24'b0;
        end
        else begin
            ar_prgexct_low_addr_1d  <= PRGEXCT_LOW_ADDR;
            ar_prgexct_high_addr_1d <= PRGEXCT_HIGH_ADDR;
            ar_rdstat_low_addr_1d   <= RDSTAT_LOW_ADDR;
            ar_rdstat_high_addr_1d  <= RDSTAT_HIGH_ADDR;
            ar_blkers_low_addr_1d   <= BLKERS_LOW_ADDR;
            ar_blkers_high_addr_1d  <= BLKERS_HIGH_ADDR;
            ar_pdread_low_addr_1d   <= PDREAD_LOW_ADDR;
            ar_pdread_high_addr_1d  <= PDREAD_HIGH_ADDR;
            ar_wrstat_low_addr_1d   <= WRSTAT_LOW_ADDR;
            ar_wrstat_high_addr_1d  <= WRSTAT_HIGH_ADDR;
       end
    end

    // Addr Setting (2d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_prgexct_low_addr_2d  <= 24'b0;
            sr_prgexct_high_addr_2d <= 24'b0;
            sr_rdstat_low_addr_2d   <= 24'b0;
            sr_rdstat_high_addr_2d  <= 24'b0;
            sr_blkers_low_addr_2d   <= 24'b0;
            sr_blkers_high_addr_2d  <= 24'b0;
            sr_pdread_low_addr_2d   <= 24'b0;
            sr_pdread_high_addr_2d  <= 24'b0;
            sr_wrstat_low_addr_2d   <= 24'b0;
            sr_wrstat_high_addr_2d  <= 24'b0;
        end
        else begin
            sr_prgexct_low_addr_2d  <= ar_prgexct_low_addr_1d;
            sr_prgexct_high_addr_2d <= ar_prgexct_high_addr_1d;
            sr_rdstat_low_addr_2d   <= ar_rdstat_low_addr_1d;
            sr_rdstat_high_addr_2d  <= ar_rdstat_high_addr_1d;
            sr_blkers_low_addr_2d   <= ar_blkers_low_addr_1d;
            sr_blkers_high_addr_2d  <= ar_blkers_high_addr_1d;
            sr_pdread_low_addr_2d   <= ar_pdread_low_addr_1d;
            sr_pdread_high_addr_2d  <= ar_pdread_high_addr_1d;
            sr_wrstat_low_addr_2d   <= ar_wrstat_low_addr_1d;
            sr_wrstat_high_addr_2d  <= ar_wrstat_high_addr_1d;
        end
    end

    // Addr Setting (3d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_prgexct_low_addr_3d  <= 24'b0;
            sr_prgexct_high_addr_3d <= 24'b0;
            sr_rdstat_low_addr_3d   <= 24'b0;
            sr_rdstat_high_addr_3d  <= 24'b0;
            sr_blkers_low_addr_3d   <= 24'b0;
            sr_blkers_high_addr_3d  <= 24'b0;
            sr_pdread_low_addr_3d   <= 24'b0;
            sr_pdread_high_addr_3d  <= 24'b0;
            sr_wrstat_low_addr_3d   <= 24'b0;
            sr_wrstat_high_addr_3d  <= 24'b0;
        end
        else begin
            sr_prgexct_low_addr_3d  <= sr_prgexct_low_addr_2d;
            sr_prgexct_high_addr_3d <= sr_prgexct_high_addr_2d;
            sr_rdstat_low_addr_3d   <= sr_rdstat_low_addr_2d;
            sr_rdstat_high_addr_3d  <= sr_rdstat_high_addr_2d;
            sr_blkers_low_addr_3d   <= sr_blkers_low_addr_2d;
            sr_blkers_high_addr_3d  <= sr_blkers_high_addr_2d;
            sr_pdread_low_addr_3d   <= sr_pdread_low_addr_2d;
            sr_pdread_high_addr_3d  <= sr_pdread_high_addr_2d;
            sr_wrstat_low_addr_3d   <= sr_wrstat_low_addr_2d;
            sr_wrstat_high_addr_3d  <= sr_wrstat_high_addr_2d;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_prgexct_low_addr_sync  <= 24'b0;
        else begin
            if(sr_prgexct_low_addr_2d == sr_prgexct_low_addr_3d)
                sr_prgexct_low_addr_sync  <= sr_prgexct_low_addr_3d;
            else
                sr_prgexct_low_addr_sync  <= sr_prgexct_low_addr_sync;
        end
    end
    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N )
            sr_prgexct_high_addr_sync  <= 24'b0;
        else begin
            if(sr_prgexct_high_addr_2d == sr_prgexct_high_addr_3d)
                sr_prgexct_high_addr_sync  <= sr_prgexct_high_addr_3d;
            else
                sr_prgexct_high_addr_sync  <= sr_prgexct_high_addr_sync;
        end
    end
    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N )
            sr_rdstat_low_addr_sync  <= 24'b0;
        else begin
            if(sr_rdstat_low_addr_2d == sr_rdstat_low_addr_3d)
                sr_rdstat_low_addr_sync  <= sr_rdstat_low_addr_3d;
            else
                sr_rdstat_low_addr_sync  <= sr_rdstat_low_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N )
            sr_rdstat_high_addr_sync  <= 24'b0;
        else begin
            if(sr_rdstat_high_addr_2d == sr_rdstat_high_addr_3d)
                sr_rdstat_high_addr_sync  <= sr_rdstat_high_addr_3d;
            else
                sr_rdstat_high_addr_sync  <= sr_rdstat_high_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N ) begin
        if(!RESET_N)
            sr_blkers_low_addr_sync  <= 24'b0;
        else begin
            if(sr_blkers_low_addr_2d == sr_blkers_low_addr_3d)
                sr_blkers_low_addr_sync  <= sr_blkers_low_addr_3d;
            else
                sr_blkers_low_addr_sync  <= sr_blkers_low_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_blkers_high_addr_sync  <= 24'b0;
        else begin
            if(sr_blkers_high_addr_2d == sr_blkers_high_addr_3d)
                sr_blkers_high_addr_sync  <= sr_blkers_high_addr_3d;
            else
                sr_blkers_high_addr_sync  <= sr_blkers_high_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_pdread_low_addr_sync  <= 24'b0;
        else begin
            if(sr_pdread_low_addr_2d == sr_pdread_low_addr_3d)
                sr_pdread_low_addr_sync  <= sr_pdread_low_addr_3d;
            else
                sr_pdread_low_addr_sync  <= sr_pdread_low_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_pdread_high_addr_sync  <= 24'b0;
        else begin
            if(sr_pdread_high_addr_2d == sr_pdread_high_addr_3d)
                sr_pdread_high_addr_sync  <= sr_pdread_high_addr_3d;
            else
                sr_pdread_high_addr_sync  <= sr_pdread_high_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_wrstat_low_addr_sync  <= 24'b0;
        else begin
            if(sr_wrstat_low_addr_2d == sr_wrstat_low_addr_3d)
                sr_wrstat_low_addr_sync  <= sr_wrstat_low_addr_3d;
            else
                sr_wrstat_low_addr_sync  <= sr_wrstat_low_addr_sync;
        end
    end

    // Addr Setting  (Diff Detect)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_wrstat_high_addr_sync  <= 24'b0;
        else begin
            if(sr_wrstat_high_addr_2d == sr_wrstat_high_addr_3d)
                sr_wrstat_high_addr_sync  <= sr_wrstat_high_addr_3d;
            else
                sr_wrstat_high_addr_sync  <= sr_wrstat_high_addr_sync;
        end
    end


    // SPI CS(async 1d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            ar_spi_cs_1d  <= 1'h0;
        else
            ar_spi_cs_1d  <= SPI_CS;
    end
    // SPI CS(sync 2d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_spi_cs_2d  <= 1'h0;
        else
            sr_spi_cs_2d  <= ar_spi_cs_1d;
    end
    // SPI CS(sync 3d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_spi_cs_3d  <= 1'h0;
        else
            sr_spi_cs_3d  <= sr_spi_cs_2d;
    end

    // Instraction edge Detect(Enable)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_inst_edge_n  <= 1'h1;
        else begin
            if ((!sr_inst_mch_n_2d & sr_inst_mch_n_3d))
                sr_inst_edge_n  <= 1'b0;
            else
                sr_inst_edge_n  <= 1'b1;
        end
    end

    // SPI CS(Enable)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_cs_edge_n  <= 1'h1;
        else begin
            if ((!sr_spi_cs_2d & sr_spi_cs_3d))
                sr_cs_edge_n  <= 1'b0;
            else
                sr_cs_edge_n  <= 1'b1;
        end
    end

    //  Instraction COUNTER
    always_ff @(posedge SPI_CLK or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_cnt  <= 6'b0;
        else begin
            if(sr_inst_cnt == 6'b100000 )// STOP
                sr_inst_cnt  <= sr_inst_cnt;
            else  // Count
                sr_inst_cnt  <= sr_inst_cnt + 1'b1;
        end
    end
    // Instraction COUNTER (1d)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            ar_inst_cnt_160M_1d  <= 6'b0;
        else
            ar_inst_cnt_160M_1d  <= sr_inst_cnt;
    end

    // Instraction COUNTER (2d)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_cnt_160M_2d  <= 6'b0;
        else
            sr_inst_cnt_160M_2d  <= ar_inst_cnt_160M_1d;
    end

    // Instraction COUNTER (3d)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_cnt_160M_3d  <= 6'b0;
        else
            sr_inst_cnt_160M_3d  <= sr_inst_cnt_160M_2d;
    end

    // Instraction COUNTER (Diff Detect)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N)begin
        if(!PTMCH_RST_N)
            sr_inst_cnt_160M_sync  <= 6'b0;
        else begin
            if(sr_inst_cnt_160M_2d == sr_inst_cnt_160M_3d)
                sr_inst_cnt_160M_sync  <= sr_inst_cnt_160M_3d;
            else
                sr_inst_cnt_160M_sync  <= sr_inst_cnt_160M_sync;
        end
    end

    // MOSI Shift Register
    always_ff @(posedge SPI_CLK or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_sht  <= 32'h0;
        else begin
            if(sr_inst_cnt == 6'b100000)// STOP
                sr_inst_sht <= sr_inst_sht;
            else  // Count
               sr_inst_sht[31:0]  <= {sr_inst_sht[30:0],SPI_MOSI};
        end
    end

    // MOSI Shift Register (1d)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            ar_inst_sht_160M_1d  <= 32'h0;
        else
            ar_inst_sht_160M_1d <= sr_inst_sht;
    end

    // MOSI Shift Register (2d)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_sht_160M_2d  <= 32'h0;
        else
            sr_inst_sht_160M_2d  <= ar_inst_sht_160M_1d;
    end

    // MOSI Shift Register (3d)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_sht_160M_3d  <= 32'h0;
        else
            sr_inst_sht_160M_3d  <= sr_inst_sht_160M_2d;
    end

    // MOSI Shift Register (Diff Detect)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_chk  <= 32'h0;
        else begin
            if((sr_inst_cnt_160M_sync == 6'b100000) & (sr_inst_sht_160M_2d == sr_inst_sht_160M_3d))
                sr_inst_chk  <= sr_inst_sht_160M_3d;
            else
                sr_inst_chk  <= sr_inst_chk;
        end
    end

    // Instracton Match pls(async)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            ar_inst_mch_n_1d  <= 1'b1;
        else
            ar_inst_mch_n_1d  <= c_inst_mch_n;
    end
    // Instracton Match pls(sync)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_mch_n_2d  <= 1'b1;
        else
            sr_inst_mch_n_2d  <= ar_inst_mch_n_1d;
    end
    // Instracton Match pls(sync)
    always_ff @(posedge CLK160M or negedge PTMCH_RST_N) begin
        if(!PTMCH_RST_N)
            sr_inst_mch_n_3d  <= 1'b1;
        else
            sr_inst_mch_n_3d  <= sr_inst_mch_n_2d;
    end
    //  TRG PLS COUNTER
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_pls_cnt  <= 4'b1;
        else begin
            if(!sr_inst_edge_n)
                sr_pls_cnt  <= 4'b0;
            else if(sr_pls_cnt == 4'b1111 )// STOP
                sr_pls_cnt  <= sr_pls_cnt;
            else  // Count
                sr_pls_cnt <= sr_pls_cnt + 1'b1;
        end
      end
    // TRG PLS time expander
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_trg_pls  <= 1'b0;
        else begin
            if(sr_pls_cnt == 4'b1111)// STOP
                sr_trg_pls <= 1'b0;
            else  // Count
                sr_trg_pls  <= 1'b1;
        end
    end
    // TRG_PLS Output sel[0]
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            TRG_PLS[0]  <= 1'b0;
        else begin
            if(sr_inst_chk[31:24] == p_program_excute)
                TRG_PLS[0] <= sr_trg_pls;
            else
                TRG_PLS[0]  <= 1'b0;
        end
    end
    // TRG_PLS Output sel[1]
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            TRG_PLS[1]  <= 1'b0;
        else begin
            if(sr_inst_chk[31:24] == p_readstatus1 | sr_inst_chk[31:24] == p_readstatus2)
                TRG_PLS[1] <= sr_trg_pls;
            else
                TRG_PLS[1]  <= 1'b0;
        end
    end
    // TRG_PLS Output sel[2]
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            TRG_PLS[2]  <= 1'b0;
        else begin
            if(sr_inst_chk[31:24] == p_128kb_blockerase)
                TRG_PLS[2] <= sr_trg_pls;
            else
                TRG_PLS[2]  <= 1'b0;
        end
    end
    // TRG_PLS Output sel[3]
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            TRG_PLS[3]  <= 1'b0;
        else begin
            if(sr_inst_chk[31:24] == p_pagedata_read)
                TRG_PLS[3] <= sr_trg_pls;
            else
                TRG_PLS[3]  <= 1'b0;
        end
    end
    // TRG_PLS Output sel[4]
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            TRG_PLS[4]  <= 1'b0;
        else begin
            if(sr_inst_chk[31:24] == p_writestatus1 | sr_inst_chk[31:24] == p_writestatus2)
                TRG_PLS[4] <= sr_trg_pls;
            else
                TRG_PLS[4]  <= 1'b0;
        end
    end

endmodule
