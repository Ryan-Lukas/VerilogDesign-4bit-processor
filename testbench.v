`timescale 1ns/1ps

module testbench;


reg Clock, SingleStep, ButtonForSingleStep,Reset;
reg [7:0] OpCode;
wire [3:0] StoreLights;

/*
reg [3:0] Rx,Ry;
reg [1:0] S;
wire [3:0] F;
*/
	//ALU UUT( Rx, Ry, S, F);

	four_bit_processor UUT(Clock,SingleStep,ButtonForSingleStep,Reset,OpCode,StoreLights);
 
initial begin 
	

	
	


	Clock = 0;
	Reset = 0;
	SingleStep = 0;
	ButtonForSingleStep = 1;
	#10;
	$display("Single Steping");
	Reset = 1;
	#10
	
	#10;
	OpCode = 8'b00000001; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	OpCode = 8'b00010010; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	OpCode = 8'b00100011; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	OpCode = 8'b00110100; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("R0-R3 contain 1-4");
	
	OpCode = 8'b01000000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R0: %b",StoreLights);
	
	OpCode = 8'b01010000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R1: %b",StoreLights);
	
	OpCode = 8'b01100000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R2: %b",StoreLights);
	
	
	OpCode = 8'b01110000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R3: %b",StoreLights);
	
	OpCode = 8'b10001100;
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Move R3 to R0");
	
	OpCode = 8'b01000000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R0: %b",StoreLights);
	
	
	OpCode = 8'b11011000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("2+3 = r1");
	
	OpCode = 8'b01010000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R1 should be 5: %b",StoreLights);
	
	
	Reset = 0;
	#10;
	
	Reset = 1;
	#10
	
	#10;
	OpCode = 8'b00000001; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	#10;
	OpCode = 8'b00010001; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	OpCode = 8'b11000100;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("1+1= r0");
	
	OpCode = 8'b01000000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R0 should be 2: %b",StoreLights);
	
	Reset = 0;
	#10;
	
	Reset = 1;
	#10
	
	#10;
	OpCode = 8'b00000001; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	#10;
	OpCode = 8'b00010001; 
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	OpCode = 8'b11000101;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("1-1= r0");
	
	OpCode = 8'b01000000;
	
	ButtonForSingleStep  = 0;
	#10;
	ButtonForSingleStep  = 1;
	#100;
	
	$display("Store R0 should be 0: %b",StoreLights);
	
	
	
	
	
	
	

	
	
	
	
	
	 
	 
	 
	 
	 
	 
	end
	always #5 Clock = ~Clock; 
endmodule
