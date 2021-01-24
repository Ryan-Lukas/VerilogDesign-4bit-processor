module PCCounter (Done,Reset,addr,isRomDone);
input Done,Reset;
output reg [3:0] addr;
output reg isRomDone;

always@(posedge Done)begin
	if(Reset == 1)
		addr <= 4'b0000;
	else
		addr <= addr+1;
		
	if(addr < 4'b1111)
		isRomDone <= 1'b0;
	else
		isRomDone <= 1'b1;
end

endmodule
