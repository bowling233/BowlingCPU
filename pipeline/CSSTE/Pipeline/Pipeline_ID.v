module Pipeline_ID(clk_ID, rst_ID, RegWrite_in_ID, Rd_addr_ID, 
  Wt_data_ID, Inst_in_ID, Rd_addr_out_ID, Rs1_out_ID, Rs2_out_ID, Imm_out_ID, ALUSrc_B_ID, 
  ALU_control_ID, Branch_ID, MemRW_ID, Jump_ID, MemtoReg_ID, RegWrite_out_ID);
  input wire clk_ID;
  input wire rst_ID;
  input wire RegWrite_in_ID;
  input wire [4:0]Rd_addr_ID;
  input wire [31:0]Wt_data_ID;
  input wire [31:0]Inst_in_ID;
  output wire [4:0]Rd_addr_out_ID;
  output wire [31:0]Rs1_out_ID;
  output wire [31:0]Rs2_out_ID;
  output wire [31:0]Imm_out_ID;
  output wire ALUSrc_B_ID;
  output wire [3:0]ALU_control_ID;
  output wire [1:0]Branch_ID;
  output wire MemRW_ID;
  output wire Jump_ID;
  output wire [1:0]MemtoReg_ID;
  output wire RegWrite_out_ID;

  Regs myRegs(
    .clk(clk_ID),
    .rst(rst_ID),
    // Instruction decode
    .Rs1_addr(Inst_in_ID[19:15]),
    .Rs2_addr(Inst_in_ID[24:20]),
    .Rs1_data(Rs1_out_ID),
    .Rs2_data(Rs2_out_ID),
    // Write back
    .RegWrite(RegWrite_in_ID),
    .Wt_addr(Rd_addr_ID),
    .Wt_data(Wt_data_ID)
  );
  wire unused;
  SCPU_ctrl mySCPU_ctrl(
    .OPcode(Inst_in_ID[6:0]),
    .Fun3(Inst_in_ID[14:12]),
    .Fun12(Inst_in_ID[31:20]),
    .ALU_Control(ALU_control_ID),
    .ALUSrc_B(ALUSrc_B_ID),
    .Branch(Branch_ID),
    .Jump({unused, Jump_ID}), // ignore jalr now
    .MemRead(),
    .MemtoReg(MemtoReg_ID),
    .MemWrite(MemRW_ID),
    .RegWrite(RegWrite_out_ID),
    .ill_inst(),
    .mret(),
    .ecall()
  );

  ImmGen myImmGen(
    .inst_field(Inst_in_ID),
    .Imm_out(Imm_out_ID)
  );

  assign Rd_addr_out_ID = Inst_in_ID[11:7];

endmodule
