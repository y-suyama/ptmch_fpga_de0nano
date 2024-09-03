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
    //240830
    input  logic [23: 0] PAGE_ADDR,
    input  logic         PLS_RISE,
    output logic [ 2: 0] PAGEADDR_SEL,
    input  logic [ 5: 0] PADDR_CNT,
    //Page Address Setting
    output logic [23: 0] PRGEXCT_LOW_ADDR,
    output logic [23: 0] PRGEXCT_HIGH_ADDR,
    output logic [23: 0] RDSTAT_LOW_ADDR,
    output logic [23: 0] RDSTAT_HIGH_ADDR,
    output logic [23: 0] BLKERS_LOW_ADDR,
    output logic [23: 0] BLKERS_HIGH_ADDR,
    output logic [23: 0] PDREAD_LOW_ADDR,
    output logic [23: 0] PDREAD_HIGH_ADDR,
    output logic [23: 0] WRSTAT_LOW_ADDR,
    output logic [23: 0] WRSTAT_HIGH_ADDR,
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
    // Read Only
    parameter p_rtlid_addr            = 16'h0000;
    parameter p_program_excute_addr   = 16'h0004;
    parameter p_readstatus_addr       = 16'h0008;
    parameter p_128kb_blockerase_addr = 16'h000C;
    parameter p_pagedata_read_addr    = 16'h0010;
    parameter p_writestatus_addr      = 16'h0014;
    // Read/Write
    parameter p_prgexct_low_addr      = 16'h0018;
    parameter p_prgexct_high_addr     = 16'h001C;
    parameter p_rdstat_low_addr       = 16'h0020;
    parameter p_rdstat_high_addr      = 16'h0024;
    parameter p_blkers_low_addr       = 16'h0028;
    parameter p_blkers_high_addr      = 16'h002C;
    parameter p_pdread_low_addr       = 16'h0030;
    parameter p_pdread_high_addr      = 16'h0034;
    parameter p_wrstat_low_addr       = 16'h0038;
    parameter p_wrstat_high_addr      = 16'h003C;
   //240830
    parameter p_paddr_sel_addr        = 16'h0040;
    parameter p_paddr_1              = 16'h0048;
    parameter p_paddr_2              = 16'h004C;
    parameter p_paddr_3              = 16'h0050;
    parameter p_paddr_4              = 16'h0054;
    parameter p_paddr_5              = 16'h0058;
    parameter p_paddr_6              = 16'h005C;
    parameter p_paddr_7              = 16'h0060;
    parameter p_paddr_8              = 16'h0064;
    parameter p_paddr_9              = 16'h0068;
    parameter p_paddr_10             = 16'h006C;
    parameter p_paddr_11             = 16'h0070;
    parameter p_paddr_12             = 16'h0074;
    parameter p_paddr_13             = 16'h0078;
    parameter p_paddr_14             = 16'h007C;
    parameter p_paddr_15             = 16'h0080;
    parameter p_paddr_16             = 16'h0084;
    parameter p_paddr_17             = 16'h0088;
    parameter p_paddr_18             = 16'h008C;
    parameter p_paddr_19             = 16'h0090;
    parameter p_paddr_20             = 16'h0094;
    parameter p_paddr_21             = 16'h0098;
    parameter p_paddr_22             = 16'h009C;
    parameter p_paddr_23             = 16'h00A0;
    parameter p_paddr_24             = 16'h00A4;
    parameter p_paddr_25             = 16'h00A8;
    parameter p_paddr_26             = 16'h00AC;
    parameter p_paddr_27             = 16'h00B0;
    parameter p_paddr_28             = 16'h00B4;
    parameter p_paddr_29             = 16'h00B8;
    parameter p_paddr_30             = 16'h00BC;
    parameter p_paddr_31             = 16'h00C0;
    parameter p_paddr_32             = 16'h00C4;
    parameter p_paddr_33             = 16'h00C8;
    parameter p_paddr_34             = 16'h00CC;
    parameter p_paddr_35             = 16'h00D0;
    parameter p_paddr_36             = 16'h00D4;
    parameter p_paddr_37             = 16'h00D8;
    parameter p_paddr_38             = 16'h00DC;
    parameter p_paddr_39             = 16'h00E0;
    parameter p_paddr_40             = 16'h00E4;
    parameter p_paddr_41             = 16'h00E8;
    parameter p_paddr_42             = 16'h00EC;
    parameter p_paddr_43             = 16'h00F0;
    parameter p_paddr_44             = 16'h00F4;
    parameter p_paddr_45             = 16'h00F8;
    parameter p_paddr_46             = 16'h00FC;
    parameter p_paddr_47             = 16'h0100;
    parameter p_paddr_48             = 16'h0104;
    parameter p_paddr_49             = 16'h0108;
    parameter p_paddr_50             = 16'h010C;
    parameter p_paddr_51             = 16'h0110;
    parameter p_paddr_52             = 16'h0114;
    parameter p_paddr_53             = 16'h0118;
    parameter p_paddr_54             = 16'h011C;
    parameter p_paddr_55             = 16'h0120;
    parameter p_paddr_56             = 16'h0124;
    parameter p_paddr_57             = 16'h0128;
    parameter p_paddr_58             = 16'h012C;
    parameter p_paddr_59             = 16'h0130;
    parameter p_paddr_60             = 16'h0134;
    parameter p_paddr_61             = 16'h0138;
    parameter p_paddr_62             = 16'h013C;
    parameter p_paddr_63             = 16'h0140;
    parameter p_paddr_64             = 16'h0144;


