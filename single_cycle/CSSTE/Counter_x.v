module Counter_x(clk, rst, clk0, clk1, clk2, counter_we, counter_val,
    counter_ch, counter0_OUT, counter1_OUT, counter2_OUT, counter_out)
    /* synthesis syn_black_box black_box_pad_pin = "clk,rst,clk0,clk1,clk2,counter_we,counter_val[31:0],counter_ch[1:0],counter0_OUT,counter1_OUT,counter2_OUT,counter_out[31:0]" */;
     input clk;
     input rst;
     input clk0;
     input clk1;
     input clk2;
     input counter_we;
     input [31:0]counter_val;
     input [1:0]counter_ch;
     output counter0_OUT;
     output counter1_OUT;
     output counter2_OUT;
     output [31:0]counter_out;
     endmodule
