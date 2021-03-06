module data_memory(
    input logic clk, rst,
    input logic[31:0] A, WD,
    input logic WE,

    output logic[31:0] RD, probe
);
    reg[31:0] memory [31:0];
	 initial begin
			for(int i = 0; i < 32; i++) begin
                memory[i] <= i;
			end
	 end
	 
    logic[4:0] low_5_bits;
    assign low_5_bits = A[4:0];
    
    assign RD = memory[low_5_bits];
    assign probe = memory[low_5_bits];

    always @(posedge clk or negedge rst)
    begin
        if(!rst) begin 
            for(int i = 0; i < 32; i++) begin
                memory[i] <= i;
            end
        end
        else if(WE) begin
		    #1;
            memory[low_5_bits] <= WD;
        end
    end

endmodule
