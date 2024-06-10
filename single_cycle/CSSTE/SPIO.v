module SPIO(clk, rst, Start, EN, P_Data, counter_set, LED_out,
    led_clk, led_sout, led_clrn, LED_PEN, GPIOf0)
    /* synthesis syn_black_box black_box_pad_pin = "clk,rst,Start,EN,P_Data[31:0],counter_set[1:0],LED_out[15:0],led_clk,led_sout,led_clrn,LED_PEN,GPIOf0[13:0]" */;
     input clk;
     input rst;
     input Start;
     input EN;
     input [31:0]P_Data;
     output [1:0]counter_set;
     output [15:0]LED_out;
     output led_clk;
     output led_sout;
     output led_clrn;
     output LED_PEN;
     output [13:0]GPIOf0;
     endmodule
