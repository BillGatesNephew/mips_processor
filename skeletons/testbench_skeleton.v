`timescale 1 ns / 100 ps
`define VECTOR_FILE "test.tv"
module testbench_skeleton();

/*********************************
 **** DEFAULT REGS AND WIRES  ****
 *********************************/
    // Number of values read in from vector .tv file
    parameter VECTOR_SIZE = 4; 

    /* Default Regs and Wires */
    reg                   clock, reset; 
    reg [31:0]            vectornum, errors; // Allows for up to 10,001 test vectors
    reg [VECTOR_SIZE-1:0] testvectors [10000:0];

/******************************
 **** MODULES BEING TESTED ****
 ******************************/
    // Example:
    // mymodule m1(a,b,c,y);

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
        // {} = testvectors[vectornum];
    end 

/**************************************
 **** CHECK RESULTS OF TEST VECTOR ****
 **************************************/
    always @ (negedge clock) 
    begin: check_results
        if(~reset) // Skip test check when reset is asserted
        begin 
            /* TEST GOES HERE */
            // Example Test:
            // if(y !== yexpected) begin
            //    $display("Error: inputs = %b", {a,b,c});
            //    $display(" outputs = %b (%b expected)",y,yexpected);
            //    errors = errors + 1;
            // end

            /* Updates test vector index and checks for vector */
            vectornum = vectornum + 1;
            if(testvectors[vectornum] === 4'bx) 
            begin: test_finished
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end 
        end 
    end
endmodule