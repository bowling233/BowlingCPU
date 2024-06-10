module sim_ROM();
    
    reg [31:0] PC_out;
    wire [31:0] Inst_in;
    
    ROM_D U2
    (
    .a(PC_out[11:2]),
    .spo(Inst_in)
    );
    
    always begin
        #5 PC_out = PC_out + 4;
    end
    
    initial begin
        PC_out = 32'h00000000;
    end
endmodule
