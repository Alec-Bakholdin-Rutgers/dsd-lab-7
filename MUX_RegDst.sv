module MUX_RegDst(
    input logic RegDst,
    input logic[31:0] Instr,
    output logic[5:0] RegDst_out
);

    assign RegDst_out = RegDst ? Instr[15:11] : Instr[20:16];

endmodule
