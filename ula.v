module ula
#(
	parameter 			DATA_WIDTH = 16,
	parameter 			FUNCT_WIDTH= 5,
	parameter [4:0] 	BYPASST    = 5'b00000,
	parameter [4:0]	AND 	     = 5'b00100,
	parameter [4:0]	SUB        = 5'b01000,
	parameter [4:0]	OR         = 5'b01100,
	parameter [4:0]	ADD        = 5'b10000,
	parameter [4:0]	XOR        = 5'b10100,
	parameter [4:0]	NSUB       = 5'b11000,
	parameter [4:0]	BYPASSY    = 5'b11100,
	parameter [4:0]	MULT       = 5'bxxx10,
	parameter [4:0]	DIV        = 5'bxxx01
)
(
	input [DATA_WIDTH-1:0] T, // operando-1 relativo ao topo da pilha
	input [DATA_WIDTH-1:0] Y, // operando-2 relativo ao barramento de Y
	input [FUNCT_WIDTH-1:0] funct, // funcao a ser executada pela ULA
	output wire flagZ, // flag para denotar valor zero no resultado calculado
	output [DATA_WIDTH-1:0] Result // saida calculada 
);
	
	reg [15:0] res; // dado tipo reg para atriuicoes
	
	assign Result = res; // atribui o resultado calculado ao output
	assign flagZ = (res == 16'b0); // verifica se o resultado eh nulo
	
always @(T or Y or funct)
	begin
		casex(funct)
			BYPASST: res = T;
			AND: res = T & Y;
			SUB: res = T - Y;
			OR: res = T | Y;
			ADD: res = T + Y;
			XOR: res = T ^ Y;
			NSUB: res = Y - T;
			BYPASSY: res = Y;
			MULT: res = T * Y; 
			DIV: res = T / Y; 
			default: res = T; // mantem o topo da pilha no topo
		endcase
	end
endmodule
