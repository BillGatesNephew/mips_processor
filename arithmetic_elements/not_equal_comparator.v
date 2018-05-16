module not_equal_comparator(
    /* Port Declarations */
    input [31:0] input_a,
    input [31:0] input_b,
    output       inputs_not_equal
);

/* Not Equal Comparator Logic */
    wire [31:0] comparison_result;
    genvar bit_index;
    generate
        for(bit_index = 0; bit_index < 32; bit_index = bit_index + 1)
        begin: bit_comparisons
            xor bit_comparison(
                comparison_result[bit_index], 
                input_a[bit_index],
                input_b[bit_index]
            );
        end 
    endgenerate
    assign inputs_not_equal = comparison_result ? 1'b1 : 1'b0;
endmodule