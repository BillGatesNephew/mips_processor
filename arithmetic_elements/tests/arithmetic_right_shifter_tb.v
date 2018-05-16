`timescale 1 ns / 100 ps
`define MODULE_NAME "arithmetic_right_shifter"
`define VECTOR_FILE "arithmetic_right_shifter_vectors.tv"
module testbench_skeleton();

/*********************************
 **** DEFAULT REGS AND WIRES  ****
 *********************************/
    // Number of values read in from vector .tv file
    parameter VECTOR_SIZE = 32 + 5 + 32; // in + shiftamt + expected_out 

    /* Default Regs and Wires */
    reg                   clock, reset; 
    reg [31:0]            vectornum, errors; // Allows for up to 10,001 test vectors
    reg [VECTOR_SIZE-1:0] testvectors [10000:0];

/******************************
 **** MODULES BEING TESTED ****
 ******************************/

    reg  [31:0] in;
    reg  [4:0]  shiftamt;
    wire [31:0] out;
    reg  [31:0] expected_out;

    arithmetic_right_shifter dut(
        .in(in),
        .shiftamt(shiftamt),
        .out(out)
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
        { in, shiftamt, expected_out } = testvectors[vectornum];
    end 

/**************************************
 **** CHECK RESULTS OF TEST VECTOR ****
 **************************************/
    always @ (negedge clock) 
    begin: check_results
        if(~reset) // Skip test check when reset is asserted
        begin 
            /* RIGHT SHIFTER TEST */
            if(out !== expected_out) begin
                $display("Error on test %d: inputs = %b", {in,shiftamt});
                $display(" outputs = %b (%b expected)",vectornum + 1, out, expected_out);
                errors = errors + 1;
            end

            /* Updates test vector index and checks for vector */
            vectornum = vectornum + 1;
            if(testvectors[vectornum] === 69'bx) 
            begin: test_finished
                $display("<< %d tests completed with %d errors >>", vectornum, errors);
                $finish;
            end 
        end 
    end
endmodule