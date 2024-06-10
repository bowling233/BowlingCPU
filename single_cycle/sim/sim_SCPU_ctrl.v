`timescale 1ns / 1ps
`default_nettype none

module sim_SCPU_ctrl2();
    
    // Inputs
    reg [6:0] OPcode;
    reg [2:0] Fun3;
    reg [11:0] Fun12;
    reg [31:0] inst;
    
    // Outputs
    wire ALUSrc_B;
    wire [1:0] MemtoReg;
    wire [1:0] Jump;
    wire Branch;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire [2:0] ALU_Control;
    wire ill_inst, mret, ecall;
    
    // Instantiate the CPU control unit module
    SCPU_ctrl uut(
    .OPcode(OPcode),
    .Fun3(Fun3),
    .Fun12(Fun12),
    .ALUSrc_B(ALUSrc_B),
    .MemtoReg(MemtoReg),
    .Jump(Jump),
    .Branch(Branch),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALU_Control(ALU_Control),
    .ill_inst(ill_inst),
    .mret(mret),
    .ecall(ecall)
    );
    
    always @(inst) begin
        OPcode <= inst[6:0];
        Fun3   <= inst[14:12];
        Fun12  <= inst[31:20];
    end
    
    initial begin
        // addi x1, x0, 1
        inst = 32'h00100093;
        #10;
        // jalr x0, 0(x0)
        inst = 32'h00000067;
        #10;
        // sw
        inst = 32'h00002023;
        #10;
        // lw
        inst = 32'h00002003;
        #10;
        // beq
        inst = 32'h00000063;
        #10;
        // mret
        inst = 32'h30200073;
        #10;
        // ecall
        inst = 32'h00000073;
        #10;
        // illegal instruction
        inst = 32'h00000000;
        #10;
        $finish;
    end
    
endmodule
