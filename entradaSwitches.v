module entradaSwitches
(
	input [15:0] switches,
	input enter,
	input clk_read,
	output reg [15:0] imediato,
	output espera
);

	wire apertouBotao;

	debounce debounce(.botao(enter),.clk_read(clk_read),.clk_out(apertouBotao));

	always @(posedge clk_read)
	begin
		if(apertouBotao) imediato <= switches;
	end
	
	assign espera = ~ apertouBotao;

endmodule 