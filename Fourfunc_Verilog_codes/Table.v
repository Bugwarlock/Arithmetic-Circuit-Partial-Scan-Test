`timescale 1 ns/ 100 ps

module Table ( func,addr, tableData );
	
	parameter ADDR_WIDTH = 4;
	parameter F_WIDTH = 8;
	
	input func;
	input [ADDR_WIDTH - 1:0] addr;
	output [F_WIDTH - 1: 0 ] tableData;
	
	wire [ADDR_WIDTH :0] addr_table;
	reg [31:0]temp;
	
	
	assign addr_table = (func==1'b1) ? {1'b0,addr} : {1'b1,addr};
	always @( addr_table ) begin
		temp <= 0;
		case ( addr_table )
			0: temp <=  32'h00000000;
			1: temp <=  32'h80000000;  //Fixed point representation of 1/1*1/2
			2: temp <=  32'h15555555;  //Fixed point representation of 1/3*1/4
			3: temp <=  32'h08888889;  //Fixed point representation of 1/5*1/6						 
			4: temp <=  32'h04924925 ; //Fixed point representation of 1/7*1/8
			5: temp <=  32'h02D82D83;  //Fixed point representation of 1/9*1/10
			6: temp <=  32'h01F07C1F;  //Fixed point representation of 1/11*1/12
			7: temp <=  32'h01681681;  //Fixed point representation of 1/13*1/14
			8: temp <=  32'h01111111;  //Fixed point representation of 1/15*1/16
			9: temp <=  32'h00D62B81;  //Fixed point representation of 1/17*1/18
			10: temp<=  32'h00AC7692;  //Fixed point representation of 1/19*1/20
			11: temp<=  32'h008DDA52;  //Fixed point representation of 1/21*1/22
			12: temp<=  32'h0076B982;  //Fixed point representation of 1/23*1/24
		  13: temp<=  32'h0064D31A;  //Fixed point representation of 1/25*1/26
			14: temp<=  32'h0056B016;  //Fixed point representation of 1/27*1/28
			15: temp<=  32'h004B5428;  //Fixed point representation of 1/29*1/30
			16: temp<=  32'h00421084;  //Fixed point representation of 1/31*1/32
			17: temp<=  32'h003A68F5;  //Fixed point representation of 1/33*1/34
			18: temp<=  32'h00340340;  //Fixed point representation of 1/35*1/36
			19: temp<=  32'h002E9C96;  //Fixed point representation of 1/37*1/38
			20: temp<=  32'h002A02A0;  //Fixed point representation of 1/39*1/40
			21: temp<=  32'h00260EDE;  //Fixed point representation of 1/41*1/42
			22: temp<=  32'h0022A373;  //Fixed point representation of 1/43*1/44
			23: temp<=  32'h001FA8EF;  //Fixed point representation of 1/45*1/46
			24: temp<=  32'h001D0CB6;  //Fixed point representation of 1/47*1/48
			25: temp<=  32'h001ABFD8;  //Fixed point representation of 1/49*1/50
			26: temp<=  32'h0018B640;  //Fixed point representation of 1/51*1/52
		  27: temp<=  32'h0016E60F;  //Fixed point representation of 1/53*1/54
			28: temp<=  32'h00154726;  //Fixed point representation of 1/55*1/56
			29: temp<=  32'h0013D2C7;  //Fixed point representation of 1/57*1/58
			30: temp<=  32'h00128354;  //Fixed point representation of 1/59*1/60
			31: temp<=  32'h00115412;  //Fixed point representation of 1/61*1/62
			32: temp <=  32'hFFFFFFFF; //Fixed point representation of 1/1
			33: temp <=  32'h2AAAAAAB;  //Fixed point representation of 1/2*1/3
			34: temp <=  32'h0CCCCCCD;  //Fixed point representation of 1/4*1/5
			35: temp <=  32'h06186186;  //Fixed point representation of 1/6*1/7						 
			36: temp <=  32'h038E38E4; //Fixed point representation of 1/8*1/9
			37: temp <=  32'h0253C825;  //Fixed point representation of 1/10*1/11
			38: temp <=  32'h01A41A42;  //Fixed point representation of 1/12*1/13
			39: temp <=  32'h01381381;  //Fixed point representation of 1/14*1/15
			40: temp <=  32'h00F0F0F1;  //Fixed point representation of 1/16*1/17
			41: temp <=  32'h00BFA030;  //Fixed point representation of 1/18*1/19
			42: temp<=   32'h009C09C1;  //Fixed point representation of 1/20*1/21
			43: temp<=   32'h0081848E;  //Fixed point representation of 1/22*1/23
			44: temp<=   32'h006D3A07;  //Fixed point representation of 1/24*1/25
		  45: temp<=   32'h005D5B2B;  //Fixed point representation of 1/26*1/27
			46: temp<=   32'h0050B599;  //Fixed point representation of 1/28*1/29
			47: temp<=   32'h00467804;  //Fixed point representation of 1/30*1/31
			48: temp<=   32'h003E0F84;  //Fixed point representation of 1/32*1/33
			49: temp<=   32'h00371280;  //Fixed point representation of 1/34*1/35
			50: temp<=   32'h00313382;  //Fixed point representation of 1/36*1/37
			51: temp<=   32'h002C38A9;  //Fixed point representation of 1/38*1/39
			52: temp<=   32'h0027F602;  //Fixed point representation of 1/40*1/41
			53: temp<=   32'h002449B6;  //Fixed point representation of 1/43*1/42
			54: temp<=   32'h00211957;  //Fixed point representation of 1/45*1/44
			55: temp<=   32'h001E500B;  //Fixed point representation of 1/47*1/46
			56: temp<=   32'h001BDD2C;  //Fixed point representation of 1/49*1/48
			57: temp<=   32'h0019B34D;  //Fixed point representation of 1/51*1/50
			58: temp<=   32'h0017C786;  //Fixed point representation of 1/53*1/52
		  59: temp<=   32'h001610E5;  //Fixed point representation of 1/55*1/54
			60: temp<=   32'h00148805;  //Fixed point representation of 1/57*1/56
			61: temp<=   32'h001326C0;  //Fixed point representation of 1/59*1/58
			62: temp<=   32'h0011E7F0;  //Fixed point representation of 1/61*1/60
			63: temp<=   32'h0010C708;  //Fixed point representation of 1/63*1/62
		
		endcase
	end  
	
	assign tableData = temp[31: 31 - F_WIDTH + 1 ];
endmodule

