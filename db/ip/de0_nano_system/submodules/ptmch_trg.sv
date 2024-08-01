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
    input  logic [23: 0]  PDREAD_HIGH_ADDR
//    input  logic [23: 0]  WRSTAT_LOW_ADDR,
//    input  logic [23: 0]  WRSTAT_HIGH_ADDR
);
//=================================================================
//  PARAMETER declarations
//=================================================================
    parameter p_program_excute   = 8'h10;
    parameter p_readstatus1      = 8'h0f;
    parameter p_readstatus2      = 8'h05;
    parameter p_128kb_blockerase = 8'hd8;
    parameter p_pagedata_read    = 8'h13;
//    parameter p_writestatus1     = 8'h1f;
//    parameter p_writestatus2     = 8'h01;
//=================================================================
//  Internal Signal
//=================================================================
    logic [31: 0]  sr_inst_sht;
    logic [ 5: 0]  sr_inst_cnt;
    logic [31: 0]  c_inst_chk;
    logic          c_inst_mch;
    logic          ar_inst_mch_sft1;
    logic          sr_inst_mch_sft2;
    logic          sr_inst_mch_sft3;
    logic          c_inst_edge;
    logic [ 3: 0]  sr_pls_cnt;
    logic          ar_spi_cs_1d;
    logic          sr_spi_cs_2d;
    logic          sr_cs_sync;
    logic          sr_cs_sync_sft1;
    logic          c_cs_edge;
    logic          n_trg_pls;
    
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
//    //write status match
//    logic          c_wrsts_ins;
//    logic          c_wrsts_addr_l;
//    logic          c_wrsts_addr_h;
//    logic          c_wrsts_mch;

    logic          c_stopcnt;
//=================================================================
//  output Port
//=================================================================
    // TRG_PLS Output sel
    assign   TRG_PLS[0]  = (c_inst_chk[31:24] == p_program_excute )? n_trg_pls:
                                                                      1'b0;
    assign   TRG_PLS[1]  = (c_inst_chk[31:24] == p_readstatus1  | c_inst_chk[31:24] == p_readstatus2)? n_trg_pls:
                                                                                                       1'b0;
    assign   TRG_PLS[2]  = (c_inst_chk[31:24] == p_128kb_blockerase )? n_trg_pls:
                                                                           1'b0;
    assign   TRG_PLS[3]  = (c_inst_chk[31:24] == p_pagedata_read )? n_trg_pls:
                                                                        1'b0;
