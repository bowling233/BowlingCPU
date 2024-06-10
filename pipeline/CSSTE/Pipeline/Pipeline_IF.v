module Pipeline_IF(clk_IF, rst_IF, en_IF, PC_in_IF, PCSrc, PC_out_IF);
  input wire clk_IF;
  input wire rst_IF;
  input wire en_IF;
  input wire [31:0]PC_in_IF;
  input wire PCSrc;
  output reg [31:0]PC_out_IF;

  always @(negedge clk_IF or posedge rst_IF) begin
    if(rst_IF) begin
      PC_out_IF <= 32'b0;
    end else if(en_IF) begin
      PC_out_IF <= PCSrc ? PC_in_IF : PC_out_IF + 4;
    end    
  end

endmodule
