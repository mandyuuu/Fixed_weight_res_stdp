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

module Readout(cs1, cs2,cs3,cs4,cs5,cs6,cs7,cs8,cs9,cs10,
                    cnt_fire1, cnt_fire2, cnt_fire3, cnt_fire4, cnt_fire5, cnt_fire6, cnt_fire7, cnt_fire8, cnt_fire9, cnt_fire10,
                    state, Clk, Mode,
                    Teach1, Teach2, Teach3, Teach4, Teach5, Teach6, Teach7, Teach8, Teach9, Teach10, switch, RChannel, 
                    ReqRChannel);
                    
   output cs1, cs2,cs3,cs4,cs5,cs6,cs7,cs8,cs9,cs10;
   output wire [10:0] cnt_fire1, cnt_fire2, cnt_fire3, cnt_fire4, cnt_fire5, cnt_fire6, cnt_fire7, cnt_fire8, cnt_fire9, cnt_fire10;
   output wire [3:0] state;
   output ReqRChannel;
   input wire [1:0] Teach1, Teach2, Teach3, Teach4, Teach5, Teach6, Teach7, Teach8, Teach9, Teach10;
   input switch;
   input wire [135:1] RChannel;
   input Clk;
   input Mode;
   wire [135:1] excitatory = 135'b111101111011111111011111111101001110111111011101111011111110101111100110011110111111111111011101111111111111011111111011011101101010011;

   OutputNeuron O1(.curr_spike(cs1), .cnt_fire(cnt_fire1), .state(state), .Teacher(Teach1), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel(ReqRChannel));
   OutputNeuron O2(.curr_spike(cs2), .cnt_fire(cnt_fire2), .state(), .Teacher(Teach2), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O3(.curr_spike(cs3), .cnt_fire(cnt_fire3), .state(), .Teacher(Teach3), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O4(.curr_spike(cs4), .cnt_fire(cnt_fire4), .state(), .Teacher(Teach4), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O5(.curr_spike(cs5), .cnt_fire(cnt_fire5), .state(), .Teacher(Teach5), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O6(.curr_spike(cs6), .cnt_fire(cnt_fire6), .state(), .Teacher(Teach6), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O7(.curr_spike(cs7), .cnt_fire(cnt_fire7), .state(), .Teacher(Teach7), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O8(.curr_spike(cs8), .cnt_fire(cnt_fire8), .state(), .Teacher(Teach8), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O9(.curr_spike(cs9), .cnt_fire(cnt_fire9), .state(), .Teacher(Teach9), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());
   OutputNeuron O10(.curr_spike(cs10), .cnt_fire(cnt_fire10), .state(), .Teacher(Teach10), .Rst(switch), .excitatory(excitatory), .RChannel(RChannel), .Clk(Clk), .Mode(Mode), .ReqRChannel());

endmodule