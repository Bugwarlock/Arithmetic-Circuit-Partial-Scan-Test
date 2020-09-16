`timescale 1 ns/ 100 ps

`define	RESET			0
`define	WAIT_ON_START	1
`define	CALC_NEXT_TERM_1	2
`define	CALC_NEXT_TERM_2	3
`define	CALC_NEXT_TERM_3	4
`define	ADD_NEW_TERM		5
`define	CALC_COMPLETE		6



module fourFuncEngine	( clk, rst, start, func, x, busy, addr, tableData, resultIPart, resultFPart );
			
	parameter F_WIDTH = 8;
	parameter NUM_OF_TERMS = 8; 
	parameter CNT_WIDTH = 4;

	input	clk;
	input	rst;
	input	start;
	input [1:0] func;
	input  [F_WIDTH - 1:0] x;
	output 	busy;
	output [CNT_WIDTH - 1:0] addr;
	input  [F_WIDTH - 1: 0 ] tableData;
	output [1:0 ] resultIPart;
	output [F_WIDTH - 1: 0 ]resultFPart;
	
	reg [F_WIDTH - 1:0] registerdX;
	reg [F_WIDTH - 1:0] term;
	reg [1:0 ] resultIPart;
	reg [F_WIDTH - 1: 0 ]resultFPart; 
	
	wire [F_WIDTH * 2  - 1: 0 ] multResult;
	reg [F_WIDTH - 1: 0 ] multRInput;
	wire [F_WIDTH + 1: 0] addResult,subResult;
	reg [CNT_WIDTH - 1:0] counter;
	wire [31:0] zeros;

	
	reg addsub;
	reg loadInput;
	reg rstInput;
	reg loadTerm;
	reg initTerm;
	reg rstTerm;
	reg selTableData;
	reg rstResultRegs;
	reg initResultRegs;
	reg loadResultRegs;
	reg incCounter;
	reg rstCounter;
	reg initCounter;
	reg busy;
	reg negateAddSubReg;
	
	reg [2:0] pState, nState;

//=========================================================================================================================	
//Datapath
//=========================================================================================================================	
	//input register
	always @(posedge clk ) begin
		if( rstInput )
			registerdX <= 0;
		else if( loadInput )
			registerdX <= x;
	end
	
	//Term register: register storing one of terms in Tailor series
	always  @( posedge clk ) begin
		if( rstTerm )
			term <= 0;
		else if( initTerm ) begin
			term <= (func[0]==1'b1)? 32'hFFFFFFFF : {zeros[31:F_WIDTH],x} ;
			end
		else if( loadTerm )
			term <= multResult [F_WIDTH * 2  - 1: F_WIDTH ];		
	end
	
	//Multiplexer on the right input of the multiplier
	always @( selTableData or tableData or registerdX ) begin
		if( selTableData )
			multRInput <= tableData;
		else
			multRInput <= registerdX;
	end
		
	//Multiplier
	
	assign 	multResult = term * multRInput ;
	
	//Adder
	assign addResult = term + { resultIPart, resultFPart };
	assign subResult = { resultIPart, resultFPart } - term;
	//Registers storing integral part and fractional parts of the result
	always @(posedge clk ) begin
		if( rstResultRegs )
			{ resultIPart, resultFPart } <= 0;
		else if( initResultRegs ) begin
			resultIPart <= (func[0]==1'b1) ? 1 : 0;	
            resultFPart <= (func[0]==1'b1) ? 0 : x;				
        end
		else if( loadResultRegs )
			{ resultIPart, resultFPart } <= (addsub==1'b1) ?addResult : subResult;
	end
	
	//Counter
	always @(posedge clk ) begin
		if( rstCounter )
			counter <= 0;
		else if ( initCounter )
			counter <= 1;
		else if( incCounter )
			counter <= counter + 1;
	end
	
	assign addr = counter;
	assign zeros=		32'h00000000;
//=========================================================================================================================	
//Controller
//=========================================================================================================================	

	
	always @( pState or rst or start or counter ) begin
		nState <= `RESET;
		loadInput <= 1'b0;
		rstInput <= 1'b0;
		loadTerm <= 1'b0;
		rstTerm <= 1'b0;
		initTerm <= 1'b0;
		selTableData <= 1'b0;
		rstResultRegs <= 1'b0;
		initResultRegs <= 1'b0;
		loadResultRegs <= 1'b0;
		initResultRegs <= 1'b0;
		incCounter <= 1'b0;
		rstCounter <= 1'b0;
		initCounter <= 1'b0;
		busy <= 1'b1;
		negateAddSubReg <= 1'b0;

		case ( pState )
			`RESET : begin
				//addsub <= 1'b0;
				rstInput <= 1'b1;
				rstTerm  <= 1'b1;
				rstResultRegs  <= 1'b1;
				rstCounter  <= 1'b1;
				busy <= 1'b0;
				if( rst )
					nState <= `RESET;
				else
					nState <= `WAIT_ON_START;
			end
			
			`WAIT_ON_START: begin
				busy <= 1'b0;				
				if( start ) begin
					loadInput <= 1'b1;
					initResultRegs <= 1'b1;
					initTerm <= 1'b1;
					initCounter <= 1'b1;
					nState <= `CALC_NEXT_TERM_1;
				end
				else
					nState <= `WAIT_ON_START;
			end
			
			`CALC_NEXT_TERM_1: begin
			    negateAddSubReg <= 1'b1;
				selTableData <= 1'b1;
				loadTerm <=1'b1;
				nState <= `CALC_NEXT_TERM_2;
			end
			
			`CALC_NEXT_TERM_2: begin
				loadTerm <=1'b1;
				nState <= `CALC_NEXT_TERM_3;
			end
			
			`CALC_NEXT_TERM_3: begin
				loadTerm <=1'b1;
				incCounter <= 1'b1;
				nState <= `ADD_NEW_TERM;
			end
			
			`ADD_NEW_TERM: begin
				loadResultRegs <= 1'b1;
				if( counter < NUM_OF_TERMS )
					nState <= `CALC_NEXT_TERM_1;
				else
					nState <= `CALC_COMPLETE;
			end
			
			`CALC_COMPLETE: begin
				busy <= 1'b0;
				nState <= `WAIT_ON_START;
			end
		
		endcase
		
	end


	always @(posedge clk ) begin
		if( rst )
			pState <= `RESET;
		else
			pState <= nState;
	end

	always @(posedge clk ) begin
	if( pState== `WAIT_ON_START )
		addsub <= 1'b1;
	else if(negateAddSubReg == 1'b1)
	  if(func[1]==1'b0)
		addsub <= (~addsub);
	end
	

	
endmodule
	  
	  