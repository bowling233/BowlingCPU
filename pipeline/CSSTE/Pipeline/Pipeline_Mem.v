module Pipeline_Mem(zero_in_Mem, Branch_in_Mem,  
  Jump_in_Mem, PCSrc);
  input wire zero_in_Mem;
  input wire [1:0]Branch_in_Mem;
  input wire Jump_in_Mem;
  output wire PCSrc;

  // jump if 
  // Branch[1] and (Branch[0] == zero)
  // or Jump
  assign PCSrc = ((Branch_in_Mem[1] == 1) && (Branch_in_Mem[0] == zero_in_Mem)) || (Jump_in_Mem == 1);
endmodule
