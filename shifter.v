module shifter (T, // saida da ULA
					 shiftCtrl, // controle de qual deslocamento deve ser feito
					 Result // resultado do deslocamento
					 );

// declaracao dos tipos de dados
input [15:0] T;
input [1:0] shiftCtrl;
output wire [15:0] Result;

reg [15:0] res;

assign Result = res;

// Parametros de shift
parameter [1:0] 	NOSHIFT         = 2'b00,
						LOGICALRIGHT    = 2'b01,
						SHIFTLEFT       = 2'b10,
						ARITHMETICRIGHT = 2'b11;
						
// bloco always para a realizacao dos documentos
always @(T or shiftCtrl)
	begin
		case(shiftCtrl)
			NOSHIFT: res = T;
			LOGICALRIGHT: res = T >> 1;
			SHIFTLEFT: res = T << 1;
			ARITHMETICRIGHT:
				begin
					res = T >> 1;
					res[15] = T[15];
					res[14] = 1'b0;
				end
		endcase
	end
endmodule	