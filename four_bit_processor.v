module four_bit_processor(Clock,SingleStep,ButtonForSingleStep,Reset,OpCode,StoreLights);

input Clock,SingleStep,ButtonForSingleStep,Reset;
input [7:0] OpCode;
output [3:0]StoreLights;

wire [7:0] addr,opFromRom,Opcode;
tri[3:0] BUS;
wire [3:0] Registers_enable,R0_wire_in, R0_wire_out,R1_wire_in,R1_wire_out,R2_wire_in,R2_wire_out,R3_wire_in,R3_wire_out, Store_wire_in,Rx_wire_in,
	Rx_wire_out,Ry_wire_in,Ry_wire_out,Alu_wire_out,Data,Registers_in,Registers_out;
	
wire [1:0] Alu_control;	
wire Store_enable,Rx_enable,Ry_enable,Store_in,Data_ctrl,Ry_in_tri,Rx_in_tri,Alu_out,Done,isRomDone;


//I,Clock,Q,Enable
Register R0(R0_wire_in,Clock,R0_wire_out,Registers_enable[0:0]);
Register R1(R1_wire_in,Clock,R1_wire_out,Registers_enable[1:1]);
Register R2(R2_wire_in,Clock,R2_wire_out,Registers_enable[2:2]);
Register R3(R3_wire_in,Clock,R3_wire_out,Registers_enable[3:3]);

Register Store(Store_wire_in,Clock,StoreLights,Store_enable);

Register Rx(Rx_wire_in,Clock,Rx_wire_out,Rx_enable);
Register Ry(Ry_wire_in,Clock,Ry_wire_out,Ry_enable);

ALU a1(Rx_wire_out,Ry_wire_out,Alu_control,Alu_wire_out);

//	tristate_buffer(input_x, enable, output_x);
tristate_buffer Store_tri(BUS,Store_in,Store_wire_in);

tristate_buffer R0_tri_in(BUS,Registers_in[0:0],R0_wire_in);
tristate_buffer R0_tri_out(R0_wire_out,Registers_out[0:0],BUS);

tristate_buffer R1_tri_in(BUS,Registers_in[1:1],R1_wire_in);
tristate_buffer R1_tri_out(R1_wire_out,Registers_out[1:1],BUS);

tristate_buffer R2_tri_in(BUS,Registers_in[2:2],R2_wire_in);
tristate_buffer R2_tri_out(R2_wire_out,Registers_out[2:2],BUS);

tristate_buffer R3_tri_in(BUS,Registers_in[3:3],R3_wire_in);
tristate_buffer R3_tri_out(R3_wire_out,Registers_out[3:3],BUS);

tristate_buffer Data_line(Data,Data_ctrl,BUS);

tristate_buffer Rx_tri(BUS,Rx_in_tri,Rx_wire_in);
tristate_buffer Ry_tri(BUS,Ry_in_tri,Ry_wire_in);

tristate_buffer ALU_tri(Alu_wire_out,Alu_out,BUS);

PCCounter p1(Done,Reset,addr,isRomDone);
ROM r1(addr,opFromRom);

mux m1(OpCode,opFromRom,SingleStep,Opcode);

ControlCircuit c1(.Clock(Clock),.Reset(Reset),.isRomDone(isRomDone),.execute(ButtonForSingleStep),.single(SingleStep),.Opcode(Opcode),.Registers_in(Registers_in),.Registers_out(Registers_out),
	.Registers_enable(Registers_enable),.DataOut(Data),.Alu_control(Alu_control),.Data_ctrl(Data_ctrl),.Done(Done),.Rx_in_tri(Rx_in_tri),.Ry_in_tri(Ry_in_tri),
		.Rx_enable(Rx_enable),.Ry_enable(Ry_enable),.Alu_out(Alu_out),.Store_in(Store_in),.Store_enable(Store_enable));




	
endmodule















































