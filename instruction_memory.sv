
module instruction_memory(
    input logic clk, rst,
    input logic[2:0] A,

    output logic[31:0] RD
);
    reg[31:0] instruction_regs[4:0] = '{default: 32'b0};

    // this is just to make sure that if someone inputs 5, 6, or 7 
    // (which are possible given logic[2:0]), that the output is defined
    logic[2:0] true_address;
    assign true_address = A > 4 ? 4 : A;

    always @(posedge clk or negedge rst)
    begin
        if(!rst) begin
            instruction_regs[0] <= 32'b0;
            instruction_regs[1] <= 32'b010101_00010_00001_0000000000000011;
            instruction_regs[2] <= 32'b010100_01000_00001_0000000000000001;
            instruction_regs[3] <= 32'b100100_00011_00100_00001_00000000000;
            instruction_regs[4] <= 32'b101100_01010_01000_00001_00000000000;
        end
        else begin
            RD <= instruction_regs[true_address];
        end
    end
endmodule
