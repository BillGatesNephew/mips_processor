module register_comparator(
    register_address_a,
    register_address_b,
    equal
);
    /* Port Declarations */
        input [4:0] register_address_a, register_address_b;
        output equal;

    /* Compare Each Bit */
        wire [4:0] bit_comparison_result;
        genvar bit_index;
        generate
            for(bit_index = 0; bit_index < 5; bit_index = bit_index + 1) begin: bit_comparisons 
                assign bit_comparison_result[bit_index] = 
                    (~register_address_a[bit_index] && ~register_address_b[bit_index]) || 
                    (register_address_a[bit_index] && register_address_b[bit_index]);
            end
        endgenerate
		  
    /* Determine If Register is $r0 or Not */
		  assign a_is_zero = (	
				~register_address_a[4] && ~register_address_a[3] && 
				~register_address_a[2] && ~register_address_a[1] &&
				~register_address_a[0]
		  ) ? 1'b1 : 1'b0;
		  
		  assign b_is_zero = (	
				~register_address_b[4] && ~register_address_b[3] && 
				~register_address_b[2] && ~register_address_b[1] &&
				~register_address_b[0]
		  ) ? 1'b1 : 1'b0;
		 
		  assign not_zero = (~a_is_zero && ~b_is_zero) ? 1'b1 : 1'b0;
		  
	/* Determine if Equal or Not */
        assign bits_same = (
            bit_comparison_result[4] && bit_comparison_result[3] &&
            bit_comparison_result[2] && bit_comparison_result[1] &&
            bit_comparison_result[0]
        ) ? 1'b1 : 1'b0;
		  
		  assign equal = (not_zero && bits_same) ? 1'b1 : 1'b0;
        
endmodule