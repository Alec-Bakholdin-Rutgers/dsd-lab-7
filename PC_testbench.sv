module PC_testbench;

    logic clk = 0, instr_clk = 0, rst = 1, RegWrite, MemWrite;
    logic[2:0] instruction_A = 0;
    logic[31:0] target_instruction;
    logic[31:0] probe_register_file, probe_data_memory;
    
    instruction_memory instruction_memory_inst(instr_clk, rst, instruction_A, target_instruction);
    PC PC_inst(clk, rst, instruction_A, RegWrite, MemWrite, probe_register_file, probe_data_memory);

    logic [5:0] opcode, sw_opcode = 6'b010100;
    assign opcode = target_instruction[31:26];
    assign RegWrite = opcode != 0 & opcode != sw_opcode;
    assign MemWrite = opcode == sw_opcode;

    initial begin
        #1; rst = 0; #1; rst = 1;
    end

    always
        begin
            instr_clk = 0;
            clk = 0; #10;
            instruction_A = (instruction_A + 1) % 5;
            if(instruction_A == 0) begin
                #5; rst = 0; #1; rst = 1; #3;
            end
            else #9; 
            instr_clk = 1; #1;
            clk = 1; #20;
        end

endmodule
