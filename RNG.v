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

// pseudo random number generator -- LFSR
module RNG1(
	input CLK,
	input SET,
	input EN,
	output [16:1] RANDOM
);

reg [8:1] rnd, rnd_next;

wire feedback = rnd[8] ^ rnd[6] ^ rnd[5] ^ rnd[4]; //feedback taps
 
always @ (posedge CLK or posedge SET)
begin
	if (SET==1) //should be set for at least one clock cycle before enable is given, otherwise no control
	begin
		rnd <= 8'b10101010; //an LFSR cannot have an all 0 state, thus reset to all 1's
	end
	else
	begin
		if (EN==1)
		begin
			rnd <= rnd_next;
		end
	end
end

always @ (*)
begin
	rnd_next = {rnd[7:1], feedback}; //shift left the xor'd every posedge clock
end

assign RANDOM = (rnd + 8'b0)>16'd150 ? (rnd + 8'b0) - 16'd5 : (rnd + 8'b0);           // d350

//assign rand = rnd + 8'b01100100;

endmodule

//module RNG2(
//	input CLK,
//	input SET,
//	input EN,
//	output [16:1] RANDOM
//);
//
//reg [8:1] rnd, rnd_next;
//
//wire feedback = rnd[8] ^ rnd[6] ^ rnd[5] ^ rnd[4]; //feedback taps
// 
//always @ (posedge CLK or posedge SET)
//begin
//	if (SET==1) //should be set for atleast one clock cycle before enable is given, otherwise no control
//	begin
//		rnd <= 8'b10111000; //an LFSR cannot have an all 0 state, thus reset to all 1's
//	end
//	else
//	begin
//		if (EN==1)
//		begin
//			rnd <= rnd_next;
//		end
//	end
//end
//
//always @ (*)
//begin
//	rnd_next = {rnd[7:1], feedback}; //shift left the xor'd every posedge clock
//end
//
//assign RANDOM = (rnd + 8'b0)>16'd350 ? (rnd + 8'b0) - 16'd5 : (rnd + 8'b0);
//
////assign rand = rnd + 8'b01100100;
//
//endmodule