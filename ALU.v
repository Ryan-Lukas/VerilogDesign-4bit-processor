
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
