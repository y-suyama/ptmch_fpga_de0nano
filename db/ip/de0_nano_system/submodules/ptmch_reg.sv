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

//=======================================================
//  Internal Signal
//=======================================================
    logic             w_reg_waitrequest;
    logic    [31: 0]  r_reg_readdata;
//=======================================================
//  output Port
//=======================================================
    assign   REG_READDATA    = r_reg_readdata;
    assign   REG_WAITREQUEST = REG_BEGINTRANSFER & REG_CS;
//=======================================================
//  Structural coding
//=======================================================
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

    // BLKERS Low Address Register(0x0020)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            BLKERS_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_blkers_low_addr))
                BLKERS_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // BLKERS High Address Register(0x0024)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            BLKERS_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_blkers_high_addr))
                BLKERS_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // PDREAD Low Address Register(0x0020)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PDREAD_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_pdread_low_addr))
                PDREAD_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // PDREAD High Address Register(0x0024)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            PDREAD_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_pdread_high_addr))
                PDREAD_HIGH_ADDR  <= REG_WRITEDATA[23:0];
        end
    end

    // WRSTAT Low Address Register(0x0020)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            WRSTAT_LOW_ADDR  <= 24'h0;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_wrstat_low_addr))
                WRSTAT_LOW_ADDR  <= REG_WRITEDATA[23:0];
        end
    end
    // WRSTAT High Address Register(0x0024)
    always_ff @(posedge CLK100M or negedge RESET_N) begin
        if(!RESET_N)
            WRSTAT_HIGH_ADDR  <= 24'hFFFFFF;
        else begin
            if (REG_BEGINTRANSFER & REG_CS & REG_WRITE & (REG_ADDRESS == p_wrstat_high_addr))
                WRSTAT_HIGH_ADDR  <= REG_WRITEDATA[23:0];
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
                    default                 : r_reg_readdata <= 32'h0000_0000;
                endcase
            end
        end
    end
endmodule

