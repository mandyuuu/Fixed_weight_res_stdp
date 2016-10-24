//------------------------------
//©   2016  Qian Wang, Yu Liu, Yingyezhe Jin, Peng Li
//Department of Electrical and Computer Engineering
//Texas A&M University

//Contact: 
//Prof. Peng Li
//Department of ECE
//3259 TAMU,  College Station, TX 77843
//pli@tamu.edu   (979) 845-1612          
//--------------------------------

`timescale 1ns / 1ps
/*****
Description:   
This is the testbench of the design, basically how input sequences are fed into the system. 

Each input file is a speech record of one of the 10 digits (0-9) which has been re-processed in order to feed into neural processor. It is in 
the form of a 2D array, in where each column corresponds to a channel, and each row presents a time point. An '1' means that there is a spike 
stimulus input in this channel at time t and a '0' other wise. The input file is taken by the neural processor row by row. After finishing 
processing one row, the neural processor will reponse to the input and request for the next. 

The whole process of speech recognition application can be diveded into two stages. The first one is training stage. During this stage, all the 
input files will beiteratively given to the system for N times. The teacher signal will be provided along with inputs to indicate which class 
does this input belongs to during draining. After N iteration is finished, the speech patterns will be given to the system again, but this time 
only onces for testing. The firing times of each readout neuron during test phase will be counted and the result shows how correctly the system 
can classify the speech input without teacher signal.

********/

module TB_LSM(
    );
   reg [77:1] FromR1 [1:786];  // store input pattern to FPGA
   reg [77:1] FromR2 [1:786];
   reg [77:1] FromR3 [1:786];
   reg [77:1] FromR4 [1:786];
   reg [77:1] FromR5 [1:786];
   reg [77:1] FromR6 [1:786];
   reg [77:1] FromR7 [1:786];
   reg [77:1] FromR8 [1:786];
   reg [77:1] FromR9 [1:786];
   reg [77:1] FromR10 [1:786];
  
   reg Clk, Clk_R, Rst, switch;
   reg [9:0] t;
   reg [4:0] TopState;	// indicates which class does current input belong to 
   reg [5:0] Iteration;
   reg Train_Done;
   
   parameter Cycle=20;
   parameter ONUstate=4'b0001;
   parameter Zerofill=77'b0;
 
   parameter l0=480;		// the lentgh of input can be inferred from its file name
   parameter l1=410;
   parameter l2=480;
   parameter l3=580;
   parameter l4=560;
   parameter l5=600;
   parameter l6=690;
   parameter l7=580;
   parameter l8=490;
   parameter l9=610;
   // ... continue to specify input pattern length if read in more patterns 
	
   wire cs1, cs2, cs3, cs4, cs5, cs6, cs7, cs8, cs9, cs10;
   wire [3:0] state;
   wire [2:0] R_state;
   reg [77:1] Pattern;
   //wire [135:1] RChannel;
   wire Mode=Train_Done;
   wire [10:0] cnt_fire1, cnt_fire2, cnt_fire3, cnt_fire4, cnt_fire5, cnt_fire6, cnt_fire7, cnt_fire8, cnt_fire9, cnt_fire10;
   reg [1:0] Teach1, Teach2, Teach3, Teach4, Teach5, Teach6, Teach7, Teach8, Teach9, Teach10;
 
    top_module uut (
		.Clk(Clk), 
		.Rst(Rst), 
		.switch(switch), 
		.Mode(Mode), 
		.Pattern(Pattern), 
		.Teach1(Teach1), 
		.Teach2(Teach2), 
		.Teach3(Teach3), 
		.Teach4(Teach4), 
		.Teach5(Teach5), 
		.Teach6(Teach6), 
		.Teach7(Teach7), 
		.Teach8(Teach8), 
		.Teach9(Teach9), 
		.Teach10(Teach10),
      .R_state(R_state),        // The state of reservoir		
		.state(state),            // The state of training unit
		.cs1(cs1), 
		.cs2(cs2), 
		.cs3(cs3), 
		.cs4(cs4), 
		.cs5(cs5), 
		.cs6(cs6), 
		.cs7(cs7), 
		.cs8(cs8), 
		.cs9(cs9), 
		.cs10(cs10), 
		.cnt_fire1(cnt_fire1), 
		.cnt_fire2(cnt_fire2), 
		.cnt_fire3(cnt_fire3), 
		.cnt_fire4(cnt_fire4), 
		.cnt_fire5(cnt_fire5), 
		.cnt_fire6(cnt_fire6), 
		.cnt_fire7(cnt_fire7), 
		.cnt_fire8(cnt_fire8), 
		.cnt_fire9(cnt_fire9), 
		.cnt_fire10(cnt_fire10)
	);                   
   integer i;
  initial
	 begin
// read input pattern from *.txt file, in this simulation, only 10 inputs are learned and tested. 

/* the naming convention is:¡¡LSM+class_pattern length. For example, LSM0_480.txt means that this is the input pattern file for digit 0,
   the lenghth of this input pattern is 480 */
	  $readmemb("{your file directory}/LSM0_480.txt", FromR1);   // please change the path of input pattern here
	  $readmemb("{your file directory}/LSM1_410.txt", FromR2);
	  $readmemb("{your file directory}/LSM2_480.txt", FromR3);
	  $readmemb("{your file directory}/LSM3_580.txt", FromR4);
	  $readmemb("{your file directory}/LSM4_560.txt", FromR5);
	  $readmemb("{your file directory}/LSM5_600.txt", FromR6);
	  $readmemb("{your file directory}/LSM6_690.txt", FromR7);
	  $readmemb("{your file directory}/LSM7_580.txt", FromR8);
	  $readmemb("{your file directory}/LSM8_490.txt", FromR9);
	  $readmemb("{your file directory}/LSM9_610.txt", FromR10);
// .. continue to read pattern in if more input patterns are given

		Clk=0;
		Clk_R=0;
		Rst=1;
	  #50
		Rst=0;
	 end

always @(posedge Clk)
begin
  if(Rst)
    begin
     t<=0;
     switch<=1;
     Iteration<=1;
     Train_Done<=0;
    end
  else
    begin
      case(TopState)
      0: if(t==l0) 
            begin 
            t<=0;
            switch<=1;  // When reservoir finishing processing one input pattern, switch to next one
            end 
         else 
           begin
            switch<=0; 
            t<=(R_state==1)?(t+1):t;   // When reservoir finishing processing one row of input, move to next one
           end
      1: if(t==l1) 
           begin
            t<=0; 
            switch<=1;
            end
         else
           begin
             switch<=0; 
            t<=(R_state==1)?(t+1):t;
           end
      2: if(t==l2) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end
       3: if(t==l3) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end
      4: if(t==l4) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end  
      5: if(t==l5) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end 
       6: if(t==l6) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end 
      7: if(t==l7) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end
      8: if(t==l8) 
          begin
            switch<=1;
            t<=0; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end  
       9: if(t==l9) 
          begin
            switch<=1;
            t<=0; 
            Iteration<=Iteration+1; 
          end
         else 
           begin
            t<=(R_state==1)?(t+1):t;
            switch<=0;
           end                          
    
      endcase 
      if(Iteration==Cycle+1) Train_Done<=1;   // repeat training for certain iterations
    end
end

always @(posedge Clk)
  begin
    if(Rst)
        TopState <=0;
    else
    case(TopState)
      0: begin				// when input pattern belongs to class 0 ( the pattern records the speech of digit 0)
          if(!Train_Done)    // train_done = 0, the system is now in training mode
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR1[t]; 
              Teach1<=2'b01;   // apply external teacher signals during training, the teacher signal of current class is 2'b01, all others are 2'b10
				  Teach2<=2'b10; 
				  Teach3<=2'b10; 
				  Teach4<=2'b10; 
				  Teach5<=2'b10; 
				  Teach6<=2'b10; 
				  Teach7<=2'b10; 
				  Teach8<=2'b10; 
				  Teach9<=2'b10; 
				  Teach10<=2'b10; 
            end
          else   // the system is now in testing mode, so no external teacher signal should be given
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR1[t]; 
              Teach1<=2'b00; 
				  Teach2<=2'b00; 
				  Teach3<=2'b00; 
				  Teach4<=2'b00; 
				  Teach5<=2'b00; 
				  Teach6<=2'b00; 
				  Teach7<=2'b00; 
				  Teach8<=2'b00; 
				  Teach9<=2'b00; 
				  Teach10<=2'b00;
            end
          if(t==l0) TopState<=1;     // when the pattern of current speech finishs, turn to next one
         end
      1: begin 
          if(!Train_Done)
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR2[t]; 
              Teach1<=2'b10; 
				  Teach2<=2'b01; 
				  Teach3<=2'b10; 
				  Teach4<=2'b10; 
				  Teach5<=2'b10; 
				  Teach6<=2'b10; 
				  Teach7<=2'b10;
				  Teach8<=2'b10;
				  Teach9<=2'b10; 
				  Teach10<=2'b10; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR2[t]; 
              Teach1<=2'b00; 
				  Teach2<=2'b00; 
				  Teach3<=2'b00;
				  Teach4<=2'b00;
				  Teach5<=2'b00; 
				  Teach6<=2'b00;
				  Teach7<=2'b00;
				  Teach8<=2'b00;
				  Teach9<=2'b00; 
				  Teach10<=2'b00; 
            end
          if(t==l1) TopState<=2;
         end
      2: begin 
          if(!Train_Done) 
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR3[t]; 
              Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b01; Teach4<=2'b10; Teach5<=2'b10; Teach6<=2'b10; Teach7<=2'b10; Teach8<=2'b10; Teach9<=2'b10; Teach10<=2'b10; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR3[t]; 
              Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end  
          if(t==l2) TopState<=3; 
         end
      3: begin 
          if(!Train_Done) 
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR4[t]; 
              Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b01; Teach5<=2'b10; Teach6<=2'b10; Teach7<=2'b10; Teach8<=2'b10; Teach9<=2'b10; Teach10<=2'b10; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR4[t]; 
              Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end
          if(t==l3) TopState<=4; 
         end
      4: begin 
          if(!Train_Done)
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR5[t]; 
              Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b10; Teach5<=2'b01; Teach6<=2'b10; Teach7<=2'b10; Teach8<=2'b10; Teach9<=2'b10; Teach10<=2'b10; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR5[t]; 
              Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end
          if(t==l4) TopState<=5; 
         end
      5: begin 
          if(!Train_Done)
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR6[t]; 
              Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b10; Teach5<=2'b10; Teach6<=2'b01; Teach7<=2'b10; Teach8<=2'b10; Teach9<=2'b10; Teach10<=2'b10;
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR6[t]; 
              Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00;
            end
          if(t==l5) TopState<=6; 
         end
      6: begin 
          if(!Train_Done) 
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR7[t]; 
              Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b10; Teach5<=2'b10; Teach6<=2'b10; Teach7<=2'b01; Teach8<=2'b10; Teach9<=2'b10; Teach10<=2'b10; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR7[t];
              Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end
          if(t==l6) TopState<=7; 
         end
      7: begin 
          if(!Train_Done) 
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR8[t]; 
               Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b10; Teach5<=2'b10; Teach6<=2'b10; Teach7<=2'b10; Teach8<=2'b01; Teach9<=2'b10; Teach10<=2'b10; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR8[t]; 
               Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end
          if(t==l7) TopState<=8; 
         end
      8: begin 
          if(!Train_Done)
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR9[t]; 
               Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b10; Teach5<=2'b10; Teach6<=2'b10; Teach7<=2'b10; Teach8<=2'b10; Teach9<=2'b01; Teach10<=2'b10; 
            end 
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR9[t]; 
               Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end 
          if(t==l8) TopState<=9; end
      9: begin 
          if(!Train_Done)
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR10[t]; 
               Teach1<=2'b10; Teach2<=2'b10; Teach3<=2'b10; Teach4<=2'b10; Teach5<=2'b10; Teach6<=2'b10; Teach7<=2'b10; Teach8<=2'b10; Teach9<=2'b10; Teach10<=2'b01; 
            end
          else
            begin if(t==0) Pattern<=Zerofill; else Pattern<=FromR10[t]; 
               Teach1<=2'b00; Teach2<=2'b00; Teach3<=2'b00; Teach4<=2'b00; Teach5<=2'b00; Teach6<=2'b00; Teach7<=2'b00; Teach8<=2'b00; Teach9<=2'b00; Teach10<=2'b00; 
            end
          if(t==l9) 
            if(Train_Done==0) TopState<=0; 
				else 
					begin 
						TopState<=1; //There is no repeat on input when doing the test. Each pattern only go through the system for once.
						$stop; 
					end 
         end
         endcase
  end

always 
#10 Clk=~Clk;

endmodule
