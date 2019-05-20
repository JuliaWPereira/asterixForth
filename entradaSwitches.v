module entradaSwitches
(
	input [15:0] switches,
	input enter,
	input clk_read,
	output reg [15:0] imediato,
	output espera
);

	always @(posedge clk_read)
	begin
		if(enter) imediato <= switches;
	end
	
	assign espera = ~ enter;

endmodule 