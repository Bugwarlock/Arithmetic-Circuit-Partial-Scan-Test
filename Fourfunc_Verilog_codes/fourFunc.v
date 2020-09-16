`timescale 1 ns/ 100 ps



module fourFunc ( clk, rst, start, func, x, busy, resultIPart, resultFPart );
	
	parameter F_WIDTH = 8;
	parameter NUM_OF_TERMS = 8; 
	parameter CNT_WIDTH = 4;
	
	input	clk;
	input	rst;
	input	start;
	input [1:0] func;
	input  [F_WIDTH - 1:0] x;
	output 	busy;
	output [1:0 ] resultIPart;
	output [F_WIDTH - 1: 0 ]resultFPart;

	wire [CNT_WIDTH - 1:0] addr;
	wire  [F_WIDTH - 1: 0 ] tableData;

	
	
	fourFuncEngine #( F_WIDTH, NUM_OF_TERMS, CNT_WIDTH )
				fourFuncEngine1( clk, rst, start,func, x, busy, addr, tableData, resultIPart, resultFPart );
				
	Table	#( CNT_WIDTH, F_WIDTH )
			Table1( func[0],addr, tableData );
					
endmodule
	 