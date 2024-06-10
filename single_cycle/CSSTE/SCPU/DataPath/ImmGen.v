`timescale 1ns / 1ps
`default_nettype none
module ImmGen(input wire [31:0] inst_field,
              output wire [31:0] Imm_out);

reg [31:0] Imm_result;
assign Imm_out = Imm_result;

always @(*) begin
    casez(inst_field[6:0])
        // R-type
        // 7'b0110011: Imm_result = 32'b0;
        // I-type
        7'b0010011, // arithmetic
        7'b0000011, // load
        7'b1100111, // jalr
        7'b1110011: // ecall, ebreak
        Imm_result = {{20{inst_field[31]}}, inst_field[31:20]};
        // S-type
        7'b0100011: Imm_result = {{20{inst_field[31]}}, inst_field[31:25], inst_field[11:7]};
        // SB-type
        7'b1100011: Imm_result = {{19{inst_field[31]}}, inst_field[31], inst_field[7], inst_field[30:25], inst_field[11:8], 1'b0};
        // U-type
        7'b0110111, // lui
        7'b0010111: // auipc
        Imm_result = {inst_field[31:12], 12'b0};
        // UJ-type
        7'b1101111: Imm_result = {{12{inst_field[31]}}, inst_field[19:12], inst_field[20], inst_field[30:21], 1'b0};
        default: Imm_result    = 0;
    endcase
end

endmodule
