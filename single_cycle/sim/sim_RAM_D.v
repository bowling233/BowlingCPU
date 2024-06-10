module sim_RAM_D; reg clka; reg wea; reg [9:0] addra; reg [31:0] dina; wire [31:0] douta; blk_mem_gen_0 your_instance_name (.clka(clka), .wea(wea), .addra(addra), .dina(dina), .douta(douta));
    
    initial begin
        // 初始化输入信号
        clka  = 0;
        wea   = 0;
        addra = 0;
        dina  = 0;
        
        // 模拟时钟
        forever #5 clka = ~clka;
    end
    
    always @(posedge clka) begin
        // 读取内存数据并显示
        $display("Address: %d, Data: %h", addra, douta);
        
        // 增加地址以进行下一次读取
        addra = addra + 1;
    end
    
endmodule
