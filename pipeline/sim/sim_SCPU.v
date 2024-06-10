`timescale 1ns / 1ps
module sim_SCPU();
    
    reg clk_100mhz;
    reg RSTN;

    // WB
    wire [1:0] MemtoReg_in_WB = myCPU.wb.MemtoReg_in_WB;
    wire [31:0] PC4_in_WB = myCPU.wb.PC4_in_WB;
    wire [31:0] ALU_in_WB = myCPU.wb.ALU_in_WB;
    wire [31:0] DMem_data_WB = myCPU.wb.DMem_data_WB;
    wire [31:0] Data_out_WB = myCPU.wb.Data_out_WB;

    // register
    wire RegWrite = myCPU.id.myRegs.RegWrite;
    wire [4:0] Rd_addr = myCPU.id.myRegs.Wt_addr;
    wire [31:0] Rd_data = myCPU.id.myRegs.Wt_data;
    wire [31:0] x1  = myCPU.id.myRegs.register[1];
    wire [31:0] x2  = myCPU.id.myRegs.register[2];
    wire [31:0] x3  = myCPU.id.myRegs.register[3];
    wire [31:0] x4  = myCPU.id.myRegs.register[4];
    wire [31:0] x5  = myCPU.id.myRegs.register[5];
    wire [31:0] x6  = myCPU.id.myRegs.register[6];
    wire [31:0] x7  = myCPU.id.myRegs.register[7];
    wire [31:0] x8  = myCPU.id.myRegs.register[8];
    wire [31:0] x9  = myCPU.id.myRegs.register[9];
    wire [31:0] x10 = myCPU.id.myRegs.register[10];
    wire [31:0] x11 = myCPU.id.myRegs.register[11];
    wire [31:0] x12 = myCPU.id.myRegs.register[12];
    wire [31:0] x13 = myCPU.id.myRegs.register[13];
    wire [31:0] x14 = myCPU.id.myRegs.register[14];
    wire [31:0] x15 = myCPU.id.myRegs.register[15];
    wire [31:0] x16 = myCPU.id.myRegs.register[16];
    wire [31:0] x17 = myCPU.id.myRegs.register[17];
    wire [31:0] x18 = myCPU.id.myRegs.register[18];
    wire [31:0] x19 = myCPU.id.myRegs.register[19];
    wire [31:0] x20 = myCPU.id.myRegs.register[20];
    wire [31:0] x21 = myCPU.id.myRegs.register[21];
    wire [31:0] x22 = myCPU.id.myRegs.register[22];
    wire [31:0] x23 = myCPU.id.myRegs.register[23];
    wire [31:0] x24 = myCPU.id.myRegs.register[24];
    wire [31:0] x25 = myCPU.id.myRegs.register[25];
    wire [31:0] x26 = myCPU.id.myRegs.register[26];
    wire [31:0] x27 = myCPU.id.myRegs.register[27];
    wire [31:0] x28 = myCPU.id.myRegs.register[28];
    wire [31:0] x29 = myCPU.id.myRegs.register[29];
    wire [31:0] x30 = myCPU.id.myRegs.register[30];
    wire [31:0] x31 = myCPU.id.myRegs.register[31];
    
    wire [31:0] Data_in;
    wire [31:0] inst_in;
    wire [31:0] PC_out_IF;
    wire [31:0] PC_out_ID;
    wire [31:0] inst_ID;
    wire [31:0] PC_out_EX;
    wire MemRW_EX;
    wire MemRW_Mem;
    wire [31:0] Data_out;
    wire [31:0] Addr_out;
    wire [31:0] Data_out_WB;
    
    ROM_D U2
    (
    .a(PC_out_IF[11:2]),
    .spo(inst_in)
    );
    
    // RAM
    blk_mem_gen_0 U3
    (
    .addra(Addr_out[31:2]),
    .clka(clk_100mhz),
    .dina(Data_out),
    .douta(Data_in),
    .wea(MemRW_Mem)
    );

    SCPU myCPU(
        .Data_in(Data_in),
        .clk(clk_100mhz),
        .inst_in(inst_in),
        .rst(~RSTN),
        .PC_out_IF(PC_out_IF),
        .PC_out_ID(PC_out_ID),
        .inst_ID(inst_ID),
        .PC_out_EX(PC_out_EX),
        .MemRW_EX(MemRW_EX),
        .MemRW_Mem(MemRW_Mem),
        .Data_out(Data_out),
        .Addr_out(Addr_out),
        .Data_out_WB(Data_out_WB)
        );
    
    always begin
        #5 clk_100mhz = ~clk_100mhz;
    end
    
    initial begin
        clk_100mhz = 1;
        RSTN       = 0;
        #5 RSTN    = 1;
        
    end


endmodule
