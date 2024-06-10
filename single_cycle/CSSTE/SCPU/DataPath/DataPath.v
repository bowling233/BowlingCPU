`timescale 1ns / 1ps
`default_nettype none
`define PC_CONTROL {Branch, ALU_Zero, Jump}
`define EXCEPT {mtvec[0], interrupt, ecall, ill_inst, mret}
`define SPEC {mtvec, mcause, mepc, mstatus, mtval}

module DataPath(input wire clk,
                input wire rst,
                input wire ALUSrc_B,
                input wire [3:0] ALU_Control,
                input wire [1:0] Branch,
                input wire [1:0] Jump,
                input wire RegWrite,
                input wire MemRead,
                input wire MemWrite,
                input wire [1:0] MemtoReg,
                input wire interrupt,
                input wire ecall,
                input wire ill_inst,
                input wire mret,
                input wire [31:0] inst_field,
                input wire [31:0] Data_in,
                output wire [31:0] ALU_out,
                output wire [31:0] Data_out,
                output reg [31:0] PC_out);
    
    wire [31:0] Imm_out;
    wire [31:0] MUX4T1_32_1_o;
    wire [31:0] Rs1_data;
    wire ALU_Zero;
    
    reg [31:0] mtvec;
    reg [31:0] mcause;
    reg [31:0] mepc;
    reg [31:0] mstatus;
    reg [31:0] mtval;
    reg [31:0] Wt_data;
    
    always @(posedge clk or posedge rst) begin
        
        // PC need to be updated first, so use blocking assignment
        casez(`PC_CONTROL)
            5'b0??00,
            5'b11000,
            5'b10100: PC_out = PC_out + 4;
            5'b11100,
            5'b10000,
            5'b00?01: PC_out = PC_out + Imm_out;
            5'b00?10: PC_out = Rs1_data + Imm_out;
            // this defalut will never be reached
            // should this keep the same?
            // default: PC_out = PC_out + 4;
            // PC first, then exception
        endcase
        casez(`EXCEPT)
            // RISC-V
            // 5'b00100,
            // 5'b00010: PC_out <= {mtvec[31:1], 1'b0};
            // 5'b11000: PC_out <= {mtvec[31:1], 1'b0} + (mcause << 2);
            // 5'b?0001: PC_out <= mepc;
            // ARM Vector
            // ecall
            5'b00100: begin
                `SPEC  = {mtvec, 32'h0000_0002, PC_out, mstatus, inst_field};
                PC_out = 32'h0000_0008;
            end
            // interrupt
            5'b11000: begin
                `SPEC  = {mtvec, 32'h8000_0000, PC_out, mstatus, inst_field};
                PC_out = 32'h0000_000C;
            end
            // mret
            5'b?0001: begin
                PC_out = mepc;
            end
            // ill_inst
            5'b00010: begin
                `SPEC  = {mtvec, 32'h0000_000B, PC_out, mstatus, inst_field};
                PC_out = 32'h0000_0004;
            end
            // default: `SPEC = `SPEC;
        endcase
        // rst has higher priority
        if (rst) begin
            `SPEC  = 160'h0;
            PC_out = 32'h0;
        end
    end
    
    ImmGen ImmGen_1(
    .inst_field(inst_field),
    .Imm_out(Imm_out)
    );
    
    // MUX
    always @(*) begin
        case(MemtoReg)
            2'b00: Wt_data = ALU_out;
            2'b01: Wt_data = Data_in;
            2'b10: Wt_data = PC_out + 4;
            2'b11: Wt_data = Imm_out;
        endcase
    end
    
    Regs Regs_1(
    .clk(clk),
    .rst(rst),
    .Rs1_addr(inst_field[19:15]),
    .Rs2_addr(inst_field[24:20]),
    .Wt_addr(inst_field[11:7]),
    .Wt_data(Wt_data),
    .RegWrite(RegWrite),
    .Rs1_data(Rs1_data),
    .Rs2_data(Data_out)
    );
    
    ALU ALU_1(
    .A(Rs1_data),
    .ALU_Control(ALU_Control),
    .B(ALUSrc_B ? Imm_out : Data_out),
    .res(ALU_out),
    .zero(ALU_Zero)
    );
    
endmodule
