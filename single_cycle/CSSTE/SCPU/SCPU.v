`timescale 1ns / 1ps
module SCPU(input wire MIO_ready,
            input wire [31:0] Data_in,
            input wire clk,
            input wire [31:0] inst_in,
            input wire rst,
            output wire MemRW,
            output wire CPU_MIO,
            output wire [31:0] Addr_out,
            output wire [31:0] Data_out,
            output wire [31:0] PC_out);
    
    wire [3:0] ALU_Control;
    wire ALUSrc_B;
    wire [1:0] Branch;
    wire [1:0] Jump;
    wire [1:0] MemtoReg;
    wire [31:0] ALU_out;
    wire MemRead, MemWrite, RegWrite,
    ill_inst, mret, ecall;
    assign MemRW = MemWrite;
    
    SCPU_ctrl Controller(
    .OPcode(inst_in[6:0]),
    .Fun3(inst_in[14:12]),
    .Fun12(inst_in[31:20]),
    .ALU_Control(ALU_Control),
    .ALUSrc_B(ALUSrc_B),
    .Branch(Branch),
    .Jump(Jump),
    //.CPU_MIO(CPU_MIO),
    //.MIO_ready(MIO_ready),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .ill_inst(ill_inst),
    .mret(mret),
    .ecall(ecall)
    );
    
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
    .interrupt(1'b0),
    .ecall(ecall),
    .ill_inst(ill_inst),
    .mret(mret),
    .inst_field(inst_in),
    .Data_in(Data_in),
    .ALU_out(Addr_out),
    .Data_out(Data_out),
    .PC_out(PC_out)
    );
endmodule
