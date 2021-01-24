module ROM(addr,data);


input [3:0] addr;
output reg [7:0] data;
parameter [3:0] S0= 8'd0, S1 = 8'd1, S2 = 8'd2,S3 =  8'd3, S4 =  8'd4, S5 =  8'd5,  S6 =  8'd6, S7 =  8'd7, S8 =  8'd8, S9 =  8'd9,
	S10= 8'd10, S11 = 8'd11, S12 = 8'd12,S13 =  8'd13, S14 =  8'd14, S15 =  8'd15;
always@(*)begin
	case(addr)
		S0: data = 8'b00000001;
		
		S1: data = 8'b00010001;
		
		S2: data = 8'b00100001;
		
		S3: data = 8'b00110001;
		
		S4: data = 8'b11000100; //1+1
		
		S5: data = 8'b11001000; //2+1
		
		S6: data = 8'b11001100; //3+1
		
		S7: data = 8'b01000000;
		
		
	default:begin end
	
	endcase
end

endmodule

