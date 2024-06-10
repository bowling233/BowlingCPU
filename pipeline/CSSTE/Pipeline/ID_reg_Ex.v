module ID_reg_Ex(clk_IDEX, rst_IDEX, en_IDEX, PC_in_IDEX, 
  Rd_addr_IDEX, Rs1_in_IDEx, Rs2_in_IDEX, Imm_in_IDEX, ALUSrc_B_in_IDEX, ALU_control_in_IDEX, 
  Branch_in_IDEX, MemRW_in_IDEX, Jump_in_IDEX, MemtoReg_in_IDEX, 
  RegWrite_in_IDEX, PC_out_IDEX, Rd_addr_out_IDEX, Rs1_out_IDEX, Rs2_out_IDEX, Imm_out_IDEX, 
  ALUSrc_B_out_IDEX, ALU_control_out_IDEX, Branch_out_IDEX, 
  MemRW_out_IDEX, Jump_out_IDEX, MemtoReg_out_IDEX, RegWrite_out_IDEX);
  input wire clk_IDEX;
  input wire rst_IDEX;
  input wire en_IDEX;
  input wire [31:0]PC_in_IDEX;
  input wire [4:0]Rd_addr_IDEX;
  input wire [31:0]Rs1_in_IDEx;
  input wire [31:0]Rs2_in_IDEX;
  input wire [31:0]Imm_in_IDEX;
  input wire ALUSrc_B_in_IDEX;
  input wire [3:0]ALU_control_in_IDEX;
  input wire [1:0] Branch_in_IDEX;
  input wire MemRW_in_IDEX;
  input wire Jump_in_IDEX;
  input wire [1:0]MemtoReg_in_IDEX;
  input wire RegWrite_in_IDEX;
  output reg [31:0]PC_out_IDEX;
  output reg [4:0]Rd_addr_out_IDEX;
  output reg [31:0]Rs1_out_IDEX;
  output reg [31:0]Rs2_out_IDEX;
  output reg [31:0]Imm_out_IDEX;
  output reg ALUSrc_B_out_IDEX;
  output reg [3:0]ALU_control_out_IDEX;
  output reg [1:0]Branch_out_IDEX;
  output reg MemRW_out_IDEX;
  output reg Jump_out_IDEX;
  output reg [1:0]MemtoReg_out_IDEX;
  output reg RegWrite_out_IDEX;

  always @(negedge clk_IDEX or posedge rst_IDEX) begin
    if(rst_IDEX) begin
      PC_out_IDEX <= 32'b0;
      Rd_addr_out_IDEX <= 5'b0;
      Rs1_out_IDEX <= 32'b0;
      Rs2_out_IDEX <= 32'b0;
      Imm_out_IDEX <= 32'b0;
      ALUSrc_B_out_IDEX <= 1'b0;
      ALU_control_out_IDEX <= 3'b0;
      Branch_out_IDEX <= 2'b00;
      MemRW_out_IDEX <= 1'b0;
      Jump_out_IDEX <= 1'b0;
      MemtoReg_out_IDEX <= 2'b0;
      RegWrite_out_IDEX <= 1'b0;
    end else if(en_IDEX) begin
      PC_out_IDEX <= PC_in_IDEX;
      Rd_addr_out_IDEX <= Rd_addr_IDEX;
      Rs1_out_IDEX <= Rs1_in_IDEx;
      Rs2_out_IDEX <= Rs2_in_IDEX;
      Imm_out_IDEX <= Imm_in_IDEX;
      ALUSrc_B_out_IDEX <= ALUSrc_B_in_IDEX;
      ALU_control_out_IDEX <= ALU_control_in_IDEX;
      Branch_out_IDEX <= Branch_in_IDEX;
      MemRW_out_IDEX <= MemRW_in_IDEX;
      Jump_out_IDEX <= Jump_in_IDEX;
      MemtoReg_out_IDEX <= MemtoReg_in_IDEX;
      RegWrite_out_IDEX <= RegWrite_in_IDEX;
    end    
  end

endmodule
