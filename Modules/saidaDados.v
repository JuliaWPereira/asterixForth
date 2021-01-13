module saidaDados
#(parameter DATA_WIDTH=16)
(
	//input imprimeSaida,
	input [DATA_WIDTH-1:0] data,
	output a_dm,b_dm,c_dm,d_dm,e_dm,f_dm,g_dm, // display dezena de milhar
	output a_um,b_um,c_um,d_um,e_um,f_um,g_um, // display unidade de milhar
	output a_c,b_c,c_c,d_c,e_c,f_c,g_c, // display centena
	output a_d,b_d,c_d,d_d,e_d,f_d,g_d, // display dezena
	output a_u,b_u,c_u,d_u,e_u,f_u,g_u // display unidade
);

	wire [3:0] dezenaMilhar;
	wire [3:0] unidadeMilhar;
	wire [3:0] centena;
	wire [3:0] dezena;
	wire [3:0] unidade;
	
	binarioParaBCD conversorBCD(data,dezenaMilhar,unidadeMilhar,centena,dezena,unidade);
	
	BCDpara7segmentos displayDezenaMilhar(dezenaMilhar,a_dm,b_dm,c_dm,d_dm,e_dm,f_dm,g_dm);
	
	BCDpara7segmentos displayUnidadeMilhar(unidadeMilhar,a_um,b_um,c_um,d_um,e_um,f_um,g_um);
	
	BCDpara7segmentos displayCentena (centena,a_c,b_c,c_c,d_c,e_c,f_c,g_c);
	
	BCDpara7segmentos displayDezena (dezena,a_d,b_d,c_d,d_d,e_d,f_d,g_d);
	
	BCDpara7segmentos displayUnidade (unidade,a_u,b_u,c_u,d_u,e_u,f_u,g_u);
	
endmodule 