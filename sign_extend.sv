module sign_extend(
    input logic[15:0] Imm,
    output logic[31:0] SignImm
);
    int intImm;
	 assign intImm = shortint'(Imm);
    assign SignImm = intImm;

endmodule
