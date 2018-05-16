module bitwise_or(
    /* Port Declarations */
    input  [31:0] input_a, 
    input  [31:0] input_b,
    output [31:0] out
);

/* Bitwise OR Logic */
    genvar bitIndex; 
    generate
        for(bitIndex = 0; bitIndex < 32; bitIndex = bitIndex + 1) begin: outputAssignment
            or outputBit(out[bitIndex], input_a[bitIndex], input_b[bitIndex]);
        end
    endgenerate
endmodule 