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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  TEXAS A&M UNIVERSITY CESG
// Engineer: Q.Wang
// 
// Create Date:    21:59:33 10/28/2015 
// Design Name: 	 Liquid State Machine
// Module Name:    Top_module
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:   This is the top design module of hardware liquid state machine neural processor. The design contains two main parts: Reservoir
// 					and Readout, each consists of corresponding neurons. The application implemnted on this design is the recognition of the speeches
//						of 10 digits(0-9),
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////


module top_module(
   //Input
	Clk,	
	Rst, 	
	switch,  	// raise high when swithing input from one pattern to another
	Mode,			// Mode = 0, system in training mode. Mode = 1, system in testing mode	
	Pattern,		// input signals for training and testing, the pattern is fed into LSM in the time order, each bit corresponds to one channel of input signal
	Teach1,     // 10 teacher signals, each is connected to one readout neuron
	Teach2, 
	Teach3, 
	Teach4, 
	Teach5, 
	Teach6, 
	Teach7, 
	Teach8, 
	Teach9, 
	Teach10,
	
	//Output
	R_state,
	state,                //
	cs1,		// output spikes of 10 readout neurons
	cs2, 
	cs3, 
	cs4, 
	cs5,
	cs6, 
	cs7, 
	cs8, 
	cs9, 
	cs10,
	cnt_fire1, //counters of firing time during test mode
	cnt_fire2, 
	cnt_fire3,
	cnt_fire4, 
	cnt_fire5, 
	cnt_fire6,
	cnt_fire7,
	cnt_fire8, 
	cnt_fire9, 
	cnt_fire10
    ); 
	 
   input Clk, Rst, switch;
	input Mode;      
	input [77:1] Pattern;      												// input spike column into reservoir
	input [1:0] Teach1, Teach2, Teach3, Teach4, Teach5, Teach6, Teach7, Teach8, Teach9, Teach10;
	output wire [3:0] state;  	// current state of readout neuron
	output wire [2:0] R_state;  // current state of reservoir neuron
	output wire cs1, cs2, cs3, cs4, cs5, cs6, cs7, cs8, cs9, cs10;
   output wire [10:0] cnt_fire1, cnt_fire2, cnt_fire3, cnt_fire4, cnt_fire5, cnt_fire6, cnt_fire7, cnt_fire8, cnt_fire9, cnt_fire10;
 
   //parameter Cycle=20;
   //parameter ONUstate=4'b0001;
   //parameter Zerofill=77'b0;
 
   //Sandeep Samal
   wire [9:0] t;  // dummy wire for Time input to Resevoir
   wire [135:1] RChannel;     // 135 spiking signals from reservoir to readout neurons
   wire ReqRChannel;
   wire ReqRChannel2R;
   assign ReqRChannel2R= ReqRChannel ||((state==1)&& Mode);   // ReqRChannel raises high when output layer required a new spike input from reservoir
   
	Reservoir R(.switch(switch), .Time(t), .Clk(Clk), .Rst(Rst), .state(R_state), .Pattern(Pattern), .R_Spike(RChannel), .ReqRChannel(ReqRChannel2R));
   
	Readout TU(cs1, cs2,cs3,cs4,cs5,cs6,cs7,cs8,cs9,cs10, 
                  cnt_fire1, cnt_fire2, cnt_fire3, cnt_fire4, cnt_fire5, cnt_fire6, cnt_fire7, cnt_fire8, cnt_fire9, cnt_fire10, 
                  state, Clk, Mode, Teach1, Teach2, Teach3, Teach4, Teach5, Teach6, Teach7, Teach8, Teach9, Teach10, switch, 
                  RChannel, ReqRChannel);
      
endmodule
