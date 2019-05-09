module pilhaDeDados
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data,
	input reset,
	input we, read_clock, write_clock,
	output reg [(DATA_WIDTH-1):0] q,
	output overflow, underflow, empty
);
	
	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [DATA_WIDTH-1:0] TOS;
	
	assign overflow = (TOS > 2**ADDR_WIDTH);
	assign underflow = (TOS == 16'b1111111111111111);
	assign empty = (TOS == 16'b00000000000000000);
	
	always @ (posedge write_clock)
	begin
		if(reset == 1)
			TOS <= 16'b00000000000000000;
		// Write
		else if (we)
			begin
				ram[TOS] <= data;
				TOS <= TOS + 16'b00000000000000001;
			end
		else
			begin
				TOS <= TOS - 16'b00000000000000001;
			end
	end
	
	always @ (posedge read_clock)
	begin
		// Read 
		q <= ram[TOS - 16'b00000000000000001];
		
	end
	
endmodule 