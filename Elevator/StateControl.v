module StateControl(arrive,Dest_up,Dest_down,wait1,wait2,close_in,open_in,open_out,Floor,up,down,wait1n,wait2n,waitn,reset);
	parameter n = 20;
	input[n-1:0] Dest_up,Dest_down;
   input wait1,wait2;
	input reset;
	input close_in,open_in;								//在电梯外控制电梯关门，在电梯内控制电梯关门和开门
	input[n-1:0] open_out;
	input arrive;											//用于指示当前电梯是否到达所选楼层
	output[4:0] Floor;
	output up,down,wait1n,wait2n,waitn;
   reg up,down,wait1n,wait2n;
	reg[1:0] state;
	reg[4:0] Floor;
	assign waitn = wait1n|wait2n;
	parameter ups = 2'd0,
				 downs = 2'd1,
				 waits = 2'd2;
	always@(Dest_up or Dest_down or wait1 or wait2 or reset or close_in or open_in or open_out or arrive)
	begin
		if(reset)
		begin
			up = 0; 
			down = 0;
			wait1n = 0;
			wait2n = 0;
			Floor = 0;
			state = waits;
		end
		else
		case(state)
		ups:		if(wait1 == 0&&arrive == 1)
					begin
						state = waits;
						up = 0;
						down = 0;
						wait2n = 1;
						wait1n = 0;
						Floor = Floor+1;
					end
					else if(wait1 == 0)
						begin
							state = ups;
							up = 1;
							down = 0;
							wait1n = 1;
							wait2n = 0;
							Floor = Floor+1;
						end
		downs:	if(wait1 == 0&&arrive == 1)
					begin
						state = waits;
						up = 0;
						down = 0;
						wait2n = 1;
						wait1n = 0;
						Floor = Floor-1;
					end
					else if(wait1 == 0)
						begin
							state = downs;
							up  = 0;
							down = 1;
							wait1n = 1;
							wait2n = 0;
							Floor = Floor-1;
						end
		waits:	if((wait2 == 0||close_in)&&Dest_up != 0)
					begin
						state = ups;
						up = 1;
						down  = 0;
						wait1n = 1;
						wait2n = 0;
					end
					else if((wait2 == 0||close_in)&&Dest_down != 0)
					begin
						state = downs;
						down = 1;
						up = 0;
						wait1n = 1;
						wait2n = 0;
					end
					else if((open_in == 1||open_out[Floor] == 1)&&arrive == 1)
					begin
						state = waits;
						up = 0;
						down = 0;
						wait1n = 0;
						wait2n = 1;
					end
		default:begin
						state = waits;
						up = 0;
						down = 0;
						wait1n = 0;
						wait2n = 1;
					end
		endcase	
	end
endmodule