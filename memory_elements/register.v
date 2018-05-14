module register (data_in, clock, enable, reset, data_out);
	
	/* Parameter Declarations */
	parameter REGISTER_SIZE = 32; // The number of bits stored by the register
	
	/* Port Declarations */
	input  clock, enable, reset;
	input  [REGISTER_SIZE-1:0] data_in;
	output [REGISTER_SIZE-1:0] data_out;

/* Register Logic */
	// Generates REGISTER_SIZE separate D Flip-Flops
	genvar dflipflop_index;
	generate
		for(dflipflop_index = 0; dflipflop_index < REGISTER_SIZE; dflipflop_index = dflipflop_index + 1)
		begin: flip_flop_creation_loop
			dflipflop new_flip_flop(
				.d(data_in[dflipflop_index]),
				.clk(clock),
				.en(enable),
				.rst(reset),
				.q(data_out[dflipflop_index])
			);
		end 
	endgenerate
endmodule