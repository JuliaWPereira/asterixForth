module gerenciadorES
#(
  parameter DATA_WIDTH=16,
  parameter ENTRADA=2'b11,
  parameter SAIDA=2'b10,
  parameter TBUS=1'b0,
  parameter GBUS=1'b1
 )
 
(
	input [1:0] seletorES, //seletor de entrada, saida ou nada
	input seletorTG, // seletor de tBus ou gBus
	input [DATA_WIDTH-1:0] tBus,
	input [DATA_WIDTH-1:0] gBus,
	input [DATA_WIDTH-1:0] switches,
	input write_clock,
	input read_clock,
	output reg [DATA_WIDTH-1:0] saidaGbus,
	output a_dm,b_dm,c_dm,d_dm,e_dm,f_dm,g_dm, // display dezena de milhar
	output a_um,b_um,c_um,d_um,e_um,f_um,g_um, // display unidade de milhar
	output a_c,b_c,c_c,d_c,e_c,f_c,g_c, // display centena
	output a_d,b_d,c_d,d_d,e_d,f_d,g_d, // display dezena
	output a_u,b_u,c_u,d_u,e_u,f_u,g_u // display unidade
);
	
	// registradores de entrada e saida
	wire [DATA_WIDTH-1:0] entrada;
	wire [DATA_WIDTH-1:0] saida;

	// definicao do controle de entrada
	wire atualizaEntrada;
	assign atualizaEntrada = (seletorES == ENTRADA)? 1'b1:1'b0;
	
	// definicao do controle de saida
	wire atualizaSaida;
	assign atualizaSaida = (seletorES == SAIDA)? 1'b1:1'b0;
	
	// definicao do controle do dado utilizado
	wire [DATA_WIDTH-1:0] data;
	assign data = (seletorES == ENTRADA)? switches : (seletorTG == TBUS)? tBus : gBus;
	
	// chamadas dos modulos de entrada e saida
	registradorEntrada regEntrada(data,atualizaEntrada,write_clock,read_clock,entrada);
	registradorSaida regSaida(data,atualizaSaida,write_clock,read_clock,saida);
	saidaDados saida7segmentos(saida,a_dm,b_dm,c_dm,d_dm,e_dm,f_dm,g_dm,
												a_um,b_um,c_um,d_um,e_um,f_um,g_um,
												a_c,b_c,c_c,d_c,e_c,f_c,g_c,
												a_d,b_d,c_d,d_d,e_d,f_d,g_d,
												a_u,b_u,c_u,d_u,e_u,f_u,g_u
									   );
	
	always @(posedge write_clock)
		begin
			if(seletorES == ENTRADA) saidaGbus <= entrada;
			else saidaGbus <= gBus;
		end
endmodule 