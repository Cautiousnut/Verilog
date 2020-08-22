module Count(clk,wait1n,wait2n,wait1,wait2,reset);
	input clk;
	input wait1n,wait2n,reset;
	output wait1,wait2;
	reg wait10,wait20,clkn;										//中间变量，用于记录wait1n,wait2n,clk变化之前的值
	reg[2:0] m,n;
	always@(reset or wait1n or wait2n or clk)
	begin
		if(reset)
		begin
			m <= 0;
			n <= 0;
			wait10 = 0;
			wait20 = 0;
			clkn = 0;
		end
		else if(wait1n!=wait10)
			  begin
					if(wait1n)m <= 0;
					wait10 = wait1n;
			  end
		else if(wait2n!=wait20)
			  begin
					if(wait2n)n <= 0;
					wait20 = wait2n;
			  end
		else if(clk!=clkn)
			  begin
					if(clk)
					begin
						m <= m+1;
						n <= n+1;
						if(m == 3'd2)m <= 0;
						if(n == 3'd5)n <= 0;
					end
					clkn = clk;
			  end
	end
	assign wait1 = (m == 3'd2)?1:0;
	assign wait2 = (n == 3'd5)?1:0;
endmodule