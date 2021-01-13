module muxInstORIme
#(parameter DATA_WIDTH=16,parameter ADDR_WIDTH=16)
(
	input [ADDR_WIDTH-1:0] instrucao,
	input [DATA_WIDTH-1:0] imediato,
	input seletor,
	output [DATA_WIDTH-1:0] imediatoORinst
);
	reg [DATA_WIDTH-1:0] res; 
	assign imediatoORinst = res;

	always @(*)
		begin
			case(seletor)
			1'b0: res = instrucao;
			1'b1: res = imediato;
			endcase
		end
	
endmodule 