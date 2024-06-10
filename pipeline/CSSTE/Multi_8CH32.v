module Multi_8CH32(clk, rst, EN, Test, point_in, LES, Data0, data1, data2,
    data3, data4, data5, data6, data7, point_out, LE_out, Disp_num)
    /* synthesis syn_black_box black_box_pad_pin = "clk,rst,EN,Test[2:0],point_in[63:0],LES[63:0],Data0[31:0],data1[31:0],data2[31:0],data3[31:0],data4[31:0],data5[31:0],data6[31:0],data7[31:0],point_out[7:0],LE_out[7:0],Disp_num[31:0]" */;
     input clk;
     input rst;
     input EN;
     input [2:0]Test;
     input [63:0]point_in;
     input [63:0]LES;
     input [31:0]Data0;
     input [31:0]data1;
     input [31:0]data2;
     input [31:0]data3;
     input [31:0]data4;
     input [31:0]data5;
     input [31:0]data6;
     input [31:0]data7;
     output [7:0]point_out;
     output [7:0]LE_out;
     output [31:0]Disp_num;
     endmodule
