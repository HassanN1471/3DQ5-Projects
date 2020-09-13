module milestone1 (
	/////// board clocks                      ////////////
	input logic CLOCK_50_I,                   // 50 MHz clock
	input logic resetn,
	
	input  logic            M1_en,
	output  logic            M1_end,
	
	output logic   [17:0]   SRAM_address,
	input  logic   [15:0]   SRAM_read_data,
	output logic   [15:0]   SRAM_write_data,
	output logic            SRAM_we_n
	
);



typedef enum logic [6:0] {
  S_DELAY1,
  
	S_IDLE,
	
	IN_S_0,
	IN_S_1,
	IN_S_2,
	IN_S_3,
	IN_S_4,
	IN_S_5,
	IN_S_6,
	IN_S_7,
	IN_S_8,
	IN_S_9,
	IN_S_10,
	IN_S_11,
	IN_S_12,
	IN_S_13,
	IN_S_14,
	IN_S_15,
	IN_S_16,
	IN_S_17,
	IN_S_18,
	IN_S_19,
	IN_S_20,
	IN_S_21,
	
	CC_S0_0,
	CC_S0_1,
	CC_S0_2,
	CC_S0_3,
	CC_S0_4,
	CC_S0_5,
	
	CC_S1_0,
	CC_S1_1,
	CC_S1_2,
	CC_S1_3,
	CC_S1_4,
	CC_S1_5,
	
	EN_S_0,
	EN_S_1,
	EN_S_2,
	EN_S_3,
	EN_S_4,
	EN_S_5,
	EN_S_6,
	EN_S_7,
	EN_S_8,
	EN_S_9,
	EN_S_10,
	EN_S_11,
	EN_S_12,
	EN_S_13,
	EN_S_14,
	EN_S_15,
	EN_S_16,
	EN_S_17,
	EN_S_18,
	EN_S_19,
	EN_S_20,
	EN_S_21,
	EN_S_22,
	EN_S_23,
	EN_S_24,
	EN_S_25,
	EN_S_26,
	EN_S_27
	
} M1_state;

M1_state state;

// Define the offset for Green and Blue data in the memory		
parameter Yaddress = 18'd0,
Uaddress = 18'd38400,
Vaddress = 18'd57600,
RGBaddress = 18'd146944;

logic [17:0] data_counter;
logic [17:0] Y_counter;
logic [17:0] RGB_counter;
logic [17:0] U_counter; 
logic [9:0] Vert_count;
logic [9:0] Hori_count;

logic [15:0] Y;

logic [7:0] U [5:0];
logic [7:0] V [5:0];

logic [7:0] Ytest;
logic [7:0] Utest;
logic [7:0] Vtest;

logic [15:0] UPrime;
logic [15:0] VPrime;

logic [32:0] U_Even;
logic [32:0] U_Odd;

logic [32:0] V_Even;
logic [32:0] V_Odd;

logic [15:0] STORY;
logic [15:0] STORU;
logic [15:0] STORV;

logic [31:0] ans1;
logic [31:0] ans2;

logic [15:0] R;
logic [15:0] G;
logic [15:0] B;

logic [31:0] R0;
logic [31:0] G0;
logic [31:0] B0;

logic [31:0] R1;
logic [31:0] G1;
logic [31:0] B1;

logic [31:0] Mult_op_1, Mult_op_2, Mult_op_3, Mult_op_4, Mult_op_5, Mult_op_6, Mult_op_7, Mult_op_8;
logic [31:0] Mult_result1, Mult_result2, Mult_result3, Mult_result4;
logic [63:0] Mult_result_long1, Mult_result_long2, Mult_result_long3, Mult_result_long4;

assign Mult_result_long1 = Mult_op_1 * Mult_op_2;
assign Mult_result1 = Mult_result_long1[31:0];

assign Mult_result_long2 = Mult_op_3 * Mult_op_4;
assign Mult_result2 = Mult_result_long2[31:0];

assign Mult_result_long3 = Mult_op_5 * Mult_op_6;
assign Mult_result3 = Mult_result_long3[31:0];

assign Mult_result_long4 = Mult_op_7 * Mult_op_8;
assign Mult_result4 = Mult_result_long4[31:0];

