module register_file(
	input logic clk, rst,
	input logic [4:0] A1, A2, A3,
	input logic [31:0] WD3,
	input logic WE3,
	output logic [31:0] RD1, RD2, probe
);
	
	reg[31:0] registers [31:0];
	initial begin
		for(int i = 0; i < 32; i++) begin
			registers[i] <= i;
		end
	end
	
	assign RD1 = registers[A1];
	assign RD2 = registers[A2];
	assign probe = registers[A3];
	
	always @(posedge clk or negedge rst)
		if(!rst) begin
			for(int i = 0; i < 32; i++) begin
				registers[i] <= i;
			end
		end
		else if(WE3) begin;
			#1;
			registers[A3] <= WD3;
		end
			
							
endmodule
