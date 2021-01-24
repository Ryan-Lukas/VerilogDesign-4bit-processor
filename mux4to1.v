module mux4to1 (w0, w1, w2, w3, S, f);
	input [3:0] w0, w1, w2, w3;
	input [1:0] S;
	output [3:0]f;
	assign f = S[1] ? (S[0] ? w3 : w2) : (S[0] ? w1 : w0);
	

endmodule

module mux(op1,op2,s,f);
	input [7:0] op1,op2;
	input s;
	output [7:0] f;
	assign f = s ? op2 :op1;
endmodule
