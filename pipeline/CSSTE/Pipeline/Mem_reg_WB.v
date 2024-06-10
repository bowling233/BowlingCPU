module Mem_reg_WB(clk_MemWB, rst_MemWB, en_MemWB, PC4_in_MemWB, 
  Rd_addr_MemWB, ALU_in_MemWB, DMem_data_MemWB, MemtoReg_in_MemWB, RegWrite_in_MemWB, 
  PC4_out_MemWB, Rd_addr_out_MemWB, ALU_out_MemWB, DMem_data_out_MemWB, MemtoReg_out_MemWB, 
  RegWrite_out_MemWB);
  input wire clk_MemWB;
  input wire rst_MemWB;
  input wire en_MemWB;
  input wire [31:0]PC4_in_MemWB;
  input wire [4:0]Rd_addr_MemWB;
  input wire [31:0]ALU_in_MemWB;
  input wire [31:0]DMem_data_MemWB;
  input wire [1:0]MemtoReg_in_MemWB;
  input wire RegWrite_in_MemWB;
  output reg [31:0]PC4_out_MemWB;
  output reg [4:0]Rd_addr_out_MemWB;
  output reg [31:0]ALU_out_MemWB;
  output reg [31:0]DMem_data_out_MemWB;
  output reg [1:0]MemtoReg_out_MemWB;
  output reg RegWrite_out_MemWB;

  always @(negedge clk_MemWB or posedge rst_MemWB) begin
    if(rst_MemWB) begin
      PC4_out_MemWB <= 32'b0;
      Rd_addr_out_MemWB <= 5'b0;
      ALU_out_MemWB <= 32'b0;
      DMem_data_out_MemWB <= 32'b0;
      MemtoReg_out_MemWB <= 2'b0;
      RegWrite_out_MemWB <= 1'b0;
    end else if(en_MemWB) begin
      PC4_out_MemWB <= PC4_in_MemWB;
      Rd_addr_out_MemWB <= Rd_addr_MemWB;
      ALU_out_MemWB <= ALU_in_MemWB;
      DMem_data_out_MemWB <= DMem_data_MemWB;
      MemtoReg_out_MemWB <= MemtoReg_in_MemWB;
      RegWrite_out_MemWB <= RegWrite_in_MemWB;
    end    
  end
endmodule
