`timescale 1ns / 1ps
`include "defines.vh"

module PCNextMux(
    input [1:0] PCSrc,
    input [31:0] PCPlus4,PCTarget,
    output reg [31:0] PCNext
    );
    
    wire [31:0] JALRTarget;
    
assign JALRTarget = {PCTarget[31:1], 1'b0};

    always @(*) begin
       
    case (PCSrc)
    `PCSRC_PLUS4 : PCNext = PCPlus4;
    `PCSRC_TARGET: PCNext = PCTarget;
    `PCSRC_JALR  : PCNext = JALRTarget;
    default :PCNext=PCPlus4;
endcase
end
    
endmodule
