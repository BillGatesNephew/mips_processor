module register (clock, enable, reset, data, out);
	/* Port Declarations */
		input clock, enable, reset;
		input [31:0] data;
		output [31:0] out; 
		
    /* D Flip-Flop Generation */
    // NOTE: D Flip-Flop utilizes active low preset and reset signals
		genvar dffe_index;
		generate
			for(dffe_index = 0; dffe_index < 32; dffe_index = dffe_index + 1) begin: dffe_init
				dflipflop new_dffe( 
					.d(data[dffe_index]),
					.clk(clock),
					.clrn(~reset),
					.prn(1'b1),
					.ena(enable),
					.q(out[dffe_index])						
				);
			end 
		endgenerate
endmodule