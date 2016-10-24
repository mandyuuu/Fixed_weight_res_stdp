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

module LiquidNeuron(curr_spike,
		InputSpike,       // The spike bit from one column of the input pattern
		I_W_Weight,       // This is one bit signal, "1" means "1", "0" means "-1"
		InternalSpike,   
		R_excite,
		R_W_Weight,
		Clk,
		state,
		cnt_i, 
		cnt_r
    );

//parameter LSM_T_M=32;
//parameter LSM_T_REFRAC=2;		 // set refractory period to be 3 clk cycles
//parameter Vth=20;					 // membrane voltage threshold for firing
//parameter Vrest=0;
//parameter Tau_EP=4;
//parameter Tau_IP=4;
//parameter Tau_EN=8;
//parameter Tau_IN=2;

input Clk;
input [5:0] cnt_i, cnt_r;
input [2:0] state;
input [8:1] InputSpike, I_W_Weight;
input [16:1] InternalSpike, R_excite, R_W_Weight;
output curr_spike;
reg curr_spike;
reg signed[31:0] Vmem;
reg signed[31:0] EP, IP, EN, IN;  // state variables of second response 
reg [3:0] lsm_ref;

always @(posedge Clk)
	case(state)
	3'b000: 
	   begin
		  Vmem <= 0;
		  EP <= 0;
		  IP <= 0;
		  EN <= 0;
		  IN <= 0;
		  lsm_ref <= 0;
		end
   3'b001:					// leakage of membrane voltage as well as state variables
      begin
  //      curr_spike <= 0;
        Vmem <= Vmem-(Vmem>>>5);    
        EP <= EP-(EP>>>2);            
        EN <= EN-(EN>>>3);            
        IP <= IP-(IP>>>2);            
        IN <= IN-(IN>>>1);           
      end
   3'b010:
        begin
	 	    EP <= EP + (InputSpike[cnt_i]? (I_W_Weight[cnt_i]?8192:(-8192)):0);
	 	    EN <= EN + (InputSpike[cnt_i]? (I_W_Weight[cnt_i]?8192:(-8192)):0);   
	   end      

	3'b011:
		begin
			EP <= EP +  (InternalSpike[cnt_r]?(R_excite[cnt_r]?16:(0)):0);
			EN <= EN +  (InternalSpike[cnt_r]?(R_excite[cnt_r]?16:(0)):0); 					
				
			IP <= IP +  (InternalSpike[cnt_r]?(R_excite[cnt_r]?(0):(-0)):0); 
			IN <= IN +  (InternalSpike[cnt_r]?(R_excite[cnt_r]?(0):(-0)):0); 
		end
	3'b100:
		begin
			Vmem <= Vmem + ((EN-EP)>>>2) + ((IP-IN)>>>1);
			//$display("Vmem=%d, EN=%d, EP=%d, IP=%d, IN=%d", Vmem, EN, EP, IP, IN);		
		end
	3'b101:
		begin
			if(lsm_ref>0)				// refractory period
				begin
					lsm_ref <= lsm_ref-1;
					Vmem <= 0;
				end
			if(Vmem>20480)
			   begin
					curr_spike <=1;
					Vmem <= 0;
					lsm_ref <= 3;
				end
		  else
		      curr_spike <=0;
		end
   endcase 
  //always @(Vmem or lsm_ref)
   //  $monitor("Vmem=%d, lsm_ref=%d", Vmem, lsm_ref);
    
endmodule
