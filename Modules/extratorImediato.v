module extratorImediato
#(parameter DATA_WIDTH=16,parameter ADDR_WIDTH=16)
(
	input [ADDR_WIDTH-1:0] instrucao,
	output [DATA_WIDTH-1:0] imediato
);

	assign imediato = instrucao;
	
endmodule 