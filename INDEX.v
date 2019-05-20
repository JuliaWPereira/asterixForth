module INDEX
#(parameter DATA_WIDTH=16)
(
	input [DATA_WIDTH-1:0] newData,
	input write_clock,
	input read_clock,
	output reg [DATA_WIDTH-1:0] data
);
	
	reg [DATA_WIDTH-1:0] INDEX;
	
	always @(posedge write_clock)
		begin
			INDEX <= newData;
		end 
	
	always @(posedge read_clock)
		begin
			data <= INDEX;
		end 
endmodule 