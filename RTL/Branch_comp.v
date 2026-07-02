`timescale 1ns / 1ps
`include "defines.vh"

module Branch_comp(
    input [31:0] RD1,RD2,
    input [2:0] func3,
    output reg branch_taken
    );
    
    wire equal,less_than_signed,less_than_unsigned;
    
    assign equal = (RD1==RD2);
    assign less_than_signed = ($signed(RD1)<$signed(RD2));
    assign less_than_unsigned = (RD1<RD2);
  
   always@(*)begin 
    case (func3)
        `B_BEQ: branch_taken=equal;
        `B_BNE: branch_taken=!equal;
        `B_BLT: branch_taken=less_than_signed;
        `B_BGE: branch_taken=!less_than_signed;
        `B_BLTU: branch_taken=less_than_unsigned;
        `B_BGEU: branch_taken=!less_than_unsigned;
        default:branch_taken=equal;
    endcase
    
 end 
endmodule
