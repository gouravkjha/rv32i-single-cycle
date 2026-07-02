`timescale 1ns / 1ps
`include "defines.vh"

module ALUSrcAMux(
    input [1:0] ALUSrcA,
    input [31:0] PC,RD1,
    output reg [31:0] SrcA
    );

   always @(*) begin
    SrcA = 32'b0;
    case (ALUSrcA)
        `ALUSRC_A_RD1:   SrcA = RD1;
        `ALUSRC_A_PC:    SrcA = PC;
        `ALUSRC_A_CONST: SrcA = 32'b0;
        default: SrcA =RD1;
    endcase
end

endmodule
