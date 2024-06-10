`timescale 1ns / 1ps
module sim_SCPU();
    
    reg clk_100mhz;
    reg RSTN;
    
    wire [31:0] PC_out;
    wire [31:0] Inst_in;
    wire [31:0] Addr_out;
    wire [31:0] Data_out;
    wire [31:0] Data_in;
    wire MemRW;
    
    wire [16:0] CONTROL = {
    myCPU.Controller.ALU_Control, // 13, 14, 15, 16
    myCPU.Controller.ALUSrc_B, // 12
    myCPU.Controller.Branch, // 10, 11
    myCPU.Controller.Jump, // 8,9
    myCPU.Controller.MemRead, // 7
    myCPU.Controller.MemtoReg, // 5,6
    myCPU.Controller.MemWrite, // 4
    myCPU.Controller.RegWrite, // 3
    myCPU.Controller.ill_inst, // 2
    myCPU.Controller.mret, // 1
    myCPU.Controller.ecall // 0
    };
    
    wire [21:0] CODE = {
    Inst_in[6:0],
    Inst_in[14:12],
    Inst_in[31:20]
    };
    
    wire [9:0] PC_CONTROL = {
    myCPU.myDataPath.Branch,
    myCPU.myDataPath.ALU_Zero,
    myCPU.myDataPath.Jump,
    myCPU.myDataPath.mtvec[0],
    myCPU.myDataPath.interrupt,
    myCPU.myDataPath.ecall,
    myCPU.myDataPath.ill_inst,
    myCPU.myDataPath.mret
    };
    
    wire [31:0] Imm        = myCPU.myDataPath.Imm_out;
    wire [31:0] ALU        = myCPU.myDataPath.ALU_out;
    wire [3:0] ALU_Control = myCPU.myDataPath.ALU_Control;
    
    // Exception
    wire [31:0] mtvec   = myCPU.myDataPath.mtvec;
    wire [31:0] mcause  = myCPU.myDataPath.mcause;
    wire [31:0] mepc    = myCPU.myDataPath.mepc;
    wire [31:0] mstatus = myCPU.myDataPath.mstatus;
    wire [31:0] mtval   = myCPU.myDataPath.mtval;
    // register
    wire [31:0] x1  = myCPU.myDataPath.Regs_1.register[1];
    wire [31:0] x2  = myCPU.myDataPath.Regs_1.register[2];
    wire [31:0] x3  = myCPU.myDataPath.Regs_1.register[3];
    wire [31:0] x4  = myCPU.myDataPath.Regs_1.register[4];
    wire [31:0] x5  = myCPU.myDataPath.Regs_1.register[5];
    wire [31:0] x6  = myCPU.myDataPath.Regs_1.register[6];
    wire [31:0] x7  = myCPU.myDataPath.Regs_1.register[7];
    wire [31:0] x8  = myCPU.myDataPath.Regs_1.register[8];
    wire [31:0] x9  = myCPU.myDataPath.Regs_1.register[9];
    wire [31:0] x10 = myCPU.myDataPath.Regs_1.register[10];
    wire [31:0] x11 = myCPU.myDataPath.Regs_1.register[11];
    wire [31:0] x12 = myCPU.myDataPath.Regs_1.register[12];
    wire [31:0] x13 = myCPU.myDataPath.Regs_1.register[13];
    wire [31:0] x14 = myCPU.myDataPath.Regs_1.register[14];
    wire [31:0] x15 = myCPU.myDataPath.Regs_1.register[15];
    wire [31:0] x16 = myCPU.myDataPath.Regs_1.register[16];
    wire [31:0] x17 = myCPU.myDataPath.Regs_1.register[17];
    wire [31:0] x18 = myCPU.myDataPath.Regs_1.register[18];
    wire [31:0] x19 = myCPU.myDataPath.Regs_1.register[19];
    wire [31:0] x20 = myCPU.myDataPath.Regs_1.register[20];
    wire [31:0] x21 = myCPU.myDataPath.Regs_1.register[21];
    wire [31:0] x22 = myCPU.myDataPath.Regs_1.register[22];
    wire [31:0] x23 = myCPU.myDataPath.Regs_1.register[23];
    wire [31:0] x24 = myCPU.myDataPath.Regs_1.register[24];
    wire [31:0] x25 = myCPU.myDataPath.Regs_1.register[25];
    wire [31:0] x26 = myCPU.myDataPath.Regs_1.register[26];
    wire [31:0] x27 = myCPU.myDataPath.Regs_1.register[27];
    wire [31:0] x28 = myCPU.myDataPath.Regs_1.register[28];
    wire [31:0] x29 = myCPU.myDataPath.Regs_1.register[29];
    wire [31:0] x30 = myCPU.myDataPath.Regs_1.register[30];
    wire [31:0] x31 = myCPU.myDataPath.Regs_1.register[31];
    
    
    ROM_D U2
    (
    .a(PC_out[11:2]),
    .spo(Inst_in)
    );
    
    // RAM
    blk_mem_gen_0 U3
    (
    .addra(Addr_out[31:2]),
    .clka(~clk_100mhz),
    .dina(Data_out),
    .douta(Data_in),
    .wea(MemRW)
    );
    
    SCPU myCPU(
    .MIO_ready(1'b0),
    .Data_in(Data_in),
    .clk(clk_100mhz),
    .inst_in(Inst_in),
    .rst(~RSTN),
    .MemRW(MemRW),
    .CPU_MIO(),
    .Addr_out(Addr_out),
    .Data_out(Data_out),
    .PC_out(PC_out)
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
