`define S0 4'd0
`define S1 4'd1
`define S2 4'd2
`define S3 4'd3
`define S4 4'd4
`define S5 4'd5
`define S6 4'd6
`define S7 4'd7
`define S8 4'd8
`define S9 4'd9
`define S10 4'd10
`define S11 4'd11
`define S12 4'd12
`define S13 4'd13

module controller(MSB,zero_flag,overflow_flag,Co,start,clk,rst,selA,selB,ldA,ldB,ldQ,shL,sel_out,init_counter,inc_counter,selTRI,done);
	input MSB,zero_flag,overflow_flag,Co,start,clk,rst;
	output selA,selB,ldA,ldB,ldQ,shL,sel_out,init_counter,inc_counter,selTRI,done;
	reg selA,selB,ldA,ldB,ldQ,shL,sel_out,init_counter,inc_counter,selTRI,done;
	reg [3:0] ps,ns;
	always @(posedge clk)begin
		if(rst)
			ps <= `S0;
		else
			ps <= ns;
	end
	always @(ps,start)begin
		ns=`S0;
		case(ps)
			`S0:ns = start?`S1:`S0;
			`S1:ns = `S2;
			`S2:ns = `S3;
			`S3:ns = `S4;
			`S4:ns = (zero_flag|overflow_flag)?`S0:`S5;
			`S5:ns = `S6;
			`S6:ns = MSB?`S8:`S7;
			`S7:ns = `S11;
			`S8:ns =`S9;
			`S9:ns = `S10;
			`S10:ns = `S11;
			`S11:ns = Co?`S12:`S5;
			`S12:ns = `S13;
			`S13:ns = `S0;
			default:ns = `S0;
		endcase
	end
	always @(ps)begin
		{selA,selB,ldA,ldB,ldQ,shL,sel_out,done,init_counter,inc_counter,selTRI}=11'd0;
		case(ps)
			`S0:;
			`S1:{selB,ldB} = 2'b01;
			`S2:{selA,ldA}=2'b01;
			`S3:ldQ = 1'b1;
			`S4:init_counter = 1'b1;
			`S5:shL = 1'b1;
			`S6:;
			`S7:{selA,selB,ldA,ldB,inc_counter} = 5'b11111;
			`S8:{selA,ldA} = 2'b11;
			`S9:;
			`S10:{selA,ldA,inc_counter} = 3'b111;
			`S11:;
			`S12:{selTRI,sel_out,done}=3'b101;
			`S13:{selTRI,sel_out,done}=3'b111;
		endcase
	end
endmodule
