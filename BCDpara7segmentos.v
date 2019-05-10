module BCDpara7segmentos
(
	input [3:0] bcd,
	output a,b,c,d,e,f,g 
);

	reg [6:0] seteSegmentos;
	
	assign {a,b,c,d,e,f,g} = seteSegmentos;

	always @(*)
	begin
		case(bcd)
			 4'b0000: seteSegmentos = 7'b0000001;
			 4'b0001: seteSegmentos = 7'b1001111;
			 4'b0010: seteSegmentos = 7'b0010010;
			 4'b0011: seteSegmentos = 7'b0000110;
			 4'b0100: seteSegmentos = 7'b1001100;
			 4'b0101: seteSegmentos = 7'b0100100;
			 4'b0110: seteSegmentos = 7'b1100000;
			 4'b0111: seteSegmentos = 7'b0001111;
			 4'b1000: seteSegmentos = 7'b0000000;
			 4'b1001: seteSegmentos = 7'b0001100;
			 default: seteSegmentos = 7'b1111111;
			 endcase
	end
endmodule