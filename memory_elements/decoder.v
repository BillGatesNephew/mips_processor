module decoder(
    /* Port Declarations */
    input  [4:0] input_address, 
    output [31:0] decoded_output
); 

/* Decoder Logic */
    // Predecode lower 4 bits
    wire [15:0] predecoded_input;
    predecoder input_predecoder(
        .input_address(input_address[3:0]),
        .decoded_output(predecoded_input)
    );
    // Use pre-decoded bits to easily determine output
    assign decoded_output[31:0] = input_address[4] ? { predecoded_input[15:0], 16'd0} : {16'd0, predecoded_input[15:0]}; 
endmodule