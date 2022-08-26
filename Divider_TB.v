`timescale 1ns/1ns
module Divider_TB ();
	reg [5:0]A;
	reg clk=0,rst=0,start=0;
	wire [5:0]Result;
	wire done;
	divider DIVIDE(A,clk,rst,start,Result,done);
	always #20 clk<=~clk;
	initial begin
		/* in 3 cycle we give the input to our component
			and we expect to get the result in 2 clock cycle*/
		/* 45 / 12
			the result we expect: 9,3*/
		#30 start = 1'b1;
		#31 start = 1'b0;
		#20 A = 5'b01101;
		#40 A = 5'b00001;
		#40 A = 5'b01100;
		/* 42 / 7
			the result we expect: 0,6*/
		#1190 start = 1'b1;
		#31 start = 1'b0;
		#20 A = 5'b01010;
		#40 A = 5'b00001;
		#40 A = 5'b00111;
		/* 212 / 2
			the result we expect: overflow_flag*/
		#1190 start = 1'b1;
		#31 start = 1'b0;
		#20 A = 5'b10100;
		#40 A = 5'b00110;
		#40 A = 5'b00010;
		/* 180 / 0
			the result we expect: zero_flag and overflow_flag
				note that because the condition of overflow is A >= Q
					so anytime we divide a number by zero
						the overflow_flag also rise*/
		#1190 start = 1'b1;
		#31 start = 1'b0;
		#20 A = 5'b10100;
		#40 A = 5'b00101;
		#40 A = 5'b00000;
		#1500 $stop;
	end
endmodule
