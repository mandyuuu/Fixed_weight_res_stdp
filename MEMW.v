//------------------------------
//©  2016  Qian Wang, Yu Liu, Yingyezhe Jin, Peng Li
//Department of Electrical and Computer Engineering
//Texas A&M University

//Contact: 
//Prof. Peng Li
//Department of ECE
//3259 TAMU,  College Station, TX 77843
//pli@tamu.edu   (979) 845-1612          
//--------------------------------

// Memory to store synapse weight, the interface is defined by Xilinx BRAM auto generator.
// The inital weights should not be all-zero. Randomly pick several synapse and assign non-zeron weights to them.

module MEMW(
	 input CLK,
    input RST,//reset active-high
    input [7:0] ADDR,
    input WE,   // write enable signal.
    input [15:0] DIN,
	 output reg [15:0] DOUT
    );
//================Internal Variables=====================
reg [15:0] MEM[1:135];//FixedPoint 32bit
reg [9:0] i;//iterator
//================Code Starts Here=======================
always @ (negedge CLK) 
begin
		if(RST)//reset to zero value for all mem
			begin
			DOUT <= 0;
			end
		else
			if(WE)//write
				begin
				MEM[ADDR] <= DIN;
				end
			else//read
				begin
				DOUT <= MEM[ADDR];
				end
end

 initial
      begin
        //$readmemb("C:/Users/qwang/Desktop/Liquid State Machine/W1.txt", MEM);
        MEM[1] = 16'b0; MEM[2] = 16'b1; MEM[3] = 16'b10; MEM[4] = 16'b11; MEM[5] = 16'b100;
        MEM[6] = 16'b101; MEM[7] = 16'b110; MEM[8] = 16'b111; MEM[9] = 16'b0; MEM[10] = 16'b0;
        MEM[11] = 16'b0; MEM[12] = 16'b0; MEM[13] = 16'b0; MEM[14] = 16'b0; MEM[15] = 16'b0;
        MEM[16] = 16'b0; MEM[17] = 16'b0; MEM[18] = 16'b0; MEM[19] = 16'b0; MEM[20] = 16'b0;
        MEM[21] = 16'b0; MEM[22] = 16'b0; MEM[23] = 16'b0; MEM[24] = 16'b0; MEM[25] = 16'b0;
        MEM[26] = 16'b0; MEM[27] = 16'b0; MEM[28] = 16'b0; MEM[29] = 16'b0; MEM[30] = 16'b0;
        MEM[31] = 16'b0; MEM[32] = 16'b0; MEM[33] = 16'b0; MEM[34] = 16'b0; MEM[35] = 16'b0;
        MEM[36] = 16'b0; MEM[37] = 16'b0; MEM[38] = 16'b0; MEM[39] = 16'b0; MEM[40] = 16'b0;
        MEM[41] = 16'b0; MEM[42] = 16'b0; MEM[43] = 16'b0; MEM[44] = 16'b0; MEM[45] = 16'b0;
        MEM[46] = 16'b0; MEM[47] = 16'b0; MEM[48] = 16'b0; MEM[49] = 16'b0; MEM[50] = 16'b0;
        MEM[51] = 16'b0; MEM[52] = 16'b0; MEM[53] = 16'b0; MEM[54] = 16'b0; MEM[55] = 16'b0;
        MEM[56] = 16'b0; MEM[57] = 16'b0; MEM[58] = 16'b0; MEM[59] = 16'b0; MEM[60] = 16'b0;
        MEM[61] = 16'b0; MEM[62] = 16'b0; MEM[63] = 16'b0; MEM[64] = 16'b0; MEM[65] = 16'b0;
        MEM[66] = 16'b0; MEM[67] = 16'b0; MEM[68] = 16'b0; MEM[69] = 16'b0; MEM[70] = 16'b0;
        MEM[71] = 16'b0; MEM[72] = 16'b0; MEM[73] = 16'b0; MEM[74] = 16'b0; MEM[75] = 16'b0;
        MEM[76] = 16'b0; MEM[77] = 16'b0; MEM[78] = 16'b0; MEM[79] = 16'b0; MEM[80] = 16'b0;
        MEM[81] = 16'b0; MEM[82] = 16'b0; MEM[83] = 16'b0; MEM[84] = 16'b0; MEM[85] = 16'b0;
        MEM[86] = 16'b0; MEM[87] = 16'b0; MEM[88] = 16'b0; MEM[89] = 16'b0; MEM[90] = 16'b0;
        MEM[91] = 16'b0; MEM[92] = 16'b0; MEM[93] = 16'b0; MEM[94] = 16'b0; MEM[95] = 16'b0;
        MEM[96] = 16'b0; MEM[97] = 16'b0; MEM[98] = 16'b0; MEM[99] = 16'b0; MEM[100] = 16'b0;
        MEM[101] = 16'b0; MEM[102] = 16'b0; MEM[103] = 16'b0; MEM[104] = 16'b0; MEM[105] = 16'b0;
        MEM[106] = 16'b0; MEM[107] = 16'b0; MEM[108] = 16'b0; MEM[109] = 16'b0; MEM[110] = 16'b0;
        MEM[111] = 16'b0; MEM[112] = 16'b0; MEM[113] = 16'b0; MEM[114] = 16'b0; MEM[115] = 16'b0;
        MEM[116] = 16'b0; MEM[117] = 16'b0; MEM[118] = 16'b0; MEM[119] = 16'b0; MEM[120] = 16'b0;
        MEM[121] = 16'b0; MEM[122] = 16'b0; MEM[123] = 16'b0; MEM[124] = 16'b0; MEM[125] = 16'b0;
        MEM[126] = 16'b0; MEM[127] = 16'b0; MEM[128] = 16'b0; MEM[129] = 16'b0; MEM[130] = 16'b0;
        MEM[131] = 16'b0; MEM[132] = 16'b0; MEM[133] = 16'b0; MEM[134] = 16'b0; MEM[135] = 16'b0;
      end        

endmodule

/*
`timescale 1ns / 100ps
module MEMW(
    input CLK,
    input WE,
    input [7:0] ADDR,
    input [15:0] DIN,
    output reg [15:0] DOUT
    );
//================Internal Variables=====================
reg [15:0] MEM[1:135];//FixedPoint 32bit
parameter Half_T = 5;
//================Code Starts Here=================================================
initial
      begin
        $readmemb("C:/Users/qwang/Desktop/Liquid State Machine/W1.txt", MEM);
      end        

always @(posedge CLK)
begin
	if(WE==0)//read mode
	   begin
		DOUT <= #5 MEM[ADDR];
	   end
	else//write mode 
	   begin
		DOUT <= #5 DIN;
		MEM[ADDR] <= #5 DIN;
	  end
end

endmodule*/