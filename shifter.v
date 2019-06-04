module shifter 
#(
	parameter 			DATA_WIDTH 		 = 16,
	parameter [1:0] 	NOSHIFT         = 2'b00,
	parameter [1:0]	LOGICALRIGHT    = 2'b01,
	parameter [1:0]	SHIFTLEFT       = 2'b10,
	parameter [1:0]	ARITHMETICRIGHT = 2'b11
)
(
	input [15:0] T, // saida da ULA
   input [1:0] shiftCtrl, // controle de qual deslocamento deve ser feito
   output wire [DATA_WIDTH-1:0] Result // resultado do deslocamento
);

	reg [15:0] res;

	assign Result = res;

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
				default: res = T;
			endcase
		end
endmodule	