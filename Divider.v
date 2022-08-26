module divider(bus_in,clk,rst,start,bus_out,done,zero_flag,overflow_flag);
	input [4:0]bus_in;
	input clk,rst,start;
	output [4:0]bus_out;
	output done,zero_flag,overflow_flag;
	wire selA,selB,ldA,ldB,ldQ,shL,sel_out,init_counter,inc_counter,Co,MSB;
	wire [4:0]out;
	data_path DATA_PATH(bus_in,selA,selB,selTRI,ldA,ldB,ldQ,shL,sel_out,init_counter,inc_counter,clk,rst,out,tri_in,zero_flag,overflow_flag,MSB,Co);
	controller CONTROLLER(MSB,zero_flag,overflow_flag,Co,start,clk,rst,selA,selB,ldA,ldB,ldQ,shL,sel_out,init_counter,inc_counter,selTRI,done);
	assign bus_out = out;
endmodule