/*
input Clock,SingleStep,ButtonForSingleStep,Reset;
input[7:0] OpCode;
output [3:0] StoreLights;

wire [7:0] ActualOpcode,opfromrom;
wire [3:0] BUS,Registers_enable,Registers_in,Registers_out,R0_wire_in,R0_wire_out,R1_wire_in,R1_wire_out,R2_wire_in,
	R2_wire_out,R3_wire_in,R3_wire_out,Store_wire_in,Alu_wire_out,addr,data,Rx_wire_out,Ry_wire_out,AluRx_wire,AluRy_wire;
wire [1:0] Alu_control;
wire Store_enable,Rx_enable,Ry_enable,Done,Rx_in_tri,Ry_in_tri,AluRx,AluRy,Alu_out,Store_in,isRomDone,Data_ctrl;
	

	Register R0(R0_wire_in,Clock,R0_wire_out,Registers_enable[0:0]);
	Register R1(R1_wire_in,Clock,R1_wire_out,Registers_enable[1:1]);
	Register R2(R2_wire_in,Clock,R2_wire_out,Registers_enable[2:2]);
	Register R3(R3_wire_in,Clock,R3_wire_out,Registers_enable[3:3]);
	
	Register Rx(Rx_wire_in,Clock,Rx_wire_out,Rx_enable);
	Register Ry(Ry_wire_in,Clock,Ry_wire_out,Ry_enable);
	
	Register Store(Store_wire_in,Clock,StoreLights,Store_enable);
	
	ALU a1(AluRx_wire,AluRy_wire,Alu_control,Alu_wire_out);
	
	PCCounter p1(Done,Reset,addr,isRomDone);
	ROM r1(addr,opfromrom);
	
	mux m1(OpCode,opfromrom,SingleStep,ActualOpcode);
	
	tristate_buffer R0_in(BUS, Registers_in[0:0], R0_wire_in);	
	tristate_buffer R0_out(R0_wire_out, Registers_out[0:0], BUS);	
	
	tristate_buffer R1_in(BUS, Registers_in[1:1], R1_wire_in);	
	tristate_buffer R1_out(R1_wire_out, Registers_out[1:1], BUS);	
	
	tristate_buffer R2_in(BUS, Registers_in[2:2], R2_wire_in);	
	tristate_buffer R2_out(R2_wire_out, Registers_out[2:2], BUS);

	tristate_buffer R3_in(BUS, Registers_in[3:3], R3_wire_in);	
	tristate_buffer R3_out(R3_wire_out, Registers_out[3:3], BUS);	
	
	tristate_buffer Rx_in(BUS, Rx_in_tri, Rx_wire_in);	
	tristate_buffer Ry_in(BUS, Ry_in_tri, Ry_wire_in);	
	
	
	tristate_buffer AluRx_in(Ry_wire_out, AluRx, AluRx_wire);	
	tristate_buffer AluRy_in(Ry_wire_out, AluRy, AluRy_wire);	
	
	tristate_buffer AluOut(Alu_wire_out, Alu_out, BUS);

	tristate_buffer DataIn(data, Data_ctrl, BUS);
	
	tristate_buffer Store_tri(BUS, Store_in, Store_wire_in);
	
		
	ControlCircuit c1(.Clock(Clock),.Reset(Reset),.isRomDone(isRomDone),.execute(ButtonForSingleStep),.single(SingleStep),.Opcode(ActualOpcode),
		.Registers_in(Registers_in),.Registers_out(Registers_out), .Registers_enable(Registers_enable),.DataOut(data),.Alu_control(Alu_control),
		.Data_ctrl(Data_ctrl),.Done(Done),.Rx_in_tri(Rx_in_tri),.Ry_in_tri(Ry_in_tri),.Rx_enable(Rx_enable),.Ry_enable(Ry_enable),.AluRx(AluRx),
		.AluRy(AluRy),.Alu_out(Alu_out),.Store_in(Store_in),.Store_enable(Store_enable));
		
		
		always@(Alu_wire_out)begin
			$display("%b",Alu_wire_out);
		end
*/