module memoriaDePrograma
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=5)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] q
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	initial
	begin
			ram[0] <= 16'b1000000000000000;
			/* PUSH */ ram[1] <= 16'b0000000000000110;
			/* PUSH */ ram[2] <= 16'b0000000000000001;
			/* ADD  */ ram[3] <= 16'b1000100000000000;
			ram[4] <= 16'b1110000000000000;
	end
	
	always @ (posedge write_clock)
	begin
		// Write
		if (we)
			ram[write_addr] <= data;
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		q <= ram[read_addr];
	end
endmodule
