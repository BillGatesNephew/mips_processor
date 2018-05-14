module decoder (in, hot_encoding);

	/* Port Declarations */
	input [4:0] in;
	output [31:0] hot_encoding;
	
	and and_0(hot_encoding[0], ~in[4], ~in[3], ~in[2], ~in[1], ~in[0]);  // 0 0 0 0 0 
	and and_1(hot_encoding[1], ~in[4], ~in[3], ~in[2], ~in[1], in[0]);   // 0 0 0 0 1
	and and_2(hot_encoding[2], ~in[4], ~in[3], ~in[2], in[1], ~in[0]);   // 0 0 0 1 0
	and and_3(hot_encoding[3], ~in[4], ~in[3], ~in[2], in[1], in[0]);    // 0 0 0 1 1
	and and_4(hot_encoding[4], ~in[4], ~in[3], in[2], ~in[1], ~in[0]);   // 0 0 1 0 0
	and and_5(hot_encoding[5], ~in[4], ~in[3], in[2], ~in[1], in[0]);	 // 0 0 1 0 1
	and and_6(hot_encoding[6], ~in[4], ~in[3], in[2], in[1], ~in[0]);    // 0 0 1 1 0
	and and_7(hot_encoding[7], ~in[4], ~in[3], in[2], in[1], in[0]) ;    // 0 0 1 1 1
	and and_8(hot_encoding[8], ~in[4], in[3], ~in[2], ~in[1], ~in[0]);   // 0 1 0 0 0	  
	and and_9(hot_encoding[9], ~in[4], in[3], ~in[2], ~in[1], in[0]);    // 0 1 0 0 1
	and and_10(hot_encoding[10], ~in[4], in[3], ~in[2], in[1], ~in[0]);  // 0 1 0 1 0 
	and and_11(hot_encoding[11], ~in[4], in[3], ~in[2], in[1], in[0]);   // 0 1 0 1 1
	and and_12(hot_encoding[12], ~in[4], in[3], in[2], ~in[1], ~in[0]);  // 0 1 1 0 0  
	and and_13(hot_encoding[13], ~in[4], in[3], in[2], ~in[1], in[0]);   // 0 1 1 0 1
	and and_14(hot_encoding[14], ~in[4], in[3], in[2], in[1], ~in[0]);   // 0 1 1 1 0
	and and_15(hot_encoding[15], ~in[4], in[3], in[2], in[1], in[0]);    // 0 1 1 1 1 
	and and_16(hot_encoding[16], in[4], ~in[3], ~in[2], ~in[1], ~in[0]); // 1 0 0 0 0 
	and and_17(hot_encoding[17], in[4], ~in[3], ~in[2], ~in[1], in[0]);  // 1 0 0 0 1
	and and_18(hot_encoding[18], in[4], ~in[3], ~in[2], in[1], ~in[0]);  // 1 0 0 1 0
	and and_19(hot_encoding[19], in[4], ~in[3], ~in[2], in[1], in[0]);   // 1 0 0 1 1
	and and_20(hot_encoding[20], in[4], ~in[3], in[2], ~in[1], ~in[0]);  // 1 0 1 0 0 
	and and_21(hot_encoding[21], in[4], ~in[3], in[2], ~in[1], in[0]);   // 1 0 1 0 1 
	and and_22(hot_encoding[22], in[4], ~in[3], in[2], in[1], ~in[0]);   // 1 0 1 1 0 
	and and_23(hot_encoding[23], in[4], ~in[3], in[2], in[1], in[0]);    // 1 0 1 1 1
	and and_24(hot_encoding[24], in[4], in[3], ~in[2], ~in[1], ~in[0]);  // 1 1 0 0 0 
	and and_25(hot_encoding[25], in[4], in[3], ~in[2], ~in[1], in[0]);   // 1 1 0 0 1
	and and_26(hot_encoding[26], in[4], in[3], ~in[2], in[1], ~in[0]);   // 1 1 0 1 0
	and and_27(hot_encoding[27], in[4], in[3], ~in[2], in[1], in[0]);    // 1 1 0 1 1
	and and_28(hot_encoding[28], in[4], in[3], in[2], ~in[1], ~in[0]);   // 1 1 1 0 0 
	and and_29(hot_encoding[29], in[4], in[3], in[2], ~in[1], in[0]);    // 1 1 1 0 1
	and and_30(hot_encoding[30], in[4], in[3], in[2], in[1], ~in[0]);    // 1 1 1 1 0
	and and_32(hot_encoding[31], in[4], in[3], in[2], in[1], in[0]);	 // 1 1 1 1 1
endmodule