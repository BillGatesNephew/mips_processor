`timescale 1 ns / 100 ps
`define MODULE_NAME "predecoder"
`define VECTOR_FILE "predecoder_vectors.tv"
module testbench_skeleton();

/*********************************
 **** DEFAULT REGS AND WIRES  ****
 *********************************/
    // Number of values read in from vector .tv file
    parameter VECTOR_SIZE = 4 + 32; // input_address + expected_decoded_output 

    /* Default Regs and Wires */
    reg                   clock, reset; 
    reg [31:0]            vectornum, errors; // Allows for up to 10,001 test vectors
    reg [VECTOR_SIZE-1:0] testvectors [10000:0];

/******************************
 **** MODULES BEING TESTED ****
 ******************************/
    reg  [3:0]  input_address;
    wire [15:0] decoded_output;
    reg  [15:0] expected_decoded_output;

    predecoder dut(
        .input_address(input_address),
        .decoded_output(decoded_output)
    );

/**********************
 **** CLOCK SIGNAL ****
 **********************/
    // 50 MHz Clock | 20 ns clock period
    always begin: clock_signal
        clock = 1; #10; clock = 0; #10;
    end 

/*******************************************
 **** LOAD TEST VECTORS AND PULSE RESET ****
 *******************************************/
    initial 
    begin: load_and_reset
        $display("<< Beginning %s Tests >>", `MODULE_NAME);
        $readmemb(`VECTOR_FILE, testvectors);
        vectornum = 0; errors = 0;
        reset = 1; #27; reset = 0;
    end 

/***************************
 **** SET INPUT SIGNALS ****
 ***************************/
    always @ (posedge clock) 
    begin: set_inputs
        #1;
        // Set signals below using concatenations
        // ie. {a,b,c,yexpected} = testvectors[vectornum]
        //
        {input_address, expected_decoded_output} = testvectors[vectornum];
    end 

/**************************************
 **** CHECK RESULTS OF TEST VECTOR ****
 **************************************/
    always @ (negedge clock) 
    begin: check_results
        if(~reset) // Skip test check when reset is asserted
        begin 
            /* DECODER TEST */
            if(decoded_output !== expected_decoded_output) 
            begin: check_test_result
                $display("Error: inputs = %b", {input_address});
                $display(" outputs = %b (%b expected)", decoded_output, expected_decoded_output);
                errors = errors + 1;
            end 

            /* Updates test vector index and checks for vector */
            vectornum = vectornum + 1;
            if(testvectors[vectornum] === 36'bx) 
            begin: test_finished
                $display("<< %d tests completed with %d errors >>", vectornum, errors);
                $finish;
            end 
        end 
    end
endmodule