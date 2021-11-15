module PC(
	input logic clk, rst,
    input logic[2:0] instruction_A,
    input logic RegWrite, MemWrite,

    output logic[31:0] probe_register_file,
    output logic[31:0] probe_data_memory
);
    logic[31:0] instruction;
    instruction_memory instruction_memory_inst(clk, rst, instruction_A, instruction);

    // parsing opcode
    logic[5:0] opcode;
    assign opcode = instruction[31:26];
    logic RegDst, ALUSrc, MemtoReg;
    logic[2:0] ALUControl;
    assign RegDst = opcode[5];
    assign ALUSrc = opcode[4];
    assign ALUControl = opcode[3:1];
    assign MemtoReg = opcode[0];

    // register_file variables
    logic[31:0] RD1, RD2, WD3;
    logic[4:0] A1, A2, A3;
    assign A1 = instruction[25:21];
    assign A2 = instruction[20:16];
    MUX_RegDst MUX_RegDst_inst(RegDst, instruction, A3);
    register_file register_file_inst(clk, rst, A1, A2, A3, WD3, RegWrite, RD1, RD2, probe_register_file);

    // sign_extend variables
    logic[15:0] low_16_bits;
    logic[31:0] SignImm;
    assign low_16_bits = instruction[15:0];
    sign_extend sign_extend_inst(low_16_bits, SignImm);

    // ALU variables
    logic[31:0] SrcA, SrcB, ALUResult;
    assign SrcA = RD1;
    MUX_ALUSrc MUX_ALUSrc_inst(ALUSrc, RD2, SignImm, SrcB);
    ALU ALU_inst(SrcA, SrcB, ALUControl, ALUResult);

    // data_memory variables
    logic[4:0] A;
    logic[31:0] WD, RD;
    assign A = ALUResult;
    assign WD = RD2;
    data_memory data_memory_inst(clk, rst, A, WD, MemWrite, RD, probe_data_memory);

    // MemtoReg MUX
    MUX_MemtoReg MUX_MemtoReg_inst(MemtoReg, ALUResult, RD, WD3);

endmodule
