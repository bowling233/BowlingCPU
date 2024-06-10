module Pipeline_Ex(PC_in_EX, Rs1_in_EX, Rs2_in_EX, Imm_in_EX, 
  ALUSrc_B_in_EX, ALU_control_in_EX, PC_out_EX, PC4_out_EX, zero_out_EX, ALU_out_EX, 
  Rs2_out_EX);
  input wire [31:0]PC_in_EX;
  input wire [31:0]Rs1_in_EX;
  input wire [31:0]Rs2_in_EX;
  input wire [31:0]Imm_in_EX;
  input wire ALUSrc_B_in_EX;
  input wire [3:0]ALU_control_in_EX;
  output wire [31:0]PC_out_EX;
  output wire [31:0]PC4_out_EX;
  output wire zero_out_EX;
  output wire [31:0]ALU_out_EX;
  output wire [31:0]Rs2_out_EX;

  ALU myALU(
    .A(Rs1_in_EX),
    .B(ALUSrc_B_in_EX ? Imm_in_EX : Rs2_in_EX),
    .ALU_Control(ALU_control_in_EX),
    .res(ALU_out_EX),
    .zero(zero_out_EX)
  );

  assign PC_out_EX = $signed(PC_in_EX) + $signed(Imm_in_EX);
  assign PC4_out_EX = PC_in_EX + 4;
  assign Rs2_out_EX = Rs2_in_EX;
endmodule
