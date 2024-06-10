`timescale 1ns / 1ps
`default_nettype none
module ALU(input wire [31:0] A,
           input wire [3:0] ALU_Control,
           input wire [31:0] B,
           output wire [31:0] res,
           output wire zero);
reg [31:0] ALU_result;
assign res  = ALU_result;
assign zero = !(|res);

always @ (*) begin
    case (ALU_Control)
        4'b0000: ALU_result = A & B;
        4'b0001: ALU_result = A | B;
        4'b0010: ALU_result = A + B;
        4'b0011: // xor
        ALU_result = A ^ B;
        4'b0100: // shift left logical
        ALU_result = A << B[4:0];
        4'b0101: // shift right logical
        ALU_result          = A >> B[4:0];
        4'b0110: ALU_result = A - B;
        4'b0111: // set on less than signed
        ALU_result = $signed(A) < $signed(B) ? 32'b1 : 32'b0;
        4'b1000: // shift right arithmetic
        // important: you need to work with signed signals to get
        // sign extension:
        // https://stackoverflow.com/questions/54872369/arithmetic-right-shift-not-working-in-verilog-hdl
        ALU_result = $signed(A) >>> B[4:0];
        4'b1001: // set on less than unsigned
        ALU_result          = (A < B) ? 32'b1 : 32'b0;
        default: ALU_result = 32'b0;
    endcase
end
endmodule
