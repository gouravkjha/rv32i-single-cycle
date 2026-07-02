`timescale 1ns / 1ps

module Instruction_Memory(
    input [31:0] PC,
    output [31:0] Instr
    );
    
    reg [31:0] mem [0:255];
    
    assign Instr = mem[PC[9:2]]; 
    
     initial begin
      $readmemh("initialize_hex.mem",mem);
  end  
    
endmodule
