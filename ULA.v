module ULA(T, // Topo da pilha
			  Y, // Dado do barramento de Y
			  funct, // Funcao executada pela ULA
			  enable32, // Ativa que o dado deve ser tratado como 32 bits
			  shiftCtrl, // Controla se ha shift no dado resultante
//			  flagC, // flag que indica carry
//			  flagZ // flag que indica q o resultado da operacao eh zero
			  );

// Setup dos parametros da ULA
	input [15:0] Y;
	inout [15:0] T;
	reg [15:0] Result;
	
	input [4:0] funct;
	input enable32;
	input [1:0] shiftCtrl;
	
	assign T = Result;
	
// Definicao dos rotulos de funcao para facilitar a leitura
	parameter [4:0] BYPASST = 5'b00000,
						 AND 	   = 5'b00100,
						 SUB	   = 5'b01000,
						 OR 	   = 5'b01100,
						 ADD     = 5'b10000,
						 XOR     = 5'b10100,
						 NSUB    = 5'b11000,
						 BYPASSY = 5'b11100,
						 MULT    = 5'b00010,
						 DIV     = 5'b00001,
						 SQRT    = 5'b00011;
						 
// Definicao dos rotulos dos deslocamentos possiveis
	parameter [1:0] NOSHIFT    = 2'b00,
						 SHIFTRLOG  = 2'b01,
						 SHIFTLEFT  = 2'b10,
						 SHIFTRARIT = 2'b11;
						 
// Execucao do ciclo always, sensivel aos parametros e aos controles
	always @ (T or Y or funct or enable32 or shiftCtrl)
		begin
			case (funct)
				BYPASST: Result = T;				
				AND: Result = T & Y;
				SUB: 
					begin
						Result = T - Y;
//						flagC = Result[16];
					end
				OR: Result = T | Y;
				ADD: 
					begin
						Result = T + Y;
//						flagC = Result[16];
					end
				XOR: Result = T ^ Y;
				NSUB:
					begin
						Result = Y - T;
//						flagC = Result[16];
					end
				BYPASSY: Result = Y;
				MULT: Result = T * Y;
				DIV: Result = T / Y;
				SQRT: Result = T;
			endcase
			case(shiftCtrl)
				NOSHIFT: Result = Result;
				SHIFTRLOG: Result = Result >> 1;
				SHIFTLEFT: Result = Result << 1;
				SHIFTRARIT:
					begin
						Result = Result >> 1;
						Result[15] = Result[14];
						Result[14] = 1'b0;
					end
			endcase
		end
endmodule	