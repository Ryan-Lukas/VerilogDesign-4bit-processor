module ControlCircuit(Clock,Reset,isRomDone,execute,single,Opcode,Registers_in,Registers_out,
	Registers_enable,DataOut,Alu_control,Data_ctrl,Done,Rx_in_tri,Ry_in_tri,Rx_enable,Ry_enable,Alu_out,Store_in,Store_enable);

input Clock,Reset,isRomDone,execute,single;
input [7:0] Opcode;
output reg[3:0] Registers_in,Registers_out,Registers_enable,DataOut;
output reg[1:0] Alu_control;
output reg Data_ctrl,Done,Rx_in_tri,Ry_in_tri,Rx_enable,Ry_enable,Alu_out,Store_in,Store_enable;
reg [1:0] Op,Rx,Ry;
reg [4:0]NS,PS;


parameter [4:0] S0= 5'd0, S1 = 5'd1, S2 = 5'd2,S3 =  5'd3, S4 =  5'd4, S5 =  5'd5,  S6 =  5'd6, S7 =  5'd7, S8 =  5'd8, S9 =  5'd9,
	S10= 5'd10, S11 = 5'd11, S12 = 5'd12,S13 =  5'd13, S14 =  5'd14, S15 =  5'd15,  S16 =  5'd16, S17 =  5'd17, S18 =  5'd18, S19 =  5'd19,
	S20= 5'd20,S21 = 5'd21;
	
	
always @(posedge Clock,negedge Reset)begin
		
		if(Reset == 0 )begin
			PS <= S0;
			end
		else begin
			PS <= NS;
		end
end	
		