//comb block
always_comb begin
  			Mult_op_1 = 32'd0;
			Mult_op_2 = 32'd0;
			//V
			Mult_op_3 = 32'd0;
			Mult_op_4 = 32'd0;

			Mult_op_5 = 32'd0;
			Mult_op_6 = 32'd0;
			
			Mult_op_7 = 32'd0;
			Mult_op_8 = 32'd0;
	case(state)
	
		IN_S_5: begin
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd21;
			
		end
		
		IN_S_6: begin
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd52;
			//V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd52;

		end
		
		
		IN_S_7: begin
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd159;
			//V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd159;

		end
		
		IN_S_8: begin
			// U
			Mult_op_1 = {24'd0,U[1]};
			Mult_op_2 = 32'd159;
			//V
			Mult_op_3 = {24'd0,V[1]};
			Mult_op_4 = 32'd159;

		end
		
		IN_S_9: begin
			// U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd52;
			//V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd52;
			
		end
		
		IN_S_10: begin
			// U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;

		end
		
		IN_S_11: begin
			
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;

		end
		
		IN_S_12: begin
			
			//U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;

		end
		
		IN_S_13: begin
			// U
			Mult_op_1 = {24'd0,U[1]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[1]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;

		end
		
		IN_S_14: begin
			// U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;;
			
		end
		
		IN_S_15: begin
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd52;

		end
		
		IN_S_16: begin
			//U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;
			
		end
		
		IN_S_17: begin
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;

		end
		
		IN_S_18: begin
			//U
			Mult_op_1 = {24'd0,U[1]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[1]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;

		end
		
		IN_S_19: begin
			// U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;

		end
		
		IN_S_20: begin
			// U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;

		end
		
		IN_S_21: begin
			// U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd52;

		end
		
		CC_S0_0: begin
			//U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;

		end
		
		CC_S0_1: begin
			
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;
	
		end
		
		CC_S0_2: begin
			//U
			Mult_op_1 = {24'd0,U[1]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[1]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;
	
		end
		
		
		CC_S0_3: begin
			// U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;	

		end
		
		
		CC_S0_4: begin
			// U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;
	
		end
		
		CC_S0_5: begin
			// U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd52;

		end
		
		CC_S1_0: begin
			//U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;

		end
		
		CC_S1_1: begin
			// U
			Mult_op_1 = {24'd0,U[0]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[0]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;

		end
		
		CC_S1_2: begin
			//U
			Mult_op_1 = {24'd0,U[1]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[1]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;

		end
		
		
		CC_S1_3: begin
			// U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;

		end
		
		
		CC_S1_4: begin
			// U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;
			
		end
		
		CC_S1_5: begin
			// U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd52;
				
		end
		
		EN_S_0: begin
			//U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;

		end
		
		EN_S_1: begin
			
			// U
			Mult_op_1 = {24'd0,U[1]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[1]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;

		end
		
		EN_S_2: begin
			//U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;
			
		end
		
		
		EN_S_3: begin
			// U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;	
			
		end
		
		
		EN_S_4: begin
			// U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;

		end
		
		EN_S_5: begin
			// U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd52;
			
			
		end
		
		
		EN_S_6: begin
			//U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;

		end
		
		EN_S_7: begin
			
			// U
			Mult_op_1 = {24'd0,U[2]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[2]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;
			
		end
		
		EN_S_8: begin
			//U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;

		end
		
		EN_S_9: begin
			// U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;
			
		
		end
		
		EN_S_10: begin
			// U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;
			
		
		end
		
		EN_S_11: begin
			// U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd52;
			
		
		end
		
		EN_S_12: begin
			//U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;
			
			
		end
		
		EN_S_13: begin
			
			// U
			Mult_op_1 = {24'd0,U[3]};
			Mult_op_2 = 32'd21;
			
			// V
			Mult_op_3 = {24'd0,V[3]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;
			

		end
		
		EN_S_14: begin
			//U
			Mult_op_1 = {24'd0,U[4]};
			Mult_op_2 = 32'd52;
			
			//V
			Mult_op_3 = {24'd0,V[4]};
			Mult_op_4 = 32'd52;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;
			
		
		end
		
		EN_S_15: begin
			// U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;	
			
			end
		
		EN_S_16: begin
			// U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd159;
			
			// V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd159;
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;
			
		
		end
		
		EN_S_17: begin
			// U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd52;
			
			// V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd52;
			
				
		end
		
		EN_S_18: begin
			//U
			Mult_op_1 = {24'd0,U[5]};
			Mult_op_2 = 32'd21;
			//V
			Mult_op_3 = {24'd0,V[5]};
			Mult_op_4 = 32'd21;
			
			//RGB
			Mult_op_5 = {24'd0,Y[15:8]}-32'd16;
			Mult_op_6 = 32'd76284;
			
			Mult_op_7 = {24'd0,Y[7:0]}-32'd16;
			Mult_op_8 = 32'd76284;
			
		
		end
		
		EN_S_19: begin
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd104595;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd104595;
			
			
		end
		
		EN_S_20: begin
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd25624;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd25624;
			
			
		end
		
		EN_S_21: begin
			
			//RGB
			Mult_op_5 = {24'd0,VPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd53281;
			
			Mult_op_7 = {24'd0,VPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd53281;
			
		
		end
		
		EN_S_22: begin
			
			//RGB
			Mult_op_5 = {24'd0,UPrime[15:8]}-32'd128;
			Mult_op_6 = 32'd132251;
			
			Mult_op_7 = {24'd0,UPrime[7:0]}-32'd128;
			Mult_op_8 = 32'd132251;
			
			
		end

		endcase
		
	end
	
	always_ff @ (posedge CLOCK_50_I or negedge resetn) begin
		if (resetn == 1'b0) begin	
			state <= S_IDLE;
			SRAM_we_n <= 1'b1;
			SRAM_write_data <= 16'd0;
			SRAM_address <= 18'd0;
			data_counter <= 18'd0;
			Y_counter <= 18'd0;
			RGB_counter <= 18'd0;
			Vert_count <= 10'd0;
			Hori_count <= 10'd0;
			M1_end <= 1'b0;
			Y <= 16'd0;
			
			UPrime <= 16'd0; 
			VPrime <= 16'd0;
			STORU <= 16'd0;
			STORV <= 16'd0;
			
			R <= 16'd0;
			G <= 16'd0;
			B <= 16'd0;
			R0 <= 32'd0;
			G0 <= 32'd0;
			B0 <= 32'd0;
			R1 <= 32'd0;
			G1 <= 32'd0;
			B1 <= 32'd0;

			{U[5], U[4], U[3], U[2], U[1], U[0]} <= 48'd0;
			{V[5], V[4], V[3], V[2], V[1], V[0]} <= 48'd0;
			
			ans1 <= 32'd0;
			ans2 <= 32'd0;


			end else begin
			
			case (state)
				
				S_IDLE: begin		
					
					if (Hori_count == 10'd319) begin
						Vert_count <= Vert_count + 10'd1;
						Hori_count <= 10'd0;
						data_counter <= data_counter - 18'd1;
					end
					
					if (Vert_count == 10'd239) begin
						M1_end <= 1'b1;
					end
					
					if (M1_en == 1'b1 && M1_end!=1'b1)
					  
					state <= IN_S_0;	
					
				end
				
				S_DELAY1: begin
				  
				  
				  state <= IN_S_0;	
				end
				IN_S_0: begin
				  SRAM_address <= Uaddress + data_counter;
					SRAM_we_n <= 1'b1;
				
					
					
					state <= IN_S_1;
				end
				
				IN_S_1: begin
				  SRAM_address <= Vaddress + data_counter;
					data_counter <= data_counter +18'd1;
					SRAM_we_n <= 1'b1;
					
					state <= IN_S_2;
				end
				
				IN_S_2: begin
				  SRAM_address <= Uaddress + data_counter;
					SRAM_we_n <= 1'b1;
					
					
					
					
					state <= IN_S_3;
				end
				
				IN_S_3: begin
				  SRAM_address <= Vaddress + data_counter;
				  data_counter <= data_counter +18'd1;
					SRAM_we_n <= 1'b1;
				
					
					U[0] <= SRAM_read_data[15:8];
					U[1] <= SRAM_read_data[7:0];
					
					state <= IN_S_4;
				end
				
				IN_S_4: begin
				  SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					SRAM_we_n <= 1'b1;
					
					
					V[0] <= SRAM_read_data[15:8];
					V[1] <= SRAM_read_data[7:0];
					
					state <= IN_S_5;
				end
				
				IN_S_5: begin
				  SRAM_address <= Uaddress + data_counter;
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					
					U[2] <= SRAM_read_data[15:8];
					U[3] <= SRAM_read_data[7:0];
					
					state <= IN_S_6;
				end
				
				IN_S_6: begin
					SRAM_address <= Vaddress + data_counter;
					data_counter <= data_counter +18'd1;
					SRAM_we_n <= 1'b1;
										
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					
					V[2] <= SRAM_read_data[15:8];
					V[3] <= SRAM_read_data[7:0];
					
					state <= IN_S_7;
				end
				
				IN_S_7: begin
					SRAM_we_n <= 1'b1;
					
					Y <= SRAM_read_data;
					Ytest <= SRAM_read_data[15:8];
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					state <= IN_S_8;
				end
				
				IN_S_8: begin
					SRAM_we_n <= 1'b1;
					
					//U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					
					U[4] <= SRAM_read_data[15:8];
					U[5] <= SRAM_read_data[7:0];
					
					state <= IN_S_9;
				end
				
				IN_S_9: begin
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					V[4] <= SRAM_read_data[15:8];
					V[5] <= SRAM_read_data[7:0];
					
					state <= IN_S_10;
				end
				
				IN_S_10: begin
					
					// U
					UPrime[15:8] <= U[0];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >>8;
					ans1 <= $signed(ans1+Mult_result1+8'd128) >> 8;
					Utest <= $signed(ans1+Mult_result1+8'd128) >> 8;
					// V
					VPrime[15:8] <= V[0];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					ans2 <= $signed(ans2+Mult_result2+8'd128) >> 8;
					Vtest <= $signed(ans2+Mult_result2+8'd128) >> 8;
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					
					state <= IN_S_11;
				end
				
				IN_S_11: begin
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					state <= IN_S_12;
				end
				
				IN_S_12: begin
				  SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= IN_S_13;
				end
				
				IN_S_13: begin
					
					// Y address
					SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= IN_S_14;
				end
				
				IN_S_14: begin
				  SRAM_address <= Uaddress + data_counter;
					SRAM_we_n <= 1'b1;
					
					Hori_count <= Hori_count + 10'd1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					state <= IN_S_15;
				end
				
				IN_S_15: begin

					SRAM_address <= Vaddress + data_counter;
					data_counter <= data_counter + 18'd1;
					SRAM_we_n <= 1'b1;
					
					Y <= SRAM_read_data;
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					SRAM_we_n <= 1'b1;
					
					state <= IN_S_16;
				end
				
				IN_S_16: begin
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					STORY <= SRAM_read_data;
					
					// U
					UPrime[15:8] <= U[1];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[1];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= IN_S_17;
				end
				
				IN_S_17: begin
					STORU <= SRAM_read_data;
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= IN_S_18;
				end
				
				IN_S_18: begin
					STORV <= SRAM_read_data;
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= IN_S_19;
				end
				
				IN_S_19: begin
					SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					
					SRAM_we_n <= 1'b1;
					
					Y <= STORY;
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= IN_S_20;
				end
				
				IN_S_20: begin
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					state <= IN_S_21;
				end
				
				IN_S_21: begin
					SRAM_we_n <= 1'b1;
					
					Hori_count <= Hori_count + 10'd2;
					
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					Hori_count <= Hori_count + 10'd2;
					
					state <= CC_S0_0;
					U_counter <= 18'd5;
				end
				
				
				CC_S0_0: begin	
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					STORY <= SRAM_read_data;
					// U
					UPrime[15:8] <= U[2];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[2];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= Mult_result3;
					G0 <= Mult_result3;
					B0 <= Mult_result3;
					
					R1 <= Mult_result4;
					G1 <= Mult_result4;
					B1 <= Mult_result4;
					
					// shift U and V
					U[0] <= U[1];
					U[1] <= U[2];
					U[2] <= U[3];
					U[3] <= U[4];
					U[4] <= U[5];	
					U[5] <= STORU[15:8];
					
					V[0] <= V[1];
					V[1] <= V[2];
					V[2] <= V[3];
					V[3] <= V[4];
					V[4] <= V[5];	
					V[5] <= STORV[15:8];
					
					SRAM_we_n <= 1'b0;
					
					state <= CC_S0_1;	
				end
				CC_S0_1: begin
					Hori_count <= Hori_count + 10'd2;
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= CC_S0_2;	
				end
				
				CC_S0_2: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= CC_S0_3;	
				end
				
				CC_S0_3: begin
					// Y address
					SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					
					Y <= STORY;
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= CC_S0_4;	
					
					
				end
				
				CC_S0_4: begin
					// U address
					SRAM_address <= Uaddress + data_counter;
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					state <= CC_S0_5;	
				end
				
				CC_S0_5: begin
					// V address
					SRAM_address <= Vaddress + data_counter;
					data_counter <= data_counter + 18'd1;
			
					U_counter <= U_counter + 18'd1;
					
					SRAM_we_n <= 1'b1;
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					
					
					state <= CC_S1_0;	
				end
				
				/////////
				
				CC_S1_0: begin	
					
					Hori_count <= Hori_count + 10'd2;
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					STORY <= SRAM_read_data;
					
					// U
					UPrime[15:8] <= U[2];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[2];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					
					// shift U and V
					U[0] <= U[1];
					U[1] <= U[2];
					U[2] <= U[3];
					U[3] <= U[4];
					U[4] <= U[5];	
					U[5] <= STORU[7:0];
					
					V[0] <= V[1];
					V[1] <= V[2];
					V[2] <= V[3];
					V[3] <= V[4];
					V[4] <= V[5];	
					V[5] <= STORV[7:0];
					
					SRAM_we_n <= 1'b0;
					
					state <= CC_S1_1;	
				end
				
				CC_S1_1: begin
					
					STORU <= SRAM_read_data;
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= CC_S1_2;	
				end
				
				CC_S1_2: begin
					
					STORV <= SRAM_read_data;
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= CC_S1_3;	
				end
				
				CC_S1_3: begin
					// Y address
					SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					
					Y <= STORY;
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= CC_S1_4;	
				end
				
				CC_S1_4: begin
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					
					state <= CC_S1_5;	
				end
				
				CC_S1_5: begin
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					SRAM_we_n <= 1'b1;
					
					if (Hori_count == 10'd311) 
					   state <= EN_S_0;
					else 
					   state <= CC_S0_0;	
				end
				
				EN_S_0: begin	
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					
					STORY <= SRAM_read_data;
					
					// U
					UPrime[15:8] <= U[2];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[2];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					/*
					// shift U and V
					U[0] <= U[1];
					U[1] <= U[2];
					U[2] <= U[3];
					U[3] <= U[4];
					U[4] <= U[5];	
					U[5] <= STORU[15:8];
					
					V[0] <= V[1];
					V[1] <= V[2];
					V[2] <= V[3];
					V[3] <= V[4];
					V[4] <= V[5];	
					V[5] <= STORV[15:8];
					*/
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_1;	
				end
				EN_S_1: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_2;	
				end
				
				EN_S_2: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_3;	
				end
				
				EN_S_3: begin
					// Y address
					SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					
					SRAM_we_n <= 1'b1;
					
					Y <= STORY;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= EN_S_4;	
					
				end
				
				EN_S_4: begin
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
				
					
					state <= EN_S_5;	
				end
				
				EN_S_5: begin
					
					Hori_count <= Hori_count + 10'd2;
					
					SRAM_we_n <= 1'b1;
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					SRAM_we_n <= 1'b1;
					
					state <= EN_S_6;	
					
				end
				
				EN_S_6: begin

					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					STORY <= SRAM_read_data;
					
					// U
					UPrime[15:8] <= U[3];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[3];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_7;
				end
				
				EN_S_7: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;	
					
					state <= EN_S_8;
				end
				
				EN_S_8: begin
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;	
					
					state <= EN_S_9;
				end
				
				EN_S_9: begin
					// Y address
					SRAM_address <= Yaddress + Y_counter;
					Y_counter <= Y_counter + 18'd1;
					
					SRAM_we_n <= 1'b1;
					
					Y <= STORY;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= EN_S_10;
				end
				
				EN_S_10: begin
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					state <= EN_S_11;
				end
				
				EN_S_11: begin
					SRAM_we_n <= 1'b1;
					
					Hori_count <= Hori_count + 10'd2;
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					
					state <= EN_S_12;
				end
				
				EN_S_12: begin
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;

					STORY <= SRAM_read_data;
					
					// U
					UPrime[15:8] <= U[4];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[4];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_13;
				end
				
				EN_S_13: begin
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(Mult_result1);
					
					// V
					ans2 <= $signed(Mult_result2);
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_14;
				end
				
				EN_S_14: begin
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// U
					ans1 <= $signed(ans1-Mult_result1);
					
					// V
					ans2 <= $signed(ans2-Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_15;
				end
				
				EN_S_15: begin
					// Y address
					//SRAM_address <= Yaddress + Y_counter;
					//Y_counter <= Y_counter + 18'd1;
					
					SRAM_we_n <= 1'b1;
					
					Y <= STORY;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					// V
					ans2 <= $signed(ans2+Mult_result2);
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= EN_S_16;
				end
				
				EN_S_16: begin
					
					SRAM_we_n <= 1'b1;
					
					// U
					ans1 <= $signed(ans1+Mult_result1);
					
					//V
					ans2 <= $signed(ans2+Mult_result2);
					
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					state <= EN_S_17;
				end
				
				EN_S_17: begin
					
					//Hori_count <= Hori_count + 10'd2;
					
					SRAM_we_n <= 1'b1;
					
					//U
					ans1 <= $signed(ans1-Mult_result1);
					
					//V
					ans2 <= $signed(ans2-Mult_result2);
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					SRAM_we_n <= 1'b1;
					
					state <= EN_S_18;
				end
				
				EN_S_18: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					Hori_count <= Hori_count + 10'd2;
					
					//STORY <= SRAM_read_data;
					
					// U
					UPrime[15:8] <= U[5];
					UPrime[7:0] <= $signed(ans1+Mult_result1+8'd128) >> 8;
					
					// V
					VPrime[15:8] <= V[5];
					VPrime[7:0] <= $signed(ans2+Mult_result2+8'd128) >> 8;			
					
					// RGB
					R0 <= $signed(Mult_result3);
					G0 <= $signed(Mult_result3);
					B0 <= $signed(Mult_result3);
					
					R1 <= $signed(Mult_result4);
					G1 <= $signed(Mult_result4);
					B1 <= $signed(Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_19;
				end
				
				EN_S_19: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// RGB
					R0 <= $signed(R0 + Mult_result3);
					
					R1 <= $signed(R1 + Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_20;
				end
				
				EN_S_20: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_21;
				end
				
				EN_S_21: begin
					
					SRAM_we_n <= 1'b1;
					
					 //Y <= STORY;
					
					// RGB
					G0 <= $signed(G0 - Mult_result3);
					
					G1 <= $signed(G1 - Mult_result4);
					
					state <= EN_S_22;
				end
				
				EN_S_22: begin
					
					SRAM_we_n <= 1'b1;
					
					// RGB
					B0 <= $signed(B0 + Mult_result3);
					
					B1 <= $signed(B1 + Mult_result4);
					
					state <= EN_S_23;
				end
				
				EN_S_23: begin
					
					Hori_count <= Hori_count + 10'd2;
					
					SRAM_we_n <= 1'b1;
					
					//RGB values
					R[15:8] <= R0[31] ? 8'd0 : |R0[30:24] ? 8'd255 : R0[23:16];
					G[15:8] <= G0[31] ? 8'd0 : |G0[30:24] ? 8'd255 : G0[23:16];
					B[15:8] <= B0[31] ? 8'd0 : |B0[30:24] ? 8'd255 : B0[23:16];
					
					R[7:0] <= R1[31] ? 8'd0 : |R1[30:24] ? 8'd255 : R1[23:16];
					G[7:0] <= G1[31] ? 8'd0 : |G1[30:24] ? 8'd255 : G1[23:16];
					B[7:0] <= B1[31] ? 8'd0 : |B1[30:24] ? 8'd255 : B1[23:16];
					
					SRAM_we_n <= 1'b1;
					
					state <= EN_S_24;
				end
				EN_S_24: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {R[15:8],G[15:8]};
					RGB_counter <= RGB_counter + 18'd1;
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_25;
				end
				EN_S_25: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {B[15:8],R[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_26;
				end
				EN_S_26: begin
					
					SRAM_address <= RGBaddress + RGB_counter;
					SRAM_write_data <= {G[7:0],B[7:0]};
					RGB_counter <= RGB_counter + 18'd1;
					
					SRAM_we_n <= 1'b0;
					
					state <= EN_S_27;
					
				end
				
				EN_S_27: begin
				  
				  SRAM_we_n <= 1'b1;
				  
				  state <= S_IDLE;
				end
				
				default: state <= S_IDLE;
				
			endcase
		end
	end
	
	endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

