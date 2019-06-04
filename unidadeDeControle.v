module unidadeDeControle
#(parameter ADDR_WIDTH=16)
(
	
	input [ADDR_WIDTH-1:0] instrucao,
	
	output outbranch, // usado no contadorDoPrograma
	output outhaltES, // usado no contadorDoPrograma para segura-lo ate ter entrada
	output outwe_memProg, // Escrita/Leitura da memoria de programa
	output [4:0] outfunct, // usado na selecao da funcao da ULA
	output [1:0] outshiftCtrl, // usado na ULA para definir o deslocamento
	output outseletorMuxTorNEXT, // usado no multiplexador de t or NEXT
	output [1:0] outseletorNEXT, // usado no multiplexador de NEXT
	output outwe_pilhaDados, // Pop/Push da pilha de Dados
	output outseletorMuxG, // usado no multiplexador G
	output [1:0] outseletorES, // usado no gerenciador de E/S
	output [1:0] outseletorINDEX, // seleciona a origem do index 
	output ehPilhaAtiva, // indica a pilha ativa
	output outwe_pilhaRetorno, // Pop/Push da pilha de Retorno
	output [2:0] outseletorY // usado no muxY

);

	assign outbranch = 1'b0; // sem desvio
	assign outhaltES = 1'b0; // sem halt de leitura da entrada
	
	assign outwe_memProg = 1'b0; // apenas leitura
	
	assign outfunct = 4'b11100; // bypassT
	assign outshiftCtrl = 2'b00; // Desvia
	
	assign outseletorMuxTorNEXT = 1'b0; // copia T em NEXT
	assign outseletorNEXT = 2'b00; // mantem NEXT
	assign outseletorMuxG = 1'bx; // 
	assign outseletorINDEX = 2'bxx; // tbarramento 
	assign ehPilhaAtiva = 0;
	
	assign outseletorY = 3'b101; // segue do NEXT
	assign outseletorES = 2'b0x; // 
	
	assign outwe_pilhaDados = 1'b0; // escreve na pilha de retorno
	assign outwe_pilhaRetorno = 1'b0; // nao escreve na pilha de retorno
	
endmodule