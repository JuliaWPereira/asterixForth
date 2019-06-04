module ulaComShifter
#(
  parameter DATA_WIDTH=16,
  parameter FUNCT_WIDTH=5
 )
(
	input [DATA_WIDTH-1:0] T,
	input [DATA_WIDTH-1:0] Y,
	input [FUNCT_WIDTH-1:0] funct,
	input [1:0] shiftCtrl,
	output wire flagZ,
	output [DATA_WIDTH-1:0] Result
);
	wire [DATA_WIDTH-1:0] res;
	wire [DATA_WIDTH-1:0] res2;
	
	ula ula(T,Y,funct,flagZ,res);
	shifter shifter(res,shiftCtrl,res2);
	
	assign Result = res2;
endmodule 