module IF_reg_ID(clk_IFID, rst_IFID, en_IFID, PC_in_IFID, 
  inst_in_IFID, PC_out_IFID, inst_out_IFID);
  input wire clk_IFID;
  input wire rst_IFID;
  input wire en_IFID;
  input wire [31:0]PC_in_IFID;
  input wire [31:0]inst_in_IFID;
  output reg [31:0]PC_out_IFID;
  output reg [31:0]inst_out_IFID;

  always @(negedge clk_IFID or posedge rst_IFID) begin
    if(rst_IFID) begin
      PC_out_IFID <= 32'b0;
      inst_out_IFID <= 32'b0;
    end else if(en_IFID) begin
      PC_out_IFID <= PC_in_IFID;
      inst_out_IFID <= inst_in_IFID;
    end    
  end
endmodule
