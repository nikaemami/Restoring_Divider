module register6 (pi, clk, rst, load, po);
	input[5:0] pi;
	input clk, rst, load;
	output[5:0]po;
	reg[5:0]po;
	always @ (posedge clk, posedge rst)begin
	  if(rst)
	     po <= 6'd0;
	  else if(load)
	     po <= pi;
	end
endmodule

module shift_register5 (pi, ser_in, clk, rst, load, shL, po);
	input[4:0] pi;
	input clk, rst, load, shL, ser_in;
	output[4:0]po;
	reg[4:0]po;
	always @ (posedge clk, posedge rst)begin
	  if(rst)
	     po <= 5'd0;
	  else if(load)
	     po <= pi;
	  else if(shL)
	     po <= {po[3:0],ser_in};
	end
endmodule

module shift_register6 (pi, ser_in, clk, rst, load, shL, po);
	input[5:0] pi;
	input clk, rst, load, shL, ser_in;
	output[5:0]po;
	reg[5:0]po;
	always @ (posedge clk, posedge rst)begin
	  if(rst)
	     po <= 6'd0;
	  else if(load)
	     po <= pi;
	  else if(shL)
	     po <= {po[3:0],ser_in};
	end
endmodule

module adder(a,b,cin,sum,co);
	input [5:0]a,b;
	input cin;
	output [5:0]sum;
	output co;
	assign {co,sum}=a+b+cin;
endmodule

module add_sub(A, B, result);
	input[5:0]A,B;
	output[5:0]result;
	wire co;
	wire[5:0]out,complement;
	wire [5:0]C;
	assign C[5] = B[5] ^ ~A[5];
	assign C[4] = B[4] ^ ~A[5];
	assign C[3] = B[3] ^ ~A[5];
	assign C[2] = B[2] ^ ~A[5];
	assign C[1] = B[1] ^ ~A[5];
	assign C[0] = B[0] ^ ~A[5];
	adder ADD_2(C,{6'b0},~A[5],complement,co);
	adder ADD(A,complement,0,out,co);
	assign result=out;
endmodule

module mux2to1_5(a,b,s,w);
	input [4:0] a,b;
	input s;
	output [4:0]w;
	assign w=(~s)?a:
		 (s)?b:5'bx;
endmodule

module mux2to1_6(a,b,s,w);
	input [5:0] a,b;
	input s;
	output [5:0] w;
	assign w=(~s)?a:
		 (s)?b:6'bx;
endmodule

module divide_zero(Q,zero_flag);
	input[5:0]Q;
	output zero_flag;
	assign zero_flag = ~|Q;
endmodule

module comparator(A,Q,overflow_flag);
	input[5:0]A,Q;
	output overflow_flag;
	assign overflow_flag = (A >= Q)?1'b1:1'b0;
endmodule

module tri_state(tri_in,selTRI,tri_out);
	input [4:0]tri_in;
	input selTRI;
	output[4:0]tri_out;
	assign tri_out = (selTRI)?tri_in:5'bz;
endmodule

module up_counter(clk,rst,init_counter,inc_counter,Co);
	input clk,rst,init_counter,inc_counter;
	output Co;
	reg [2:0]count;
	always @(posedge clk)begin
		if(rst)
			count<=3'b0;
		else
			if(init_counter)
				count<=3'b0;
			else
				if(inc_counter)
					count<=count+1;
	end
	assign Co=(count==5)?1'b1:1'b0;
endmodule