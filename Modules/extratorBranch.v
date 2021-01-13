module extratorBranch
#(parameter ADDR_WIDTH=16)
(
	input [ADDR_WIDTH-1:0] instrucao,
	output [10:0] offset
);

	assign offset = instrucao[10:0];
	
endmodule 