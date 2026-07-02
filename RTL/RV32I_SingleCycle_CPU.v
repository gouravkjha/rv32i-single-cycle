`timescale 1ns / 1ps

module RV32I_SingleCycle_CPU(
    input clk,
    input rst
);

wire [31:0] PC, PCPlus4, PCNext;
wire [31:0] Instr;
wire [31:0] RD1, RD2;
wire [31:0] ImmExt;
wire [31:0] SrcA, SrcB;
wire [31:0] ALUResult;
wire [31:0] RD;
wire [31:0] LoadData;
wire [31:0] Result;

wire [3:0] ALUControl;
wire [2:0] ImmSrc;
wire [1:0] ALUSrcA;
wire [1:0] PCSrc;
wire [1:0] ResultSrc;

wire WriteE;
wire MemWrite;
wire Branch_Taken;
wire ALUSrcB;

//=========================================================
// Instruction Fetch (IF)
//=========================================================

PC u_PC (
    .clk    (clk),
    .reset  (rst),
    .PCNext (PCNext),
    .PC     (PC)
);

PCPlus4 u_PCPlus4 (
    .PC      (PC),
    .PCPlus4 (PCPlus4)
);

PCNextMux u_PCNextMux (
    .PCSrc   (PCSrc),
    .PCPlus4 (PCPlus4),
    .PCTarget(ALUResult),
    .PCNext  (PCNext)
);

Instruction_Memory u_Instruction_Memory (
    .PC    (PC),
    .Instr (Instr)
);

//=========================================================
// Instruction Decode (ID)
//=========================================================

Register_File u_Register_File (
    .clk    (clk),
    .rst     (rst),
    .WriteE (WriteE),
    .R1     (Instr[19:15]),
    .R2     (Instr[24:20]),
    .RD     (Instr[11:7]),
    .WriteD (Result),
    .RD1    (RD1),
    .RD2    (RD2)
);

ImmSignExtend u_ImmSignExtend (
    .instr  (Instr[31:7]),
    .ImmSrc (ImmSrc),
    .ImmExt (ImmExt)
);

Control_Unit u_Control_Unit (
    .Branch_Taken (Branch_Taken),
    .func3        (Instr[14:12]),
    .func7        (Instr[31:25]),
    .OPcode       (Instr[6:0]),
    .WriteE       (WriteE),
    .ALUSrcA      (ALUSrcA),
    .ALUSrcB      (ALUSrcB),
    .MemWrite     (MemWrite),
    .ImmSrc       (ImmSrc),
    .ALUControl   (ALUControl),
    .PCSrc        (PCSrc),
    .ResultSrc    (ResultSrc)
);

Branch_comp u_Branch_comp (
    .RD1          (RD1),
    .RD2          (RD2),
    .func3        (Instr[14:12]),
    .branch_taken (Branch_Taken)
);

//=========================================================
// Execute (EX)
//=========================================================

ALUSrcAMux u_ALUSrcAMux (
    .ALUSrcA (ALUSrcA),
    .PC      (PC),
    .RD1     (RD1),
    .SrcA    (SrcA)
);

ALUSrcBMux u_ALUSrcBMux (
    .ALUSrcB (ALUSrcB),
    .RD2     (RD2),
    .ImmExt  (ImmExt),
    .SrcB    (SrcB)
);

ALU u_ALU (
    .ALUControl (ALUControl),
    .A          (SrcA),
    .B          (SrcB),
    .ALUResult  (ALUResult)
);

//=========================================================
// Memory Access (MEM)
//=========================================================

Data_Memory u_Data_Memory (
    .clk      (clk),
    .MemWrite (MemWrite),
    .funct3   (Instr[14:12]),
    .ALUAddr  (ALUResult),
    .WData    (RD2),
    .RD       (RD)
);

Load_extend u_Load_extend (
    .func3      (Instr[14:12]),
    .ByteOffset (ALUResult[1:0]),
    .RD         (RD),
    .LoadData   (LoadData)
);

//=========================================================
// Write Back (WB)
//=========================================================

ResultSrcMux u_ResultSrcMux (
    .ResultSrc (ResultSrc),
    .ALUResult (ALUResult),
    .LoadData  (LoadData),
    .PCPlus4   (PCPlus4),
    .Result    (Result)
);

endmodule