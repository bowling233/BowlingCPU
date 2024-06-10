module Pipeline_WB(PC4_in_WB, ALU_in_WB, DMem_data_WB, 
  MemtoReg_in_WB, Data_out_WB);
  input wire [31:0]PC4_in_WB;
  input wire [31:0]ALU_in_WB;
  input wire [31:0]DMem_data_WB;
  input wire [1:0]MemtoReg_in_WB;
  output reg[31:0]Data_out_WB;

  //mux
  always @(*) begin
    // write back
    if(MemtoReg_in_WB == 2'b00) begin
      Data_out_WB <= ALU_in_WB;
    // load
    end else if(MemtoReg_in_WB == 2'b01) begin
      Data_out_WB <= DMem_data_WB;
    // jump
    end else if(MemtoReg_in_WB == 2'b10) begin
      Data_out_WB <= PC4_in_WB;
    // u-type not implemented
    end else begin
      Data_out_WB <= 32'b0;
    end
  end

endmodule
