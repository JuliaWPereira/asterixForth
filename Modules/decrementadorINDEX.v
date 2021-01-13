module decrementadorINDEX
#(parameter DATA_WIDTH=16)
(
	input [DATA_WIDTH-1:0] index,
	output wire [DATA_WIDTH-1:0] indexDecrementado
);

	assign indexDecrementado= index - 16'b0000000000000001;

endmodule 