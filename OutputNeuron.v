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

module OutputNeuron(curr_spike, cnt_fire, state, Teacher, Rst, excitatory, RChannel, Clk, Mode, ReqRChannel, R_state);
	
	input [1:0] Teacher;      // teacher signal
   input Clk, Rst;
   input [135:1] excitatory;
   input [135:1] RChannel;
   input Mode;               // Mode==0 is the training mode, Mode==1 is the testing mode
   input [2:0] R_state;
   output curr_spike;
   output [3:0] state;
   output [10:0] cnt_fire;
   output ReqRChannel;
   reg ReqRChannel;
   reg [10:0] cnt_fire;
   reg [3:0] state;
   reg rnd_en;
   reg curr_spike;
   reg signed [15:0] Vmem, C, EP, EN, IP, IN;
   reg [3:0] lsm_ref;
   reg [7:0] cnt;           // counter to access input weights for updating Vmem
   reg [7:0] cnt_lsm;       // counter to access input/output weights for updating the weights themselves
   
   reg [7:0] Addr;
   reg WE;
   wire signed [15:0] W;
   reg signed [15:0] W_new, W_new_pre;
   wire [15:0] rndout1, rndout2;
   RNG1 RNG01(.CLK(Clk), .SET(Rst), .EN(rnd_en), .RANDOM(rndout1));
   //RNG2 RNG02(.CLK(Clk), .SET(Rst), .EN(rnd_en), .RANDOM(rndout2));
   //MEMW MWW(.CLK(Clk), .RST(Rst), .ADDR(Addr), .WE(WE), .DIN(W_new), .DOUT(W));

   //Sandeep
  // MEMW_arm MWW(.CLK(Clk), .A(Addr), .WEN(WE), .D(W_new), .Q(W), .EMA(3'b011), .EMAW(2'b01), .RET1N(1'b1), .CEN(1'b0));

   //MEMW MWW(.clka(Clk), .rsta(Rst), .addra(Addr), .wea(WE), .dina(W_new), .douta(W));
   MEMW MWW(.CLK(Clk), .RST(Rst), .ADDR(Addr), .WE(WE), .DIN(W_new), .DOUT(W));

   //assign Addr=(state==4'b0111)?cnt:cnt_lsm;
   always @(posedge Clk)
     begin
     if(Rst)
       begin
         state <= 0;
         ReqRChannel <=0;
         WE <=0;
       end  
     else  
      case(state)
       4'b0000:        // To initialize Vmem, Calcium, EP, EN, IP, IN and counters
        begin
          rnd_en <=0;
          Vmem <= 0;
          C <= 0;
          EP <= 0;
		      IP <= 0;
		      EN <= 0;
		      IN <= 0;
		      cnt <= 1;
		      cnt_lsm <= 1;
		      lsm_ref <= 0;
		      state <= 4'b0001;
		      cnt_fire<=0;
		      ReqRChannel <=0;
		      WE <=0;
        end
       4'b0001:            // Inherent leakages of Vmem, EP, EN, IP, IN, C of this particular neuron
        begin
          state <= 4'b0111;
          curr_spike <= 0;
          C <= C-(C>>>6);
          EP <= EP-(EP>>>2);            
          EN <= EN-(EN>>>3);            
          IP <= IP-(IP>>>2);            
          IN <= IN-(IN>>>1); 
          ReqRChannel <=1;        
          if((Teacher==2'b01)&&(C<6*1024)) // teacher signal of neuron which coincidences with current pattern class would strength this particular
													// neuron's responding firing activity
            Vmem <= Vmem + 20*1024 - (Vmem>>>5);
          else if((Teacher==2'b10)&&(C>4*1024))		// teacher signals of all other neurons would weaken their firing activity. In this way neuron 
																	// learn the classificaiton efficiently
            Vmem <= Vmem - 10*1024 - (Vmem>>>5);
          else 
            Vmem <= Vmem - (Vmem>>>5);
        end 
       4'b0111:
        begin
          WE<=0;
          ReqRChannel<=0;
          //Addr <=cnt;  
          if(cnt==135)
            begin
               cnt<=1;
               state <=4'b0011;
               ReqRChannel <=0;
            end
          else
            begin
               cnt<=cnt+1;
               state <=4'b0010;
               Addr <= cnt;
            end
        end
       4'b0010:                   // iterate 135 times to accumulate EP, EN and IP and IN
        begin
          WE <=0;
          cnt_lsm <= 1;
          state<=4'b0111;
          if(excitatory[cnt-1]==1)
            begin
              EP <= EP + (RChannel[cnt-1]*W*16);
              EN <= EN + (RChannel[cnt-1]*W*16);
            end
          else
            begin
              IP <= IP + (RChannel[cnt-1]*W*16);
              IN <= IN + (RChannel[cnt-1]*W*16);
            end
        end
       4'b0011:                        // Finalize the membrane potential Vmem
        begin
            state <= 4'b0100;
            Vmem <= Vmem + ((EN-EP)>>>2) + ((IP-IN)>>>1);
        end 
       4'b0100:                        // Compare Vmem with threshold to check fire activity
        begin
            rnd_en<=1;
            state <= 4'b0110;
            if(lsm_ref>0)
				      begin
					     lsm_ref <= lsm_ref-1;
					     Vmem <= 0;
				      end
			      if(Vmem>2048)
			        begin
					     curr_spike <=1;
					     Vmem <= 0;
					     lsm_ref <= 3;
					     C <= C + 1024;   // C: calcium concentrate
					     if(Mode==1)
					       cnt_fire<=cnt_fire+1;
				      end 
        end
        4'b0110:
         begin
            WE <=0;
            Addr <= cnt_lsm;
            if(cnt_lsm==135)
              begin
                cnt_lsm<=1;
                state<=4'b0001;
                ReqRChannel <=0;     //
              end
            else
              begin
                cnt_lsm<=cnt_lsm+1;
                state<=4'b0101;
              end
         end
        4'b0101:         //  Since Calcium is updated in the previous stage, here we update all the 135 presynaptic weights for the current neuron.
          if(Mode==0)
            begin
              WE <=0;
              state <= 4'b1000;      // stochastically update weight value, the weight of synapses is updated sequentially 
              if(RChannel[cnt_lsm-1]==1 && (C > 5*1024) && (C < 8*1024) && ((rndout1)< 50))   // && (({$random} % 1048576 )< 13421*16)
                      W_new_pre <= (W<-512)?(-512):((W>512)? 511:(W + 1));   
              else
              begin           
                  if(RChannel[cnt_lsm-1]==1 && (C < 5*1024) && (C > 2*1024) && ((rndout1)< 50))
                          W_new_pre <= (W<-512)?(-512):((W>512)? 511:(W - 1));  
                  else
                      W_new_pre <= W;      
              end 
            end 
          else
            state <= 4'b0001;
         4'b1000:				// write the up-to-date weight to BRAM
          begin
            WE<=1;
            state<=4'b0110;
            W_new <= W_new_pre;
          end   
     endcase
     end    

endmodule
