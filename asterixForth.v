module asterixForth
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=16)
(
	input pushButtonEntrada, // botao para enter da entrada
	input pushButtonReset, // botao para resetar o processador
	input read_clock, // clock do FPGA
	input sw15,
	input sw14,
	input sw13,
	input sw12,
	input sw11,
	input sw10,
	input sw9,
	input sw8,
	input sw7,
	input sw6,
	input sw5,
	input sw4,
	input sw3,
	input sw2,
	input sw1,
	input sw0, // switches
			
	output a_dm,b_dm,c_dm,d_dm,e_dm,f_dm,g_dm, // display dezena de milhar
	output a_um,b_um,c_um,d_um,e_um,f_um,g_um, // display unidade de milhar
	output a_c,b_c,c_c,d_c,e_c,f_c,g_c, // display centena
	output a_d,b_d,c_d,d_d,e_d,f_d,g_d, // display dezena
	output a_u,b_u,c_u,d_u,e_u,f_u,g_u // display unidade
);

	/* Sinais de controle */
	wire branch; // usado no contadorDoPrograma
	wire haltES; // usado no contadorDoPrograma para segura-lo ate ter entrada
	wire we_memProg; // Escrita/Leitura da memoria de programa
	wire [4:0] funct; // usado na selecao da funcao da ULA
	wire [1:0] shiftCtrl; // usado na ULA para definir o deslocamento
	wire flagZ; // resultado da ULA para ver se o resultado eh zero
	wire seletorMuxTorNEXT; // usado no multiplexador de t or NEXT
	wire [1:0] seletorNEXT; // usado no multiplexador de NEXT
	wire overflowDados; // saida da pilha de dados para overflow
	wire underflowDados; // saida da pilha de dados para underflow
	wire emptyDados; // saida da pilha de dados para pilha vazia
	wire we_pilhaDados; // Pop/Push da pilha de Dados
	wire seletorMuxG; // usado no multiplexador G
	wire [1:0] seletorES; // usado no gerenciador de E/S
	wire atualizaEntrada; // flag para ler entrada
	wire atualizaSaida; // flag para ler saida
	wire [1:0] seletorINDEX; // seleciona a origem do index
	wire ehPilhaAtiva; // informa se a pilha ativa eh a de dados ou a de retorno
	wire we_pilhaRetorno; // Pop/Push da pilha de Retorno
	wire overflowRetorno; // saida da pilha de retorno para overflow
	wire underflowRetorno; // saida da pilha de retorno para underflow
	wire emptyRetorno; // saida da pilha de retorno para pilha vazia
	wire [2:0] seletorY; // usado no muxY
	
	/* Juncao dos switches em um vetor */
	wire [DATA_WIDTH-1:0] entrada_switches;
	assign entrada_switches = {sw15,sw14,sw13,sw12,sw11,sw10,sw9,sw8,
										sw7,sw6,sw5,sw4,sw3,sw2,sw1,sw0};
	
	/* Variaveis */
	wire write_clock;
	wire enter;
	wire reset;
	wire [ADDR_WIDTH-1:0] read_addr;
	wire [DATA_WIDTH-1:0] instrucao;
	wire [10:0] offset;
	wire [DATA_WIDTH-1:0] dataMemProg; // variavel nao sera utilizada ainda
	wire [ADDR_WIDTH-1:0] write_addr; // tambem nao eh utilizado ainda, posi nao escrevemos na memoria de programa nesse lab
	wire [DATA_WIDTH-1:0] reg_TOP; // registrador que armazena o topo da pilha
	wire [DATA_WIDTH-1:0] ULA_result; // resultado da ULA
	wire [DATA_WIDTH-1:0] Y; // resultado do barramento Y
	wire [DATA_WIDTH-1:0] T; // resultado do barramento T
	wire [DATA_WIDTH-1:0] reg_NEXT; // registrador do segundo elemento da pilha
	wire [DATA_WIDTH-1:0] TorNEXT; // resultado do muxTorNEXT
	wire [DATA_WIDTH-1:0] dataNEXT; // resultado do multiplexador de NEXT 
	wire [DATA_WIDTH-1:0] popPilhaDados; // resultado do pop da pilha de dados
	wire [DATA_WIDTH-1:0] G; // resultado da multiplexacao de muxG
	wire [DATA_WIDTH-1:0] reg_ENTRADA; // registrador que armazena a entrada dos switches
	wire [DATA_WIDTH-1:0] reg_SAIDA; // registrador que armazena a saida dos displays de 7seg
	wire [DATA_WIDTH-1:0] popPilhaRetorno; // resultado do pop da pilha de retorno
	wire [DATA_WIDTH-1:0] indexDecrementado; // index decrementado de 1
	wire [DATA_WIDTH-1:0] reg_INDEX; // registrador do INDEX
	wire [DATA_WIDTH-1:0] I; // resultado muxINDEX
	wire [DATA_WIDTH-1:0] reg_NC; // acumulador NC
	wire [DATA_WIDTH-1:0] reg_MD; // acumulador MD
	wire [DATA_WIDTH-1:0] reg_SR; // acumulador SR
	wire [DATA_WIDTH-1:0] imediatoE; // armazenado em entrada
	wire [DATA_WIDTH-1:0] imediato; // imediato da instrucao
	wire [DATA_WIDTH-1:0] imediatoORinst; // resultado do MUX entre instrucao e imediato
	wire seletorMUXimeORist; // seletor do MUX entre instrucao e imediato
	
	
	/* Modulo da Unidade de controle */
	unidadeDeControle UDC(instrucao,branch,haltES,we_memProg,funct,shiftCtrl,
								 seletorMuxTorNEXT,seletorNEXT,we_pilhaDados,seletorMuxG,
								 seletorES,seletorINDEX,ehPilhaAtiva,we_pilhaRetorno,seletorY);
	
	/* Modulo de divisao de frequencia para o clock do processador*/
	divisorFrequencia divFreq(read_clock,write_clock);
	
	/* Modulos de debounce dos botoes enter e reset*/
	debounce debounceEntrada(pushButtonEntrada,read_clock,enter);
	debounce debounceReset(pushButtonReset,read_clock,reset);
	
	/* Modulo para a extracao do offset da instrucao */
	extratorBranch extratorB(instrucao,offset);
	
	/* Modulo de extracao do imediato */
	extratorImediato extratorI(instrucao,imediato);
	
	/* Modulo de multiplexacao entre imediato e instrucao */
	muxInstORIme muxIorI(instrucao,imediato,seletorMUXimeORist,imediatoORinst );
	
	/* Modulo do Contador do Programa */
	contadorDoPrograma PC(write_clock,read_clock,branch,offset,reset,haltES,read_addr);
	
	/* Modulo da Memoria de Programa */
	memoriaDePrograma memPrograma(dataMemProg,read_addr,write_addr,we_memProg,read_clock,
											write_clock,instrucao);
	
	/* Modulo do registrador de topo da pilha */
	TOP top(ULA_result,write_clock,read_clock,reg_TOP);
	
	/* Modulo da Unidade Logico-Aritmetica */
	ulaComShifter ula(reg_TOP,Y,funct,shiftCtrl,flagZ,ULA_result);
	
	/* Modulo do barramento T */
	barramentoT tBus(reg_TOP,T);
	
	/* Modulo de Multiplexacao entre T e NEXT */
	muxTorNEXT muxTNEXT(reg_TOP,reg_NEXT,seletorMuxTorNEXT,TorNEXT);
	
	/* Modulo de Multiplexacao do NEXT */
	muxNEXT muxN(popPilhaDados,instrucao,TorNEXT,seletorNEXT,dataNEXT);
	
	/* Modulo do registrador do segundo elemento da pilha de dados */
	NEXT next(dataNEXT,write_clock,read_clock,reg_NEXT);
	
	/* Modulo da Pilha de Dados */
	pilhaDeDados dataStack(reg_NEXT,reset,we_pilhaDados,read_clock,write_clock,
								  popPilhaDados,overflowDados,underflowDados,emptyDados);
	
	/* Modulo do barramento de Entrada e Saida */
	muxG muxG(reg_ENTRADA,reg_NEXT,seletorMuxG,G);
	
	/* Modulo de gerenciamento de Entrada e Saida */
	gerenciadorES gES(seletorES,enter,atualizaEntrada,atualizaSaida);
	
	/* Modulo do registrador de entrada */
	registradorEntrada regEntrada(imediato,atualizaEntrada,write_clock,
											read_clock,reg_ENTRADA);
											
	/* Modulo de entrada de dados dos switches */
	entradaSwitches switches(entrada_switches,enter,read_clock,imediatoE,haltES);
											
	/* Modulo do registrador de saida */
	registradorSaida regSaida(G,atualizaSaida,write_clock,read_clock,reg_SAIDA);
	
	/* Modulo da saida de dados */
	saidaDados saida(reg_SAIDA,a_dm,b_dm,c_dm,d_dm,e_dm,f_dm,g_dm,
				  a_um,b_um,c_um,d_um,e_um,f_um,g_um,
				  a_c,b_c,c_c,d_c,e_c,f_c,g_c,
				  a_d,b_d,c_d,d_d,e_d,f_d,g_d,
				  a_u,b_u,c_u,d_u,e_u,f_u,g_u);
	
	/* Modulo de multiplexacao do INDEX */
	muxINDEX muxI(read_addr,T,popPilhaRetorno,indexDecrementado,seletorINDEX,I);
	
	/* Modulo de decremento do INDEX */
	decrementadorINDEX decINDEX(reg_INDEX,indexDecrementado);
	
	/* Modulo do registrar INDEX */
	index index(I,ehPilhaAtiva,write_clock,read_clock,reg_INDEX);
	
	/* Modulo da pilha de retorno */
	pilhaDeRetorno returnStack(reg_INDEX,reset,we_pilhaRetorno,read_clock,write_clock,
										popPilhaRetorno,overflowRetorno,underflowRetorno,emptyRetorno);
	
	/* Modulo do barramento do Y */
	muxY muxy(reg_NEXT,reg_NC,reg_MD,reg_SR,G,imediatoORinst,read_addr,reg_INDEX,seletorY,Y);
	
endmodule 