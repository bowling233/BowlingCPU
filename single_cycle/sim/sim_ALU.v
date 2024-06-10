`timescale 1ns / 1ps
`default_nettype none

module sim_ALU();
    
    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns
    
    // Inputs
    reg [31:0] A;
    reg [3:0] ALU_Control;
    reg [31:0] B;
    
    // Outputs
    wire [31:0] res;
    wire zero;
    
    // Instantiate the ALU module
    ALU uut(
    .A(A),
    .ALU_Control(ALU_Control),
    .B(B),
    .res(res),
    .zero(zero)
    );
    
    // Clock generation
    reg clk                        = 0;
    always #((CLK_PERIOD / 2)) clk = !clk;
    
    // Test vectors
    initial begin
        $display("Starting ALU Testbench...");
        
        // Test vector 1: A & B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0000;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of A & B = %h", res);
        
        // Test vector 2: A | B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0001;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of A | B = %h", res);
        
        // Test vector 3: A + B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0010;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of A + B = %h", res);
        
        // Test vector 4: A - B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0110;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of A - B = %h", res);
        
        // Test vector 5: Set on less than signed
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0111;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of Set on less than = %h", res);
        
        // Test vector 6: A << B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0100;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of ~(A | B) = %h", res);
        
        // Test vector 7: A >> B[4:0] logical
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0101;
        B           = 5'h0F;
        #10; // Wait for 10 ns
        $display("Result of A >> B[4:0] = %h", res);
        
        // Test vector 8: A ^ B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b0011;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of A ^ B = %h", res);
        
        // Test vector 9: A >>> B
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b1000;
        B           = 5'h0F;
        #10; // Wait for 10 ns
        $display("Result of A >>> B = %h", res);
        
        // Test vector 10: sltu
        A           = 32'hAAAA_AAAA;
        ALU_Control = 4'b1001;
        B           = 32'h5555_5555;
        #10; // Wait for 10 ns
        $display("Result of Set on less than unsigned = %h", res);
        
        $display("ALU Testbench finished.");
        $finish; // End simulation
        
        
    end
    
    // Clock process
    always #((CLK_PERIOD / 2)) clk = ~clk;
    
endmodule
