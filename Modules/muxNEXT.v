module muxNEXT
#(parameter DATA_WIDTH=16)
(
	input [DATA_WIDTH-1:0] popMemoriaDados,
	input [DATA_WIDTH-1:0] enderecoMemoriaProg,
	input [DATA_WIDTH-1:0] resMuxTorNEXT,
	input [1:0] selectNEXT,
	output wire [DATA_WIDTH-1:0] next
);

	reg [DATA_WIDTH-1:0] res;
	
	assign next = res;
	
	always @(*)
		begin
			case(selectNEXT)
				2'b00: res <= popMemoriaDados;
				2'b01: res <= resMuxTorNEXT;
				2'b11: res <= enderecoMemoriaProg;
				default: res <= resMuxTorNEXT;
			endcase 
		end
endmodule 