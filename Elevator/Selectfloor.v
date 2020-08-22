module Selectfloor(up_request,down_request,in_request,Floor,Dest_up,Dest_down,reset,arrive);
	parameter n = 20;
	input[n-1:0] up_request,down_request;
	input[4:0] in_request;
	input[4:0] Floor;
	input reset;
	output[n-1:0] Dest_up,Dest_down;
	output arrive;
	reg arrive;
	reg [n-1:0] Dest_up,Dest_down;
	always@(up_request,down_request,in_request,Floor,reset)
	begin
		if(reset)	
		begin
			Dest_up = 20'd0;
			Dest_down = 20'd0;
			arrive = 1;
		end
		else
		begin
			if(in_request>Floor)Dest_up[in_request] = 1;
			else Dest_down[in_request] = 1;
			if(Dest_up[Floor] == 1)
			begin
				Dest_up[Floor] = 0;
				arrive = 1;
			end
			else if(Dest_down[Floor] == 1)
			begin
				Dest_down[Floor] = 0;
				arrive = 1;
			end
			else arrive = 0;
			Dest_up = Dest_up|up_request;
			Dest_down = Dest_down|down_request;
		end
	end
endmodule
