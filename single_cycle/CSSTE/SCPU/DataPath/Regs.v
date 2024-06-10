`timescale 1ns / 1ps
`default_nettype none
module Regs(input wire clk,
            rst,
            RegWrite,
            input wire [4:0] Rs1_addr,
            Rs2_addr,
            Wt_addr,
            input wire [31:0] Wt_data,
            output wire [31:0] Rs1_data,
            Rs2_data);
    reg [31:0] register [1:31];
    integer i;
    
    assign Rs1_data = (Rs1_addr == 0) ? 0 : register[Rs1_addr];
    assign Rs2_data = (Rs2_addr == 0) ? 0 : register[Rs2_addr];
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            for(i = 1; i <= 31; i = i+1)
                register[i] <= 0;
        end
        else
        begin
            if ((Wt_addr != 0) && RegWrite) begin
                register[Wt_addr] <= Wt_data;
            end
        end
    end
endmodule
