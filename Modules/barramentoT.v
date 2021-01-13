module barramentoT
#(parameter DATA_WIDTH=16)
(
	input [DATA_WIDTH-1:0] top,
	output [DATA_WIDTH-1:0] outputT
);

assign outputT = top;

endmodule 