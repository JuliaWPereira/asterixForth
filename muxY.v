module muxY(yN, // registrador NEXT
				yNC, // acumulador NEXT com carry
				yMD, // acumulador para multiplicacao e divisao
				ySR, // acumulador de raiz quadrada
				yGBUS, // barramento de E/S
				yR, // instrucao vigente
				yPC, // contador do programa
				yINDEX, // topo da pilha de retorno
				selectY, // seletor do Y utilizado
				Yout // saida da multiplexacao
				);
		 
input [15:0] yN, yNC, yMD, ySR, yGBUS, yR, yPC, yINDEX;
input [2:0] selectY;
output wire [15:0] Yout;

reg [15:0] res;

assign Yout = res;

// Definicao das possibilidades de Y
parameter [2:0]	N     = 3'b000, // next - segundo elemento da pilha vigente
						NC    = 3'b001, // acumulador next com carry bit
						MD    = 3'b010, // acumulador de multiplicacao e divisao
						SR    = 3'b011, // acumulador de raiz quadrada
						GBUS  = 3'b100, // toma o Y vindo do barramento de entrada/saida de dados
						R     = 3'b101, // toma o Y como a instrucao corrente
						PC    = 3'b110, // toma o Y como o PC
						INDEX = 3'b111; // toma o Y como o topo da pilha de retorno
// bloco always
always @(*)
	begin
		case(selectY)
			N: res = yN;
			NC: res = yNC;
			MD: res = yMD;
			SR: res = ySR;
			GBUS: res = yGBUS;
			R: res = yR;
			PC: res = yPC;
			INDEX: res = yINDEX;
		endcase 
	end 
endmodule 