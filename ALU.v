
module ALU ( A, B, S, F);
input [1:0] S;
input [3:0] A, B;
output reg [3:0] F;
always @(S, A, B)
case (S)
2'b00: F = A + B;
2'b01: F = A - B;
2'b10: F = A & B;
2'b11: F = !A;
endcase

endmodule












/*

module ALU(Rx,Ry,S,Out);

input [3:0] Rx,Ry;
input[1:0] S;
output[3:0] Out;
wire Cout;

wire [3:0] add,sub,andop,notop;


	always@(*)begin
		case(S)
			2'b00: Out <= Rx + Ry;
			
			2'b01: Out <= Rx - Ry;
			
			2'b10: Out <= Rx & Ry;
			
			2'b11: Out <= !Rx;
		endcase
	end 	

	
fourbitRCA u1(Rx,Ry,add);

subtractor u2(Rx,Ry,sub);

andOp u3(Rx,Ry,andop);

notOp u4(Rx,notop);

mux4to1 u5(add,sub,andop,notop, S, Out);


endmodule
*/
