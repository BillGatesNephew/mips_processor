module bitwise_or(input_a, input_b, out);
    /* Port Declarations */
    input [31:0] input_a, input_b;
    output [31:0] out; 
    /* Bitwise Or Logic */
    genvar bitIndex; 
    generate
        // The loop iterates over each bit index and determines appropriate output value
        for(bitIndex = 0; bitIndex < 32; bitIndex = bitIndex + 1) begin: outputAssignment
            or outputBit(out[bitIndex], input_a[bitIndex], input_b[bitIndex]);
        end
    endgenerate
endmodule 