//    assign   TRG_PLS[4]  = (c_inst_chk[31:24] == p_writestatus1 | c_inst_chk[31:24] == p_writestatus2)? n_trg_pls:
//                                                                                                        1'b0;
    assign   c_inst_edge = (sr_inst_mch_sft2 & ~sr_inst_mch_sft3);
    assign   c_cs_edge   = (~sr_cs_sync & sr_cs_sync_sft1);
    assign   c_stopcnt   = (sr_inst_cnt == 6'b100000)? 1'b1:
                                                       1'b0;
    assign   c_inst_chk   = (c_stopcnt == 1'b1)? sr_inst_sht:
                                                 1'b0;
    
//=================================================================
//  Structural coding
//=================================================================
    //  Instraction COUNTER
    always_ff @(posedge SPI_CLK or negedge RESET_N or posedge c_cs_edge) begin
        if(!RESET_N | c_cs_edge)
            sr_inst_cnt  <= 6'b0;
        else begin
            if(c_stopcnt == 1'b1 )// STOP
                sr_inst_cnt  <= sr_inst_cnt;
            else  // Count
                sr_inst_cnt  <= sr_inst_cnt + 1'b1;
        end
    end
    // MOSI Shift Register
    always_ff @(posedge SPI_CLK or negedge RESET_N or posedge c_cs_edge) begin
        if(!RESET_N | c_cs_edge)
            sr_inst_sht  <= 32'h0;
        else begin
            if(c_stopcnt == 1'b1)// STOP
                sr_inst_sht <= sr_inst_sht;
            else  // Count
               sr_inst_sht[31:0]  <= {sr_inst_sht[30:0],SPI_MOSI};
        end
    end

    // Instracton Match pls(async)
    always_ff @(posedge CLK160M or negedge RESET_N or posedge c_cs_edge) begin
        if(!RESET_N | c_cs_edge)
            ar_inst_mch_sft1  <= 1'b0;
        else
            ar_inst_mch_sft1  <= c_inst_mch;
    end
    // Instracton Match pls(sync)
    always_ff @(posedge CLK160M or negedge RESET_N or posedge c_cs_edge) begin
        if(!RESET_N | c_cs_edge)
            sr_inst_mch_sft2  <= 1'b0;
        else
            sr_inst_mch_sft2  <= ar_inst_mch_sft1;
    end
    // Instracton Match pls(sync)
    always_ff @(posedge CLK160M or negedge RESET_N or posedge c_cs_edge) begin
        if(!RESET_N | c_cs_edge)
            sr_inst_mch_sft3  <= 1'b0;
        else
            sr_inst_mch_sft3  <= sr_inst_mch_sft2;
    end
    //  TRG PLS COUNTER
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_pls_cnt  <= 4'b1111;
        else
            if (c_inst_edge == 1'b1) // CLR
                sr_pls_cnt  <= 4'b0;
            else if(sr_pls_cnt == 4'b1111 )// STOP
                sr_pls_cnt  <= sr_pls_cnt;
            else  // Count
                sr_pls_cnt <= sr_pls_cnt + 1'b1;
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
            sr_cs_sync  <= 1'h0;
        else
            sr_cs_sync  <= sr_spi_cs_2d;
    end
    // SPI CS(sft 1d)
    always_ff @(posedge CLK160M or negedge RESET_N) begin
        if(!RESET_N)
            sr_cs_sync_sft1  <= 1'h0;
        else
            sr_cs_sync_sft1  <= sr_cs_sync;
    end

    //program execute match
    assign   c_prgex_ins        = (p_program_excute == c_inst_chk[31:24]);
    assign   c_prgex_addr_l     = (c_inst_chk[23:0]>=PRGEXCT_LOW_ADDR);
    assign   c_prgex_addr_h     = (c_inst_chk[23:0]<=PRGEXCT_HIGH_ADDR);
    assign   c_prgex_mch        = (c_prgex_ins & c_prgex_addr_l & c_prgex_addr_h);

    //read status match
    assign   c_rdsts_ins        = (p_readstatus1 == c_inst_chk[31:24])|(p_readstatus2 == c_inst_chk[31:24]);
    assign   c_rdsts_addr_l     = (c_inst_chk[23:0]>=RDSTAT_LOW_ADDR);
    assign   c_rdsts_addr_h     = (c_inst_chk[23:0]<=RDSTAT_HIGH_ADDR);
    assign   c_rdsts_mch        = (c_rdsts_ins & c_rdsts_addr_l & c_rdsts_addr_h);

    //128KB Block Erase match
    assign   c_128kbbe_ins      = (p_128kb_blockerase == c_inst_chk[31:24]);
    assign   c_128kbbe_addr_l   = (c_inst_chk[23:0]>=BLKERS_LOW_ADDR);
    assign   c_128kbbe_addr_h   = (c_inst_chk[23:0]<=BLKERS_HIGH_ADDR);
    assign   c_128kbbe_mch      = (c_128kbbe_ins & c_128kbbe_addr_l & c_128kbbe_addr_h);

    //page data read match
    assign   c_pagedread_ins    = (p_pagedata_read == c_inst_chk[31:24]);
    assign   c_pagedread_addr_l = (c_inst_chk[23:0]>=PDREAD_LOW_ADDR);
    assign   c_pagedread_addr_h = (c_inst_chk[23:0]<=PDREAD_HIGH_ADDR);
    assign   c_pagedread_mch    = (c_pagedread_ins & c_pagedread_addr_l & c_pagedread_addr_h);

//    //write status match
//    assign   c_wrsts_ins        = (p_writestatus1 == c_inst_chk[31:24])|(p_writestatus2 == c_inst_chk[31:24]);
//    assign   c_wrsts_addr_l     = (c_inst_chk[23:0]>=WRSTAT_LOW_ADDR);
//    assign   c_wrsts_addr_h     = (c_inst_chk[23:0]<=WRSTAT_HIGH_ADDR);
//    assign   c_wrsts_mch        = (c_wrsts_ins & c_wrsts_addr_l & c_wrsts_addr_h);

//    assign   c_inst_mch        = (c_prgex_mch | c_rdsts_mch | c_128kbbe_mch | c_pagedread_mch | c_wrsts_mch);
    assign   c_inst_mch        = (c_prgex_mch | c_rdsts_mch | c_128kbbe_mch | c_pagedread_mch);

    // TRG PLS time expander
    always @* begin
        case (sr_pls_cnt)
            4'b0000 : n_trg_pls = 1'b1;
            4'b0001 : n_trg_pls = 1'b1;
            4'b0010 : n_trg_pls = 1'b1;
            4'b0011 : n_trg_pls = 1'b1;
            4'b0100 : n_trg_pls = 1'b1;
            4'b0101 : n_trg_pls = 1'b1;
            4'b0110 : n_trg_pls = 1'b1;
            4'b0111 : n_trg_pls = 1'b1;
            4'b1000 : n_trg_pls = 1'b1;
            4'b1001 : n_trg_pls = 1'b1;
            4'b1010 : n_trg_pls = 1'b1;
            4'b1011 : n_trg_pls = 1'b1;
            4'b1100 : n_trg_pls = 1'b1;
            4'b1101 : n_trg_pls = 1'b1;
            4'b1110 : n_trg_pls = 1'b1;
            4'b1111 : n_trg_pls = 1'b0;
            default : n_trg_pls = 1'b0;
        endcase
    end
endmodule
