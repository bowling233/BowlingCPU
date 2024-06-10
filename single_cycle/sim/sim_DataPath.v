`timescale 1ns / 1ps
`default_nettype none
module sim_DataPath();
    
    reg clk;
    reg rst;
    reg ALUSrc_B;
    reg [3:0] ALU_Control;
    reg Branch;
    reg [1:0] Jump;
    reg RegWrite;
    reg MemRead;
    reg MemWrite;
    reg [1:0] MemtoReg;
    reg interrupt;
    reg ecall;
    reg ill_inst;
    reg mret;
    reg [31:0] inst_field;
    reg [31:0] Data_in;
    wire [31:0] ALU_out;
    wire [31:0] Data_out;
    wire [31:0] PC_out;
    
    wire [8:0] peek = {
    myDataPath.Branch,
    myDataPath.ALU_Zero,
    myDataPath.Jump,
    myDataPath.mtvec[0],
    myDataPath.interrupt,
    myDataPath.ecall,
    myDataPath.ill_inst,
    myDataPath.mret
    };
    
    wire [159:0] SPEC = {
    myDataPath.mtvec,
    myDataPath.mcause,
    myDataPath.mepc,
    myDataPath.mstatus,
    myDataPath.mtval
    };
    
    wire [6:0] Imm = myDataPath.Imm_out;
    
    wire [31:0] x0  = myDataPath.Regs_1.register[0];
    wire [31:0] x1  = myDataPath.Regs_1.register[1];
    wire [31:0] x2  = myDataPath.Regs_1.register[2];
    wire [31:0] x3  = myDataPath.Regs_1.register[3];
    wire [31:0] x4  = myDataPath.Regs_1.register[4];
    wire [31:0] x5  = myDataPath.Regs_1.register[5];
    wire [31:0] x6  = myDataPath.Regs_1.register[6];
    wire [31:0] x7  = myDataPath.Regs_1.register[7];
    wire [31:0] x8  = myDataPath.Regs_1.register[8];
    wire [31:0] x9  = myDataPath.Regs_1.register[9];
    wire [31:0] x10 = myDataPath.Regs_1.register[10];
    wire [31:0] x11 = myDataPath.Regs_1.register[11];
    wire [31:0] x12 = myDataPath.Regs_1.register[12];
    wire [31:0] x13 = myDataPath.Regs_1.register[13];
    wire [31:0] x14 = myDataPath.Regs_1.register[14];
    wire [31:0] x15 = myDataPath.Regs_1.register[15];
    wire [31:0] x16 = myDataPath.Regs_1.register[16];
    wire [31:0] x17 = myDataPath.Regs_1.register[17];
    wire [31:0] x18 = myDataPath.Regs_1.register[18];
    wire [31:0] x19 = myDataPath.Regs_1.register[19];
    wire [31:0] x20 = myDataPath.Regs_1.register[20];
    wire [31:0] x21 = myDataPath.Regs_1.register[21];
    wire [31:0] x22 = myDataPath.Regs_1.register[22];
    wire [31:0] x23 = myDataPath.Regs_1.register[23];
    wire [31:0] x24 = myDataPath.Regs_1.register[24];
    wire [31:0] x25 = myDataPath.Regs_1.register[25];
    wire [31:0] x26 = myDataPath.Regs_1.register[26];
    wire [31:0] x27 = myDataPath.Regs_1.register[27];
    wire [31:0] x28 = myDataPath.Regs_1.register[28];
    wire [31:0] x29 = myDataPath.Regs_1.register[29];
    wire [31:0] x30 = myDataPath.Regs_1.register[30];
    wire [31:0] x31 = myDataPath.Regs_1.register[31];
    
    DataPath myDataPath(
    .clk(clk),
    .rst(rst),
    .ALUSrc_B(ALUSrc_B),
    .ALU_Control(ALU_Control),
    .Branch(Branch),
    .Jump(Jump),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .MemtoReg(MemtoReg),
    .interrupt(interrupt),
    .ecall(ecall),
    .ill_inst(ill_inst),
    .mret(mret),
    .inst_field(inst_field),
    .Data_in(Data_in),
    .ALU_out(ALU_out),
    .Data_out(Data_out),
    .PC_out(PC_out)
    );
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        rst = 1;
        // all signals
        ALUSrc_B    = 0;
        ALU_Control = 4'b0000;
        Branch      = 0;
        Jump        = 2'b00;
        RegWrite    = 0;
        MemRead     = 0;
        MemWrite    = 0;
        MemtoReg    = 2'b00;
        interrupt   = 0;
        ecall       = 0;
        ill_inst    = 0;
        mret        = 0;
        inst_field  = 32'h00000000;
        Data_in     = 32'h00000000;
        
        #10 rst = 0;
        
        // test ALU add
        // addi x0, x0, 5
        inst_field  = 32'h00500013;
        ALUSrc_B    = 1;
        ALU_Control = 3'b010;
        #10;
        // test register file write
        // addi x1, x0, 1
        inst_field = 32'h00100093;
        Data_in    = 32'h00000001;
        MemtoReg   = 2'b01;
        RegWrite   = 1;
        #10;
        RegWrite = 0;
        Data_in  = 32'h00000000;
        // test register file read
        // addi x1, x1, 0
        inst_field  = 32'h00008093;
        ALUSrc_B    = 1;
        ALU_Control = 3'b010;
        #10;
        $finish;
    end
    
endmodule
