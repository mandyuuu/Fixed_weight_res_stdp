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
//////////////////////////////////////////////////////////////////////////////////
// Company:  TEXAS A&M UNIVERSITY CESG
// Engineer: Q.Wang
// 
// Create Date:    22:00:45 10/16/2014 
// Design Name: 
// Module Name:    Reservoir 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

//module Reservoir(
//			Clk, 
//			Rst,
//			state,
//			Pattern,
//			R_Spike,   //
//			ReqRChannel,
//			Time,
//			cnt_i,
//			switch
//    );

module Reservoir(
	// output
	state,
	R_Spike, 	
	
	// input
	Clk, 
	Rst,
	Pattern,
	Time, 			
	ReqRChannel,     
   cnt_i,	   	
	switch);	 
	 
input Clk;
input Rst;
input [9:0] Time;
input switch;       
output [135:1] R_Spike;
output [2:0] state;
output [5:0] cnt_i;
input [77:1] Pattern;
input ReqRChannel;

reg [5:0] cnt_i, cnt_r;	
reg [2:0] state, nextstate; 
reg [135:1] R_Spike, R_Spike_Next;
wire [8:1]InputSpike1, InputSpike2, InputSpike3, InputSpike4, InputSpike5, InputSpike6, InputSpike7, InputSpike8, InputSpike9, InputSpike10, 
          InputSpike11, InputSpike12, InputSpike13, InputSpike14, InputSpike15, InputSpike16, InputSpike17, InputSpike18, InputSpike19, InputSpike20, 
          InputSpike21, InputSpike22, InputSpike23, InputSpike24, InputSpike25, InputSpike26, InputSpike27, InputSpike28, InputSpike29, InputSpike30,
          InputSpike31, InputSpike32, InputSpike33, InputSpike34, InputSpike35, InputSpike36, InputSpike37, InputSpike38, InputSpike39, InputSpike40,
          InputSpike41, InputSpike42, InputSpike43, InputSpike44, InputSpike45, InputSpike46, InputSpike47, InputSpike48, InputSpike49, InputSpike50, 
          InputSpike51, InputSpike52, InputSpike53, InputSpike54, InputSpike55, InputSpike56, InputSpike57, InputSpike58, InputSpike59, InputSpike60, 
          InputSpike61, InputSpike62, InputSpike63, InputSpike64, InputSpike65, InputSpike66, InputSpike67, InputSpike68, InputSpike69, InputSpike70, 
          InputSpike71, InputSpike72, InputSpike73, InputSpike74, InputSpike75, InputSpike76, InputSpike77, InputSpike78, InputSpike79, InputSpike80, 
          InputSpike81, InputSpike82, InputSpike83, InputSpike84, InputSpike85, InputSpike86, InputSpike87, InputSpike88, InputSpike89, InputSpike90, 
          InputSpike91, InputSpike92, InputSpike93, InputSpike94, InputSpike95, InputSpike96, InputSpike97, InputSpike98, InputSpike99, InputSpike100, 
          InputSpike101, InputSpike102, InputSpike103, InputSpike104, InputSpike105, InputSpike106, InputSpike107, InputSpike108, InputSpike109, InputSpike110, 
          InputSpike111, InputSpike112, InputSpike113, InputSpike114, InputSpike115, InputSpike116, InputSpike117, InputSpike118, InputSpike119, InputSpike120, 
          InputSpike121, InputSpike122, InputSpike123, InputSpike124, InputSpike125, InputSpike126, InputSpike127, InputSpike128, InputSpike129, InputSpike130, 
          InputSpike131, InputSpike132, InputSpike133, InputSpike134, InputSpike135;

wire [8:1]I_W_Weight1, I_W_Weight2, I_W_Weight3, I_W_Weight4, I_W_Weight5, I_W_Weight6, I_W_Weight7, I_W_Weight8, I_W_Weight9, I_W_Weight10, 
          I_W_Weight11, I_W_Weight12, I_W_Weight13, I_W_Weight14, I_W_Weight15, I_W_Weight16, I_W_Weight17, I_W_Weight18, I_W_Weight19, I_W_Weight20,
          I_W_Weight21, I_W_Weight22, I_W_Weight23, I_W_Weight24, I_W_Weight25, I_W_Weight26, I_W_Weight27, I_W_Weight28, I_W_Weight29, I_W_Weight30, 
          I_W_Weight31, I_W_Weight32, I_W_Weight33, I_W_Weight34, I_W_Weight35, I_W_Weight36, I_W_Weight37, I_W_Weight38, I_W_Weight39, I_W_Weight40,
          I_W_Weight41, I_W_Weight42, I_W_Weight43, I_W_Weight44, I_W_Weight45, I_W_Weight46, I_W_Weight47, I_W_Weight48, I_W_Weight49, I_W_Weight50, 
          I_W_Weight51, I_W_Weight52, I_W_Weight53, I_W_Weight54, I_W_Weight55, I_W_Weight56, I_W_Weight57, I_W_Weight58, I_W_Weight59, I_W_Weight60,
          I_W_Weight61, I_W_Weight62, I_W_Weight63, I_W_Weight64, I_W_Weight65, I_W_Weight66, I_W_Weight67, I_W_Weight68, I_W_Weight69, I_W_Weight70,
          I_W_Weight71, I_W_Weight72, I_W_Weight73, I_W_Weight74, I_W_Weight75, I_W_Weight76, I_W_Weight77, I_W_Weight78, I_W_Weight79, I_W_Weight80,
          I_W_Weight81, I_W_Weight82, I_W_Weight83, I_W_Weight84, I_W_Weight85, I_W_Weight86, I_W_Weight87, I_W_Weight88, I_W_Weight89, I_W_Weight90, 
          I_W_Weight91, I_W_Weight92, I_W_Weight93, I_W_Weight94, I_W_Weight95, I_W_Weight96, I_W_Weight97, I_W_Weight98, I_W_Weight99, I_W_Weight100, 
          I_W_Weight101, I_W_Weight102, I_W_Weight103, I_W_Weight104, I_W_Weight105, I_W_Weight106, I_W_Weight107, I_W_Weight108, I_W_Weight109, I_W_Weight110, 
          I_W_Weight111, I_W_Weight112, I_W_Weight113, I_W_Weight114, I_W_Weight115, I_W_Weight116, I_W_Weight117, I_W_Weight118, I_W_Weight119, I_W_Weight120, 
          I_W_Weight121, I_W_Weight122, I_W_Weight123, I_W_Weight124, I_W_Weight125, I_W_Weight126, I_W_Weight127, I_W_Weight128, I_W_Weight129, I_W_Weight130, 
          I_W_Weight131, I_W_Weight132, I_W_Weight133, I_W_Weight134, I_W_Weight135; 

wire [16:1] InternalSpike1, InternalSpike2, InternalSpike3, InternalSpike4, InternalSpike5, InternalSpike6, InternalSpike7, InternalSpike8, InternalSpike9, InternalSpike10, 
    InternalSpike11, InternalSpike12, InternalSpike13, InternalSpike14, InternalSpike15, InternalSpike16, InternalSpike17, InternalSpike18, InternalSpike19, InternalSpike20,
    InternalSpike21, InternalSpike22, InternalSpike23, InternalSpike24, InternalSpike25, InternalSpike26, InternalSpike27, InternalSpike28, InternalSpike29, InternalSpike30, 
    InternalSpike31, InternalSpike32, InternalSpike33, InternalSpike34, InternalSpike35, InternalSpike36, InternalSpike37, InternalSpike38, InternalSpike39, InternalSpike40,
    InternalSpike41, InternalSpike42, InternalSpike43, InternalSpike44, InternalSpike45, InternalSpike46, InternalSpike47, InternalSpike48, InternalSpike49, InternalSpike50, 
    InternalSpike51, InternalSpike52, InternalSpike53, InternalSpike54, InternalSpike55, InternalSpike56, InternalSpike57, InternalSpike58, InternalSpike59, InternalSpike60,
    InternalSpike61, InternalSpike62, InternalSpike63, InternalSpike64, InternalSpike65, InternalSpike66, InternalSpike67, InternalSpike68, InternalSpike69, InternalSpike70, 
    InternalSpike71, InternalSpike72, InternalSpike73, InternalSpike74, InternalSpike75, InternalSpike76, InternalSpike77, InternalSpike78, InternalSpike79, InternalSpike80, 
    InternalSpike81, InternalSpike82, InternalSpike83, InternalSpike84, InternalSpike85, InternalSpike86, InternalSpike87, InternalSpike88, InternalSpike89, InternalSpike90, 
    InternalSpike91, InternalSpike92, InternalSpike93, InternalSpike94, InternalSpike95, InternalSpike96, InternalSpike97, InternalSpike98, InternalSpike99, InternalSpike100, 
    InternalSpike101, InternalSpike102, InternalSpike103, InternalSpike104, InternalSpike105, InternalSpike106, InternalSpike107, InternalSpike108, InternalSpike109, InternalSpike110, 
    InternalSpike111, InternalSpike112, InternalSpike113, InternalSpike114, InternalSpike115, InternalSpike116, InternalSpike117, InternalSpike118, InternalSpike119, InternalSpike120, 
    InternalSpike121, InternalSpike122, InternalSpike123, InternalSpike124, InternalSpike125, InternalSpike126, InternalSpike127, InternalSpike128, InternalSpike129, InternalSpike130, 
    InternalSpike131, InternalSpike132, InternalSpike133, InternalSpike134, InternalSpike135;   

wire [16:1] R_excite1, R_excite2, R_excite3, R_excite4, R_excite5, R_excite6, R_excite7, R_excite8, R_excite9, R_excite10,
    R_excite11, R_excite12, R_excite13, R_excite14, R_excite15, R_excite16, R_excite17, R_excite18, R_excite19, R_excite20,
    R_excite21, R_excite22, R_excite23, R_excite24, R_excite25, R_excite26, R_excite27, R_excite28, R_excite29, R_excite30, 
    R_excite31, R_excite32, R_excite33, R_excite34, R_excite35, R_excite36, R_excite37, R_excite38, R_excite39, R_excite40, 
    R_excite41, R_excite42, R_excite43, R_excite44, R_excite45, R_excite46, R_excite47, R_excite48, R_excite49, R_excite50,
    R_excite51, R_excite52, R_excite53, R_excite54, R_excite55, R_excite56, R_excite57, R_excite58, R_excite59, R_excite60,
    R_excite61, R_excite62, R_excite63, R_excite64, R_excite65, R_excite66, R_excite67, R_excite68, R_excite69, R_excite70, 
    R_excite71, R_excite72, R_excite73, R_excite74, R_excite75, R_excite76, R_excite77, R_excite78, R_excite79, R_excite80, 
    R_excite81, R_excite82, R_excite83, R_excite84, R_excite85, R_excite86, R_excite87, R_excite88, R_excite89, R_excite90, 
    R_excite91, R_excite92, R_excite93, R_excite94, R_excite95, R_excite96, R_excite97, R_excite98, R_excite99, R_excite100, 
    R_excite101, R_excite102, R_excite103, R_excite104, R_excite105, R_excite106, R_excite107, R_excite108, R_excite109, R_excite110, 
    R_excite111, R_excite112, R_excite113, R_excite114, R_excite115, R_excite116, R_excite117, R_excite118, R_excite119, R_excite120, 
    R_excite121, R_excite122, R_excite123, R_excite124, R_excite125, R_excite126, R_excite127, R_excite128, R_excite129, R_excite130, 
    R_excite131, R_excite132, R_excite133, R_excite134, R_excite135;          

