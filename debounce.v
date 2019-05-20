module debounce
(
	input botao,
	input clk_read, 
	output clk_out
);

	reg Q1,Q2,Q3;

	assign clk_out = Q1 & Q2 & Q3;
	
	always @(posedge clk_read)
	begin
		Q1 <= botao;
		Q2 <= Q1;
		Q3 <= Q2;
	end
		
endmodule 