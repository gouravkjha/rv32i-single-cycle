//=========================================================
// ALU Operation Encodings
// Used by ALU Decoder and ALU module.
//=========================================================

`define ALU_ADD   4'b0000   // Addition
`define ALU_SUB   4'b0001   // Subtraction
`define ALU_AND   4'b0010   // Bitwise AND
`define ALU_OR    4'b0011   // Bitwise OR
`define ALU_XOR   4'b0100   // Bitwise XOR
`define ALU_SLL   4'b0101   // Logical Left Shift
`define ALU_SRL   4'b0110   // Logical Right Shift
`define ALU_SRA   4'b0111   // Arithmetic Right Shift
`define ALU_SLT   4'b1000   // Signed Less-Than Comparison
`define ALU_SLTU  4'b1001   // Unsigned Less-Than Comparison


//=========================================================
// ALU Source A Mux Select Encodings
// Used by Control Unit and ALUSrcAMux module.
//=========================================================

`define ALUSRC_A_RD1    2'b00   // Select Register File output (RD1)
`define ALUSRC_A_PC     2'b01   // Select Program Counter (PC)
`define ALUSRC_A_CONST  2'b10   // Select internal constant 32'b0 (LUI)

//=========================================================
// Branch funct3 Encodings
// Used by Branch Comparator module.
//=========================================================

`define B_BEQ   3'b000   // Branch if Equal
`define B_BNE   3'b001   // Branch if Not Equal
`define B_BLT   3'b100   // Branch if Less Than (Signed)
`define B_BGE   3'b101   // Branch if Greater Than or Equal (Signed)
`define B_BLTU  3'b110   // Branch if Less Than (Unsigned)
`define B_BGEU  3'b111   // Branch if Greater Than or Equal (Unsigned)

//=========================================================
// Immediate Source Encodings
// Used by Control Unit and Immediate Sign Extension module.
//=========================================================

`define IMM_I  3'b000   // I-type Immediate
`define IMM_S  3'b001   // S-type Immediate
`define IMM_B  3'b010   // B-type Immediate
`define IMM_U  3'b011   // U-type Immediate
`define IMM_J  3'b100   // J-type Immediate

//=========================================================
// PC Source Select Encodings
// Used by Control Unit and PCNextMux module.
//=========================================================

`define PCSRC_PLUS4   2'b00   // Next sequential instruction (PC + 4)
`define PCSRC_TARGET  2'b01   // Branch taken or JAL target (PC + Immediate)
`define PCSRC_JALR    2'b10   // JALR target ({PCTarget[31:1], 1'b0})

//=========================================================
// Result Source Select Encodings
// Used by Control Unit and ResultSrcMux module.
//=========================================================

`define RESULTSRC_ALU      2'b00   // Write back ALUResult (R-type, I-type ALU, U-type)
`define RESULTSRC_LOAD     2'b01   // Write back LoadData (Load instructions)
`define RESULTSRC_PCPLUS4  2'b10   // Write back PC+4 (JAL, JALR)

//=========================================================
// RV32I Opcode Encodings
// Used by Control Unit and instruction decode logic.
//=========================================================

`define RTYPE   7'b0110011   // R-type: ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
`define ITYPE   7'b0010011   // I-type ALU: ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
`define LOAD    7'b0000011   // Load: LB, LH, LW, LBU, LHU
`define STORE   7'b0100011   // Store: SB, SH, SW
`define BRANCH  7'b1100011   // Branch: BEQ, BNE, BLT, BGE, BLTU, BGEU
`define LUI     7'b0110111   // Load Upper Immediate
`define AUIPC   7'b0010111   // Add Upper Immediate to PC
`define JAL     7'b1101111   // Jump And Link
`define JALR    7'b1100111   // Jump And Link Register

//=========================================================
// ALU funct3 Encodings
// Used by ALU Decoder inside Control Unit.
//=========================================================

`define F3_ADD_SUB   3'b000   // ADD/SUB (R-type), ADDI (I-type)
`define F3_SLL       3'b001   // SLL, SLLI
`define F3_SLT       3'b010   // SLT, SLTI
`define F3_SLTU      3'b011   // SLTU, SLTIU
`define F3_XOR       3'b100   // XOR, XORI
`define F3_SRL_SRA   3'b101   // SRL/SRA, SRLI/SRAI
`define F3_OR        3'b110   // OR, ORI
`define F3_AND       3'b111   // AND, ANDI