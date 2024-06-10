module clk_div(clk, rst, SW2, SW8, STEP, clkdiv, Clk_CPU)
    /* synthesis syn_black_box black_box_pad_pin = "clk,rst,SW2,SW8,STEP,clkdiv[31:0],Clk_CPU" */;
     input clk;
     input rst;
     input SW2;
     input SW8;
     input STEP;
     output [31:0]clkdiv;
     output Clk_CPU;
     endmodule