always@(*)begin	

		Registers_in = 4'b0000;
		Registers_out = 4'b0000;
		Registers_enable = 4'b0000;
		DataOut = Opcode[3:0];
		Alu_control = Opcode[1:0];
		Data_ctrl = 1'b0;
		Done = 1'b0;
		Rx_in_tri = 1'b0;
		Ry_in_tri = 1'b0;
		Rx_enable = 1'b0;
		Ry_enable = 1'b0;
		Alu_out = 1'b0;
		Store_in = 1'b0;
		Store_enable = 1'b0;
		case(PS)
			S0:begin
				if(single == 1'b0 )begin
					NS = S2;
					end
				else begin
					NS = S1;
					end
			end
			
			
			S1:if(!isRomDone)
				NS = S4;
				else NS = S1;
				
			S2: if(!execute)
					NS = S3;
				else NS = S2;
			
			S3:begin
					NS=S4;					
				end
				
			S4:begin
				if(Opcode[7:6] == 2'b00)
					NS = S5;
				else if(Opcode[7:6] == 2'b01)
					NS = S8;
				else if(Opcode[7:6] == 2'b10)
					NS = S10;
				else if(Opcode[7:6] == 2'b11)
					NS = S13;
				else NS = S4;
				end
				
			S5:NS =S6;
			
			S6:begin
				if(Opcode[5:4] == 2'b00)begin
					Registers_in = 4'b0001;
					Registers_enable =4'b0001;
					Data_ctrl =1'b1;
				end
				else if(Opcode[5:4] == 2'b01)begin
					Registers_in = 4'b0010;
					Registers_enable =4'b0010;
					Data_ctrl =1'b1;
				end	
				else if(Opcode[5:4] == 2'b10)begin
					Registers_in = 4'b0100;
					Registers_enable =4'b0100;
					Data_ctrl =1'b1;
				end
				else if(Opcode[5:4] == 2'b11)begin
					Registers_in = 4'b1000;
					Registers_enable =4'b1000;
					Data_ctrl =1'b1;
					
				end
				else NS = S6;
					//DataOut = Opcode[3:0];
					Done = 1'b1;
					NS = S7;
				end
				
			S7:begin
				Registers_in = 4'b0000;
				Registers_enable =4'b0000;
				Data_ctrl =1'b0;
				Done = 1'b0;
				NS = S0;
			end
			
			S8:begin
				if(Opcode[5:4] == 2'b00)begin
					Registers_out = 4'b0001;
					Store_in = 1'b1;
					Store_enable = 1'b1;
				end
				else if(Opcode[5:4] == 2'b01)begin
					Registers_out = 4'b0010;
					Store_in = 1'b1;
					Store_enable = 1'b1;
				end
				else if(Opcode[5:4] == 2'b10)begin
					Registers_out = 4'b0100;
					Store_in = 1'b1;
					Store_enable = 1'b1;
				end
				else if(Opcode[5:4] == 2'b11)begin
					Registers_out = 4'b1000;
					Store_in = 1'b1;
					Store_enable = 1'b1;
				end
				else NS = S8;
				
				Done = 1'b1;
				NS = S9;
			end
			
			S9:begin
				Registers_out = 4'b0000;
				Store_in = 1'b0;
				Store_enable = 1'b0;
				Done = 1'b0;
				NS = S0;
			end
			
			S10: NS = S11;
			
			S11:begin
				if(Opcode[3:2] == 2'b00)begin
					Registers_out = 4'b0001;
				end
				else if(Opcode[3:2] == 2'b01)begin
					Registers_out = 4'b0010;
				end
				else if(Opcode[3:2] == 2'b10)begin
					Registers_out = 4'b0100;
				end
				else if(Opcode[3:2] == 2'b11)begin
					Registers_out = 4'b1000;
				end
				else NS = S11;
				
				if(Opcode[5:4] == 2'b00)begin
					Registers_in = 4'b0001;
					Registers_enable =4'b0001;
				end
				else if(Opcode[5:4] == 2'b01)begin
					Registers_in = 4'b0010;
					Registers_enable =4'b0010;
				end	
				else if(Opcode[5:4] == 2'b10)begin
					Registers_in = 4'b0100;
					Registers_enable =4'b0100;
				end
				else if(Opcode[5:4] == 2'b11)begin
					Registers_in = 4'b1000;
					Registers_enable =4'b1000;
				end
				else NS = S11;
				
				Done = 1'b1;
				NS = S12;
				
			end
			
			S12:begin
				Registers_in = 4'b0000;
				Registers_out = 4'b0000;
				Registers_enable = 4'b0000;
				Done = 1'b0;
				NS = S0;
			end
			
			S13: NS = S14;
			
			S14:begin
					case (Opcode[5:4])
					
					2'b00 : 	begin
								Registers_out = 4'b0001;
								Rx_in_tri = 1'b1;
								Rx_enable = 1'b1;
								NS = S15;
								end
					2'b01 : 	begin
								Registers_out = 4'b0010;
								Rx_in_tri = 1'b1;
								Rx_enable = 1'b1;
								NS = S15;
								end
					2'b10 : 	begin
								Registers_out = 4'b0100;
								Rx_in_tri = 1'b1;
								Rx_enable = 1'b1;
								NS = S15;
								end
					2'b11 : 	begin
								Registers_out = 4'b1000;
								Rx_in_tri = 1'b1;
								Rx_enable = 1'b1;
								NS = S15;
								end
					default : NS = S14;
					endcase
			end
			
			S15:begin
				Rx_in_tri = 1'b0;
				Rx_enable = 1'b0;
				Registers_out = 4'b0000;
				NS = S16;
			end
			
			S16:begin
								case (Opcode[3:2])
					
					2'b00 : 	begin
								Registers_out = 4'b0001;
								Ry_in_tri = 1'b1;
								Ry_enable = 1'b1;
								NS = S17;
								end
					2'b01 : 	begin
								Registers_out = 4'b0010;
								Ry_in_tri = 1'b1;
								Ry_enable = 1'b1;
								NS = S17;
								end
					2'b10 : 	begin
								Registers_out = 4'b0100;
								Ry_in_tri = 1'b1;
								Ry_enable = 1'b1;
								NS = S17;
								end
					2'b11 : 	begin
								Registers_out = 4'b1000;
								Ry_in_tri = 1'b1;
								Ry_enable = 1'b1;
								NS = S17;
								end
					default : NS = S16;
					endcase
				
			end
			
			S17:begin
				Ry_in_tri = 1'b0;
				Ry_enable = 1'b0;
				Registers_out = 4'b0000;
				NS = S18;
			end
			
			S18:begin
				NS = S19;
			end
			
			S19:begin
				Alu_out = 1'b1;
				
				if(Opcode[5:4] == 2'b00)begin
					Registers_in = 4'b0001;
					Registers_enable =4'b0001;
				end
				else if(Opcode[5:4] == 2'b01)begin
					Registers_in = 4'b0010;
					Registers_enable =4'b0010;
				end	
				else if(Opcode[5:4] == 2'b10)begin
					Registers_in = 4'b0100;
					Registers_enable =4'b0100;
				end
				else if(Opcode[5:4] == 2'b11)begin
					Registers_in = 4'b1000;
					Registers_enable =4'b1000;
				end
				else NS = S19;
				
				Done = 1'b1;
				NS = S20;
			end
			
			S20:begin
				NS = S21;
			end
			
			S21:begin
				Alu_out = 1'b0;
				Registers_in = 4'b0000;
				Registers_enable = 4'b0000;
				Done = 1'b0;
				
				NS = S0;
			end
			
			default: NS = S0;
		endcase
		
	
		
end

endmodule
