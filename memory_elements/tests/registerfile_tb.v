`timescale 1 ns / 100 ps
`define MODULE_NAME "register_file"
`define VECTOR_FILE "registerfile_vectors.tv"
module testbench_skeleton();

/*********************************
 **** DEFAULT REGS AND WIRES  ****
 *********************************/
    // Number of values read in from vector .tv file
    parameter VECTOR_SIZE = 1 + 5 + 5 + 5 + 32 + 64; 

    /* Default Regs and Wires */
    reg                   clock, reset; 
    reg [31:0]            vectornum, errors; // Allows for up to 10,001 test vectors
    reg [VECTOR_SIZE-1:0] testvectors [10000:0];

/******************************
 **** MODULES BEING TESTED ****
 ******************************/
    // Example:
    // mymodule m1(a,b,c,y);
    reg         write_en;
    reg  [4:0]  write_reg_addr, read_reg_a_addr, read_reg_b_addr;
    reg  [31:0] write_reg_data_in;
    wire [31:0] reg_a_data_out, reg_b_data_out;
    reg  [63:0] expected_data_out;

    register_file dut(
        .clock(clock),
        .reset(reset),
        .write_en(write_en),
        .write_reg_addr(write_reg_addr),
        .read_reg_a_addr(read_reg_a_addr),
        .read_reg_b_addr(read_reg_b_addr),
        .write_reg_data_in(write_reg_data_in),
        .reg_a_data_out(reg_a_data_out),
        .reg_b_data_out(reg_b_data_out)
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
        { write_en, write_reg_addr, read_reg_a_addr, read_reg_b_addr, write_reg_data_in, expected_data_out } = testvectors[vectornum];
    end 

/**************************************
 **** CHECK RESULTS OF TEST VECTOR ****
 **************************************/
    always @ (negedge clock) 
    begin: check_results
        if(~reset) // Skip test check when reset is asserted
        begin 
            /* D FLIP-FLOP TEST */
            if({reg_a_data_out, reg_b_data_out} !== expected_data_out) 
            begin: check_test_result
                $display("Error on test %d: inputs = %b", vectornum + 1, {write_en, write_reg_addr, read_reg_a_addr, read_reg_b_addr, write_reg_data_in});
                $display(" outputs = %b (%b expected)", {reg_a_data_out, reg_b_data_out}, expected_data_out);
                errors = errors + 1;
            end 

            /* Updates test vector index and checks for vector */
            vectornum = vectornum + 1;
            if(testvectors[vectornum] === 112'bx) 
            begin: test_finished
                $display("<< %d tests completed with %d errors >>", vectornum, errors);
                $finish;
            end 
        end 
    end
endmodule