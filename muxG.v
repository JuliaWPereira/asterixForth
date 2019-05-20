module muxG
#(parameter DATA_WIDTH=16)
(
	input [DATA_WIDTH-1:0] entrada, // registrador entrada
	input [DATA_WIDTH-1:0] next,
	input selectG,
	output wire [DATA_WIDTH-1:0] gBusOutput
);

	reg [DATA_WIDTH-1:0] res;
	
	assign gBusOutput = res;

	always @(*)
		begin
			case(selectG)
			1'b0: res = entrada;
			1'b1: res = next;
			endcase
		end
endmodule 