//=======================================================
//  Company name        : 
//  Date                : 
//  File Name           : ptmch_reg.sv
//  Project Name        : 
//  Coding              : suyama
//  Rev.                : 1.0(����)
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
    input  logic [ 7: 0] PADDR_CNT,
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
    parameter p_paddr_0              = 16'h0044;
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
    parameter p_paddr_65             = 16'h0148;
    parameter p_paddr_66             = 16'h014C;
    parameter p_paddr_67             = 16'h0150;
    parameter p_paddr_68             = 16'h0154;
    parameter p_paddr_69             = 16'h0158;
    parameter p_paddr_70             = 16'h015C;
    parameter p_paddr_71             = 16'h0160;
    parameter p_paddr_72             = 16'h0164;
    parameter p_paddr_73             = 16'h0168;
    parameter p_paddr_74             = 16'h016C;
    parameter p_paddr_75             = 16'h0170;
    parameter p_paddr_76             = 16'h0174;
    parameter p_paddr_77             = 16'h0178;
    parameter p_paddr_78             = 16'h017C;
    parameter p_paddr_79             = 16'h0180;
    parameter p_paddr_80             = 16'h0184;
    parameter p_paddr_81             = 16'h0188;
    parameter p_paddr_82             = 16'h018C;
    parameter p_paddr_83             = 16'h0190;
    parameter p_paddr_84             = 16'h0194;
    parameter p_paddr_85             = 16'h0198;
    parameter p_paddr_86             = 16'h019C;
    parameter p_paddr_87             = 16'h01A0;
    parameter p_paddr_88             = 16'h01A4;
    parameter p_paddr_89             = 16'h01A8;
    parameter p_paddr_90             = 16'h01AC;
    parameter p_paddr_91             = 16'h01B0;
    parameter p_paddr_92             = 16'h01B4;
    parameter p_paddr_93             = 16'h01B8;
    parameter p_paddr_94             = 16'h01BC;
    parameter p_paddr_95             = 16'h01C0;
    parameter p_paddr_96             = 16'h01C4;
    parameter p_paddr_97             = 16'h01C8;
    parameter p_paddr_98             = 16'h01CC;
    parameter p_paddr_99             = 16'h01D0;
    parameter p_paddr_100            = 16'h01D4;
    parameter p_paddr_101            = 16'h01D8;
    parameter p_paddr_102            = 16'h01DC;
    parameter p_paddr_103            = 16'h01E0;
    parameter p_paddr_104            = 16'h01E4;
    parameter p_paddr_105            = 16'h01E8;
    parameter p_paddr_106            = 16'h01EC;
    parameter p_paddr_107            = 16'h01F0;
    parameter p_paddr_108            = 16'h01F4;
    parameter p_paddr_109            = 16'h01F8;
    parameter p_paddr_110            = 16'h01FC;
    parameter p_paddr_111            = 16'h0200;
    parameter p_paddr_112            = 16'h0204;
    parameter p_paddr_113            = 16'h0208;
    parameter p_paddr_114            = 16'h020C;
    parameter p_paddr_115            = 16'h0210;
    parameter p_paddr_116            = 16'h0214;
    parameter p_paddr_117            = 16'h0218;
    parameter p_paddr_118            = 16'h021C;
    parameter p_paddr_119            = 16'h0220;
    parameter p_paddr_120            = 16'h0224;
    parameter p_paddr_121            = 16'h0228;
    parameter p_paddr_122            = 16'h022C;
    parameter p_paddr_123            = 16'h0230;
    parameter p_paddr_124            = 16'h0234;
    parameter p_paddr_125            = 16'h0238;
    parameter p_paddr_126            = 16'h023C;
    parameter p_paddr_127            = 16'h0240;
    parameter p_paddr_128            = 16'h0244;
    parameter p_paddr_129            = 16'h0248;
    parameter p_paddr_130            = 16'h024C;
    parameter p_paddr_131            = 16'h0250;
    parameter p_paddr_132            = 16'h0254;
    parameter p_paddr_133            = 16'h0258;
    parameter p_paddr_134            = 16'h025C;
    parameter p_paddr_135            = 16'h0260;
    parameter p_paddr_136            = 16'h0264;
    parameter p_paddr_137            = 16'h0268;
    parameter p_paddr_138            = 16'h026C;
    parameter p_paddr_139            = 16'h0270;
    parameter p_paddr_140            = 16'h0274;
    parameter p_paddr_141            = 16'h0278;
    parameter p_paddr_142            = 16'h027C;
    parameter p_paddr_143            = 16'h0280;
    parameter p_paddr_144            = 16'h0284;
    parameter p_paddr_145            = 16'h0288;
    parameter p_paddr_146            = 16'h028C;
    parameter p_paddr_147            = 16'h0290;
    parameter p_paddr_148            = 16'h0294;
    parameter p_paddr_149            = 16'h0298;
    parameter p_paddr_150            = 16'h029C;
    parameter p_paddr_151            = 16'h02A0;
    parameter p_paddr_152            = 16'h02A4;
    parameter p_paddr_153            = 16'h02A8;
    parameter p_paddr_154            = 16'h02AC;
    parameter p_paddr_155            = 16'h02B0;
    parameter p_paddr_156            = 16'h02B4;
    parameter p_paddr_157            = 16'h02B8;
    parameter p_paddr_158            = 16'h02BC;
    parameter p_paddr_159            = 16'h02C0;
    parameter p_paddr_160            = 16'h02C4;
    parameter p_paddr_161            = 16'h02C8;
    parameter p_paddr_162            = 16'h02CC;
    parameter p_paddr_163            = 16'h02D0;
    parameter p_paddr_164            = 16'h02D4;
    parameter p_paddr_165            = 16'h02D8;
    parameter p_paddr_166            = 16'h02DC;
    parameter p_paddr_167            = 16'h02E0;
    parameter p_paddr_168            = 16'h02E4;
    parameter p_paddr_169            = 16'h02E8;
    parameter p_paddr_170            = 16'h02EC;
    parameter p_paddr_171            = 16'h02F0;
    parameter p_paddr_172            = 16'h02F4;
    parameter p_paddr_173            = 16'h02F8;
    parameter p_paddr_174            = 16'h02FC;
    parameter p_paddr_175            = 16'h0300;
    parameter p_paddr_176            = 16'h0304;
    parameter p_paddr_177            = 16'h0308;
    parameter p_paddr_178            = 16'h030C;
    parameter p_paddr_179            = 16'h0310;
    parameter p_paddr_180            = 16'h0314;
    parameter p_paddr_181            = 16'h0318;
    parameter p_paddr_182            = 16'h031C;
    parameter p_paddr_183            = 16'h0320;
    parameter p_paddr_184            = 16'h0324;
    parameter p_paddr_185            = 16'h0328;
    parameter p_paddr_186            = 16'h032C;
    parameter p_paddr_187            = 16'h0330;
    parameter p_paddr_188            = 16'h0334;
    parameter p_paddr_189            = 16'h0338;
    parameter p_paddr_190            = 16'h033C;
    parameter p_paddr_191            = 16'h0340;
    parameter p_paddr_192            = 16'h0344;
    parameter p_paddr_193            = 16'h0348;
    parameter p_paddr_194            = 16'h034C;
    parameter p_paddr_195            = 16'h0350;
    parameter p_paddr_196            = 16'h0354;
    parameter p_paddr_197            = 16'h0358;
    parameter p_paddr_198            = 16'h035C;
    parameter p_paddr_199            = 16'h0360;
    parameter p_paddr_200            = 16'h0364;
    parameter p_paddr_201            = 16'h0368;
    parameter p_paddr_202            = 16'h036C;
    parameter p_paddr_203            = 16'h0370;
    parameter p_paddr_204            = 16'h0374;
    parameter p_paddr_205            = 16'h0378;
    parameter p_paddr_206            = 16'h037C;
    parameter p_paddr_207            = 16'h0380;
    parameter p_paddr_208            = 16'h0384;
    parameter p_paddr_209            = 16'h0388;
    parameter p_paddr_210            = 16'h038C;
    parameter p_paddr_211            = 16'h0390;
    parameter p_paddr_212            = 16'h0394;
    parameter p_paddr_213            = 16'h0398;
    parameter p_paddr_214            = 16'h039C;
    parameter p_paddr_215            = 16'h03A0;
    parameter p_paddr_216            = 16'h03A4;
    parameter p_paddr_217            = 16'h03A8;
    parameter p_paddr_218            = 16'h03AC;
    parameter p_paddr_219            = 16'h03B0;
    parameter p_paddr_220            = 16'h03B4;
    parameter p_paddr_221            = 16'h03B8;
    parameter p_paddr_222            = 16'h03BC;
    parameter p_paddr_223            = 16'h03C0;
    parameter p_paddr_224            = 16'h03C4;
    parameter p_paddr_225            = 16'h03C8;
    parameter p_paddr_226            = 16'h03CC;
    parameter p_paddr_227            = 16'h03D0;
    parameter p_paddr_228            = 16'h03D4;
    parameter p_paddr_229            = 16'h03D8;
    parameter p_paddr_230            = 16'h03DC;
    parameter p_paddr_231            = 16'h03E0;
    parameter p_paddr_232            = 16'h03E4;
    parameter p_paddr_233            = 16'h03E8;
    parameter p_paddr_234            = 16'h03EC;
    parameter p_paddr_235            = 16'h03F0;
    parameter p_paddr_236            = 16'h03F4;
    parameter p_paddr_237            = 16'h03F8;
    parameter p_paddr_238            = 16'h03FC;
    parameter p_paddr_239            = 16'h0400;
    parameter p_paddr_240            = 16'h0404;
    parameter p_paddr_241            = 16'h0408;
    parameter p_paddr_242            = 16'h040C;
    parameter p_paddr_243            = 16'h0410;
    parameter p_paddr_244            = 16'h0414;
    parameter p_paddr_245            = 16'h0418;
    parameter p_paddr_246            = 16'h041C;
    parameter p_paddr_247            = 16'h0420;
    parameter p_paddr_248            = 16'h0424;
    parameter p_paddr_249            = 16'h0428;
    parameter p_paddr_250            = 16'h042C;
    parameter p_paddr_251            = 16'h0430;
    parameter p_paddr_252            = 16'h0434;
    parameter p_paddr_253            = 16'h0438;
    parameter p_paddr_254            = 16'h043C;
    parameter p_paddr_255            = 16'h0440;

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
    logic    [23: 0]  sr_paddr_dat[255:0]; // 24x256 Array
    //240901
