module ula (T, // operando-1 relativo ao topo da pilha
				Y, // operando-2 relativo ao barramento de Y
				funct, // funcao a ser executada pela ULA
//				enable32, // flag para tratar o dado como long
				flagC, //// flag para carry bit
				flagZ, // flag para denotar valor zero no teste
				Result
				);

// Definicao dos tipos de parametro
	input [15:0] T; // operando 1 de 16 bits
	input [15:0] Y; // operando 2 de 16 bits
	input [4:0] funct; // opcode da operacao
//	input enable32; // flag de dado long
	output reg flagC; // flag de carry
	output wire flagZ; // flag de zero
	output [15:0] Result; // resultado da operacao
	
	reg [15:0] res; // dado tipo reg para atriuicoes
	
	assign Result = res; // atribui o resultado calculado ao output
	assign flagZ = (res == 16'b0); // verifica se o resultado eh nulo
	
// Rotulos das funcoes da ULA
	parameter [4:0] 	BYPASST = 5'b00000,
							AND 	  = 5'b00100,
							SUB     = 5'b01000,
							OR      = 5'b01100,
							ADD     = 5'b10000,
							XOR     = 5'b10100,
							NSUB    = 5'b11000,
							BYPASSY = 5'b11100,
							MULT    = 5'bxxx10,
							DIV     = 5'bxxx01;
				//			SQRT    = 5'bxxx11;

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
			//SQRT: res <= T; // arrumar
			default: res = T; // mantem o topo da pilha no topo
		endcase
	end
endmodule
