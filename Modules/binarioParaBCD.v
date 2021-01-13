module binarioParaBCD 
(
	input [15:0] binario,
	output reg [3:0] dezenaMilhar,
	output reg [3:0] unidadeMilhar,
	output reg [3:0] centena,
	output reg [3:0] dezena,
	output reg [3:0] unidade
);
			
	integer i;
	
	always @ (binario)
	begin
		dezenaMilhar = 4'd0;
		unidadeMilhar = 4'd0;
		centena = 4'd0;
		dezena = 4'd0;
		unidade = 4'd0;
		
		for(i = 15; i>=0; i=i-1)
		begin
			if(dezenaMilhar >= 5)
				dezenaMilhar = dezenaMilhar + 4'd3;
			if(unidadeMilhar >= 5)
				unidadeMilhar = unidadeMilhar + 4'd3;
			if(centena >= 5)
				centena = centena + 4'd3;
			if (dezena >= 5)
				dezena = dezena + 4'd3;
			if (unidade >= 5)
				unidade = unidade + 4'd3;
				
			dezenaMilhar = dezenaMilhar << 1;
			dezenaMilhar[0] = unidadeMilhar[3];
				
			unidadeMilhar = unidadeMilhar << 1;
			unidadeMilhar[0] = centena[3];
			
			centena = centena << 1;
			centena[0] = dezena[3];
			
			dezena = dezena << 1;
			dezena[0] = unidade[3];
			
			unidade = unidade << 1;
			unidade[0] = binario[i];
		end	
	end
endmodule 