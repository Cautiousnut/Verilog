module Elevator(clk,up_request,down_request,in_request,reset,Floor,up,down,waitn,open_in,open_out,close_in);
	parameter n = 20;
	input clk;
	input[n-1:0] up_request,down_request;
	input[4:0] in_request;
	input reset;
	input open_in,close_in;
	input[n-1:0] open_out;
	output up,down,waitn;
	output[4:0] Floor;
	wire[n-1:0]Dest_up,Dest_down;
	wire wait1,wait2;
	wire wait1n,wait2n;
	wire arrive;
	Selectfloor #(n) A(up_request,down_request,in_request,Floor,Dest_up,Dest_down,reset,arrive);
	StateControl #(n)	B(arrive,Dest_up,Dest_down,wait1,wait2,close_in,open_in,open_out,Floor,up,down,wait1n,wait2n,waitn,reset);
	Count	C(clk,wait1n,wait2n,wait1,wait2,reset);
endmodule