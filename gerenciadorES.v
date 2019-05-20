module gerenciadorES
#(parameter DATA_WIDTH=16,
  parameter ENTRADA=2'b11,
  parameter SAIDA=2'b10
 )
(
	input [1:0] seletorES, //seletor de entrada, saida ou nada
	input enter, // pushButton pressionado
	output atualizaEntrada,
	output atualizaSaida
);
	// definicao do controle de entrada
	assign atualizaEntrada = ((seletorES == ENTRADA) && (enter == 1))? 1'b1:1'b0;
	
	// definicao do controle de saida
	assign atualizaSaida = (seletorES == SAIDA)? 1'b1:1'b0;
endmodule 