//assign the input connection for each reservoir neuron
assign InputSpike1={Pattern[19], Pattern[38], Pattern[61], 5'b0};
assign InputSpike2={Pattern[14], Pattern[29], Pattern[35], Pattern[43], 4'b0};
assign InputSpike3={Pattern[39], Pattern[63], 6'b0};
assign InputSpike4={Pattern[30], 7'b0};
assign InputSpike5={Pattern[36], Pattern[50], Pattern[74], 5'b0};
assign InputSpike6={8'b0};
assign InputSpike7={Pattern[76], 7'b0};
assign InputSpike8={Pattern[6], Pattern[16], Pattern[51], Pattern[66], 4'b0};
assign InputSpike9={Pattern[13], Pattern[37], 6'b0};
assign InputSpike10={Pattern[52], Pattern[68], 6'b0};
assign InputSpike11={Pattern[24], Pattern[52], 6'b0};
assign InputSpike12={Pattern[2], Pattern[28], Pattern[57], Pattern[68], 4'b0};
assign InputSpike13={Pattern[67], 7'b0};
assign InputSpike14={Pattern[54], Pattern[60], 6'b0};
assign InputSpike15={8'b0};
assign InputSpike16={Pattern[1], 7'b0};
assign InputSpike17={Pattern[45], 7'b0};
assign InputSpike18={Pattern[74], Pattern[77], 6'b0};
assign InputSpike19={Pattern[15], Pattern[19], Pattern[51], Pattern[69], 4'b0};
assign InputSpike20={Pattern[40], Pattern[49], 6'b0};
assign InputSpike21={Pattern[22], 7'b0};
assign InputSpike22={Pattern[21], Pattern[25], Pattern[45], Pattern[55], 4'b0};
assign InputSpike23={Pattern[43], Pattern[63], 6'b0};
assign InputSpike24={Pattern[3], Pattern[4], 6'b0};
assign InputSpike25={Pattern[64], 7'b0};
assign InputSpike26={8'b0};
assign InputSpike27={Pattern[31], 7'b0};
assign InputSpike28={Pattern[24], 7'b0};
assign InputSpike29={Pattern[61], Pattern[71], 6'b0};
assign InputSpike30={Pattern[34], Pattern[41], 6'b0};
assign InputSpike31={Pattern[72], 7'b0};
assign InputSpike32={Pattern[32], Pattern[35], 6'b0};
assign InputSpike33={Pattern[11], Pattern[55], Pattern[73], 5'b0};
assign InputSpike34={8'b0};
assign InputSpike35={Pattern[14], Pattern[36], 6'b0};
assign InputSpike36={Pattern[69], 7'b0};
assign InputSpike37={Pattern[1], Pattern[4], 6'b0};
assign InputSpike38={Pattern[3], Pattern[65], Pattern[69], 5'b0};
assign InputSpike39={Pattern[2], Pattern[13], Pattern[20], Pattern[75], Pattern[76], 3'b0};
assign InputSpike40={8'b0};
assign InputSpike41={Pattern[44], 7'b0};
assign InputSpike42={Pattern[58], 7'b0};
assign InputSpike43={Pattern[14], Pattern[29], Pattern[45], Pattern[53], 4'b0};
assign InputSpike44={Pattern[2], Pattern[14], Pattern[16], Pattern[25], Pattern[27], Pattern[47], Pattern[51], Pattern[67]};
assign InputSpike45={Pattern[43], Pattern[70], 6'b0};
assign InputSpike46={8'b0};
assign InputSpike47={Pattern[3], Pattern[65], 6'b0};
assign InputSpike48={Pattern[5], Pattern[25], Pattern[59], Pattern[67], 4'b0};
assign InputSpike49={Pattern[13], Pattern[51], Pattern[55], Pattern[59], 4'b0};
assign InputSpike50={Pattern[12], Pattern[31], Pattern[39], Pattern[50], 4'b0};
assign InputSpike51={Pattern[5], Pattern[6], Pattern[70], 5'b0};
assign InputSpike52={Pattern[77], 7'b0};
assign InputSpike53={Pattern[62], 7'b0};
assign InputSpike54={Pattern[28], Pattern[48], Pattern[58], 5'b0};
assign InputSpike55={8'b0};
assign InputSpike56={Pattern[8], 7'b0};
assign InputSpike57={Pattern[10], Pattern[43], Pattern[67], 5'b0};
assign InputSpike58={Pattern[32], Pattern[34], 6'b0};
assign InputSpike59={Pattern[32], Pattern[56], 6'b0};
assign InputSpike60={Pattern[54], 7'b0};
assign InputSpike61={Pattern[16], Pattern[32], Pattern[38], Pattern[50], Pattern[66], 3'b0};
assign InputSpike62={Pattern[52], Pattern[60], Pattern[71], 5'b0};
assign InputSpike63={Pattern[7], Pattern[9], Pattern[33], Pattern[36], 4'b0};
assign InputSpike64={Pattern[2], Pattern[64], Pattern[76], 5'b0};
assign InputSpike65={Pattern[16], Pattern[26], Pattern[38], 5'b0};
assign InputSpike66={Pattern[7], Pattern[47], 6'b0};
assign InputSpike67={Pattern[58], 7'b0};
assign InputSpike68={Pattern[53], 7'b0};
assign InputSpike69={Pattern[33], Pattern[47], Pattern[49], 5'b0};
assign InputSpike70={Pattern[76], Pattern[77], 6'b0};
assign InputSpike71={Pattern[54], Pattern[72], Pattern[73], 5'b0};
assign InputSpike72={Pattern[5], Pattern[20], Pattern[31], Pattern[34], 4'b0};
assign InputSpike73={Pattern[20], Pattern[28], 6'b0};
assign InputSpike74={Pattern[44], Pattern[48], 6'b0};
assign InputSpike75={8'b0};
assign InputSpike76={Pattern[17], 7'b0};
assign InputSpike77={Pattern[4], Pattern[42], Pattern[58], Pattern[60], Pattern[75], 3'b0};
assign InputSpike78={Pattern[39], Pattern[54], 6'b0};
assign InputSpike79={Pattern[29], Pattern[61], Pattern[62], Pattern[75], 4'b0};
assign InputSpike80={Pattern[44], Pattern[49], 6'b0};
assign InputSpike81={Pattern[46], 7'b0};
assign InputSpike82={Pattern[8], Pattern[30], Pattern[74], 5'b0};
assign InputSpike83={Pattern[12], Pattern[22], Pattern[42], 5'b0};
assign InputSpike84={Pattern[20], Pattern[59], 6'b0};
assign InputSpike85={Pattern[26], Pattern[49], Pattern[62], 5'b0};
assign InputSpike86={Pattern[13], Pattern[42], Pattern[45], Pattern[48], 4'b0};
assign InputSpike87={Pattern[68], 7'b0};
assign InputSpike88={Pattern[41], 7'b0};
assign InputSpike89={Pattern[27], Pattern[70], 6'b0};
assign InputSpike90={8'b0};
assign InputSpike91={Pattern[3], Pattern[7], Pattern[9], Pattern[19], Pattern[71], 3'b0};
assign InputSpike92={Pattern[18], Pattern[53], 6'b0};
assign InputSpike93={Pattern[25], Pattern[31], 6'b0};
assign InputSpike94={Pattern[60], Pattern[64], 6'b0};
assign InputSpike95={Pattern[15], 7'b0};
assign InputSpike96={Pattern[18], Pattern[22], Pattern[37], Pattern[57], Pattern[64], 3'b0};
assign InputSpike97={Pattern[15], 7'b0};
assign InputSpike98={Pattern[17], Pattern[24], Pattern[56], 5'b0};
assign InputSpike99={Pattern[23], 7'b0};
assign InputSpike100={Pattern[7], Pattern[21], Pattern[23], Pattern[41], 4'b0};
assign InputSpike101={Pattern[8], Pattern[65], Pattern[77], 5'b0};
assign InputSpike102={Pattern[9], Pattern[12], Pattern[65], Pattern[69], 4'b0};
assign InputSpike103={Pattern[63], Pattern[68], Pattern[71], 5'b0};
assign InputSpike104={Pattern[10], Pattern[11], Pattern[42], Pattern[46], 4'b0};
assign InputSpike105={Pattern[19], Pattern[46], Pattern[56], Pattern[66], 4'b0};
assign InputSpike106={Pattern[22], Pattern[40], Pattern[66], 5'b0};
assign InputSpike107={Pattern[63], Pattern[72], 6'b0};
assign InputSpike108={8'b0};
assign InputSpike109={Pattern[26], 7'b0};
assign InputSpike110={8'b0};
assign InputSpike111={Pattern[36], Pattern[48], Pattern[61], 5'b0};
assign InputSpike112={Pattern[53], 7'b0};
assign InputSpike113={Pattern[39], 7'b0};
assign InputSpike114={Pattern[1], Pattern[6], Pattern[11], 5'b0};
assign InputSpike115={Pattern[8], Pattern[9], Pattern[18], Pattern[24], Pattern[26], Pattern[56], 2'b0};
assign InputSpike116={Pattern[46], 7'b0};
assign InputSpike117={Pattern[11], Pattern[73], Pattern[75], 5'b0};
assign InputSpike118={Pattern[74], 7'b0};
assign InputSpike119={Pattern[27], Pattern[59], Pattern[70], 5'b0};
assign InputSpike120={Pattern[10], 7'b0};
assign InputSpike121={Pattern[18], Pattern[30], Pattern[33], Pattern[40], 4'b0};
assign InputSpike122={Pattern[41], 7'b0};
assign InputSpike123={Pattern[34], Pattern[62], 6'b0};
assign InputSpike124={Pattern[23], Pattern[52], Pattern[73], 5'b0};
assign InputSpike125={Pattern[38], 7'b0};
assign InputSpike126={Pattern[57], 7'b0};
assign InputSpike127={Pattern[50], Pattern[57], 6'b0};
assign InputSpike128={Pattern[12], Pattern[44], 6'b0};
assign InputSpike129={Pattern[37], 7'b0};
assign InputSpike130={Pattern[4], Pattern[6], Pattern[35], Pattern[37], 4'b0};
assign InputSpike131={Pattern[21], Pattern[55], 6'b0};
assign InputSpike132={Pattern[5], Pattern[28], 6'b0};
assign InputSpike133={Pattern[1], Pattern[17], 6'b0};
assign InputSpike134={Pattern[21], Pattern[35], 6'b0};
assign InputSpike135={Pattern[23], Pattern[27], Pattern[29], Pattern[30], Pattern[33], Pattern[40], Pattern[47], Pattern[72]};

// assign the input connection type ( excitatory ('1') or inhibitory('0') ) for each reservoir neuron
assign I_W_Weight1=8'b11100000;    assign I_W_Weight2=8'b10000000;   assign I_W_Weight3=8'b01000000;    assign I_W_Weight4=8'b10000000;
assign I_W_Weight5=8'b01000000;    assign I_W_Weight6=8'b00000000;   assign I_W_Weight7=8'b00000000;    assign I_W_Weight8=8'b10110000;
assign I_W_Weight9=8'b10000000;    assign I_W_Weight10=8'b10000000;   assign I_W_Weight11=8'b00000000;   assign I_W_Weight12=8'b11010000;
assign I_W_Weight13=8'b10000000;   assign I_W_Weight14=8'b01000000;   assign I_W_Weight15=8'b00000000;   assign I_W_Weight16=8'b10000000;
assign I_W_Weight17=8'b00000000;   assign I_W_Weight18=8'b11000000;   assign I_W_Weight19=8'b11100000;   assign I_W_Weight20=8'b11000000;
assign I_W_Weight21=8'b10000000;   assign I_W_Weight22=8'b00110000;   assign I_W_Weight23=8'b00000000;   assign I_W_Weight24=8'b01000000;
assign I_W_Weight25=8'b10000000;   assign I_W_Weight26=8'b00000000;   assign I_W_Weight27=8'b10000000;   assign I_W_Weight28=8'b10000000;
assign I_W_Weight29=8'b11000000;   assign I_W_Weight30=8'b10000000;   assign I_W_Weight31=8'b00000000;   assign I_W_Weight32=8'b01000000;
assign I_W_Weight33=8'b00100000;   assign I_W_Weight34=8'b00000000;   assign I_W_Weight35=8'b11000000;   assign I_W_Weight36=8'b00000000;
assign I_W_Weight37=8'b00000000;   assign I_W_Weight38=8'b10000000;   assign I_W_Weight39=8'b01011000;   assign I_W_Weight40=8'b00000000;
assign I_W_Weight41=8'b10000000;   assign I_W_Weight42=8'b00000000;   assign I_W_Weight43=8'b00110000;   assign I_W_Weight44=8'b00101001;
assign I_W_Weight45=8'b10000000;   assign I_W_Weight46=8'b00000000;   assign I_W_Weight47=8'b01000000;   assign I_W_Weight48=8'b01010000;
assign I_W_Weight49=8'b01110000;   assign I_W_Weight50=8'b10110000;   assign I_W_Weight51=8'b11000000;   assign I_W_Weight52=8'b00000000;
assign I_W_Weight53=8'b00000000;   assign I_W_Weight54=8'b10000000;   assign I_W_Weight55=8'b00000000;   assign I_W_Weight56=8'b00000000;
assign I_W_Weight57=8'b01000000;   assign I_W_Weight58=8'b11000000;   assign I_W_Weight59=8'b00000000;   assign I_W_Weight60=8'b00000000;
assign I_W_Weight61=8'b00011000;   assign I_W_Weight62=8'b01000000;   assign I_W_Weight63=8'b10100000;   assign I_W_Weight64=8'b11100000;
assign I_W_Weight65=8'b10000000;   assign I_W_Weight66=8'b11000000;   assign I_W_Weight67=8'b10000000;   assign I_W_Weight68=8'b10000000;
assign I_W_Weight69=8'b01100000;   assign I_W_Weight70=8'b01000000;   assign I_W_Weight71=8'b00000000;   assign I_W_Weight72=8'b10010000;
assign I_W_Weight73=8'b10000000;   assign I_W_Weight74=8'b01000000;   assign I_W_Weight75=8'b00000000;   assign I_W_Weight76=8'b00000000;
assign I_W_Weight77=8'b10100000;   assign I_W_Weight78=8'b11000000;   assign I_W_Weight79=8'b00000000;   assign I_W_Weight80=8'b01000000;
assign I_W_Weight81=8'b10000000;   assign I_W_Weight82=8'b10000000;   assign I_W_Weight83=8'b00000000;   assign I_W_Weight84=8'b00000000;
assign I_W_Weight85=8'b10100000;   assign I_W_Weight86=8'b01100000;   assign I_W_Weight87=8'b00000000;   assign I_W_Weight88=8'b10000000;
assign I_W_Weight89=8'b11000000;   assign I_W_Weight90=8'b00000000;   assign I_W_Weight91=8'b00000000;   assign I_W_Weight92=8'b11000000;
assign I_W_Weight93=8'b01000000;   assign I_W_Weight94=8'b11000000;   assign I_W_Weight95=8'b10000000;   assign I_W_Weight96=8'b10011000;
assign I_W_Weight97=8'b10000000;   assign I_W_Weight98=8'b01000000;   assign I_W_Weight99=8'b10000000;   assign I_W_Weight100=8'b11110000;
assign I_W_Weight101=8'b01000000;  assign I_W_Weight102=8'b01110000;  assign I_W_Weight103=8'b01000000;  assign I_W_Weight104=8'b01000000;
assign I_W_Weight105=8'b01010000;  assign I_W_Weight106=8'b01100000;  assign I_W_Weight107=8'b10000000;  assign I_W_Weight108=8'b00000000;
assign I_W_Weight109=8'b00000000;  assign I_W_Weight110=8'b00000000;  assign I_W_Weight111=8'b01100000;  assign I_W_Weight112=8'b10000000;
assign I_W_Weight113=8'b00000000;  assign I_W_Weight114=8'b11000000;  assign I_W_Weight115=8'b10011000;  assign I_W_Weight116=8'b10000000;
assign I_W_Weight117=8'b11000000;  assign I_W_Weight118=8'b00000000;  assign I_W_Weight119=8'b10000000;  assign I_W_Weight120=8'b00000000;
assign I_W_Weight121=8'b10010000;  assign I_W_Weight122=8'b10000000;  assign I_W_Weight123=8'b10000000;  assign I_W_Weight124=8'b11100000;
assign I_W_Weight125=8'b10000000;  assign I_W_Weight126=8'b00000000;  assign I_W_Weight127=8'b10000000;  assign I_W_Weight128=8'b10000000;
assign I_W_Weight129=8'b10000000;  assign I_W_Weight130=8'b00010000;  assign I_W_Weight131=8'b01000000;  assign I_W_Weight132=8'b01000000;
assign I_W_Weight133=8'b01000000;  assign I_W_Weight134=8'b00000000;  assign I_W_Weight135=8'b10101001;

// assign the connection within reservoir layer
assign InternalSpike1={R_Spike[16], R_Spike[33], R_Spike[46], R_Spike[47], 12'b0};
assign InternalSpike2={R_Spike[3], R_Spike[17], R_Spike[18], 13'b0};
assign InternalSpike3={R_Spike[2], R_Spike[3], R_Spike[16], R_Spike[19], R_Spike[32], R_Spike[33], R_Spike[49], R_Spike[50], R_Spike[93], R_Spike[96], R_Spike[122], 5'b0};
assign InternalSpike4={R_Spike[2], R_Spike[5], R_Spike[48], R_Spike[49], R_Spike[50], R_Spike[95], R_Spike[111], 9'b0};
assign InternalSpike5={R_Spike[110], 15'b0};
assign InternalSpike6={R_Spike[4], R_Spike[6], R_Spike[8], R_Spike[19], R_Spike[35], R_Spike[50], R_Spike[93], 9'b0};
assign InternalSpike7={R_Spike[6], R_Spike[7], R_Spike[10], R_Spike[24], R_Spike[37], R_Spike[38], R_Spike[39], R_Spike[52], R_Spike[66], R_Spike[81], 6'b0};
assign InternalSpike8={R_Spike[7], R_Spike[9], R_Spike[10], R_Spike[35], R_Spike[52], R_Spike[53], R_Spike[112], 9'b0};
assign InternalSpike9={R_Spike[9], R_Spike[10], R_Spike[21], R_Spike[26], R_Spike[53], R_Spike[54], R_Spike[55], R_Spike[69], R_Spike[72], R_Spike[88], R_Spike[100], 5'b0};
assign InternalSpike10={R_Spike[11], R_Spike[55], R_Spike[57], R_Spike[82], 12'b0};
assign InternalSpike11={R_Spike[10], R_Spike[26], R_Spike[28], R_Spike[55], R_Spike[72], R_Spike[133], 10'b0};
assign InternalSpike12={R_Spike[11], R_Spike[12], R_Spike[13], R_Spike[27], R_Spike[28], R_Spike[42], R_Spike[45], R_Spike[54], R_Spike[72], R_Spike[73], R_Spike[131], 5'b0};
assign InternalSpike13={R_Spike[43], R_Spike[44], R_Spike[56], R_Spike[59], R_Spike[89], R_Spike[118], 10'b0};
assign InternalSpike14={R_Spike[13], R_Spike[14], R_Spike[15], R_Spike[30], R_Spike[42], R_Spike[58], R_Spike[74], R_Spike[88], R_Spike[89], 7'b0};
assign InternalSpike15={R_Spike[13], R_Spike[15], R_Spike[105], R_Spike[119], 12'b0};
assign InternalSpike16={R_Spike[3], R_Spike[16], R_Spike[47], R_Spike[61], R_Spike[91], 11'b0};
assign InternalSpike17={R_Spike[1], R_Spike[18], R_Spike[20], R_Spike[32], R_Spike[33], R_Spike[47], R_Spike[76], R_Spike[77], R_Spike[109], R_Spike[122], 6'b0};
assign InternalSpike18={R_Spike[16], R_Spike[18], R_Spike[19], R_Spike[20], R_Spike[34], R_Spike[47], R_Spike[76], R_Spike[79], R_Spike[81], R_Spike[122], 6'b0};
assign InternalSpike19={R_Spike[2], R_Spike[5], R_Spike[17], R_Spike[20], R_Spike[33], R_Spike[34], R_Spike[46], R_Spike[49], R_Spike[78], R_Spike[80], R_Spike[94], 5'b0};
assign InternalSpike20={R_Spike[5], R_Spike[6], R_Spike[19], R_Spike[49], R_Spike[52], R_Spike[68], R_Spike[82], R_Spike[97], R_Spike[110], 7'b0};
assign InternalSpike21={R_Spike[5], R_Spike[6], R_Spike[65], R_Spike[93], 12'b0};
assign InternalSpike22={R_Spike[21], R_Spike[23], R_Spike[36], R_Spike[38], R_Spike[39], R_Spike[51], R_Spike[52], R_Spike[53], R_Spike[65], R_Spike[83], R_Spike[115], 5'b0};
assign InternalSpike23={R_Spike[8], R_Spike[9], R_Spike[22], R_Spike[23], R_Spike[36], R_Spike[37], R_Spike[54], R_Spike[69], R_Spike[82], R_Spike[84], R_Spike[110], R_Spike[113], R_Spike[114], R_Spike[128], 2'b0};
assign InternalSpike24={R_Spike[8], R_Spike[23], R_Spike[26], R_Spike[37], R_Spike[40], R_Spike[54], R_Spike[56], R_Spike[85], R_Spike[98], R_Spike[101], R_Spike[111], 5'b0};
assign InternalSpike25={R_Spike[10], R_Spike[13], R_Spike[24], R_Spike[25], R_Spike[38], R_Spike[39], R_Spike[54], R_Spike[101], R_Spike[129], R_Spike[130], R_Spike[131], 5'b0};
assign InternalSpike26={R_Spike[10], R_Spike[11], R_Spike[24], R_Spike[25], R_Spike[27], R_Spike[71], R_Spike[72], R_Spike[86], R_Spike[99], R_Spike[118], 6'b0};
assign InternalSpike27={R_Spike[39], R_Spike[55], R_Spike[57], R_Spike[71], R_Spike[72], R_Spike[87], R_Spike[116], R_Spike[118], 8'b0};
assign InternalSpike28={R_Spike[15], R_Spike[27], R_Spike[28], R_Spike[29], R_Spike[45], R_Spike[59], R_Spike[60], R_Spike[73], R_Spike[74], R_Spike[88], R_Spike[116], R_Spike[118], R_Spike[131], 3'b0};
assign InternalSpike29={R_Spike[28], R_Spike[44], R_Spike[59], R_Spike[74], R_Spike[89], R_Spike[104], 10'b0};
assign InternalSpike30={R_Spike[14], R_Spike[15], R_Spike[29], R_Spike[30], R_Spike[45], R_Spike[59], R_Spike[60], R_Spike[88], R_Spike[89], R_Spike[118], 6'b0};
assign InternalSpike31={R_Spike[32], R_Spike[62], R_Spike[77], 13'b0};
assign InternalSpike32={R_Spike[3], R_Spike[31], R_Spike[63], 13'b0};
assign InternalSpike33={R_Spike[51], R_Spike[61], R_Spike[63], R_Spike[77], 12'b0};
assign InternalSpike34={R_Spike[32], R_Spike[33], R_Spike[47], R_Spike[82], 12'b0};
assign InternalSpike35={R_Spike[19], R_Spike[34], R_Spike[35], R_Spike[49], R_Spike[52], R_Spike[79], R_Spike[81], R_Spike[82], 8'b0};
assign InternalSpike36={R_Spike[8], R_Spike[18], R_Spike[37], R_Spike[66], R_Spike[80], 11'b0};
assign InternalSpike37={R_Spike[36], R_Spike[37], R_Spike[38], R_Spike[51], R_Spike[52], R_Spike[66], R_Spike[67], R_Spike[81], R_Spike[98], 7'b0};
assign InternalSpike38={R_Spike[38], R_Spike[39], R_Spike[53], R_Spike[82], R_Spike[129], 11'b0};
assign InternalSpike39={R_Spike[6], R_Spike[8], R_Spike[10], R_Spike[22], R_Spike[24], R_Spike[37], R_Spike[38], R_Spike[39], R_Spike[85], R_Spike[97], R_Spike[114], 5'b0};
assign InternalSpike40={R_Spike[10], R_Spike[25], R_Spike[38], R_Spike[39], R_Spike[40], R_Spike[41], R_Spike[68], R_Spike[85], 8'b0};
assign InternalSpike41={R_Spike[39], R_Spike[87], 14'b0};
assign InternalSpike42={R_Spike[25], R_Spike[29], R_Spike[42], R_Spike[73], R_Spike[86], R_Spike[88], R_Spike[102], R_Spike[130], 8'b0};
assign InternalSpike43={R_Spike[43], R_Spike[135], 14'b0};
assign InternalSpike44={R_Spike[15], R_Spike[60], R_Spike[74], R_Spike[90], 12'b0};
assign InternalSpike45={R_Spike[15], R_Spike[89], R_Spike[119], R_Spike[131], 12'b0};
assign InternalSpike46={R_Spike[2], R_Spike[31], R_Spike[47], R_Spike[62], 12'b0};
assign InternalSpike47={R_Spike[3], R_Spike[61], R_Spike[93], 13'b0};
assign InternalSpike48={R_Spike[2], R_Spike[5], R_Spike[18], R_Spike[19], R_Spike[46], R_Spike[47], R_Spike[49], R_Spike[63], R_Spike[110], 7'b0};
assign InternalSpike49={R_Spike[3], R_Spike[5], R_Spike[19], R_Spike[35], R_Spike[80], R_Spike[108], R_Spike[109], R_Spike[125], 8'b0};
assign InternalSpike50={R_Spike[4], R_Spike[6], R_Spike[17], R_Spike[36], R_Spike[94], R_Spike[125], 10'b0};
assign InternalSpike51={R_Spike[7], R_Spike[8], R_Spike[22], R_Spike[37], R_Spike[50], R_Spike[66], R_Spike[94], R_Spike[95], R_Spike[110], 7'b0};
assign InternalSpike52={R_Spike[65], R_Spike[69], R_Spike[82], R_Spike[113], 12'b0};
assign InternalSpike53={R_Spike[7], R_Spike[9], R_Spike[22], R_Spike[23], R_Spike[25], R_Spike[52], R_Spike[53], R_Spike[68], R_Spike[97], R_Spike[98], R_Spike[100], R_Spike[114], 4'b0};
assign InternalSpike54={R_Spike[8], R_Spike[23], R_Spike[25], R_Spike[50], R_Spike[53], R_Spike[55], R_Spike[69], R_Spike[83], R_Spike[85], R_Spike[114], 6'b0};
assign InternalSpike55={R_Spike[10], R_Spike[26], R_Spike[56], R_Spike[98], R_Spike[99], R_Spike[102], R_Spike[128], 9'b0};
assign InternalSpike56={R_Spike[11], R_Spike[26], R_Spike[58], R_Spike[71], R_Spike[101], R_Spike[115], R_Spike[116], R_Spike[132], 8'b0};
assign InternalSpike57={R_Spike[11], R_Spike[12], R_Spike[26], R_Spike[27], R_Spike[28], R_Spike[56], R_Spike[57], R_Spike[72], R_Spike[74], R_Spike[118], 6'b0};
assign InternalSpike58={R_Spike[27], R_Spike[29], R_Spike[57], R_Spike[73], R_Spike[74], R_Spike[102], R_Spike[105], R_Spike[118], R_Spike[120], R_Spike[133], 6'b0};
assign InternalSpike59={R_Spike[14], R_Spike[29], R_Spike[30], R_Spike[43], R_Spike[44], R_Spike[58], R_Spike[59], R_Spike[60], R_Spike[118], 7'b0};
assign InternalSpike60={R_Spike[73], 15'b0};
assign InternalSpike61={R_Spike[2], R_Spike[18], R_Spike[31], R_Spike[61], R_Spike[62], 11'b0};
assign InternalSpike62={R_Spike[1], R_Spike[18], R_Spike[46], R_Spike[49], R_Spike[64], 11'b0};
assign InternalSpike63={R_Spike[17], R_Spike[20], R_Spike[32], R_Spike[50], R_Spike[77], R_Spike[79], R_Spike[91], R_Spike[107], R_Spike[108], R_Spike[127], 6'b0};
assign InternalSpike64={R_Spike[5], R_Spike[17], R_Spike[19], R_Spike[33], R_Spike[49], R_Spike[50], R_Spike[63], R_Spike[65], R_Spike[78], R_Spike[79], R_Spike[95], R_Spike[109], R_Spike[110], R_Spike[122], 2'b0};
assign InternalSpike65={R_Spike[8], R_Spike[18], R_Spike[21], R_Spike[35], R_Spike[50], R_Spike[65], R_Spike[80], R_Spike[111], 8'b0};
assign InternalSpike66={R_Spike[35], R_Spike[67], R_Spike[68], R_Spike[95], R_Spike[124], R_Spike[125], 10'b0};
assign InternalSpike67={R_Spike[8], R_Spike[9], R_Spike[21], R_Spike[36], R_Spike[53], R_Spike[82], R_Spike[96], R_Spike[97], R_Spike[98], R_Spike[111], R_Spike[112], R_Spike[125], R_Spike[127], 3'b0};
assign InternalSpike68={R_Spike[23], R_Spike[36], R_Spike[51], R_Spike[54], R_Spike[111], R_Spike[114], 10'b0};
assign InternalSpike69={R_Spike[38], R_Spike[70], R_Spike[82], R_Spike[83], 12'b0};
assign InternalSpike70={R_Spike[11], R_Spike[25], R_Spike[39], R_Spike[42], R_Spike[53], R_Spike[56], R_Spike[70], R_Spike[71], R_Spike[100], R_Spike[101], R_Spike[116], R_Spike[117], R_Spike[130], 3'b0};
assign InternalSpike71={R_Spike[25], R_Spike[27], R_Spike[42], R_Spike[56], R_Spike[59], R_Spike[70], R_Spike[101], R_Spike[115], R_Spike[129], 7'b0};
assign InternalSpike72={R_Spike[11], R_Spike[27], R_Spike[42], R_Spike[44], R_Spike[54], R_Spike[88], R_Spike[116], 9'b0};
assign InternalSpike73={R_Spike[58], R_Spike[59], R_Spike[74], R_Spike[75], R_Spike[87], R_Spike[131], 10'b0};
assign InternalSpike74={R_Spike[15], R_Spike[43], R_Spike[44], R_Spike[73], R_Spike[89], R_Spike[103], R_Spike[105], R_Spike[119], R_Spike[134], 7'b0};
assign InternalSpike75={R_Spike[13], R_Spike[57], R_Spike[58], R_Spike[60], R_Spike[74], R_Spike[90], R_Spike[104], R_Spike[134], R_Spike[135], 7'b0};
assign InternalSpike76={R_Spike[19], R_Spike[31], R_Spike[47], R_Spike[76], R_Spike[78], R_Spike[107], R_Spike[123], 9'b0};
assign InternalSpike77={R_Spike[4], R_Spike[32], R_Spike[35], R_Spike[46], R_Spike[62], R_Spike[63], R_Spike[64], R_Spike[77], R_Spike[78], R_Spike[93], R_Spike[107], R_Spike[108], R_Spike[125], 3'b0};
assign InternalSpike78={R_Spike[35], R_Spike[123], 14'b0};
assign InternalSpike79={R_Spike[5], R_Spike[19], R_Spike[65], R_Spike[77], R_Spike[78], R_Spike[79], R_Spike[80], R_Spike[122], R_Spike[123], R_Spike[124], 6'b0};
assign InternalSpike80={R_Spike[35], R_Spike[36], R_Spike[79], R_Spike[81], R_Spike[125], R_Spike[127], 10'b0};
assign InternalSpike81={R_Spike[7], R_Spike[38], R_Spike[80], R_Spike[81], R_Spike[112], R_Spike[125], 10'b0};
assign InternalSpike82={R_Spike[6], R_Spike[36], R_Spike[65], R_Spike[68], R_Spike[70], R_Spike[81], R_Spike[113], R_Spike[116], 8'b0};
assign InternalSpike83={R_Spike[22], R_Spike[23], R_Spike[82], R_Spike[83], R_Spike[85], R_Spike[100], R_Spike[101], R_Spike[113], R_Spike[129], 7'b0};
assign InternalSpike84={R_Spike[37], R_Spike[38], R_Spike[53], R_Spike[71], R_Spike[83], R_Spike[87], R_Spike[97], R_Spike[98], R_Spike[100], R_Spike[129], R_Spike[130], R_Spike[131], 4'b0};
assign InternalSpike85={R_Spike[23], R_Spike[24], R_Spike[25], R_Spike[26], R_Spike[54], R_Spike[56], R_Spike[83], R_Spike[86], R_Spike[99], R_Spike[101], R_Spike[117], R_Spike[128], R_Spike[130], R_Spike[131], R_Spike[132], 1'b0};
assign InternalSpike86={R_Spike[11], R_Spike[12], R_Spike[38], R_Spike[41], R_Spike[72], R_Spike[84], R_Spike[103], R_Spike[113], R_Spike[115], R_Spike[130], R_Spike[131], 5'b0};
assign InternalSpike87={R_Spike[12], R_Spike[25], R_Spike[29], R_Spike[39], R_Spike[71], R_Spike[72], R_Spike[117], R_Spike[119], 8'b0};
assign InternalSpike88={R_Spike[12], R_Spike[27], R_Spike[28], R_Spike[43], R_Spike[44], R_Spike[58], R_Spike[89], R_Spike[103], R_Spike[120], R_Spike[132], R_Spike[133], R_Spike[134], 4'b0};
assign InternalSpike89={R_Spike[28], R_Spike[29], R_Spike[30], R_Spike[43], R_Spike[44], R_Spike[59], R_Spike[73], R_Spike[74], R_Spike[89], R_Spike[118], R_Spike[120], 5'b0};
assign InternalSpike90={R_Spike[29], R_Spike[44], R_Spike[58], R_Spike[74], R_Spike[75], 11'b0};
assign InternalSpike91={R_Spike[48], R_Spike[93], R_Spike[106],  13'b0};
assign InternalSpike92={R_Spike[46], R_Spike[91], R_Spike[108], R_Spike[109], R_Spike[110], 11'b0};
assign InternalSpike93={R_Spike[2], R_Spike[31], R_Spike[47], R_Spike[49], R_Spike[78], R_Spike[107], R_Spike[108], R_Spike[109], R_Spike[124], 7'b0};
assign InternalSpike94={R_Spike[4], R_Spike[32], R_Spike[48], R_Spike[49], R_Spike[63], R_Spike[64], R_Spike[93], R_Spike[94], R_Spike[95], R_Spike[109], R_Spike[110], 5'b0};
assign InternalSpike95={R_Spike[22], R_Spike[50], R_Spike[64], R_Spike[81], 12'b0};
assign InternalSpike96={R_Spike[5], R_Spike[7], R_Spike[8], R_Spike[50], R_Spike[51], R_Spike[66], R_Spike[81], R_Spike[97], R_Spike[110], R_Spike[124], 6'b0};
assign InternalSpike97={R_Spike[8], R_Spike[19], R_Spike[21], R_Spike[38], R_Spike[51], R_Spike[54], R_Spike[65], R_Spike[67], R_Spike[68], R_Spike[69], R_Spike[83], R_Spike[96], R_Spike[110], R_Spike[112], R_Spike[113], 1'b0};
assign InternalSpike98={R_Spike[8], R_Spike[23], R_Spike[53], R_Spike[69], R_Spike[96], R_Spike[98], 10'b0};
assign InternalSpike99={R_Spike[24], R_Spike[67], R_Spike[98], R_Spike[99], R_Spike[113], R_Spike[129], 10'b0};
assign InternalSpike100={R_Spike[12], R_Spike[42], R_Spike[53], R_Spike[54], R_Spike[55], R_Spike[72], R_Spike[85], R_Spike[100], R_Spike[101], R_Spike[105], R_Spike[114], R_Spike[115], R_Spike[128], R_Spike[130], 2'b0};
assign InternalSpike101={R_Spike[26], R_Spike[55], R_Spike[70], R_Spike[100], R_Spike[116], R_Spike[130], R_Spike[132], 9'b0};
assign InternalSpike102={R_Spike[86], R_Spike[101], R_Spike[103], R_Spike[130], R_Spike[134], 11'b0};
assign InternalSpike103={R_Spike[55], R_Spike[57], R_Spike[59], R_Spike[60], R_Spike[73], R_Spike[102], R_Spike[134], R_Spike[135], 8'b0};
assign InternalSpike104={R_Spike[13], R_Spike[29], R_Spike[30], R_Spike[59], R_Spike[60], R_Spike[102], R_Spike[103], R_Spike[104], R_Spike[119], R_Spike[134], 6'b0};
assign InternalSpike105={R_Spike[29], R_Spike[60], R_Spike[105], R_Spike[135], 12'b0};
assign InternalSpike106={R_Spike[2], R_Spike[62], R_Spike[92], R_Spike[121], 12'b0};
assign InternalSpike107={R_Spike[32], R_Spike[47], R_Spike[61], R_Spike[77], R_Spike[78], R_Spike[107], R_Spike[123], 9'b0};
assign InternalSpike108={R_Spike[19], R_Spike[76], R_Spike[80], R_Spike[92], R_Spike[94], R_Spike[107], R_Spike[108], R_Spike[123], 8'b0};
assign InternalSpike109={R_Spike[20], R_Spike[63], R_Spike[94], R_Spike[111], 12'b0};
assign InternalSpike110={R_Spike[2], R_Spike[5], R_Spike[37], R_Spike[49], R_Spike[94], R_Spike[109], R_Spike[110], R_Spike[112], R_Spike[125], R_Spike[126], 6'b0};
assign InternalSpike111={R_Spike[38], R_Spike[39], R_Spike[50], R_Spike[52], R_Spike[66], R_Spike[81], R_Spike[97], R_Spike[112], 8'b0};
assign InternalSpike112={R_Spike[36], R_Spike[51], R_Spike[67], R_Spike[85], R_Spike[97], R_Spike[126], 10'b0};
assign InternalSpike113={R_Spike[52], R_Spike[69], R_Spike[97], R_Spike[98], R_Spike[109], R_Spike[111], R_Spike[112], R_Spike[113], 8'b0};
assign InternalSpike114={R_Spike[8], R_Spike[10], R_Spike[22], R_Spike[24], R_Spike[68], R_Spike[69], R_Spike[81], R_Spike[82], R_Spike[97], R_Spike[114], R_Spike[115], R_Spike[128], 4'b0};
assign InternalSpike115={R_Spike[8], R_Spike[39], R_Spike[42], R_Spike[69], R_Spike[84], R_Spike[99], R_Spike[115], R_Spike[116], 8'b0};
assign InternalSpike116={R_Spike[11], R_Spike[27], R_Spike[55], R_Spike[70], R_Spike[71], R_Spike[73], R_Spike[84], R_Spike[86], R_Spike[100], R_Spike[101], R_Spike[115], R_Spike[116], R_Spike[117], R_Spike[130], R_Spike[131], R_Spike[132]};
assign InternalSpike117={R_Spike[11], R_Spike[26], R_Spike[41], R_Spike[58], R_Spike[73], R_Spike[102], R_Spike[103], R_Spike[116], R_Spike[118], R_Spike[130], R_Spike[132], 5'b0};
assign InternalSpike118={R_Spike[42], R_Spike[69], R_Spike[71], R_Spike[104], R_Spike[119], 11'b0};
assign InternalSpike119={R_Spike[59], R_Spike[73], R_Spike[75], R_Spike[89], R_Spike[134], R_Spike[135], 10'b0};
assign InternalSpike120={R_Spike[73], R_Spike[119], R_Spike[133], R_Spike[134], R_Spike[135], 11'b0};
assign InternalSpike121={R_Spike[17], R_Spike[19], R_Spike[76], R_Spike[78], R_Spike[121], 11'b0};
assign InternalSpike122={R_Spike[2], R_Spike[3], R_Spike[61], R_Spike[63], 12'b0};
assign InternalSpike123={R_Spike[32], R_Spike[49], R_Spike[50], R_Spike[61], R_Spike[78], R_Spike[80], R_Spike[95], R_Spike[108], R_Spike[109], R_Spike[121], R_Spike[122], R_Spike[123], 4'b0};
assign InternalSpike124={R_Spike[2], R_Spike[48], R_Spike[64], R_Spike[76], R_Spike[78], R_Spike[109], R_Spike[123], R_Spike[125], R_Spike[126], 7'b0}; 
assign InternalSpike125={R_Spike[64], R_Spike[66], R_Spike[111], R_Spike[126], 12'b0}; 
assign InternalSpike126={R_Spike[35], R_Spike[79], R_Spike[80], R_Spike[82], R_Spike[83], R_Spike[95], R_Spike[110], 9'b0};
assign InternalSpike127={R_Spike[36], R_Spike[68], R_Spike[82], R_Spike[97], R_Spike[110], R_Spike[127], 10'b0};
assign InternalSpike128={R_Spike[69], R_Spike[112], R_Spike[113], R_Spike[115], 12'b0};
assign InternalSpike129={R_Spike[41], R_Spike[54], R_Spike[68], R_Spike[70], R_Spike[85], R_Spike[98], R_Spike[99], R_Spike[102], R_Spike[113], R_Spike[114], R_Spike[116], 5'b0};
assign InternalSpike130={R_Spike[23], R_Spike[39], R_Spike[56], R_Spike[84], R_Spike[86], 11'b0};
assign InternalSpike131={R_Spike[53], R_Spike[56], R_Spike[69], R_Spike[85], R_Spike[87], 11'b0};
assign InternalSpike132={R_Spike[86], R_Spike[87], R_Spike[131], 13'b0};
assign InternalSpike133={R_Spike[73], R_Spike[102], R_Spike[104], R_Spike[118], R_Spike[133], 11'b0};
assign InternalSpike134={R_Spike[12], R_Spike[44], R_Spike[59], R_Spike[89], R_Spike[133], R_Spike[135], 10'b0};
assign InternalSpike135={R_Spike[45], R_Spike[73], R_Spike[103], R_Spike[105], R_Spike[118], 11'b0};

// assign the connected synapses type (excitatory or inhibitory) for each neuron
assign R_excite1=16'b1110000000000000; assign R_excite2=16'b1110000000000000; assign R_excite3=16'b1110011111100000; assign R_excite4=16'b 1011101000000000;
assign R_excite5=16'b 1000000000000000; assign R_excite6=16'b 1110111000000000; assign R_excite7=16'b 1101111011000000; assign R_excite8=16'b 1101011000000000;
assign R_excite9=16'b 1011111001100000; assign R_excite10=16'b 1111000000000000; assign R_excite11=16'b 0111000000000000; assign R_excite12=16'b 1111111100100000;
assign R_excite13=16'b 0111100000000000; assign R_excite14=16'b 1111111110000000; assign R_excite15=16'b 1111000000000000; assign R_excite16=16'b 1101000000000000;
assign R_excite17=16'b 1110101101000000; assign R_excite18=16'b 1101101111000000; assign R_excite19=16'b 1011111101100000; assign R_excite20=16'b 0101001110000000;
assign R_excite21=16'b 0111000000000000; assign R_excite22=16'b 1101110111100000; assign R_excite23=16'b 1111011011111000; assign R_excite24=16'b 1111111111100000;
assign R_excite25=16'b 0111111110100000; assign R_excite26=16'b 0111110110000000; assign R_excite27=16'b 1111011000000000; assign R_excite28=16'b 1110110011101000;
assign R_excite29=16'b 1111110000000000; assign R_excite30=16'b 1101110110000000; assign R_excite31=16'b 0010000000000000; assign R_excite32=16'b 1010000000000000;
assign R_excite33=16'b 1111000000000000; assign R_excite34=16'b 0101000000000000; assign R_excite35=16'b 0111011100000000; assign R_excite36=16'b 1111100000000000;
assign R_excite37=16'b 0111011110000000; assign R_excite38=16'b 1111100000000000; assign R_excite39=16'b 1101111111100000; assign R_excite40=16'b 0111110100000000;
assign R_excite41=16'b 1100000000000000; assign R_excite42=16'b 1010111000000000; assign R_excite43=16'b 0100000000000000; assign R_excite44=16'b 1011000000000000;
assign R_excite45=16'b 1111000000000000; assign R_excite46=16'b 1000000000000000; assign R_excite47=16'b 1110000000000000; assign R_excite48=16'b 1010101110000000;
assign R_excite49=16'b 1001110000000000; assign R_excite50=16'b 1110100000000000; assign R_excite51=16'b 1111111010000000; assign R_excite52=16'b 1011000000000000;
assign R_excite53=16'b 1111101011110000; assign R_excite54=16'b 1111110111000000; assign R_excite55=16'b 0111110000000000; assign R_excite56=16'b 1111111000000000;
assign R_excite57=16'b 1111111010000000; assign R_excite58=16'b 1010111010000000; assign R_excite59=16'b 1010111000000000; assign R_excite60=16'b 0000000000000000;
assign R_excite61=16'b 1101000000000000; assign R_excite62=16'b 1111100000000000; assign R_excite63=16'b 1101110111000000; assign R_excite64=16'b 0101111101001100;
assign R_excite65=16'b 1111111100000000; assign R_excite66=16'b 1100100000000000; assign R_excite67=16'b 1110111111101000; assign R_excite68=16'b 1011110000000000;
assign R_excite69=16'b 1111000000000000; assign R_excite70=16'b 1111111111110000; assign R_excite71=16'b 1111111110000000; assign R_excite72=16'b 1111111000000000;
assign R_excite73=16'b 1111110000000000; assign R_excite74=16'b 1010111110000000; assign R_excite75=16'b 1110111110000000; assign R_excite76=16'b 0001011000000000;
assign R_excite77=16'b 1011011101110000; assign R_excite78=16'b 1100000000000000; assign R_excite79=16'b 0011011111000000; assign R_excite80=16'b 1011010000000000;
assign R_excite81=16'b 1111100000000000; assign R_excite82=16'b 1010111100000000; assign R_excite83=16'b 1111111110000000; assign R_excite84=16'b 1111111111010000;
assign R_excite85=16'b 1111111111100100; assign R_excite86=16'b 1111011110100000; assign R_excite87=16'b 1101101100000000; assign R_excite88=16'b 1110111110010000;
assign R_excite89=16'b 1010110110100000; assign R_excite90=16'b 0111100000000000; assign R_excite91=16'b 1110000000000000; assign R_excite92=16'b 1010100000000000;
assign R_excite93=16'b 1001011010000000; assign R_excite94=16'b 1011111100100000; assign R_excite95=16'b 1111000000000000; assign R_excite96=16'b 0111111111000000;
assign R_excite97=16'b 1011111100111110; assign R_excite98=16'b 1110110000000000; assign R_excite99=16'b 1111110000000000; assign R_excite100=16'b 1111101111110000;
assign R_excite101=16'b 1111100000000000; assign R_excite102=16'b 1110100000000000; assign R_excite103=16'b 1110011100000000; assign R_excite104=16'b 1011011111000000;
assign R_excite105=16'b 0011000000000000; assign R_excite106=16'b 1010000000000000; assign R_excite107=16'b 0011011000000000; assign R_excite108=16'b 0111111100000000;
assign R_excite109=16'b 1111000000000000; assign R_excite110=16'b 1011101101000000; assign R_excite111=16'b 1110111100000000; assign R_excite112=16'b 0111110000000000;
assign R_excite113=16'b 0011011100000000; assign R_excite114=16'b 1011001111100000; assign R_excite115=16'b 1110111100000000; assign R_excite116=16'b 1111101111111010;
assign R_excite117=16'b 1111011100000000; assign R_excite118=16'b 1011100000000000; assign R_excite119=16'b 1011110000000000; assign R_excite120=16'b 0101100000000000;
assign R_excite121=16'b 1010000000000000; assign R_excite122=16'b 1111000000000000; assign R_excite123=16'b 0111010100110000; assign R_excite124=16'b 1111001010000000;
assign R_excite125=16'b 1111000000000000; assign R_excite126=16'b 1111101000000000; assign R_excite127=16'b 0011110000000000; assign R_excite128=16'b 0111000000000000;
assign R_excite129=16'b 1101111111100000; assign R_excite130=16'b 1111100000000000; assign R_excite131=16'b 1101100000000000; assign R_excite132=16'b 1110000000000000;
assign R_excite133=16'b 0110000000000000; assign R_excite134=16'b 1111010000000000; assign R_excite135=16'b 1011000000000000;

// 135 liquid neuron sub-module
LiquidNeuron L1(.curr_spike(cs1), .InputSpike(InputSpike1),   .I_W_Weight(I_W_Weight1), .InternalSpike(InternalSpike1), .R_excite(R_excite1), .R_W_Weight(R_excite1),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L2(.curr_spike(cs2), .InputSpike(InputSpike2),   .I_W_Weight(I_W_Weight2), .InternalSpike(InternalSpike2), .R_excite(R_excite2), .R_W_Weight(R_excite2),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L3(.curr_spike(cs3), .InputSpike(InputSpike3),   .I_W_Weight(I_W_Weight3), .InternalSpike(InternalSpike3), .R_excite(R_excite3), .R_W_Weight(R_excite3),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L4(.curr_spike(cs4), .InputSpike(InputSpike4),   .I_W_Weight(I_W_Weight4), .InternalSpike(InternalSpike4), .R_excite(R_excite4), .R_W_Weight(R_excite4),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L5(.curr_spike(cs5), .InputSpike(InputSpike5),   .I_W_Weight(I_W_Weight5), .InternalSpike(InternalSpike5), .R_excite(R_excite5), .R_W_Weight(R_excite5),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L6(.curr_spike(cs6), .InputSpike(InputSpike6),   .I_W_Weight(I_W_Weight6), .InternalSpike(InternalSpike6), .R_excite(R_excite6), .R_W_Weight(R_excite6),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L7(.curr_spike(cs7), .InputSpike(InputSpike7),   .I_W_Weight(I_W_Weight7), .InternalSpike(InternalSpike7), .R_excite(R_excite7), .R_W_Weight(R_excite7),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L8(.curr_spike(cs8), .InputSpike(InputSpike8),   .I_W_Weight(I_W_Weight8), .InternalSpike(InternalSpike8), .R_excite(R_excite8), .R_W_Weight(R_excite8),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L9(.curr_spike(cs9), .InputSpike(InputSpike9),   .I_W_Weight(I_W_Weight9), .InternalSpike(InternalSpike9), .R_excite(R_excite9), .R_W_Weight(R_excite9),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L10(.curr_spike(cs10), .InputSpike(InputSpike10),   .I_W_Weight(I_W_Weight10), .InternalSpike(InternalSpike10), .R_excite(R_excite10), .R_W_Weight(R_excite10),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L11(.curr_spike(cs11), .InputSpike(InputSpike11),   .I_W_Weight(I_W_Weight11), .InternalSpike(InternalSpike11), .R_excite(R_excite11), .R_W_Weight(R_excite11),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L12(.curr_spike(cs12), .InputSpike(InputSpike12),   .I_W_Weight(I_W_Weight12), .InternalSpike(InternalSpike12), .R_excite(R_excite12), .R_W_Weight(R_excite12),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L13(.curr_spike(cs13), .InputSpike(InputSpike13),   .I_W_Weight(I_W_Weight13), .InternalSpike(InternalSpike13), .R_excite(R_excite13), .R_W_Weight(R_excite13),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L14(.curr_spike(cs14), .InputSpike(InputSpike14),   .I_W_Weight(I_W_Weight14), .InternalSpike(InternalSpike14), .R_excite(R_excite14), .R_W_Weight(R_excite14),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L15(.curr_spike(cs15), .InputSpike(InputSpike15),   .I_W_Weight(I_W_Weight15), .InternalSpike(InternalSpike15), .R_excite(R_excite15), .R_W_Weight(R_excite15),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L16(.curr_spike(cs16), .InputSpike(InputSpike16),   .I_W_Weight(I_W_Weight16), .InternalSpike(InternalSpike16), .R_excite(R_excite16), .R_W_Weight(R_excite16),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L17(.curr_spike(cs17), .InputSpike(InputSpike17),   .I_W_Weight(I_W_Weight17), .InternalSpike(InternalSpike17), .R_excite(R_excite17), .R_W_Weight(R_excite17),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L18(.curr_spike(cs18), .InputSpike(InputSpike18),   .I_W_Weight(I_W_Weight18), .InternalSpike(InternalSpike18), .R_excite(R_excite18), .R_W_Weight(R_excite18),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L19(.curr_spike(cs19), .InputSpike(InputSpike19),   .I_W_Weight(I_W_Weight19), .InternalSpike(InternalSpike19), .R_excite(R_excite19), .R_W_Weight(R_excite19),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L20(.curr_spike(cs20), .InputSpike(InputSpike20),   .I_W_Weight(I_W_Weight20), .InternalSpike(InternalSpike20), .R_excite(R_excite20), .R_W_Weight(R_excite20),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L21(.curr_spike(cs21), .InputSpike(InputSpike21),   .I_W_Weight(I_W_Weight21), .InternalSpike(InternalSpike21), .R_excite(R_excite21), .R_W_Weight(R_excite21),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L22(.curr_spike(cs22), .InputSpike(InputSpike22),   .I_W_Weight(I_W_Weight22), .InternalSpike(InternalSpike22), .R_excite(R_excite22), .R_W_Weight(R_excite22),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L23(.curr_spike(cs23), .InputSpike(InputSpike23),   .I_W_Weight(I_W_Weight23), .InternalSpike(InternalSpike23), .R_excite(R_excite23), .R_W_Weight(R_excite23),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L24(.curr_spike(cs24), .InputSpike(InputSpike24),   .I_W_Weight(I_W_Weight24), .InternalSpike(InternalSpike24), .R_excite(R_excite24), .R_W_Weight(R_excite24),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L25(.curr_spike(cs25), .InputSpike(InputSpike25),   .I_W_Weight(I_W_Weight25), .InternalSpike(InternalSpike25), .R_excite(R_excite25), .R_W_Weight(R_excite25),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L26(.curr_spike(cs26), .InputSpike(InputSpike26),   .I_W_Weight(I_W_Weight26), .InternalSpike(InternalSpike26), .R_excite(R_excite26), .R_W_Weight(R_excite26),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L27(.curr_spike(cs27), .InputSpike(InputSpike27),   .I_W_Weight(I_W_Weight27), .InternalSpike(InternalSpike27), .R_excite(R_excite27), .R_W_Weight(R_excite27),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L28(.curr_spike(cs28), .InputSpike(InputSpike28),   .I_W_Weight(I_W_Weight28), .InternalSpike(InternalSpike28), .R_excite(R_excite28), .R_W_Weight(R_excite28),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L29(.curr_spike(cs29), .InputSpike(InputSpike29),   .I_W_Weight(I_W_Weight29), .InternalSpike(InternalSpike29), .R_excite(R_excite29), .R_W_Weight(R_excite29),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L30(.curr_spike(cs30), .InputSpike(InputSpike30),   .I_W_Weight(I_W_Weight30), .InternalSpike(InternalSpike30), .R_excite(R_excite30), .R_W_Weight(R_excite30),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L31(.curr_spike(cs31), .InputSpike(InputSpike31),   .I_W_Weight(I_W_Weight31), .InternalSpike(InternalSpike31), .R_excite(R_excite31), .R_W_Weight(R_excite31),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L32(.curr_spike(cs32), .InputSpike(InputSpike32),   .I_W_Weight(I_W_Weight32), .InternalSpike(InternalSpike32), .R_excite(R_excite32), .R_W_Weight(R_excite32),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L33(.curr_spike(cs33), .InputSpike(InputSpike33),   .I_W_Weight(I_W_Weight33), .InternalSpike(InternalSpike33), .R_excite(R_excite33), .R_W_Weight(R_excite33),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L34(.curr_spike(cs34), .InputSpike(InputSpike34),   .I_W_Weight(I_W_Weight34), .InternalSpike(InternalSpike34), .R_excite(R_excite34), .R_W_Weight(R_excite34),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L35(.curr_spike(cs35), .InputSpike(InputSpike35),   .I_W_Weight(I_W_Weight35), .InternalSpike(InternalSpike35), .R_excite(R_excite35), .R_W_Weight(R_excite35),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L36(.curr_spike(cs36), .InputSpike(InputSpike36),   .I_W_Weight(I_W_Weight36), .InternalSpike(InternalSpike36), .R_excite(R_excite36), .R_W_Weight(R_excite36),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L37(.curr_spike(cs37), .InputSpike(InputSpike37),   .I_W_Weight(I_W_Weight37), .InternalSpike(InternalSpike37), .R_excite(R_excite37), .R_W_Weight(R_excite37),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L38(.curr_spike(cs38), .InputSpike(InputSpike38),   .I_W_Weight(I_W_Weight38), .InternalSpike(InternalSpike38), .R_excite(R_excite38), .R_W_Weight(R_excite38),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L39(.curr_spike(cs39), .InputSpike(InputSpike39),   .I_W_Weight(I_W_Weight39), .InternalSpike(InternalSpike39), .R_excite(R_excite39), .R_W_Weight(R_excite39),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L40(.curr_spike(cs40), .InputSpike(InputSpike40),   .I_W_Weight(I_W_Weight40), .InternalSpike(InternalSpike40), .R_excite(R_excite40), .R_W_Weight(R_excite40),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L41(.curr_spike(cs41), .InputSpike(InputSpike41),   .I_W_Weight(I_W_Weight41), .InternalSpike(InternalSpike41), .R_excite(R_excite41), .R_W_Weight(R_excite41),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L42(.curr_spike(cs42), .InputSpike(InputSpike42),   .I_W_Weight(I_W_Weight42), .InternalSpike(InternalSpike42), .R_excite(R_excite42), .R_W_Weight(R_excite42),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L43(.curr_spike(cs43), .InputSpike(InputSpike43),   .I_W_Weight(I_W_Weight43), .InternalSpike(InternalSpike43), .R_excite(R_excite43), .R_W_Weight(R_excite43),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L44(.curr_spike(cs44), .InputSpike(InputSpike44),   .I_W_Weight(I_W_Weight44), .InternalSpike(InternalSpike44), .R_excite(R_excite44), .R_W_Weight(R_excite44),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L45(.curr_spike(cs45), .InputSpike(InputSpike45),   .I_W_Weight(I_W_Weight45), .InternalSpike(InternalSpike45), .R_excite(R_excite45), .R_W_Weight(R_excite45),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L46(.curr_spike(cs46), .InputSpike(InputSpike46),   .I_W_Weight(I_W_Weight46), .InternalSpike(InternalSpike46), .R_excite(R_excite46), .R_W_Weight(R_excite46),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L47(.curr_spike(cs47), .InputSpike(InputSpike47),   .I_W_Weight(I_W_Weight47), .InternalSpike(InternalSpike47), .R_excite(R_excite47), .R_W_Weight(R_excite47),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L48(.curr_spike(cs48), .InputSpike(InputSpike48),   .I_W_Weight(I_W_Weight48), .InternalSpike(InternalSpike48), .R_excite(R_excite48), .R_W_Weight(R_excite48),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L49(.curr_spike(cs49), .InputSpike(InputSpike49),   .I_W_Weight(I_W_Weight49), .InternalSpike(InternalSpike49), .R_excite(R_excite49), .R_W_Weight(R_excite49),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L50(.curr_spike(cs50), .InputSpike(InputSpike50),   .I_W_Weight(I_W_Weight50), .InternalSpike(InternalSpike50), .R_excite(R_excite50), .R_W_Weight(R_excite50),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L51(.curr_spike(cs51), .InputSpike(InputSpike51),   .I_W_Weight(I_W_Weight51), .InternalSpike(InternalSpike51), .R_excite(R_excite51), .R_W_Weight(R_excite51),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L52(.curr_spike(cs52), .InputSpike(InputSpike52),   .I_W_Weight(I_W_Weight52), .InternalSpike(InternalSpike52), .R_excite(R_excite52), .R_W_Weight(R_excite52),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L53(.curr_spike(cs53), .InputSpike(InputSpike53),   .I_W_Weight(I_W_Weight53), .InternalSpike(InternalSpike53), .R_excite(R_excite53), .R_W_Weight(R_excite53),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L54(.curr_spike(cs54), .InputSpike(InputSpike54),   .I_W_Weight(I_W_Weight54), .InternalSpike(InternalSpike54), .R_excite(R_excite54), .R_W_Weight(R_excite54),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L55(.curr_spike(cs55), .InputSpike(InputSpike55),   .I_W_Weight(I_W_Weight55), .InternalSpike(InternalSpike55), .R_excite(R_excite55), .R_W_Weight(R_excite55),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L56(.curr_spike(cs56), .InputSpike(InputSpike56),   .I_W_Weight(I_W_Weight56), .InternalSpike(InternalSpike56), .R_excite(R_excite56), .R_W_Weight(R_excite56),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L57(.curr_spike(cs57), .InputSpike(InputSpike57),   .I_W_Weight(I_W_Weight57), .InternalSpike(InternalSpike57), .R_excite(R_excite57), .R_W_Weight(R_excite57),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L58(.curr_spike(cs58), .InputSpike(InputSpike58),   .I_W_Weight(I_W_Weight58), .InternalSpike(InternalSpike58), .R_excite(R_excite58), .R_W_Weight(R_excite58),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L59(.curr_spike(cs59), .InputSpike(InputSpike59),   .I_W_Weight(I_W_Weight59), .InternalSpike(InternalSpike59), .R_excite(R_excite59), .R_W_Weight(R_excite59),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L60(.curr_spike(cs60), .InputSpike(InputSpike60),   .I_W_Weight(I_W_Weight60), .InternalSpike(InternalSpike60), .R_excite(R_excite60), .R_W_Weight(R_excite60),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L61(.curr_spike(cs61), .InputSpike(InputSpike61),   .I_W_Weight(I_W_Weight61), .InternalSpike(InternalSpike61), .R_excite(R_excite61), .R_W_Weight(R_excite61),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L62(.curr_spike(cs62), .InputSpike(InputSpike62),   .I_W_Weight(I_W_Weight62), .InternalSpike(InternalSpike62), .R_excite(R_excite62), .R_W_Weight(R_excite62),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L63(.curr_spike(cs63), .InputSpike(InputSpike63),   .I_W_Weight(I_W_Weight63), .InternalSpike(InternalSpike63), .R_excite(R_excite63), .R_W_Weight(R_excite63),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L64(.curr_spike(cs64), .InputSpike(InputSpike64),   .I_W_Weight(I_W_Weight64), .InternalSpike(InternalSpike64), .R_excite(R_excite64), .R_W_Weight(R_excite64),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L65(.curr_spike(cs65), .InputSpike(InputSpike65),   .I_W_Weight(I_W_Weight65), .InternalSpike(InternalSpike65), .R_excite(R_excite65), .R_W_Weight(R_excite65),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L66(.curr_spike(cs66), .InputSpike(InputSpike66),   .I_W_Weight(I_W_Weight66), .InternalSpike(InternalSpike66), .R_excite(R_excite66), .R_W_Weight(R_excite66),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L67(.curr_spike(cs67), .InputSpike(InputSpike67),   .I_W_Weight(I_W_Weight67), .InternalSpike(InternalSpike67), .R_excite(R_excite67), .R_W_Weight(R_excite67),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L68(.curr_spike(cs68), .InputSpike(InputSpike68),   .I_W_Weight(I_W_Weight68), .InternalSpike(InternalSpike68), .R_excite(R_excite68), .R_W_Weight(R_excite68),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L69(.curr_spike(cs69), .InputSpike(InputSpike69),   .I_W_Weight(I_W_Weight69), .InternalSpike(InternalSpike69), .R_excite(R_excite69), .R_W_Weight(R_excite69),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L70(.curr_spike(cs70), .InputSpike(InputSpike70),   .I_W_Weight(I_W_Weight70), .InternalSpike(InternalSpike70), .R_excite(R_excite70), .R_W_Weight(R_excite70),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L71(.curr_spike(cs71), .InputSpike(InputSpike71),   .I_W_Weight(I_W_Weight71), .InternalSpike(InternalSpike71), .R_excite(R_excite71), .R_W_Weight(R_excite71),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L72(.curr_spike(cs72), .InputSpike(InputSpike72),   .I_W_Weight(I_W_Weight72), .InternalSpike(InternalSpike72), .R_excite(R_excite72), .R_W_Weight(R_excite72),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L73(.curr_spike(cs73), .InputSpike(InputSpike73),   .I_W_Weight(I_W_Weight73), .InternalSpike(InternalSpike73), .R_excite(R_excite73), .R_W_Weight(R_excite73),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L74(.curr_spike(cs74), .InputSpike(InputSpike74),   .I_W_Weight(I_W_Weight74), .InternalSpike(InternalSpike74), .R_excite(R_excite74), .R_W_Weight(R_excite74),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L75(.curr_spike(cs75), .InputSpike(InputSpike75),   .I_W_Weight(I_W_Weight75), .InternalSpike(InternalSpike75), .R_excite(R_excite75), .R_W_Weight(R_excite75),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L76(.curr_spike(cs76), .InputSpike(InputSpike76),   .I_W_Weight(I_W_Weight76), .InternalSpike(InternalSpike76), .R_excite(R_excite76), .R_W_Weight(R_excite76),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L77(.curr_spike(cs77), .InputSpike(InputSpike77),   .I_W_Weight(I_W_Weight77), .InternalSpike(InternalSpike77), .R_excite(R_excite77), .R_W_Weight(R_excite77),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L78(.curr_spike(cs78), .InputSpike(InputSpike78),   .I_W_Weight(I_W_Weight78), .InternalSpike(InternalSpike78), .R_excite(R_excite78), .R_W_Weight(R_excite78),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L79(.curr_spike(cs79), .InputSpike(InputSpike79),   .I_W_Weight(I_W_Weight79), .InternalSpike(InternalSpike79), .R_excite(R_excite79), .R_W_Weight(R_excite79),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L80(.curr_spike(cs80), .InputSpike(InputSpike80),   .I_W_Weight(I_W_Weight80), .InternalSpike(InternalSpike80), .R_excite(R_excite80), .R_W_Weight(R_excite80),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L81(.curr_spike(cs81), .InputSpike(InputSpike81),   .I_W_Weight(I_W_Weight81), .InternalSpike(InternalSpike81), .R_excite(R_excite81), .R_W_Weight(R_excite81),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L82(.curr_spike(cs82), .InputSpike(InputSpike82),   .I_W_Weight(I_W_Weight82), .InternalSpike(InternalSpike82), .R_excite(R_excite82), .R_W_Weight(R_excite82),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L83(.curr_spike(cs83), .InputSpike(InputSpike83),   .I_W_Weight(I_W_Weight83), .InternalSpike(InternalSpike83), .R_excite(R_excite83), .R_W_Weight(R_excite83),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L84(.curr_spike(cs84), .InputSpike(InputSpike84),   .I_W_Weight(I_W_Weight84), .InternalSpike(InternalSpike84), .R_excite(R_excite84), .R_W_Weight(R_excite84),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L85(.curr_spike(cs85), .InputSpike(InputSpike85),   .I_W_Weight(I_W_Weight85), .InternalSpike(InternalSpike85), .R_excite(R_excite85), .R_W_Weight(R_excite85),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L86(.curr_spike(cs86), .InputSpike(InputSpike86),   .I_W_Weight(I_W_Weight86), .InternalSpike(InternalSpike86), .R_excite(R_excite86), .R_W_Weight(R_excite86),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L87(.curr_spike(cs87), .InputSpike(InputSpike87),   .I_W_Weight(I_W_Weight87), .InternalSpike(InternalSpike87), .R_excite(R_excite87), .R_W_Weight(R_excite87),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L88(.curr_spike(cs88), .InputSpike(InputSpike88),   .I_W_Weight(I_W_Weight88), .InternalSpike(InternalSpike88), .R_excite(R_excite88), .R_W_Weight(R_excite88),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L89(.curr_spike(cs89), .InputSpike(InputSpike89),   .I_W_Weight(I_W_Weight89), .InternalSpike(InternalSpike89), .R_excite(R_excite89), .R_W_Weight(R_excite89),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L90(.curr_spike(cs90), .InputSpike(InputSpike90),   .I_W_Weight(I_W_Weight90), .InternalSpike(InternalSpike90), .R_excite(R_excite90), .R_W_Weight(R_excite90),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L91(.curr_spike(cs91), .InputSpike(InputSpike91),   .I_W_Weight(I_W_Weight91), .InternalSpike(InternalSpike91), .R_excite(R_excite91), .R_W_Weight(R_excite91),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L92(.curr_spike(cs92), .InputSpike(InputSpike92),   .I_W_Weight(I_W_Weight92), .InternalSpike(InternalSpike92), .R_excite(R_excite92), .R_W_Weight(R_excite92),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L93(.curr_spike(cs93), .InputSpike(InputSpike93),   .I_W_Weight(I_W_Weight93), .InternalSpike(InternalSpike93), .R_excite(R_excite93), .R_W_Weight(R_excite93),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L94(.curr_spike(cs94), .InputSpike(InputSpike94),   .I_W_Weight(I_W_Weight94), .InternalSpike(InternalSpike94), .R_excite(R_excite94), .R_W_Weight(R_excite94),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L95(.curr_spike(cs95), .InputSpike(InputSpike95),   .I_W_Weight(I_W_Weight95), .InternalSpike(InternalSpike95), .R_excite(R_excite95), .R_W_Weight(R_excite95),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L96(.curr_spike(cs96), .InputSpike(InputSpike96),   .I_W_Weight(I_W_Weight96), .InternalSpike(InternalSpike96), .R_excite(R_excite96), .R_W_Weight(R_excite96),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L97(.curr_spike(cs97), .InputSpike(InputSpike97),   .I_W_Weight(I_W_Weight97), .InternalSpike(InternalSpike97), .R_excite(R_excite97), .R_W_Weight(R_excite97),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L98(.curr_spike(cs98), .InputSpike(InputSpike98),   .I_W_Weight(I_W_Weight98), .InternalSpike(InternalSpike98), .R_excite(R_excite98), .R_W_Weight(R_excite98),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L99(.curr_spike(cs99), .InputSpike(InputSpike99),   .I_W_Weight(I_W_Weight99), .InternalSpike(InternalSpike99), .R_excite(R_excite99), .R_W_Weight(R_excite99),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L100(.curr_spike(cs100), .InputSpike(InputSpike100),   .I_W_Weight(I_W_Weight100), .InternalSpike(InternalSpike100), .R_excite(R_excite100), .R_W_Weight(R_excite100),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L101(.curr_spike(cs101), .InputSpike(InputSpike101),   .I_W_Weight(I_W_Weight101), .InternalSpike(InternalSpike101), .R_excite(R_excite101), .R_W_Weight(R_excite101),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L102(.curr_spike(cs102), .InputSpike(InputSpike102),   .I_W_Weight(I_W_Weight102), .InternalSpike(InternalSpike102), .R_excite(R_excite102), .R_W_Weight(R_excite102),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L103(.curr_spike(cs103), .InputSpike(InputSpike103),   .I_W_Weight(I_W_Weight103), .InternalSpike(InternalSpike103), .R_excite(R_excite103), .R_W_Weight(R_excite103),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L104(.curr_spike(cs104), .InputSpike(InputSpike104),   .I_W_Weight(I_W_Weight104), .InternalSpike(InternalSpike104), .R_excite(R_excite104), .R_W_Weight(R_excite104),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L105(.curr_spike(cs105), .InputSpike(InputSpike105),   .I_W_Weight(I_W_Weight105), .InternalSpike(InternalSpike105), .R_excite(R_excite105), .R_W_Weight(R_excite105),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L106(.curr_spike(cs106), .InputSpike(InputSpike106),   .I_W_Weight(I_W_Weight106), .InternalSpike(InternalSpike106), .R_excite(R_excite106), .R_W_Weight(R_excite106),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L107(.curr_spike(cs107), .InputSpike(InputSpike107),   .I_W_Weight(I_W_Weight107), .InternalSpike(InternalSpike107), .R_excite(R_excite107), .R_W_Weight(R_excite107),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L108(.curr_spike(cs108), .InputSpike(InputSpike108),   .I_W_Weight(I_W_Weight108), .InternalSpike(InternalSpike108), .R_excite(R_excite108), .R_W_Weight(R_excite108),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L109(.curr_spike(cs109), .InputSpike(InputSpike109),   .I_W_Weight(I_W_Weight109), .InternalSpike(InternalSpike109), .R_excite(R_excite109), .R_W_Weight(R_excite109),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L110(.curr_spike(cs110), .InputSpike(InputSpike110),   .I_W_Weight(I_W_Weight110), .InternalSpike(InternalSpike110), .R_excite(R_excite110), .R_W_Weight(R_excite110),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L111(.curr_spike(cs111), .InputSpike(InputSpike111),   .I_W_Weight(I_W_Weight111), .InternalSpike(InternalSpike111), .R_excite(R_excite111), .R_W_Weight(R_excite111),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L112(.curr_spike(cs112), .InputSpike(InputSpike112),   .I_W_Weight(I_W_Weight112), .InternalSpike(InternalSpike112), .R_excite(R_excite112), .R_W_Weight(R_excite112),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L113(.curr_spike(cs113), .InputSpike(InputSpike113),   .I_W_Weight(I_W_Weight113), .InternalSpike(InternalSpike113), .R_excite(R_excite113), .R_W_Weight(R_excite113),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L114(.curr_spike(cs114), .InputSpike(InputSpike114),   .I_W_Weight(I_W_Weight114), .InternalSpike(InternalSpike114), .R_excite(R_excite114), .R_W_Weight(R_excite114),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L115(.curr_spike(cs115), .InputSpike(InputSpike115),   .I_W_Weight(I_W_Weight115), .InternalSpike(InternalSpike115), .R_excite(R_excite115), .R_W_Weight(R_excite115),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L116(.curr_spike(cs116), .InputSpike(InputSpike116),   .I_W_Weight(I_W_Weight116), .InternalSpike(InternalSpike116), .R_excite(R_excite116), .R_W_Weight(R_excite116),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L117(.curr_spike(cs117), .InputSpike(InputSpike117),   .I_W_Weight(I_W_Weight117), .InternalSpike(InternalSpike117), .R_excite(R_excite117), .R_W_Weight(R_excite117),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L118(.curr_spike(cs118), .InputSpike(InputSpike118),   .I_W_Weight(I_W_Weight118), .InternalSpike(InternalSpike118), .R_excite(R_excite118), .R_W_Weight(R_excite118),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L119(.curr_spike(cs119), .InputSpike(InputSpike119),   .I_W_Weight(I_W_Weight119), .InternalSpike(InternalSpike119), .R_excite(R_excite119), .R_W_Weight(R_excite119),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L120(.curr_spike(cs120), .InputSpike(InputSpike120),   .I_W_Weight(I_W_Weight120), .InternalSpike(InternalSpike120), .R_excite(R_excite120), .R_W_Weight(R_excite120),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L121(.curr_spike(cs121), .InputSpike(InputSpike121),   .I_W_Weight(I_W_Weight121), .InternalSpike(InternalSpike121), .R_excite(R_excite121), .R_W_Weight(R_excite121),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L122(.curr_spike(cs122), .InputSpike(InputSpike122),   .I_W_Weight(I_W_Weight122), .InternalSpike(InternalSpike122), .R_excite(R_excite122), .R_W_Weight(R_excite122),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L123(.curr_spike(cs123), .InputSpike(InputSpike123),   .I_W_Weight(I_W_Weight123), .InternalSpike(InternalSpike123), .R_excite(R_excite123), .R_W_Weight(R_excite123),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L124(.curr_spike(cs124), .InputSpike(InputSpike124),   .I_W_Weight(I_W_Weight124), .InternalSpike(InternalSpike124), .R_excite(R_excite124), .R_W_Weight(R_excite124),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L125(.curr_spike(cs125), .InputSpike(InputSpike125),   .I_W_Weight(I_W_Weight125), .InternalSpike(InternalSpike125), .R_excite(R_excite125), .R_W_Weight(R_excite125),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L126(.curr_spike(cs126), .InputSpike(InputSpike126),   .I_W_Weight(I_W_Weight126), .InternalSpike(InternalSpike126), .R_excite(R_excite126), .R_W_Weight(R_excite126),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L127(.curr_spike(cs127), .InputSpike(InputSpike127),   .I_W_Weight(I_W_Weight127), .InternalSpike(InternalSpike127), .R_excite(R_excite127), .R_W_Weight(R_excite127),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L128(.curr_spike(cs128), .InputSpike(InputSpike128),   .I_W_Weight(I_W_Weight128), .InternalSpike(InternalSpike128), .R_excite(R_excite128), .R_W_Weight(R_excite128),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L129(.curr_spike(cs129), .InputSpike(InputSpike129),   .I_W_Weight(I_W_Weight129), .InternalSpike(InternalSpike129), .R_excite(R_excite129), .R_W_Weight(R_excite129),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L130(.curr_spike(cs130), .InputSpike(InputSpike130),   .I_W_Weight(I_W_Weight130), .InternalSpike(InternalSpike130), .R_excite(R_excite130), .R_W_Weight(R_excite130),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L131(.curr_spike(cs131), .InputSpike(InputSpike131),   .I_W_Weight(I_W_Weight131), .InternalSpike(InternalSpike131), .R_excite(R_excite131), .R_W_Weight(R_excite131),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L132(.curr_spike(cs132), .InputSpike(InputSpike132),   .I_W_Weight(I_W_Weight132), .InternalSpike(InternalSpike132), .R_excite(R_excite132), .R_W_Weight(R_excite132),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L133(.curr_spike(cs133), .InputSpike(InputSpike133),   .I_W_Weight(I_W_Weight133), .InternalSpike(InternalSpike133), .R_excite(R_excite133), .R_W_Weight(R_excite133),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L134(.curr_spike(cs134), .InputSpike(InputSpike134),   .I_W_Weight(I_W_Weight134), .InternalSpike(InternalSpike134), .R_excite(R_excite134), .R_W_Weight(R_excite134),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));
LiquidNeuron L135(.curr_spike(cs135), .InputSpike(InputSpike135),   .I_W_Weight(I_W_Weight135), .InternalSpike(InternalSpike135), .R_excite(R_excite135), .R_W_Weight(R_excite135),   .Clk(Clk),	.state(state), .cnt_i(cnt_i), .cnt_r(cnt_r));

//**** control/function logic for liquid neuron****//
/* all neurons are controlled by same state signal and work parallelly */
always @(posedge Clk)
begin
  if(Rst || switch)  
	  begin
			state <= 0;   // waiting for a new input to come
	  end
  else
	  case(state)
			3'b000: 			// initialization
				begin
				  state <= 3'b001;
				  R_Spike <= 135'b0;
				  R_Spike_Next <=135'b0;
				  cnt_i <= 1;
				  cnt_r <= 1;
			  end  
			3'b001:                        // variable leakage
			  begin
			       state <= 3'b010; 
			       R_Spike <= R_Spike_Next;
			  end
			3'b010:                       // potentiate neurons with external input
			  begin
			    if(cnt_i < 8)
			       cnt_i <= cnt_i + 1;
				  else
				    begin
				     state <= 3'b011;
				     cnt_i <= 1;
				    end
				end
			3'b011:                        // potentiate neurons with other liquid neurons 
			  begin
			    if(cnt_r < 16)
		         cnt_r <= cnt_r + 1;
			    else
			      begin
			       state <= 3'b100;		
			       cnt_r <= 1;
			      end
			  end	     
			3'b100: 		// update membrane voltage
			  begin
			     state <= 3'b101;    
			  end
			3'b101: 	// generate spikes
			     state <= 3'b110;
			3'b110:	// flop the spikes
			  begin
			  if(ReqRChannel) 
			  begin 
			     state <= 3'b001;
			     R_Spike_Next[1] <= cs1; R_Spike_Next[2] <= cs2; R_Spike_Next[3] <= cs3; R_Spike_Next[4] <= cs4; R_Spike_Next[5] <= cs5; R_Spike_Next[6] <= cs6; R_Spike_Next[7] <= cs7; R_Spike_Next[8] <= cs8; R_Spike_Next[9] <= cs9; R_Spike_Next[10] <= cs10; 
		      R_Spike_Next[11] <= cs11; R_Spike_Next[12] <= cs12; R_Spike_Next[13] <= cs13; R_Spike_Next[14] <= cs14; R_Spike_Next[15] <= cs15; R_Spike_Next[16] <= cs16; R_Spike_Next[17] <= cs17; R_Spike_Next[18] <= cs18; R_Spike_Next[19] <= cs19; R_Spike_Next[20] <= cs20; 
		      R_Spike_Next[21] <= cs21; R_Spike_Next[22] <= cs22; R_Spike_Next[23] <= cs23; R_Spike_Next[24] <= cs24; R_Spike_Next[25] <= cs25; R_Spike_Next[26] <= cs26; R_Spike_Next[27] <= cs27; R_Spike_Next[28] <= cs28; R_Spike_Next[29] <= cs29; R_Spike_Next[30] <= cs30; 
		      R_Spike_Next[31] <= cs31; R_Spike_Next[32] <= cs32; R_Spike_Next[33] <= cs33; R_Spike_Next[34] <= cs34; R_Spike_Next[35] <= cs35; R_Spike_Next[36] <= cs36; R_Spike_Next[37] <= cs37; R_Spike_Next[38] <= cs38; R_Spike_Next[39] <= cs39; R_Spike_Next[40] <= cs40; 
		      R_Spike_Next[41] <= cs41; R_Spike_Next[42] <= cs42; R_Spike_Next[43] <= cs43; R_Spike_Next[44] <= cs44; R_Spike_Next[45] <= cs45; R_Spike_Next[46] <= cs46; R_Spike_Next[47] <= cs47; R_Spike_Next[48] <= cs48; R_Spike_Next[49] <= cs49; R_Spike_Next[50] <= cs50; 
		      R_Spike_Next[51] <= cs51; R_Spike_Next[52] <= cs52; R_Spike_Next[53] <= cs53; R_Spike_Next[54] <= cs54; R_Spike_Next[55] <= cs55; R_Spike_Next[56] <= cs56; R_Spike_Next[57] <= cs57; R_Spike_Next[58] <= cs58; R_Spike_Next[59] <= cs59; R_Spike_Next[60] <= cs60; 
		      R_Spike_Next[61] <= cs61; R_Spike_Next[62] <= cs62; R_Spike_Next[63] <= cs63; R_Spike_Next[64] <= cs64; R_Spike_Next[65] <= cs65; R_Spike_Next[66] <= cs66; R_Spike_Next[67] <= cs67; R_Spike_Next[68] <= cs68; R_Spike_Next[69] <= cs69; R_Spike_Next[70] <= cs70; 
		      R_Spike_Next[71] <= cs71; R_Spike_Next[72] <= cs72; R_Spike_Next[73] <= cs73; R_Spike_Next[74] <= cs74; R_Spike_Next[75] <= cs75; R_Spike_Next[76] <= cs76; R_Spike_Next[77] <= cs77; R_Spike_Next[78] <= cs78; R_Spike_Next[79] <= cs79; R_Spike_Next[80] <= cs80; 
		      R_Spike_Next[81] <= cs81; R_Spike_Next[82] <= cs82; R_Spike_Next[83] <= cs83; R_Spike_Next[84] <= cs84; R_Spike_Next[85] <= cs85; R_Spike_Next[86] <= cs86; R_Spike_Next[87] <= cs87; R_Spike_Next[88] <= cs88; R_Spike_Next[89] <= cs89; R_Spike_Next[90] <= cs90; 
		      R_Spike_Next[91] <= cs91; R_Spike_Next[92] <= cs92; R_Spike_Next[93] <= cs93; R_Spike_Next[94] <= cs94; R_Spike_Next[95] <= cs95; R_Spike_Next[96] <= cs96; R_Spike_Next[97] <= cs97; R_Spike_Next[98] <= cs98; R_Spike_Next[99] <= cs99; R_Spike_Next[100] <= cs100; 
		      R_Spike_Next[101] <= cs101; R_Spike_Next[102] <= cs102; R_Spike_Next[103] <= cs103; R_Spike_Next[104] <= cs104; R_Spike_Next[105] <= cs105; R_Spike_Next[106] <= cs106; R_Spike_Next[107] <= cs107; R_Spike_Next[108] <= cs108; R_Spike_Next[109] <= cs109; R_Spike_Next[110] <= cs110; 
		      R_Spike_Next[111] <= cs111; R_Spike_Next[112] <= cs112; R_Spike_Next[113] <= cs113; R_Spike_Next[114] <= cs114; R_Spike_Next[115] <= cs115; R_Spike_Next[116] <= cs116; R_Spike_Next[117] <= cs117; R_Spike_Next[118] <= cs118; R_Spike_Next[119] <= cs119; R_Spike_Next[120] <= cs120; 
		      R_Spike_Next[121] <= cs121; R_Spike_Next[122] <= cs122; R_Spike_Next[123] <= cs123; R_Spike_Next[124] <= cs124; R_Spike_Next[125] <= cs125; R_Spike_Next[126] <= cs126; R_Spike_Next[127] <= cs127; R_Spike_Next[128] <= cs128; R_Spike_Next[129] <= cs129; R_Spike_Next[130] <= cs130; 
		      R_Spike_Next[131] <= cs131; R_Spike_Next[132] <= cs132; R_Spike_Next[133] <= cs133; R_Spike_Next[134] <= cs134; R_Spike_Next[135] <= cs135; 
		      end
			  end
			default: state <= 0;
	  endcase
end

//always @(posedge Clk)
//	begin
//		state <= nextstate;
//	end 

endmodule
/*

function [RChannel]=ObtainRChannel(pattern, I_pre_index, I_pre_weight, R_pre_index, R_pre_excite, R_pre_weight)
R_Spike=zeros(1,135);
RChannel=zeros(135,length(pattern(1,:)));
Vre=zeros(1,135);   lsm_ref=zeros(1,135);
EPre=zeros(1,135); ENre=zeros(1,135);  IPre=zeros(1,135);  INre=zeros(1,135);
ExternalSpike=zeros(1,8);    %%%% The spikes coming from input layer neurons %%%%
InternalSpike=zeros(1,16);    %%%% The spikes coming from liquid neurons %%%%
R_Spike_Next=R_Spike;
for t=1:length(pattern(1,:))
    patterncolumn=pattern(:,t); %%%% Each time column of the pattern
    R_Spike=R_Spike_Next;
    for i=1:135
        for j=1:8  %%% Scan through all the input neurons into this liquid neuron
            if(I_pre_index(j,i)~=0)   
               ExternalSpike(j)=patterncolumn(I_pre_index(j,i)); %%% Spikes from input neurons to this liquid neuron
            else                     %%% empty elements in I_R_Vector(:,i)   
               ExternalSpike(j)=0;
            end
        end
        for j=1:16  %%% Scan through all the input neurons into this liquid neuron
            if(R_pre_index(j,i)~=0)   
               InternalSpike(j)=R_Spike(R_pre_index(j,i)); %%% Spikes from liq neurons to this liquid neuron
               R_Spike_Next(R_pre_index(j,i))=0;      %%%%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
            else                     %%% empty elements in R_pre_index(:,i)   
               InternalSpike(j)=0;
            end
        end
        [RChannel(i,:), Vre(i), lsm_ref(i), EPre(i), ENre(i), IPre(i), INre(i), currentspike]...
        =PotentiateEachLiquidNeuron(t, RChannel(i,:), Vre(i), lsm_ref(i), ...
                                    ExternalSpike, I_pre_weight(:,i), ...
                                    EPre(i), ENre(i), IPre(i), INre(i), ...
                                    InternalSpike, R_pre_excite(:,i), R_pre_weight(:,i));
        R_Spike_Next(i)=currentspike;   
    end
end
end

*/