//=======================================================
//  Internal Signal
//=======================================================
    logic             w_reg_waitrequest;
    logic    [31: 0]  r_reg_readdata;
    logic    [15: 0]  sr_prgexct_paddr;
    logic    [15: 0]  sr_blker_paddr;
    logic    [23: 0]  ar_page_paddr_1d;
    logic    [23: 0]  sr_page_paddr_2d;
    logic    [23: 0]  sr_page_paddr_3d;
    logic    [23: 0]  sr_page_paddr_sync;
    logic    [23: 0]  sr_page_paddr_buf;
    logic    [ 2: 0]  sr_page_addr_sel;
    //240830 PageAddress Register
    logic    [23: 0]  sr_paddr_dat[128:1]; // 24x128 Array


//=======================================================
//  output Port
//=======================================================
    assign   REG_READDATA    = r_reg_readdata;
    assign   REG_WAITREQUEST = REG_BEGINTRANSFER & REG_CS;
    assign   PAGEADDR_SEL    = sr_page_addr_sel;

//=======================================================
//  Structural coding
//=======================================================
    // Page Addr (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            ar_page_paddr_1d  <= 24'b0;
        end
        else begin
            ar_page_paddr_1d  <= PAGE_ADDR;
       end
    end

    // Page Addr (2d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_page_paddr_2d  <= 24'b0;
        end
        else begin
            sr_page_paddr_2d  <= ar_page_paddr_1d;
        end
    end

    // Page Addr (3d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_page_paddr_3d  <= 24'b0;
        end
        else begin
            sr_page_paddr_3d  <= sr_page_paddr_2d;
        end
    end

    // Page Addr (Diff Detect)
    always_ff @(posedge CLK100M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_page_paddr_sync  <= 24'b0;
        else begin
            if(sr_page_paddr_2d == sr_page_paddr_3d)
                sr_page_paddr_sync  <= sr_page_paddr_3d;
            else
                sr_page_paddr_sync  <= sr_page_paddr_sync;
        end
    end

    // Page Addr mem buffer
    always_ff @(posedge CLK100M or negedge RESET_N ) begin
        if(!RESET_N )
            sr_page_paddr_buf  <= 24'b0;
        else begin
            if(PLS_RISE == 1'b1) // Load
                sr_page_paddr_buf  <= sr_page_paddr_sync;
            else
                sr_page_paddr_buf  <= sr_page_paddr_buf;
        end
    end

    // Page Address Resister1
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[1]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd1)
               sr_paddr_dat[1]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[1]  <= sr_paddr_dat[1];
        end
    end

    // Page Address Resister2
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[2]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd2)
               sr_paddr_dat[2]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[2]  <= sr_paddr_dat[2];
        end
    end

    // Page Address Resister3
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[3]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd3)
               sr_paddr_dat[3]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[3]  <= sr_paddr_dat[3];
        end
    end

    // Page Address Resister4
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[4]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd4)
               sr_paddr_dat[4]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[4]  <= sr_paddr_dat[4];
        end
    end

    // Page Address Resister5
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[5]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd5)
               sr_paddr_dat[5]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[5]  <= sr_paddr_dat[5];
        end
    end

    // Page Address Resister6
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[6]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd6)
               sr_paddr_dat[6]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[6]  <= sr_paddr_dat[6];
        end
    end

    // Page Address Resister7
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[7]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd7)
               sr_paddr_dat[7]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[7]  <= sr_paddr_dat[7];
        end
    end

    // Page Address Resister8
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[8]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd8)
               sr_paddr_dat[8]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[8]  <= sr_paddr_dat[8];
        end
    end

    // Page Address Resister9
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[9]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd9)
               sr_paddr_dat[9]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[9]  <= sr_paddr_dat[9];
        end
    end

    // Page Address Resister10
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[10]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd10)
               sr_paddr_dat[10]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[10]  <= sr_paddr_dat[10];
        end
    end

    // Page Address Resister11
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[11]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd11)
               sr_paddr_dat[11]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[11]  <= sr_paddr_dat[11];
        end
    end

    // Page Address Resister12
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[12]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd12)
               sr_paddr_dat[12]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[12]  <= sr_paddr_dat[12];
        end
    end

    // Page Address Resister13
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[13]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd13)
               sr_paddr_dat[13]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[13]  <= sr_paddr_dat[13];
        end
    end

    // Page Address Resister14
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[14]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd14)
               sr_paddr_dat[14]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[14]  <= sr_paddr_dat[14];
        end
    end

    // Page Address Resister15
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[15]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd15)
               sr_paddr_dat[15]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[15]  <= sr_paddr_dat[15];
        end
    end

    // Page Address Resister16
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[16]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd16)
               sr_paddr_dat[16]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[16]  <= sr_paddr_dat[16];
        end
    end

    // Page Address Resister17
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[17]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd17)
               sr_paddr_dat[17]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[17]  <= sr_paddr_dat[17];
        end
    end

    // Page Address Resister18
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[18]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd18)
               sr_paddr_dat[18]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[18]  <= sr_paddr_dat[18];
        end
    end

    // Page Address Resister19
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[19]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd19)
               sr_paddr_dat[19]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[19]  <= sr_paddr_dat[19];
        end
    end

    // Page Address Resister20
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[20]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd20)
               sr_paddr_dat[20]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[20]  <= sr_paddr_dat[20];
        end
    end

    // Page Address Resister21
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[21]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd21)
               sr_paddr_dat[21]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[21]  <= sr_paddr_dat[21];
        end
    end

    // Page Address Resister22
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[22]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd22)
               sr_paddr_dat[22]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[22]  <= sr_paddr_dat[22];
        end
    end

    // Page Address Resister23
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[23]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd23)
               sr_paddr_dat[23]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[23]  <= sr_paddr_dat[23];
        end
    end

    // Page Address Resister24
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[24]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd24)
               sr_paddr_dat[24]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[24]  <= sr_paddr_dat[24];
        end
    end

    // Page Address Resister25
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[25]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd25)
               sr_paddr_dat[25]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[25]  <= sr_paddr_dat[25];
        end
    end

    // Page Address Resister26
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[26]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd26)
               sr_paddr_dat[26]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[26]  <= sr_paddr_dat[26];
        end
    end

    // Page Address Resister27
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[27]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd27)
               sr_paddr_dat[27]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[27]  <= sr_paddr_dat[27];
        end
    end

    // Page Address Resister28
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[28]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd28)
               sr_paddr_dat[28]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[28]  <= sr_paddr_dat[28];
        end
    end

    // Page Address Resister29
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[29]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd29)
               sr_paddr_dat[29]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[29]  <= sr_paddr_dat[29];
        end
    end

    // Page Address Resister30
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[30]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd30)
               sr_paddr_dat[30]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[30]  <= sr_paddr_dat[30];
        end
    end

    // Page Address Resister31
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[31]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd31)
               sr_paddr_dat[31]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[31]  <= sr_paddr_dat[31];
        end
    end

    // Page Address Resister32
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[32]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd32)
               sr_paddr_dat[32]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[32]  <= sr_paddr_dat[32];
        end
    end

    // Page Address Resister33
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[33]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd33)
               sr_paddr_dat[33]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[33]  <= sr_paddr_dat[33];
        end
    end

    // Page Address Resister34
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[34]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd34)
               sr_paddr_dat[34]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[34]  <= sr_paddr_dat[34];
        end
    end

    // Page Address Resister35
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[35]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd35)
               sr_paddr_dat[35]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[35]  <= sr_paddr_dat[35];
        end
    end

    // Page Address Resister36
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[36]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd36)
               sr_paddr_dat[36]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[36]  <= sr_paddr_dat[36];
        end
    end

    // Page Address Resister37
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[37]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd37)
               sr_paddr_dat[37]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[37]  <= sr_paddr_dat[37];
        end
    end

    // Page Address Resister38
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[38]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd38)
               sr_paddr_dat[38]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[38]  <= sr_paddr_dat[38];
        end
    end

    // Page Address Resister39
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[39]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd39)
               sr_paddr_dat[39]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[39]  <= sr_paddr_dat[39];
        end
    end

    // Page Address Resister40
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[40]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd40)
               sr_paddr_dat[40]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[40]  <= sr_paddr_dat[40];
        end
    end

    // Page Address Resister41
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[41]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd41)
               sr_paddr_dat[41]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[41]  <= sr_paddr_dat[41];
        end
    end

    // Page Address Resister42
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[42]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd42)
               sr_paddr_dat[42]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[42]  <= sr_paddr_dat[42];
        end
    end

    // Page Address Resister43
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[43]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd43)
               sr_paddr_dat[43]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[43]  <= sr_paddr_dat[43];
        end
    end

    // Page Address Resister44
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[44]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd44)
               sr_paddr_dat[44]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[44]  <= sr_paddr_dat[44];
        end
    end

    // Page Address Resister45
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[45]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd45)
               sr_paddr_dat[45]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[45]  <= sr_paddr_dat[45];
        end
    end

    // Page Address Resister46
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[46]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd46)
               sr_paddr_dat[46]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[46]  <= sr_paddr_dat[46];
        end
    end

    // Page Address Resister47
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[47]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd47)
               sr_paddr_dat[47]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[47]  <= sr_paddr_dat[47];
        end
    end

    // Page Address Resister48
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[48]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd48)
               sr_paddr_dat[48]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[48]  <= sr_paddr_dat[48];
        end
    end

    // Page Address Resister49
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[49]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd49)
               sr_paddr_dat[49]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[49]  <= sr_paddr_dat[49];
        end
    end

    // Page Address Resister50
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[50]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd50)
               sr_paddr_dat[50]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[50]  <= sr_paddr_dat[50];
        end
    end

    // Page Address Resister51
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[51]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd51)
               sr_paddr_dat[51]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[51]  <= sr_paddr_dat[51];
        end
    end

    // Page Address Resister52
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[52]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd52)
               sr_paddr_dat[52]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[52]  <= sr_paddr_dat[52];
        end
    end

    // Page Address Resister53
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[53]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd53)
               sr_paddr_dat[53]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[53]  <= sr_paddr_dat[53];
        end
    end

    // Page Address Resister54
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[54]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd54)
               sr_paddr_dat[54]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[54]  <= sr_paddr_dat[54];
        end
    end

    // Page Address Resister55
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[55]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd55)
               sr_paddr_dat[55]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[55]  <= sr_paddr_dat[55];
        end
    end

    // Page Address Resister56
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[56]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd56)
               sr_paddr_dat[56]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[56]  <= sr_paddr_dat[56];
        end
    end

    // Page Address Resister57
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[57]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd57)
               sr_paddr_dat[57]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[57]  <= sr_paddr_dat[57];
        end
    end

    // Page Address Resister58
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[58]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd58)
               sr_paddr_dat[58]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[58]  <= sr_paddr_dat[58];
        end
    end

    // Page Address Resister59
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[59]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd59)
               sr_paddr_dat[59]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[59]  <= sr_paddr_dat[59];
        end
    end

    // Page Address Resister60
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[60]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd60)
               sr_paddr_dat[60]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[60]  <= sr_paddr_dat[60];
        end
    end

    // Page Address Resister61
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[61]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd61)
               sr_paddr_dat[61]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[61]  <= sr_paddr_dat[61];
        end
    end

    // Page Address Resister62
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[62]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd62)
               sr_paddr_dat[62]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[62]  <= sr_paddr_dat[62];
        end
    end

    // Page Address Resister63
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[63]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd63)
               sr_paddr_dat[63]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[63]  <= sr_paddr_dat[63];
        end
    end

    // Page Address Resister64
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[64]   <= 24'h0;
        else begin
           if (PADDR_CNT == 6'd64)
               sr_paddr_dat[64]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[64]  <= sr_paddr_dat[64];
        end
    end

    // Avalone Write DATA
    // PRGEXCT Low Address Register(0x0018)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PRGEXCT_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_prgexct_low_addr))
                PRGEXCT_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // PRGEXCT High Address Register(0x001C)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PRGEXCT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_prgexct_high_addr))
                PRGEXCT_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // RDSTAT Low Address Register(0x0020)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            RDSTAT_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_rdstat_low_addr))
                RDSTAT_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // RDSTAT High Address Register(0x0024)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            RDSTAT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_rdstat_high_addr))
                RDSTAT_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // BLKERS Low Address Register(0x0028)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            BLKERS_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_blkers_low_addr))
                BLKERS_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // BLKERS High Address Register(0x002C)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            BLKERS_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_blkers_high_addr))
                BLKERS_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // PDREAD Low Address Register(0x0030)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PDREAD_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_pdread_low_addr))
                PDREAD_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // PDREAD High Address Register(0x0034)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PDREAD_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_pdread_high_addr))
                PDREAD_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // WRSTAT Low Address Register(0x0038)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            WRSTAT_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_wrstat_low_addr))
                WRSTAT_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // WRSTAT High Address Register(0x003C)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            WRSTAT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_wrstat_high_addr))
                WRSTAT_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // Page Address Select Register(0x0040)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_page_addr_sel  <= 3'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_paddr_sel_addr))
                sr_page_addr_sel  <= REG_WRITEDATA[2:0];
        end
    end

    // Avalone READ DATA
    always_ff @(posedge CLK100M or negedge RESET_N) begin
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
                    p_prgexct_low_addr      : r_reg_readdata <= {8'd0,PRGEXCT_LOW_ADDR};
                    p_prgexct_high_addr     : r_reg_readdata <= {8'd0,PRGEXCT_HIGH_ADDR};
                    p_rdstat_low_addr       : r_reg_readdata <= {8'd0,RDSTAT_LOW_ADDR};
                    p_rdstat_high_addr      : r_reg_readdata <= {8'd0,RDSTAT_HIGH_ADDR};
                    p_blkers_low_addr       : r_reg_readdata <= {8'd0,BLKERS_LOW_ADDR};
                    p_blkers_high_addr      : r_reg_readdata <= {8'd0,BLKERS_HIGH_ADDR};
                    p_pdread_low_addr       : r_reg_readdata <= {8'd0,PDREAD_LOW_ADDR};
                    p_pdread_high_addr      : r_reg_readdata <= {8'd0,PDREAD_HIGH_ADDR};
                    p_wrstat_low_addr       : r_reg_readdata <= {8'd0,WRSTAT_LOW_ADDR};
                    p_wrstat_high_addr      : r_reg_readdata <= {8'd0,WRSTAT_HIGH_ADDR};
                    // 240830
                    p_paddr_sel_addr        : r_reg_readdata <= {29'd0,sr_page_addr_sel};
                    p_paddr_1               : r_reg_readdata <= {8'd0,sr_paddr_dat[1]};
                    p_paddr_2               : r_reg_readdata <= {8'd0,sr_paddr_dat[2]};
                    p_paddr_3               : r_reg_readdata <= {8'd0,sr_paddr_dat[3]};
                    p_paddr_4               : r_reg_readdata <= {8'd0,sr_paddr_dat[4]};
                    p_paddr_5               : r_reg_readdata <= {8'd0,sr_paddr_dat[5]};
                    p_paddr_6               : r_reg_readdata <= {8'd0,sr_paddr_dat[6]};
                    p_paddr_7               : r_reg_readdata <= {8'd0,sr_paddr_dat[7]};
                    p_paddr_8               : r_reg_readdata <= {8'd0,sr_paddr_dat[8]};
                    p_paddr_9               : r_reg_readdata <= {8'd0,sr_paddr_dat[9]};
                    p_paddr_10              : r_reg_readdata <= {8'd0,sr_paddr_dat[10]};
                    p_paddr_11              : r_reg_readdata <= {8'd0,sr_paddr_dat[11]};
                    p_paddr_12              : r_reg_readdata <= {8'd0,sr_paddr_dat[12]};
                    p_paddr_13              : r_reg_readdata <= {8'd0,sr_paddr_dat[13]};
                    p_paddr_14              : r_reg_readdata <= {8'd0,sr_paddr_dat[14]};
                    p_paddr_15              : r_reg_readdata <= {8'd0,sr_paddr_dat[15]};
                    p_paddr_16              : r_reg_readdata <= {8'd0,sr_paddr_dat[16]};
                    p_paddr_17              : r_reg_readdata <= {8'd0,sr_paddr_dat[17]};
                    p_paddr_18              : r_reg_readdata <= {8'd0,sr_paddr_dat[18]};
                    p_paddr_19              : r_reg_readdata <= {8'd0,sr_paddr_dat[19]};
                    p_paddr_20              : r_reg_readdata <= {8'd0,sr_paddr_dat[20]};
                    p_paddr_21              : r_reg_readdata <= {8'd0,sr_paddr_dat[21]};
                    p_paddr_22              : r_reg_readdata <= {8'd0,sr_paddr_dat[22]};
                    p_paddr_23              : r_reg_readdata <= {8'd0,sr_paddr_dat[23]};
                    p_paddr_24              : r_reg_readdata <= {8'd0,sr_paddr_dat[24]};
                    p_paddr_25              : r_reg_readdata <= {8'd0,sr_paddr_dat[25]};
                    p_paddr_26              : r_reg_readdata <= {8'd0,sr_paddr_dat[26]};
                    p_paddr_27              : r_reg_readdata <= {8'd0,sr_paddr_dat[27]};
                    p_paddr_28              : r_reg_readdata <= {8'd0,sr_paddr_dat[28]};
                    p_paddr_29              : r_reg_readdata <= {8'd0,sr_paddr_dat[29]};
                    p_paddr_30              : r_reg_readdata <= {8'd0,sr_paddr_dat[30]};
                    p_paddr_31              : r_reg_readdata <= {8'd0,sr_paddr_dat[31]};
                    p_paddr_32              : r_reg_readdata <= {8'd0,sr_paddr_dat[32]};
                    p_paddr_33              : r_reg_readdata <= {8'd0,sr_paddr_dat[33]};
                    p_paddr_34              : r_reg_readdata <= {8'd0,sr_paddr_dat[34]};
                    p_paddr_35              : r_reg_readdata <= {8'd0,sr_paddr_dat[35]};
                    p_paddr_36              : r_reg_readdata <= {8'd0,sr_paddr_dat[36]};
                    p_paddr_37              : r_reg_readdata <= {8'd0,sr_paddr_dat[37]};
                    p_paddr_38              : r_reg_readdata <= {8'd0,sr_paddr_dat[38]};
                    p_paddr_39              : r_reg_readdata <= {8'd0,sr_paddr_dat[39]};
                    p_paddr_40              : r_reg_readdata <= {8'd0,sr_paddr_dat[40]};
                    p_paddr_41              : r_reg_readdata <= {8'd0,sr_paddr_dat[41]};
                    p_paddr_42              : r_reg_readdata <= {8'd0,sr_paddr_dat[42]};
                    p_paddr_43              : r_reg_readdata <= {8'd0,sr_paddr_dat[43]};
                    p_paddr_44              : r_reg_readdata <= {8'd0,sr_paddr_dat[44]};
                    p_paddr_45              : r_reg_readdata <= {8'd0,sr_paddr_dat[45]};
                    p_paddr_46              : r_reg_readdata <= {8'd0,sr_paddr_dat[46]};
                    p_paddr_47              : r_reg_readdata <= {8'd0,sr_paddr_dat[47]};
                    p_paddr_48              : r_reg_readdata <= {8'd0,sr_paddr_dat[48]};
                    p_paddr_49              : r_reg_readdata <= {8'd0,sr_paddr_dat[49]};
                    p_paddr_50              : r_reg_readdata <= {8'd0,sr_paddr_dat[50]};
                    p_paddr_51              : r_reg_readdata <= {8'd0,sr_paddr_dat[51]};
                    p_paddr_52              : r_reg_readdata <= {8'd0,sr_paddr_dat[52]};
                    p_paddr_53              : r_reg_readdata <= {8'd0,sr_paddr_dat[53]};
                    p_paddr_54              : r_reg_readdata <= {8'd0,sr_paddr_dat[54]};
                    p_paddr_55              : r_reg_readdata <= {8'd0,sr_paddr_dat[55]};
                    p_paddr_56              : r_reg_readdata <= {8'd0,sr_paddr_dat[56]};
                    p_paddr_57              : r_reg_readdata <= {8'd0,sr_paddr_dat[57]};
                    p_paddr_58              : r_reg_readdata <= {8'd0,sr_paddr_dat[58]};
                    p_paddr_59              : r_reg_readdata <= {8'd0,sr_paddr_dat[59]};
                    p_paddr_60              : r_reg_readdata <= {8'd0,sr_paddr_dat[60]};
                    p_paddr_61              : r_reg_readdata <= {8'd0,sr_paddr_dat[61]};
                    p_paddr_62              : r_reg_readdata <= {8'd0,sr_paddr_dat[62]};
                    p_paddr_63              : r_reg_readdata <= {8'd0,sr_paddr_dat[63]};
                    p_paddr_64              : r_reg_readdata <= {8'd0,sr_paddr_dat[64]};
                    default                 : r_reg_readdata <= 32'h0000_0000;
                endcase
            end
        end
    end
endmodule

