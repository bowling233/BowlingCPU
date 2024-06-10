`timescale 1ns / 1ps
module CSSTE (input clk_100mhz,
              input RSTN,
              input [3:0] BTN_y,
              input [15:0] SW,
              output [3:0] Blue,
              output [3:0] Green,
              output [3:0] Red,
              output HSYNC,
              output VSYNC,
              output [7:0] AN,
              output [7:0] segment,
              output [15:0] LED_out);
    
    wire            [3:0]                               U9_BTN_OK   ;
    wire            [15:0]                              U9_SW_OK    ;
    wire                                                U9_rst  ;
    wire            [31:0]                              U8_clkdiv   ;
    wire                                                U8_Clk_CPU  ;
    wire            [31:0]                              PC_out  ;
    wire            [31:0]                              Inst_in ;
    wire            [31:0]                              U4_Cpu_data4bus ;
    wire                                                MemRW   ;
    wire            [31:0]                              Addr_out    ;
    wire            [31:0]                              Data_out    ;
    wire            [9:0]                               ram_addr    ;
    wire            [31:0]                              ram_data_in ;
    wire                                                U4_data_ram_we  ;
    wire            [31:0]                              RAM_B_0_douta   ;
    wire                                                U4_counter_we   ;
    wire            [31:0]                              U10_counter_val ;
    wire            [1:0]                               U10_counter_ch  ;
    wire                                                counter0_OUT    ;
    wire                                                counter1_OUT    ;
    wire                                                counter2_OUT    ;
    wire            [31:0]                              U10_counter_out ;
    wire                                                U7_EN   ;
    wire                                                U5_EN   ;
    wire            [7:0]                               U5_point_out    ;
    wire            [7:0]                               U5_LE_out   ;
    wire            [31:0]                              U5_Disp_num ;
    
    SAnti_jitter U9
    (.clk(clk_100mhz),  //y
    .RSTN   (RSTN), //y
    // .readn(1'b1),
    .Key_y  (BTN_y), //y
    .SW (SW), //y
    .BTN_OK (U9_BTN_OK), //y
    .SW_OK  (U9_SW_OK), //y
    .rst    (U9_rst)); //y
    
    clk_div U8
    (.clk(clk_100mhz), //y
    .SW2    (U9_SW_OK[2]), //y
    .SW8    (U9_SW_OK[8]), //y
    .STEP   (U9_SW_OK[10]), //y
    .rst    (U9_rst), //y
    .clkdiv (U8_clkdiv), //y
    .Clk_CPU    (U8_Clk_CPU)); //y
    
    //given
    ROM_D U2
    (.a(PC_out[11:2]), //y
    .spo    (Inst_in)); //y
    
    //given
    //SCPU U1
    //(.Addr_out(Addr_out),
    //.Data_in    (U4_Cpu_data4bus),
    //.Data_out   (Data_out),
    //.MIO_ready  (1'b0),
    //.MemRW  (MemRW),
    //.PC_out (PC_out),
    //.clk    (U8_Clk_CPU), //y
    //.inst_in    (Inst_in), //y
    //.rst    (U9_rst)); //y
    wire [31:0] PC_out_IF;
    assign PC_out = PC_out_IF;
    wire [31:0] PC_out_ID;
    wire [31:0] inst_ID;
    wire [31:0] PC_out_Ex;
    wire MemRW_Ex;
    wire [31:0] Data_out_WB;
    
    SCPU U1
    (
    .Data_in(U4_Cpu_data4bus),
    .clk(U8_Clk_CPU),
    .inst_in(Inst_in),
    .rst(U9_rst),
    //.CPU_MIO,
    .PC_out_IF(PC_out_IF),
    .PC_out_ID(PC_out_ID),
    .inst_ID(inst_ID),
    .PC_out_EX(PC_out_Ex),
    .MemRW_EX(MemRW_Ex),
    .MemRW_Mem(MemRW),
    .Data_out(Data_out),
    .Addr_out(Addr_out),
    .Data_out_WB(Data_out_WB)
    );
    
    //given
    blk_mem_gen_0 U3
    (.addra(ram_addr),
    .clka   (~clk_100mhz), //y
    .dina   (ram_data_in), //y
    .douta  (RAM_B_0_douta),
    .wea    (U4_data_ram_we)); //y
    
    Counter_x U10
    (.clk(~U8_Clk_CPU), //y
    .rst    (U9_rst), //y
    .clk0   (U8_clkdiv[6]), //y
    .clk1   (U8_clkdiv[9]), //y
    .clk2   (U8_clkdiv[11]), //y
    .counter_we (U4_counter_we), //y
    .counter_val    (U10_counter_val),
    .counter_ch (U10_counter_ch),
    .counter0_OUT   (counter0_OUT),
    .counter1_OUT   (counter1_OUT),
    .counter2_OUT   (counter2_OUT),
    .counter_out    (U10_counter_out)); //y
    
    MIO_BUS U4
    (.clk(clk_100mhz), //y
    .BTN    (U9_BTN_OK), //y
    .rst    (U9_rst), //y
    .Cpu_data4bus   (U4_Cpu_data4bus), //y
    .mem_w  (MemRW), //y
    .addr_bus   (Addr_out), //y
    .Cpu_data2bus   (Data_out), //y
    .ram_addr   (ram_addr), //y
    .ram_data_in    (ram_data_in), //y
    .data_ram_we    (U4_data_ram_we), //y
    .ram_data_out   (RAM_B_0_douta), //y
    .counter_we (U4_counter_we), //y
    .Peripheral_in  (U10_counter_val), //y
    .counter0_out   (counter0_OUT), //y
    .counter1_out   (counter1_OUT), //y
    .counter2_out   (counter2_OUT), //y
    .counter_out    (U10_counter_out), //y
    .SW (U9_SW_OK), //y
    .led_out    (LED_out), //y
    .GPIOf0000000_we    (U7_EN), //y
    .GPIOe0000000_we    (U5_EN)); //y
    
    Multi_8CH32 U5
    (.clk(~U8_Clk_CPU), //y
    .rst    (U9_rst), //y
    .point_in   ({U8_clkdiv, U8_clkdiv}), //y
    .data2  (Inst_in), //y
    .data4  (Addr_out), //y
    .data5  (Data_out), //y
    .data7  (PC_out), //y
    .data1  ({2'b0, PC_out[31:2]}), //y
    .Data0  (U10_counter_val), //y
    .data3  (U10_counter_out), //y
    .LES    (64'b0), //y
    .Test   (U9_SW_OK[7:5]), //y
    .data6  (U4_Cpu_data4bus), //y
    .EN (U5_EN), //y
    .point_out  (U5_point_out), //y
    .LE_out (U5_LE_out), //y
    .Disp_num   (U5_Disp_num)); //y
    
    VGA U11
    (.clk_25m(U8_clkdiv[1]), //y
    .clk_100m   (clk_100mhz), //y
    // deleted .inst   (Inst_in), //y
    //new
    .PC_IF(PC_out_IF),
    .inst_IF(Inst_in),
    .PC_ID(PC_out_ID),
    .inst_ID(inst_ID),
    .PC_Ex(PC_out_Ex),
    .MemRW_Ex(MemRW_Ex),
    .MemRW_Mem(MemRW),
    .Data_out(Data_out),
    .Addr_out(Addr_out),
    .Data_out_WB(Data_out_WB),
    //new
    // deleted.mem_wen    (MemRW), //y
    // deleted.alu_res    (Addr_out), //y
    // deleted.dmem_addr  (Addr_out), //y
    // deleted.pc (PC_out), //y
    // deleted.dmem_i_data    (ram_data_in), //y
    // deleted.dmem_o_data    (RAM_B_0_douta), //y
    .rst    (U9_rst), //y
    .hs (HSYNC), //y
    .vs (VSYNC), //y
    .vga_r  (Red), //y
    .vga_g  (Green), //y
    .vga_b  (Blue)
    ); //y
    
    SPIO U7
    (.clk(~U8_Clk_CPU), //y
    .rst    (U9_rst), //y
    .Start  (U8_clkdiv[20]), //y
    .P_Data (U10_counter_val), //y
    .counter_set    (U10_counter_ch), //y
    .LED_out    (LED_out),
    .EN (U7_EN)); //y
    
    Seg7_Dev U6
    (.scan(U8_clkdiv[18:16]), //y
    .les    (U5_LE_out), //y
    .point  (U5_point_out), //y
    .disp_num   (U5_Disp_num), //y
    .AN (AN), //y
    .segment    (segment)); //y
    
endmodule
