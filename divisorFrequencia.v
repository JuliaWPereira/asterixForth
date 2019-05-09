// A frequencia de entrada eh de 50MHz e a saida eh de 1Hz
module divisorFrequencia(
							input clock_in, // clock in sera o clk_read
							output clock_out // clock out sera o clk_write
						  );
						  
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd50000000;

assign clock_out = (counter<DIVISOR/2)?1'b0:1'b1;

always @(posedge clock_in)
begin
	counter <= counter + 28'd1;
	if(counter>=(DIVISOR-1)) counter <= 28'd0;
end
endmodule 