//    logic             sr_read_comb;
    logic    [15: 0]  sr_reg_address_1d;
    logic             sr_reg_begintransfer_1d;
    logic             sr_reg_cs_1d;
    logic             sr_reg_read_1d;
    logic    [31: 0]  sr_reg_readdata_1d;
    logic             sr_reg_write_1d;
    logic    [31: 0]  sr_reg_writedata_1d;


//=======================================================
//  output Port
//=======================================================
//    assign   REG_READDATA    = r_reg_readdata;
    assign   REG_READDATA    = sr_reg_readdata_1d;
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

    // Page Address Resister0
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[0]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd0)
               sr_paddr_dat[0]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[0]  <= sr_paddr_dat[0];
        end
    end

    // Page Address Resister1
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[1]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd1)
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
           if (PADDR_CNT == 8'd2)
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
           if (PADDR_CNT == 8'd3)
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
           if (PADDR_CNT == 8'd4)
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
           if (PADDR_CNT == 8'd5)
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
           if (PADDR_CNT == 8'd6)
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
           if (PADDR_CNT == 8'd7)
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
           if (PADDR_CNT == 8'd8)
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
           if (PADDR_CNT == 8'd9)
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
           if (PADDR_CNT == 8'd10)
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
           if (PADDR_CNT == 8'd11)
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
           if (PADDR_CNT == 8'd12)
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
           if (PADDR_CNT == 8'd13)
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
           if (PADDR_CNT == 8'd14)
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
           if (PADDR_CNT == 8'd15)
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
           if (PADDR_CNT == 8'd16)
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
           if (PADDR_CNT == 8'd17)
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
           if (PADDR_CNT == 8'd18)
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
           if (PADDR_CNT == 8'd19)
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
           if (PADDR_CNT == 8'd20)
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
           if (PADDR_CNT == 8'd21)
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
           if (PADDR_CNT == 8'd22)
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
           if (PADDR_CNT == 8'd23)
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
           if (PADDR_CNT == 8'd24)
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
           if (PADDR_CNT == 8'd25)
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
           if (PADDR_CNT == 8'd26)
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
           if (PADDR_CNT == 8'd27)
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
           if (PADDR_CNT == 8'd28)
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
           if (PADDR_CNT == 8'd29)
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
           if (PADDR_CNT == 8'd30)
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
           if (PADDR_CNT == 8'd31)
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
           if (PADDR_CNT == 8'd32)
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
           if (PADDR_CNT == 8'd33)
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
           if (PADDR_CNT == 8'd34)
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
           if (PADDR_CNT == 8'd35)
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
           if (PADDR_CNT == 8'd36)
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
           if (PADDR_CNT == 8'd37)
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
           if (PADDR_CNT == 8'd38)
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
           if (PADDR_CNT == 8'd39)
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
           if (PADDR_CNT == 8'd40)
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
           if (PADDR_CNT == 8'd41)
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
           if (PADDR_CNT == 8'd42)
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
           if (PADDR_CNT == 8'd43)
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
           if (PADDR_CNT == 8'd44)
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
           if (PADDR_CNT == 8'd45)
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
           if (PADDR_CNT == 8'd46)
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
           if (PADDR_CNT == 8'd47)
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
           if (PADDR_CNT == 8'd48)
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
           if (PADDR_CNT == 8'd49)
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
           if (PADDR_CNT == 8'd50)
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
           if (PADDR_CNT == 8'd51)
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
           if (PADDR_CNT == 8'd52)
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
           if (PADDR_CNT == 8'd53)
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
           if (PADDR_CNT == 8'd54)
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
           if (PADDR_CNT == 8'd55)
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
           if (PADDR_CNT == 8'd56)
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
           if (PADDR_CNT == 8'd57)
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
           if (PADDR_CNT == 8'd58)
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
           if (PADDR_CNT == 8'd59)
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
           if (PADDR_CNT == 8'd60)
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
           if (PADDR_CNT == 8'd61)
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
           if (PADDR_CNT == 8'd62)
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
           if (PADDR_CNT == 8'd63)
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
           if (PADDR_CNT == 8'd64)
               sr_paddr_dat[64]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[64]  <= sr_paddr_dat[64];
        end
    end

    // Page Address Resister65
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[65]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd65)
               sr_paddr_dat[65]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[65]  <= sr_paddr_dat[65];
        end
    end

    // Page Address Resister66
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[66]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd66)
               sr_paddr_dat[66]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[66]  <= sr_paddr_dat[66];
        end
    end

    // Page Address Resister67
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[67]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd67)
               sr_paddr_dat[67]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[67]  <= sr_paddr_dat[67];
        end
    end

    // Page Address Resister68
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[68]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd68)
               sr_paddr_dat[68]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[68]  <= sr_paddr_dat[68];
        end
    end

    // Page Address Resister69
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[69]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd69)
               sr_paddr_dat[69]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[69]  <= sr_paddr_dat[69];
        end
    end

    // Page Address Resister70
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[70]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd70)
               sr_paddr_dat[70]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[70]  <= sr_paddr_dat[70];
        end
    end

    // Page Address Resister71
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[71]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd71)
               sr_paddr_dat[71]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[71]  <= sr_paddr_dat[71];
        end
    end

    // Page Address Resister72
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[72]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd72)
               sr_paddr_dat[72]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[72]  <= sr_paddr_dat[72];
        end
    end

    // Page Address Resister73
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[73]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd73)
               sr_paddr_dat[73]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[73]  <= sr_paddr_dat[73];
        end
    end

    // Page Address Resister74
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[74]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd74)
               sr_paddr_dat[74]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[74]  <= sr_paddr_dat[74];
        end
    end

    // Page Address Resister75
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[75]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd75)
               sr_paddr_dat[75]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[75]  <= sr_paddr_dat[75];
        end
    end

    // Page Address Resister76
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[76]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd76)
               sr_paddr_dat[76]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[76]  <= sr_paddr_dat[76];
        end
    end

    // Page Address Resister77
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[77]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd77)
               sr_paddr_dat[77]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[77]  <= sr_paddr_dat[77];
        end
    end

    // Page Address Resister78
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[78]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd78)
               sr_paddr_dat[78]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[78]  <= sr_paddr_dat[78];
        end
    end

    // Page Address Resister79
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[79]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd79)
               sr_paddr_dat[79]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[79]  <= sr_paddr_dat[79];
        end
    end

    // Page Address Resister80
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[80]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd80)
               sr_paddr_dat[80]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[80]  <= sr_paddr_dat[80];
        end
    end

    // Page Address Resister81
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[81]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd81)
               sr_paddr_dat[81]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[81]  <= sr_paddr_dat[81];
        end
    end

    // Page Address Resister82
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[82]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd82)
               sr_paddr_dat[82]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[82]  <= sr_paddr_dat[82];
        end
    end

    // Page Address Resister83
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[83]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd83)
               sr_paddr_dat[83]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[83]  <= sr_paddr_dat[83];
        end
    end

    // Page Address Resister84
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[84]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd84)
               sr_paddr_dat[84]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[84]  <= sr_paddr_dat[84];
        end
    end

    // Page Address Resister85
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[85]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd85)
               sr_paddr_dat[85]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[85]  <= sr_paddr_dat[85];
        end
    end

    // Page Address Resister86
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[86]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd86)
               sr_paddr_dat[86]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[86]  <= sr_paddr_dat[86];
        end
    end

    // Page Address Resister87
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[87]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd87)
               sr_paddr_dat[87]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[87]  <= sr_paddr_dat[87];
        end
    end

    // Page Address Resister88
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[88]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd88)
               sr_paddr_dat[88]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[88]  <= sr_paddr_dat[88];
        end
    end

    // Page Address Resister89
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[89]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd89)
               sr_paddr_dat[89]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[89]  <= sr_paddr_dat[89];
        end
    end

    // Page Address Resister90
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[90]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd90)
               sr_paddr_dat[90]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[90]  <= sr_paddr_dat[90];
        end
    end

    // Page Address Resister91
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[91]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd91)
               sr_paddr_dat[91]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[91]  <= sr_paddr_dat[91];
        end
    end

    // Page Address Resister92
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[92]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd92)
               sr_paddr_dat[92]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[92]  <= sr_paddr_dat[92];
        end
    end

    // Page Address Resister93
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[93]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd93)
               sr_paddr_dat[93]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[93]  <= sr_paddr_dat[93];
        end
    end

    // Page Address Resister94
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[94]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd94)
               sr_paddr_dat[94]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[94]  <= sr_paddr_dat[94];
        end
    end

    // Page Address Resister95
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[95]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd95)
               sr_paddr_dat[95]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[95]  <= sr_paddr_dat[95];
        end
    end

    // Page Address Resister96
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[96]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd96)
               sr_paddr_dat[96]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[96]  <= sr_paddr_dat[96];
        end
    end

    // Page Address Resister97
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[97]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd97)
               sr_paddr_dat[97]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[97]  <= sr_paddr_dat[97];
        end
    end

    // Page Address Resister98
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[98]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd98)
               sr_paddr_dat[98]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[98]  <= sr_paddr_dat[98];
        end
    end

    // Page Address Resister99
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[99]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd99)
               sr_paddr_dat[99]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[99]  <= sr_paddr_dat[99];
        end
    end

    // Page Address Resister100
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[100]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd100)
               sr_paddr_dat[100]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[100]  <= sr_paddr_dat[100];
        end
    end

    // Page Address Resister101
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[101]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd101)
               sr_paddr_dat[101]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[101]  <= sr_paddr_dat[101];
        end
    end

    // Page Address Resister102
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[102]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd102)
               sr_paddr_dat[102]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[102]  <= sr_paddr_dat[102];
        end
    end

    // Page Address Resister103
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[103]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd103)
               sr_paddr_dat[103]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[103]  <= sr_paddr_dat[103];
        end
    end

    // Page Address Resister104
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[104]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd104)
               sr_paddr_dat[104]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[104]  <= sr_paddr_dat[104];
        end
    end

    // Page Address Resister105
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[105]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd105)
               sr_paddr_dat[105]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[105]  <= sr_paddr_dat[105];
        end
    end

    // Page Address Resister106
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[106]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd106)
               sr_paddr_dat[106]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[106]  <= sr_paddr_dat[106];
        end
    end

    // Page Address Resister107
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[107]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd107)
               sr_paddr_dat[107]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[107]  <= sr_paddr_dat[107];
        end
    end

    // Page Address Resister108
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[108]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd108)
               sr_paddr_dat[108]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[108]  <= sr_paddr_dat[108];
        end
    end

    // Page Address Resister109
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[109]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd109)
               sr_paddr_dat[109]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[109]  <= sr_paddr_dat[109];
        end
    end

    // Page Address Resister110
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[110]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd110)
               sr_paddr_dat[110]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[110]  <= sr_paddr_dat[110];
        end
    end

    // Page Address Resister111
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[111]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd111)
               sr_paddr_dat[111]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[111]  <= sr_paddr_dat[111];
        end
    end

    // Page Address Resister112
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[112]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd112)
               sr_paddr_dat[112]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[112]  <= sr_paddr_dat[112];
        end
    end

    // Page Address Resister113
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[113]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd113)
               sr_paddr_dat[113]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[113]  <= sr_paddr_dat[113];
        end
    end

    // Page Address Resister114
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[114]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd114)
               sr_paddr_dat[114]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[114]  <= sr_paddr_dat[114];
        end
    end

    // Page Address Resister115
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[115]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd115)
               sr_paddr_dat[115]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[115]  <= sr_paddr_dat[115];
        end
    end

    // Page Address Resister116
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[116]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd116)
               sr_paddr_dat[116]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[116]  <= sr_paddr_dat[116];
        end
    end

    // Page Address Resister117
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[117]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd117)
               sr_paddr_dat[117]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[117]  <= sr_paddr_dat[117];
        end
    end

    // Page Address Resister118
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[118]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd118)
               sr_paddr_dat[118]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[118]  <= sr_paddr_dat[118];
        end
    end

    // Page Address Resister119
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[119]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd119)
               sr_paddr_dat[119]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[119]  <= sr_paddr_dat[119];
        end
    end

    // Page Address Resister120
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[120]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd120)
               sr_paddr_dat[120]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[120]  <= sr_paddr_dat[120];
        end
    end

    // Page Address Resister121
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[121]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd121)
               sr_paddr_dat[121]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[121]  <= sr_paddr_dat[121];
        end
    end

    // Page Address Resister122
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[122]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd122)
               sr_paddr_dat[122]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[122]  <= sr_paddr_dat[122];
        end
    end

    // Page Address Resister123
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[123]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd123)
               sr_paddr_dat[123]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[123]  <= sr_paddr_dat[123];
        end
    end

    // Page Address Resister124
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[124]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd124)
               sr_paddr_dat[124]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[124]  <= sr_paddr_dat[124];
        end
    end

    // Page Address Resister125
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[125]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd125)
               sr_paddr_dat[125]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[125]  <= sr_paddr_dat[125];
        end
    end

    // Page Address Resister126
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[126]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd126)
               sr_paddr_dat[126]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[126]  <= sr_paddr_dat[126];
        end
    end

    // Page Address Resister127
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[127]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd127)
               sr_paddr_dat[127]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[127]  <= sr_paddr_dat[127];
        end
    end

    // Page Address Resister128
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[128]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd128)
               sr_paddr_dat[128]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[128]  <= sr_paddr_dat[128];
        end
    end

    // Page Address Resister129
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[129]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd129)
               sr_paddr_dat[129]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[129]  <= sr_paddr_dat[129];
        end
    end

    // Page Address Resister130
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[130]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd130)
               sr_paddr_dat[130]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[130]  <= sr_paddr_dat[130];
        end
    end

    // Page Address Resister131
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[131]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd131)
               sr_paddr_dat[131]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[131]  <= sr_paddr_dat[131];
        end
    end

    // Page Address Resister132
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[132]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd132)
               sr_paddr_dat[132]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[132]  <= sr_paddr_dat[132];
        end
    end

    // Page Address Resister133
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[133]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd133)
               sr_paddr_dat[133]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[133]  <= sr_paddr_dat[133];
        end
    end

    // Page Address Resister134
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[134]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd134)
               sr_paddr_dat[134]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[134]  <= sr_paddr_dat[134];
        end
    end

    // Page Address Resister135
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[135]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd135)
               sr_paddr_dat[135]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[135]  <= sr_paddr_dat[135];
        end
    end

    // Page Address Resister136
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[136]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd136)
               sr_paddr_dat[136]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[136]  <= sr_paddr_dat[136];
        end
    end

    // Page Address Resister137
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[137]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd137)
               sr_paddr_dat[137]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[137]  <= sr_paddr_dat[137];
        end
    end

    // Page Address Resister138
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[138]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd138)
               sr_paddr_dat[138]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[138]  <= sr_paddr_dat[138];
        end
    end

    // Page Address Resister139
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[139]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd139)
               sr_paddr_dat[139]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[139]  <= sr_paddr_dat[139];
        end
    end

    // Page Address Resister140
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[140]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd140)
               sr_paddr_dat[140]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[140]  <= sr_paddr_dat[140];
        end
    end

    // Page Address Resister141
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[141]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd141)
               sr_paddr_dat[141]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[141]  <= sr_paddr_dat[141];
        end
    end

    // Page Address Resister142
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[142]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd142)
               sr_paddr_dat[142]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[142]  <= sr_paddr_dat[142];
        end
    end

    // Page Address Resister143
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[143]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd143)
               sr_paddr_dat[143]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[143]  <= sr_paddr_dat[143];
        end
    end

    // Page Address Resister144
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[144]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd144)
               sr_paddr_dat[144]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[144]  <= sr_paddr_dat[144];
        end
    end

    // Page Address Resister145
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[145]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd145)
               sr_paddr_dat[145]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[145]  <= sr_paddr_dat[145];
        end
    end

    // Page Address Resister146
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[146]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd146)
               sr_paddr_dat[146]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[146]  <= sr_paddr_dat[146];
        end
    end

    // Page Address Resister147
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[147]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd147)
               sr_paddr_dat[147]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[147]  <= sr_paddr_dat[147];
        end
    end

    // Page Address Resister148
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[148]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd148)
               sr_paddr_dat[148]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[148]  <= sr_paddr_dat[148];
        end
    end

    // Page Address Resister149
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[149]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd149)
               sr_paddr_dat[149]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[149]  <= sr_paddr_dat[149];
        end
    end

    // Page Address Resister150
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[150]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd150)
               sr_paddr_dat[150]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[150]  <= sr_paddr_dat[150];
        end
    end

    // Page Address Resister151
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[151]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd151)
               sr_paddr_dat[151]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[151]  <= sr_paddr_dat[151];
        end
    end

    // Page Address Resister152
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[152]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd152)
               sr_paddr_dat[152]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[152]  <= sr_paddr_dat[152];
        end
    end

    // Page Address Resister153
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[153]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd153)
               sr_paddr_dat[153]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[153]  <= sr_paddr_dat[153];
        end
    end

    // Page Address Resister154
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[154]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd154)
               sr_paddr_dat[154]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[154]  <= sr_paddr_dat[154];
        end
    end

    // Page Address Resister155
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[155]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd155)
               sr_paddr_dat[155]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[155]  <= sr_paddr_dat[155];
        end
    end

    // Page Address Resister156
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[156]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd156)
               sr_paddr_dat[156]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[156]  <= sr_paddr_dat[156];
        end
    end

    // Page Address Resister157
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[157]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd157)
               sr_paddr_dat[157]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[157]  <= sr_paddr_dat[157];
        end
    end

    // Page Address Resister158
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[158]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd158)
               sr_paddr_dat[158]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[158]  <= sr_paddr_dat[158];
        end
    end

    // Page Address Resister159
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[159]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd159)
               sr_paddr_dat[159]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[159]  <= sr_paddr_dat[159];
        end
    end

    // Page Address Resister160
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[160]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd160)
               sr_paddr_dat[160]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[160]  <= sr_paddr_dat[160];
        end
    end

    // Page Address Resister161
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[161]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd161)
               sr_paddr_dat[161]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[161]  <= sr_paddr_dat[161];
        end
    end

    // Page Address Resister162
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[162]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd162)
               sr_paddr_dat[162]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[162]  <= sr_paddr_dat[162];
        end
    end

    // Page Address Resister163
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[163]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd163)
               sr_paddr_dat[163]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[163]  <= sr_paddr_dat[163];
        end
    end

    // Page Address Resister164
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[164]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd164)
               sr_paddr_dat[164]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[164]  <= sr_paddr_dat[164];
        end
    end

    // Page Address Resister165
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[165]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd165)
               sr_paddr_dat[165]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[165]  <= sr_paddr_dat[165];
        end
    end

    // Page Address Resister166
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[166]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd166)
               sr_paddr_dat[166]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[166]  <= sr_paddr_dat[166];
        end
    end

    // Page Address Resister167
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[167]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd167)
               sr_paddr_dat[167]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[167]  <= sr_paddr_dat[167];
        end
    end

    // Page Address Resister168
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[168]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd168)
               sr_paddr_dat[168]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[168]  <= sr_paddr_dat[168];
        end
    end

    // Page Address Resister169
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[169]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd169)
               sr_paddr_dat[169]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[169]  <= sr_paddr_dat[169];
        end
    end

    // Page Address Resister170
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[170]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd170)
               sr_paddr_dat[170]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[170]  <= sr_paddr_dat[170];
        end
    end

    // Page Address Resister171
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[171]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd171)
               sr_paddr_dat[171]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[171]  <= sr_paddr_dat[171];
        end
    end

    // Page Address Resister172
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[172]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd172)
               sr_paddr_dat[172]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[172]  <= sr_paddr_dat[172];
        end
    end

    // Page Address Resister173
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[173]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd173)
               sr_paddr_dat[173]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[173]  <= sr_paddr_dat[173];
        end
    end

    // Page Address Resister174
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[174]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd174)
               sr_paddr_dat[174]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[174]  <= sr_paddr_dat[174];
        end
    end

    // Page Address Resister175
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[175]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd175)
               sr_paddr_dat[175]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[175]  <= sr_paddr_dat[175];
        end
    end

    // Page Address Resister176
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[176]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd176)
               sr_paddr_dat[176]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[176]  <= sr_paddr_dat[176];
        end
    end

    // Page Address Resister177
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[177]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd177)
               sr_paddr_dat[177]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[177]  <= sr_paddr_dat[177];
        end
    end

    // Page Address Resister178
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[178]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd178)
               sr_paddr_dat[178]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[178]  <= sr_paddr_dat[178];
        end
    end

    // Page Address Resister179
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[179]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd179)
               sr_paddr_dat[179]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[179]  <= sr_paddr_dat[179];
        end
    end

    // Page Address Resister180
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[180]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd180)
               sr_paddr_dat[180]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[180]  <= sr_paddr_dat[180];
        end
    end

    // Page Address Resister181
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[181]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd181)
               sr_paddr_dat[181]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[181]  <= sr_paddr_dat[181];
        end
    end

    // Page Address Resister182
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[182]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd182)
               sr_paddr_dat[182]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[182]  <= sr_paddr_dat[182];
        end
    end

    // Page Address Resister183
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[183]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd183)
               sr_paddr_dat[183]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[183]  <= sr_paddr_dat[183];
        end
    end

    // Page Address Resister184
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[184]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd184)
               sr_paddr_dat[184]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[184]  <= sr_paddr_dat[184];
        end
    end

    // Page Address Resister185
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[185]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd185)
               sr_paddr_dat[185]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[185]  <= sr_paddr_dat[185];
        end
    end

    // Page Address Resister186
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[186]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd186)
               sr_paddr_dat[186]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[186]  <= sr_paddr_dat[186];
        end
    end

    // Page Address Resister187
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[187]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd187)
               sr_paddr_dat[187]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[187]  <= sr_paddr_dat[187];
        end
    end

    // Page Address Resister188
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[188]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd188)
               sr_paddr_dat[188]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[188]  <= sr_paddr_dat[188];
        end
    end

    // Page Address Resister189
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[189]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd189)
               sr_paddr_dat[189]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[189]  <= sr_paddr_dat[189];
        end
    end

    // Page Address Resister190
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[190]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd190)
               sr_paddr_dat[190]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[190]  <= sr_paddr_dat[190];
        end
    end

    // Page Address Resister191
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[191]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd191)
               sr_paddr_dat[191]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[191]  <= sr_paddr_dat[191];
        end
    end

    // Page Address Resister192
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[192]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd192)
               sr_paddr_dat[192]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[192]  <= sr_paddr_dat[192];
        end
    end

    // Page Address Resister193
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[193]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd193)
               sr_paddr_dat[193]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[193]  <= sr_paddr_dat[193];
        end
    end

    // Page Address Resister194
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[194]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd194)
               sr_paddr_dat[194]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[194]  <= sr_paddr_dat[194];
        end
    end

    // Page Address Resister195
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[195]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd195)
               sr_paddr_dat[195]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[195]  <= sr_paddr_dat[195];
        end
    end

    // Page Address Resister196
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[196]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd196)
               sr_paddr_dat[196]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[196]  <= sr_paddr_dat[196];
        end
    end

    // Page Address Resister197
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[197]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd197)
               sr_paddr_dat[197]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[197]  <= sr_paddr_dat[197];
        end
    end

    // Page Address Resister198
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[198]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd198)
               sr_paddr_dat[198]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[198]  <= sr_paddr_dat[198];
        end
    end

    // Page Address Resister199
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[199]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd199)
               sr_paddr_dat[199]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[199]  <= sr_paddr_dat[199];
        end
    end

    // Page Address Resister200
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[200]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd200)
               sr_paddr_dat[200]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[200]  <= sr_paddr_dat[200];
        end
    end

    // Page Address Resister201
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[201]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd201)
               sr_paddr_dat[201]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[201]  <= sr_paddr_dat[201];
        end
    end

    // Page Address Resister202
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[202]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd202)
               sr_paddr_dat[202]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[202]  <= sr_paddr_dat[202];
        end
    end

    // Page Address Resister203
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[203]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd203)
               sr_paddr_dat[203]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[203]  <= sr_paddr_dat[203];
        end
    end

    // Page Address Resister204
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[204]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd204)
               sr_paddr_dat[204]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[204]  <= sr_paddr_dat[204];
        end
    end

    // Page Address Resister205
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[205]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd205)
               sr_paddr_dat[205]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[205]  <= sr_paddr_dat[205];
        end
    end

    // Page Address Resister206
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[206]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd206)
               sr_paddr_dat[206]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[206]  <= sr_paddr_dat[206];
        end
    end

    // Page Address Resister207
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[207]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd207)
               sr_paddr_dat[207]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[207]  <= sr_paddr_dat[207];
        end
    end

    // Page Address Resister208
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[208]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd208)
               sr_paddr_dat[208]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[208]  <= sr_paddr_dat[208];
        end
    end

    // Page Address Resister209
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[209]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd209)
               sr_paddr_dat[209]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[209]  <= sr_paddr_dat[209];
        end
    end

    // Page Address Resister210
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[210]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd210)
               sr_paddr_dat[210]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[210]  <= sr_paddr_dat[210];
        end
    end

    // Page Address Resister211
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[211]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd211)
               sr_paddr_dat[211]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[211]  <= sr_paddr_dat[211];
        end
    end

    // Page Address Resister212
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[212]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd212)
               sr_paddr_dat[212]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[212]  <= sr_paddr_dat[212];
        end
    end

    // Page Address Resister213
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[213]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd213)
               sr_paddr_dat[213]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[213]  <= sr_paddr_dat[213];
        end
    end

    // Page Address Resister214
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[214]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd214)
               sr_paddr_dat[214]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[214]  <= sr_paddr_dat[214];
        end
    end

    // Page Address Resister215
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[215]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd215)
               sr_paddr_dat[215]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[215]  <= sr_paddr_dat[215];
        end
    end

    // Page Address Resister216
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[216]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd216)
               sr_paddr_dat[216]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[216]  <= sr_paddr_dat[216];
        end
    end

    // Page Address Resister217
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[217]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd217)
               sr_paddr_dat[217]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[217]  <= sr_paddr_dat[217];
        end
    end

    // Page Address Resister218
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[218]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd218)
               sr_paddr_dat[218]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[218]  <= sr_paddr_dat[218];
        end
    end

    // Page Address Resister219
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[219]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd219)
               sr_paddr_dat[219]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[219]  <= sr_paddr_dat[219];
        end
    end

    // Page Address Resister220
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[220]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd220)
               sr_paddr_dat[220]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[220]  <= sr_paddr_dat[220];
        end
    end

    // Page Address Resister221
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[221]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd221)
               sr_paddr_dat[221]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[221]  <= sr_paddr_dat[221];
        end
    end

    // Page Address Resister222
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[222]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd222)
               sr_paddr_dat[222]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[222]  <= sr_paddr_dat[222];
        end
    end

    // Page Address Resister223
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[223]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd223)
               sr_paddr_dat[223]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[223]  <= sr_paddr_dat[223];
        end
    end

    // Page Address Resister224
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[224]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd224)
               sr_paddr_dat[224]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[224]  <= sr_paddr_dat[224];
        end
    end

    // Page Address Resister225
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[225]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd225)
               sr_paddr_dat[225]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[225]  <= sr_paddr_dat[225];
        end
    end

    // Page Address Resister226
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[226]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd226)
               sr_paddr_dat[226]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[226]  <= sr_paddr_dat[226];
        end
    end

    // Page Address Resister227
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[227]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd227)
               sr_paddr_dat[227]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[227]  <= sr_paddr_dat[227];
        end
    end

    // Page Address Resister228
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[228]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd228)
               sr_paddr_dat[228]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[228]  <= sr_paddr_dat[228];
        end
    end

    // Page Address Resister229
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[229]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd229)
               sr_paddr_dat[229]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[229]  <= sr_paddr_dat[229];
        end
    end

    // Page Address Resister230
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[230]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd230)
               sr_paddr_dat[230]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[230]  <= sr_paddr_dat[230];
        end
    end

    // Page Address Resister231
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[231]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd231)
               sr_paddr_dat[231]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[231]  <= sr_paddr_dat[231];
        end
    end

    // Page Address Resister232
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[232]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd232)
               sr_paddr_dat[232]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[232]  <= sr_paddr_dat[232];
        end
    end

    // Page Address Resister233
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[233]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd233)
               sr_paddr_dat[233]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[233]  <= sr_paddr_dat[233];
        end
    end

    // Page Address Resister234
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[234]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd234)
               sr_paddr_dat[234]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[234]  <= sr_paddr_dat[234];
        end
    end

    // Page Address Resister235
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[235]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd235)
               sr_paddr_dat[235]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[235]  <= sr_paddr_dat[235];
        end
    end

    // Page Address Resister236
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[236]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd236)
               sr_paddr_dat[236]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[236]  <= sr_paddr_dat[236];
        end
    end

    // Page Address Resister237
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[237]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd237)
               sr_paddr_dat[237]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[237]  <= sr_paddr_dat[237];
        end
    end

    // Page Address Resister238
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[238]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd238)
               sr_paddr_dat[238]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[238]  <= sr_paddr_dat[238];
        end
    end

    // Page Address Resister239
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[239]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd239)
               sr_paddr_dat[239]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[239]  <= sr_paddr_dat[239];
        end
    end

    // Page Address Resister240
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[240]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd240)
               sr_paddr_dat[240]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[240]  <= sr_paddr_dat[240];
        end
    end

    // Page Address Resister241
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[241]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd241)
               sr_paddr_dat[241]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[241]  <= sr_paddr_dat[241];
        end
    end

    // Page Address Resister242
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[242]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd242)
               sr_paddr_dat[242]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[242]  <= sr_paddr_dat[242];
        end
    end

    // Page Address Resister243
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[243]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd243)
               sr_paddr_dat[243]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[243]  <= sr_paddr_dat[243];
        end
    end

    // Page Address Resister244
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[244]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd244)
               sr_paddr_dat[244]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[244]  <= sr_paddr_dat[244];
        end
    end

    // Page Address Resister245
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[245]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd245)
               sr_paddr_dat[245]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[245]  <= sr_paddr_dat[245];
        end
    end

    // Page Address Resister246
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[246]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd246)
               sr_paddr_dat[246]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[246]  <= sr_paddr_dat[246];
        end
    end

    // Page Address Resister247
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[247]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd247)
               sr_paddr_dat[247]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[247]  <= sr_paddr_dat[247];
        end
    end

    // Page Address Resister248
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[248]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd248)
               sr_paddr_dat[248]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[248]  <= sr_paddr_dat[248];
        end
    end

    // Page Address Resister249
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[249]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd249)
               sr_paddr_dat[249]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[249]  <= sr_paddr_dat[249];
        end
    end

    // Page Address Resister250
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[250]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd250)
               sr_paddr_dat[250]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[250]  <= sr_paddr_dat[250];
        end
    end

    // Page Address Resister251
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[251]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd251)
               sr_paddr_dat[251]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[251]  <= sr_paddr_dat[251];
        end
    end

    // Page Address Resister252
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[252]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd252)
               sr_paddr_dat[252]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[252]  <= sr_paddr_dat[252];
        end
    end

    // Page Address Resister253
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[253]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd253)
               sr_paddr_dat[253]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[253]  <= sr_paddr_dat[253];
        end
    end

    // Page Address Resister254
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[254]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd254)
               sr_paddr_dat[254]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[254]  <= sr_paddr_dat[254];
        end
    end

    // Page Address Resister255
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_paddr_dat[255]   <= 24'h0;
        else begin
           if (PADDR_CNT == 8'd255)
               sr_paddr_dat[255]  <= sr_page_paddr_buf;
           else
               sr_paddr_dat[255]  <= sr_paddr_dat[255];
        end
    end

    // Avalone Write DATA
    // PRGEXCT Low Address Register(0x0018)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PRGEXCT_LOW_ADDR  <= 24'h0;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_prgexct_low_addr))
                PRGEXCT_LOW_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end
    // PRGEXCT High Address Register(0x001C)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PRGEXCT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_prgexct_high_addr))
                PRGEXCT_HIGH_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end

    // RDSTAT Low Address Register(0x0020)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            RDSTAT_LOW_ADDR  <= 24'h0;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_rdstat_low_addr))
                RDSTAT_LOW_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end
    // RDSTAT High Address Register(0x0024)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            RDSTAT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_rdstat_high_addr))
                RDSTAT_HIGH_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end

    // BLKERS Low Address Register(0x0028)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            BLKERS_LOW_ADDR  <= 24'h0;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_blkers_low_addr))
                BLKERS_LOW_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end
    // BLKERS High Address Register(0x002C)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            BLKERS_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_blkers_high_addr))
                BLKERS_HIGH_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end

    // PDREAD Low Address Register(0x0030)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PDREAD_LOW_ADDR  <= 24'h0;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_pdread_low_addr))
                PDREAD_LOW_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end
    // PDREAD High Address Register(0x0034)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PDREAD_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_pdread_high_addr))
                PDREAD_HIGH_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end

    // WRSTAT Low Address Register(0x0038)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            WRSTAT_LOW_ADDR  <= 24'h0;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_wrstat_low_addr))
                WRSTAT_LOW_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end
    // WRSTAT High Address Register(0x003C)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            WRSTAT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_wrstat_high_addr))
                WRSTAT_HIGH_ADDR  <= sr_reg_writedata_1d[23:0];
        end
    end

    // Page Address Select Register(0x0040)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            sr_page_addr_sel  <= 3'h0;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_write_1d & (sr_reg_address_1d == p_paddr_sel_addr))
                sr_page_addr_sel  <= sr_reg_writedata_1d[2:0];
        end
    end

    // REG_BEGINTRANSFER retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_begintransfer_1d  <= 1'b0;
        end
        else begin
            sr_reg_begintransfer_1d  <= REG_BEGINTRANSFER;
       end
    end

    // REG_CS retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_cs_1d  <= 1'b0;
        end
        else begin
            sr_reg_cs_1d  <= REG_CS;
       end
    end

    // REG_READ retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_read_1d  <= 1'b0;
        end
        else begin
            sr_reg_read_1d  <= REG_READ;
       end
    end

    // REG_WRITE retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_write_1d  <= 1'b0;
        end
        else begin
            sr_reg_write_1d  <= REG_WRITE;
       end
    end

    // REG_ADDRESS retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_address_1d  <= 16'b0;
        end
        else begin
            sr_reg_address_1d  <= REG_ADDRESS;
       end
    end

    // r_reg_readdata retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_readdata_1d  <= 32'b0;
        end
        else begin
            sr_reg_readdata_1d  <= r_reg_readdata;
       end
    end

    // REG_WRITE retiming (1d)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N) begin
            sr_reg_writedata_1d  <= 32'b0;
        end
        else begin
            sr_reg_writedata_1d  <= REG_WRITE;
       end
    end

    // Avalone READ DATA
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            r_reg_readdata <= 32'h0000_0000;
        else begin
            if (sr_reg_begintransfer_1d & sr_reg_cs_1d & sr_reg_read_1d) begin
//                case(REG_ADDRESS)
                case(sr_reg_address_1d)
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
                    sr_page_addr_sel        : r_reg_readdata <= {29'd0,sr_page_addr_sel};
                    p_paddr_0               : r_reg_readdata <= {8'd0,sr_paddr_dat[0]};
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
                    p_paddr_65              : r_reg_readdata <= {8'd0,sr_paddr_dat[65]};
                    p_paddr_66              : r_reg_readdata <= {8'd0,sr_paddr_dat[66]};
                    p_paddr_67              : r_reg_readdata <= {8'd0,sr_paddr_dat[67]};
                    p_paddr_68              : r_reg_readdata <= {8'd0,sr_paddr_dat[68]};
                    p_paddr_69              : r_reg_readdata <= {8'd0,sr_paddr_dat[69]};
                    p_paddr_70              : r_reg_readdata <= {8'd0,sr_paddr_dat[70]};
                    p_paddr_71              : r_reg_readdata <= {8'd0,sr_paddr_dat[71]};
                    p_paddr_72              : r_reg_readdata <= {8'd0,sr_paddr_dat[72]};
                    p_paddr_73              : r_reg_readdata <= {8'd0,sr_paddr_dat[73]};
                    p_paddr_74              : r_reg_readdata <= {8'd0,sr_paddr_dat[74]};
                    p_paddr_75              : r_reg_readdata <= {8'd0,sr_paddr_dat[75]};
                    p_paddr_76              : r_reg_readdata <= {8'd0,sr_paddr_dat[76]};
                    p_paddr_77              : r_reg_readdata <= {8'd0,sr_paddr_dat[77]};
                    p_paddr_78              : r_reg_readdata <= {8'd0,sr_paddr_dat[78]};
                    p_paddr_79              : r_reg_readdata <= {8'd0,sr_paddr_dat[79]};
                    p_paddr_80              : r_reg_readdata <= {8'd0,sr_paddr_dat[80]};
                    p_paddr_81              : r_reg_readdata <= {8'd0,sr_paddr_dat[81]};
                    p_paddr_82              : r_reg_readdata <= {8'd0,sr_paddr_dat[82]};
                    p_paddr_83              : r_reg_readdata <= {8'd0,sr_paddr_dat[83]};
                    p_paddr_84              : r_reg_readdata <= {8'd0,sr_paddr_dat[84]};
                    p_paddr_85              : r_reg_readdata <= {8'd0,sr_paddr_dat[85]};
                    p_paddr_86              : r_reg_readdata <= {8'd0,sr_paddr_dat[86]};
                    p_paddr_87              : r_reg_readdata <= {8'd0,sr_paddr_dat[87]};
                    p_paddr_88              : r_reg_readdata <= {8'd0,sr_paddr_dat[88]};
                    p_paddr_89              : r_reg_readdata <= {8'd0,sr_paddr_dat[89]};
                    p_paddr_90              : r_reg_readdata <= {8'd0,sr_paddr_dat[90]};
                    p_paddr_91              : r_reg_readdata <= {8'd0,sr_paddr_dat[91]};
                    p_paddr_92              : r_reg_readdata <= {8'd0,sr_paddr_dat[92]};
                    p_paddr_93              : r_reg_readdata <= {8'd0,sr_paddr_dat[93]};
                    p_paddr_94              : r_reg_readdata <= {8'd0,sr_paddr_dat[94]};
                    p_paddr_95              : r_reg_readdata <= {8'd0,sr_paddr_dat[95]};
                    p_paddr_96              : r_reg_readdata <= {8'd0,sr_paddr_dat[96]};
                    p_paddr_97              : r_reg_readdata <= {8'd0,sr_paddr_dat[97]};
                    p_paddr_98              : r_reg_readdata <= {8'd0,sr_paddr_dat[98]};
                    p_paddr_99              : r_reg_readdata <= {8'd0,sr_paddr_dat[99]};
                    p_paddr_100             : r_reg_readdata <= {8'd0,sr_paddr_dat[100]};
                    p_paddr_101             : r_reg_readdata <= {8'd0,sr_paddr_dat[101]};
                    p_paddr_102             : r_reg_readdata <= {8'd0,sr_paddr_dat[102]};
                    p_paddr_103             : r_reg_readdata <= {8'd0,sr_paddr_dat[103]};
                    p_paddr_104             : r_reg_readdata <= {8'd0,sr_paddr_dat[104]};
                    p_paddr_105             : r_reg_readdata <= {8'd0,sr_paddr_dat[105]};
                    p_paddr_106             : r_reg_readdata <= {8'd0,sr_paddr_dat[106]};
                    p_paddr_107             : r_reg_readdata <= {8'd0,sr_paddr_dat[107]};
                    p_paddr_108             : r_reg_readdata <= {8'd0,sr_paddr_dat[108]};
                    p_paddr_109             : r_reg_readdata <= {8'd0,sr_paddr_dat[109]};
                    p_paddr_110             : r_reg_readdata <= {8'd0,sr_paddr_dat[110]};
                    p_paddr_111             : r_reg_readdata <= {8'd0,sr_paddr_dat[111]};
                    p_paddr_112             : r_reg_readdata <= {8'd0,sr_paddr_dat[112]};
                    p_paddr_113             : r_reg_readdata <= {8'd0,sr_paddr_dat[113]};
                    p_paddr_114             : r_reg_readdata <= {8'd0,sr_paddr_dat[114]};
                    p_paddr_115             : r_reg_readdata <= {8'd0,sr_paddr_dat[115]};
                    p_paddr_116             : r_reg_readdata <= {8'd0,sr_paddr_dat[116]};
                    p_paddr_117             : r_reg_readdata <= {8'd0,sr_paddr_dat[117]};
                    p_paddr_118             : r_reg_readdata <= {8'd0,sr_paddr_dat[118]};
                    p_paddr_119             : r_reg_readdata <= {8'd0,sr_paddr_dat[119]};
                    p_paddr_120             : r_reg_readdata <= {8'd0,sr_paddr_dat[120]};
                    p_paddr_121             : r_reg_readdata <= {8'd0,sr_paddr_dat[121]};
                    p_paddr_122             : r_reg_readdata <= {8'd0,sr_paddr_dat[122]};
                    p_paddr_123             : r_reg_readdata <= {8'd0,sr_paddr_dat[123]};
                    p_paddr_124             : r_reg_readdata <= {8'd0,sr_paddr_dat[124]};
                    p_paddr_125             : r_reg_readdata <= {8'd0,sr_paddr_dat[125]};
                    p_paddr_126             : r_reg_readdata <= {8'd0,sr_paddr_dat[126]};
                    p_paddr_127             : r_reg_readdata <= {8'd0,sr_paddr_dat[127]};
                    p_paddr_128             : r_reg_readdata <= {8'd0,sr_paddr_dat[128]};
                    p_paddr_129             : r_reg_readdata <= {8'd0,sr_paddr_dat[129]};
                    p_paddr_130             : r_reg_readdata <= {8'd0,sr_paddr_dat[130]};
                    p_paddr_131             : r_reg_readdata <= {8'd0,sr_paddr_dat[131]};
                    p_paddr_132             : r_reg_readdata <= {8'd0,sr_paddr_dat[132]};
                    p_paddr_133             : r_reg_readdata <= {8'd0,sr_paddr_dat[133]};
                    p_paddr_134             : r_reg_readdata <= {8'd0,sr_paddr_dat[134]};
                    p_paddr_135             : r_reg_readdata <= {8'd0,sr_paddr_dat[135]};
                    p_paddr_136             : r_reg_readdata <= {8'd0,sr_paddr_dat[136]};
                    p_paddr_137             : r_reg_readdata <= {8'd0,sr_paddr_dat[137]};
                    p_paddr_138             : r_reg_readdata <= {8'd0,sr_paddr_dat[138]};
                    p_paddr_139             : r_reg_readdata <= {8'd0,sr_paddr_dat[139]};
                    p_paddr_140             : r_reg_readdata <= {8'd0,sr_paddr_dat[140]};
                    p_paddr_141             : r_reg_readdata <= {8'd0,sr_paddr_dat[141]};
                    p_paddr_142             : r_reg_readdata <= {8'd0,sr_paddr_dat[142]};
                    p_paddr_143             : r_reg_readdata <= {8'd0,sr_paddr_dat[143]};
                    p_paddr_144             : r_reg_readdata <= {8'd0,sr_paddr_dat[144]};
                    p_paddr_145             : r_reg_readdata <= {8'd0,sr_paddr_dat[145]};
                    p_paddr_146             : r_reg_readdata <= {8'd0,sr_paddr_dat[146]};
                    p_paddr_147             : r_reg_readdata <= {8'd0,sr_paddr_dat[147]};
                    p_paddr_148             : r_reg_readdata <= {8'd0,sr_paddr_dat[148]};
                    p_paddr_149             : r_reg_readdata <= {8'd0,sr_paddr_dat[149]};
                    p_paddr_150             : r_reg_readdata <= {8'd0,sr_paddr_dat[150]};
                    p_paddr_151             : r_reg_readdata <= {8'd0,sr_paddr_dat[151]};
                    p_paddr_152             : r_reg_readdata <= {8'd0,sr_paddr_dat[152]};
                    p_paddr_153             : r_reg_readdata <= {8'd0,sr_paddr_dat[153]};
                    p_paddr_154             : r_reg_readdata <= {8'd0,sr_paddr_dat[154]};
                    p_paddr_155             : r_reg_readdata <= {8'd0,sr_paddr_dat[155]};
                    p_paddr_156             : r_reg_readdata <= {8'd0,sr_paddr_dat[156]};
                    p_paddr_157             : r_reg_readdata <= {8'd0,sr_paddr_dat[157]};
                    p_paddr_158             : r_reg_readdata <= {8'd0,sr_paddr_dat[158]};
                    p_paddr_159             : r_reg_readdata <= {8'd0,sr_paddr_dat[159]};
                    p_paddr_160             : r_reg_readdata <= {8'd0,sr_paddr_dat[160]};
                    p_paddr_161             : r_reg_readdata <= {8'd0,sr_paddr_dat[161]};
                    p_paddr_162             : r_reg_readdata <= {8'd0,sr_paddr_dat[162]};
                    p_paddr_163             : r_reg_readdata <= {8'd0,sr_paddr_dat[163]};
                    p_paddr_164             : r_reg_readdata <= {8'd0,sr_paddr_dat[164]};
                    p_paddr_165             : r_reg_readdata <= {8'd0,sr_paddr_dat[165]};
                    p_paddr_166             : r_reg_readdata <= {8'd0,sr_paddr_dat[166]};
                    p_paddr_167             : r_reg_readdata <= {8'd0,sr_paddr_dat[167]};
                    p_paddr_168             : r_reg_readdata <= {8'd0,sr_paddr_dat[168]};
                    p_paddr_169             : r_reg_readdata <= {8'd0,sr_paddr_dat[169]};
                    p_paddr_170             : r_reg_readdata <= {8'd0,sr_paddr_dat[170]};
                    p_paddr_171             : r_reg_readdata <= {8'd0,sr_paddr_dat[171]};
                    p_paddr_172             : r_reg_readdata <= {8'd0,sr_paddr_dat[172]};
                    p_paddr_173             : r_reg_readdata <= {8'd0,sr_paddr_dat[173]};
                    p_paddr_174             : r_reg_readdata <= {8'd0,sr_paddr_dat[174]};
                    p_paddr_175             : r_reg_readdata <= {8'd0,sr_paddr_dat[175]};
                    p_paddr_176             : r_reg_readdata <= {8'd0,sr_paddr_dat[176]};
                    p_paddr_177             : r_reg_readdata <= {8'd0,sr_paddr_dat[177]};
                    p_paddr_178             : r_reg_readdata <= {8'd0,sr_paddr_dat[178]};
                    p_paddr_179             : r_reg_readdata <= {8'd0,sr_paddr_dat[179]};
                    p_paddr_180             : r_reg_readdata <= {8'd0,sr_paddr_dat[180]};
                    p_paddr_181             : r_reg_readdata <= {8'd0,sr_paddr_dat[181]};
                    p_paddr_182             : r_reg_readdata <= {8'd0,sr_paddr_dat[182]};
                    p_paddr_183             : r_reg_readdata <= {8'd0,sr_paddr_dat[183]};
                    p_paddr_184             : r_reg_readdata <= {8'd0,sr_paddr_dat[184]};
                    p_paddr_185             : r_reg_readdata <= {8'd0,sr_paddr_dat[185]};
                    p_paddr_186             : r_reg_readdata <= {8'd0,sr_paddr_dat[186]};
                    p_paddr_187             : r_reg_readdata <= {8'd0,sr_paddr_dat[187]};
                    p_paddr_188             : r_reg_readdata <= {8'd0,sr_paddr_dat[188]};
                    p_paddr_189             : r_reg_readdata <= {8'd0,sr_paddr_dat[189]};
                    p_paddr_190             : r_reg_readdata <= {8'd0,sr_paddr_dat[190]};
                    p_paddr_191             : r_reg_readdata <= {8'd0,sr_paddr_dat[191]};
                    p_paddr_192             : r_reg_readdata <= {8'd0,sr_paddr_dat[192]};
                    p_paddr_193             : r_reg_readdata <= {8'd0,sr_paddr_dat[193]};
                    p_paddr_194             : r_reg_readdata <= {8'd0,sr_paddr_dat[194]};
                    p_paddr_195             : r_reg_readdata <= {8'd0,sr_paddr_dat[195]};
                    p_paddr_196             : r_reg_readdata <= {8'd0,sr_paddr_dat[196]};
                    p_paddr_197             : r_reg_readdata <= {8'd0,sr_paddr_dat[197]};
                    p_paddr_198             : r_reg_readdata <= {8'd0,sr_paddr_dat[198]};
                    p_paddr_199             : r_reg_readdata <= {8'd0,sr_paddr_dat[199]};
                    p_paddr_200             : r_reg_readdata <= {8'd0,sr_paddr_dat[200]};
                    p_paddr_201             : r_reg_readdata <= {8'd0,sr_paddr_dat[201]};
                    p_paddr_202             : r_reg_readdata <= {8'd0,sr_paddr_dat[202]};
                    p_paddr_203             : r_reg_readdata <= {8'd0,sr_paddr_dat[203]};
                    p_paddr_204             : r_reg_readdata <= {8'd0,sr_paddr_dat[204]};
                    p_paddr_205             : r_reg_readdata <= {8'd0,sr_paddr_dat[205]};
                    p_paddr_206             : r_reg_readdata <= {8'd0,sr_paddr_dat[206]};
                    p_paddr_207             : r_reg_readdata <= {8'd0,sr_paddr_dat[207]};
                    p_paddr_208             : r_reg_readdata <= {8'd0,sr_paddr_dat[208]};
                    p_paddr_209             : r_reg_readdata <= {8'd0,sr_paddr_dat[209]};
                    p_paddr_210             : r_reg_readdata <= {8'd0,sr_paddr_dat[210]};
                    p_paddr_211             : r_reg_readdata <= {8'd0,sr_paddr_dat[211]};
                    p_paddr_212             : r_reg_readdata <= {8'd0,sr_paddr_dat[212]};
                    p_paddr_213             : r_reg_readdata <= {8'd0,sr_paddr_dat[213]};
                    p_paddr_214             : r_reg_readdata <= {8'd0,sr_paddr_dat[214]};
                    p_paddr_215             : r_reg_readdata <= {8'd0,sr_paddr_dat[215]};
                    p_paddr_216             : r_reg_readdata <= {8'd0,sr_paddr_dat[216]};
                    p_paddr_217             : r_reg_readdata <= {8'd0,sr_paddr_dat[217]};
                    p_paddr_218             : r_reg_readdata <= {8'd0,sr_paddr_dat[218]};
                    p_paddr_219             : r_reg_readdata <= {8'd0,sr_paddr_dat[219]};
                    p_paddr_220             : r_reg_readdata <= {8'd0,sr_paddr_dat[220]};
                    p_paddr_221             : r_reg_readdata <= {8'd0,sr_paddr_dat[221]};
                    p_paddr_222             : r_reg_readdata <= {8'd0,sr_paddr_dat[222]};
                    p_paddr_223             : r_reg_readdata <= {8'd0,sr_paddr_dat[223]};
                    p_paddr_224             : r_reg_readdata <= {8'd0,sr_paddr_dat[224]};
                    p_paddr_225             : r_reg_readdata <= {8'd0,sr_paddr_dat[225]};
                    p_paddr_226             : r_reg_readdata <= {8'd0,sr_paddr_dat[226]};
                    p_paddr_227             : r_reg_readdata <= {8'd0,sr_paddr_dat[227]};
                    p_paddr_228             : r_reg_readdata <= {8'd0,sr_paddr_dat[228]};
                    p_paddr_229             : r_reg_readdata <= {8'd0,sr_paddr_dat[229]};
                    p_paddr_230             : r_reg_readdata <= {8'd0,sr_paddr_dat[230]};
                    p_paddr_231             : r_reg_readdata <= {8'd0,sr_paddr_dat[231]};
                    p_paddr_232             : r_reg_readdata <= {8'd0,sr_paddr_dat[232]};
                    p_paddr_233             : r_reg_readdata <= {8'd0,sr_paddr_dat[233]};
                    p_paddr_234             : r_reg_readdata <= {8'd0,sr_paddr_dat[234]};
                    p_paddr_235             : r_reg_readdata <= {8'd0,sr_paddr_dat[235]};
                    p_paddr_236             : r_reg_readdata <= {8'd0,sr_paddr_dat[236]};
                    p_paddr_237             : r_reg_readdata <= {8'd0,sr_paddr_dat[237]};
                    p_paddr_238             : r_reg_readdata <= {8'd0,sr_paddr_dat[238]};
                    p_paddr_239             : r_reg_readdata <= {8'd0,sr_paddr_dat[239]};
                    p_paddr_240             : r_reg_readdata <= {8'd0,sr_paddr_dat[240]};
                    p_paddr_241             : r_reg_readdata <= {8'd0,sr_paddr_dat[241]};
                    p_paddr_242             : r_reg_readdata <= {8'd0,sr_paddr_dat[242]};
                    p_paddr_243             : r_reg_readdata <= {8'd0,sr_paddr_dat[243]};
                    p_paddr_244             : r_reg_readdata <= {8'd0,sr_paddr_dat[244]};
                    p_paddr_245             : r_reg_readdata <= {8'd0,sr_paddr_dat[245]};
                    p_paddr_246             : r_reg_readdata <= {8'd0,sr_paddr_dat[246]};
                    p_paddr_247             : r_reg_readdata <= {8'd0,sr_paddr_dat[247]};
                    p_paddr_248             : r_reg_readdata <= {8'd0,sr_paddr_dat[248]};
                    p_paddr_249             : r_reg_readdata <= {8'd0,sr_paddr_dat[249]};
                    p_paddr_250             : r_reg_readdata <= {8'd0,sr_paddr_dat[250]};
                    p_paddr_251             : r_reg_readdata <= {8'd0,sr_paddr_dat[251]};
                    p_paddr_252             : r_reg_readdata <= {8'd0,sr_paddr_dat[252]};
                    p_paddr_253             : r_reg_readdata <= {8'd0,sr_paddr_dat[253]};
                    p_paddr_254             : r_reg_readdata <= {8'd0,sr_paddr_dat[254]};
                    p_paddr_255             : r_reg_readdata <= {8'd0,sr_paddr_dat[255]};
                    default                 : r_reg_readdata <= 32'h0000_0000;
                endcase
            end
        end
    end
endmodule

