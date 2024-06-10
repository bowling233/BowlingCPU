module SAnti_jitter(clk, RSTN, readn, Key_y, Key_x, SW, Key_out, Key_ready,
    pulse_out, BTN_OK, SW_OK, CR, rst)
    /* synthesis syn_black_box black_box_pad_pin = "clk,RSTN,readn,Key_y[3:0],Key_x[4:0],SW[15:0],Key_out[4:0],Key_ready,pulse_out[3:0],BTN_OK[3:0],SW_OK[15:0],CR,rst" */;
     input clk;
     input RSTN;
     input readn;
     input [3:0]Key_y;
     output [4:0]Key_x;
     input [15:0]SW;
     output [4:0]Key_out;
     output Key_ready;
     output [3:0]pulse_out;
     output [3:0]BTN_OK;
     output [15:0]SW_OK;
     output CR;
     output rst;
     endmodule
