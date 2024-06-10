module Ex_reg_Mem(clk_EXMem, rst_EXMem, en_EXMem, PC_in_EXMem, 
  PC4_in_EXMem, Rd_addr_EXMem, zero_in_EXMem, ALU_in_EXMem, Rs2_in_EXMem, Branch_in_EXMem, 
  MemRW_in_EXMem, Junp_in_EXMem, MemtoReg_in_EXMem, RegWrite_in_EXMem, 
  PC_out_EXMem, PC4_out_EXMem, Rd_addr_out_EXMem, zero_out_EXMem, ALU_out_EXMem, 
  Rs2_out_EXMem, Branch_out_EXMem, MemRW_out_EXMem, Jump_out_EXMem, 
  MemtoReg_out_EXMem, RegWrite_out_EXMem);
  input wire clk_EXMem;
  input wire rst_EXMem;
  input wire en_EXMem;
  input wire [31:0]PC_in_EXMem;
  input wire [31:0]PC4_in_EXMem;
  input wire [4:0]Rd_addr_EXMem;
  input wire zero_in_EXMem;
  input wire [31:0]ALU_in_EXMem;
  input wire [31:0]Rs2_in_EXMem;
  input wire [1:0]Branch_in_EXMem;
  input wire MemRW_in_EXMem;
  input wire Junp_in_EXMem;
  input wire [1:0]MemtoReg_in_EXMem;
  input wire RegWrite_in_EXMem;
  output reg [31:0]PC_out_EXMem;
  output reg [31:0]PC4_out_EXMem;
  output reg [4:0]Rd_addr_out_EXMem;
  output reg zero_out_EXMem;
  output reg [31:0]ALU_out_EXMem;
  output reg [31:0]Rs2_out_EXMem;
  output reg [1:0]Branch_out_EXMem;
  output reg MemRW_out_EXMem;
  output reg Jump_out_EXMem;
  output reg [1:0]MemtoReg_out_EXMem;
  output reg RegWrite_out_EXMem;

  always @(negedge clk_EXMem or posedge rst_EXMem) begin
    if(rst_EXMem) begin
      PC_out_EXMem <= 32'b0;
      PC4_out_EXMem <= 32'b0;
      Rd_addr_out_EXMem <= 5'b0;
      zero_out_EXMem <= 1'b0;
      ALU_out_EXMem <= 32'b0;
      Rs2_out_EXMem <= 32'b0;
      Branch_out_EXMem <= 2'b00;
      MemRW_out_EXMem <= 1'b0;
      Jump_out_EXMem <= 1'b0;
      MemtoReg_out_EXMem <= 2'b0;
      RegWrite_out_EXMem <= 1'b0;
    end else if(en_EXMem) begin
      PC_out_EXMem <= PC_in_EXMem;
      PC4_out_EXMem <= PC4_in_EXMem;
      Rd_addr_out_EXMem <= Rd_addr_EXMem;
      zero_out_EXMem <= zero_in_EXMem;
      ALU_out_EXMem <= ALU_in_EXMem;
      Rs2_out_EXMem <= Rs2_in_EXMem;
      Branch_out_EXMem <= Branch_in_EXMem;
      MemRW_out_EXMem <= MemRW_in_EXMem;
      Jump_out_EXMem <= Junp_in_EXMem;
      MemtoReg_out_EXMem <= MemtoReg_in_EXMem;
      RegWrite_out_EXMem <= RegWrite_in_EXMem;
    end    
  end

  
endmodule
