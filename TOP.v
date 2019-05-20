module TOP
#(parameter DATA_WIDTH=16)
(
	input [DATA_WIDTH-1:0] newData,
	input write_clock,
	input read_clock,
	output reg [DATA_WIDTH-1:0] data
);
	
	reg [DATA_WIDTH-1:0] TOP;
	
	always @(posedge write_clock)
		begin
			TOP <= newData;
		end 
	
	always @(posedge read_clock)
		begin
			data <= TOP;
		end 
endmodule 