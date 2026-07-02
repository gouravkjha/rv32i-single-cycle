`timescale 1ns / 1ps
`include "defines.vh"

module Control_Unit(
    input Branch_Taken,
    input [2:0] func3,
    input [6:0] func7,OPcode,
    output  WriteE,ALUSrcB,MemWrite,
    output  reg [1:0] ALUSrcA,
    output  reg [2:0] ImmSrc,
    output  reg [3:0] ALUControl,
    output  reg [1:0] PCSrc,ResultSrc
    );

    wire ALUOp;
    wire [1:0] PCSrc_branch; 
    
    // Main Decoder Logic
    
    assign PCSrc_branch = (OPcode == `BRANCH && Branch_Taken)?2'b01:2'b00;
    assign ALUOp = (OPcode != `RTYPE && OPcode != `ITYPE );
    assign WriteE = (OPcode != `STORE && OPcode != `BRANCH);
    assign ALUSrcB = (OPcode != `RTYPE);
    assign MemWrite = (OPcode == `STORE); 
    
    always @(*) begin
    case (OPcode)
        `RTYPE:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc }  = {2'b00, 3'b000, 2'b00, 2'b00};       
        `ITYPE:{ALUSrcA, ImmSrc, PCSrc, ResultSrc }  = {2'b00, 3'b000, 2'b00, 2'b00};
        `LOAD:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc }   = {2'b00, 3'b000, 2'b00, 2'b01};
        `STORE:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc }  = {2'b00, 3'b001, 2'b00, 2'b00};
        `BRANCH:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc } = {2'b01, 3'b010,PCSrc_branch,2'b00};
        `LUI:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc }    = {2'b10,3'b011, 2'b00, 2'b00};
        `AUIPC:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc }  = {2'b01, 3'b011, 2'b00, 2'b00};
        `JAL: { ALUSrcA, ImmSrc, PCSrc, ResultSrc }   = {2'b01, 3'b100, 2'b01, 2'b10};
        `JALR:{ ALUSrcA, ImmSrc, PCSrc, ResultSrc }   = {2'b00, 3'b000, 2'b10, 2'b10};
         default: { ALUSrcA,ImmSrc, PCSrc, ResultSrc }  = {2'b00, 3'b000, 2'b00, 2'b00};
    endcase
end

        
    //ALU Decoder Logic 
    
    wire funct7_rtype_bit;      // funct7[5] valid only for R-type instructions
    wire funct7_shift_imm_bit;  // funct7[5] valid only for SRLI/SRAI
    wire alu_func7_bit;         // Unified funct7[5] bit used by ALU decoder 
    
    
   assign funct7_rtype_bit =(OPcode == `RTYPE)? func7[5] : 1'b0;
assign funct7_shift_imm_bit = (OPcode == `ITYPE && func3 == `F3_SRL_SRA)? func7[5] : 1'b0;

assign alu_func7_bit =funct7_rtype_bit | funct7_shift_imm_bit; // For all instructions except R-type and SRLI/SRAI this signal is forced LOW

    always@(*)begin 
     if(ALUOp)
       ALUControl=`ALU_ADD;   //ADD FOR J,U,S,B,I-LOAD,I-JUMP
       
       else begin
      case ({alu_func7_bit, func3})
    {1'b0, `F3_ADD_SUB} : ALUControl = `ALU_ADD;
    {1'b1, `F3_ADD_SUB} : ALUControl = `ALU_SUB;
    {1'b0, `F3_AND}     : ALUControl = `ALU_AND;
    {1'b0, `F3_OR}      : ALUControl = `ALU_OR;
    {1'b0, `F3_XOR}     : ALUControl = `ALU_XOR;
    {1'b0, `F3_SLL}     : ALUControl = `ALU_SLL;
    {1'b0, `F3_SRL_SRA} : ALUControl = `ALU_SRL;
    {1'b1, `F3_SRL_SRA} : ALUControl = `ALU_SRA;
    {1'b0, `F3_SLT}     : ALUControl = `ALU_SLT;
    {1'b0, `F3_SLTU}    : ALUControl = `ALU_SLTU;
     default: ALUControl = `ALU_ADD;
    endcase
    end
    
    end
endmodule
