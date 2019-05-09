module contadorDoPrograma
#(parameter ADDR_WIDTH=16)
(
	input write_clock,
	input read_clock,
	input branch,
	input [10:0] offset, // fazer um extensor de cadeia para a soma?
	input reset,
	output reg [(ADDR_WIDTH - 1):0] output_addr
);

// Extensao do offset para soma
	wire
	[(ADDR_WIDTH - 1):0] offset_ext;
	assign offset_ext = {5'b00000,offset};

// Declaracao para o registrador
	reg [(ADDR_WIDTH-1):0] PC;
	
// Bloco always para reset do PC e para atualizaçao do valor de PC
	always @(posedge write_clock)
	begin
		if(reset == 1) PC = 16'b00000000000000000;
		else if(branch == 1) PC <= PC + offset_ext;
		else PC <= PC + 16'b00000000000000001;
	end 
	always @(posedge read_clock)
	begin
		output_addr <= PC;
	end
endmodule 