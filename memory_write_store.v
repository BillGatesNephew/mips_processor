module memory_write_store(
    memory_instruction,
    write_instruction,
    memory_input_a,
    write_input_a,
    memory_input_b,
    write_input_b,
    memory_regfile_write_address,
    write_regfile_write_address,
    memory_refile_write_en,
    write_refile_write_en,
    memory_ram_to_register_en,
    write_ram_to_register_en,
	 memory_overflow,
	 write_overflow,
    clock, reset
);

    /* Port Declarations */
        // Instruction 
        input  [31:0] memory_instruction;
        output [31:0] write_instruction;

        // Register Values
        input  [31:0] memory_input_a, memory_input_b;
        output [31:0] write_input_a, write_input_b;
        
        // Instruction Controls
        input  [4:0] memory_regfile_write_address;
        output [4:0] write_regfile_write_address;
        input  memory_refile_write_en;
        output write_refile_write_en;
        input  memory_ram_to_register_en;
        output write_ram_to_register_en;

        // Other
		  input memory_overflow;
		  output write_overflow;
        input clock, reset;

/******************************
 **** INSTRUCTION REGISTER ****
 ******************************/
    register memory_instruction_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(memory_instruction),
        .out(write_instruction)
    );

/********************************
 **** PRIMARY INPUT REGISTER ****
 ********************************/
    register memory_input_a_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(memory_input_a),
        .out(write_input_a)
    );

 /*********************************
 **** SECONDARY INPUT REGISTER ****
 **********************************/
    register memory_input_b_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(memory_input_b),
        .out(write_input_b)
    );

/****************************************
 **** REGFILE WRITE CONTROL REGISTER ****
 ****************************************/
    wire [31:0] padded_memory_regfile_write_address, 
                padded_write_regfile_write_address;
	assign padded_memory_regfile_write_address[4:0] = memory_regfile_write_address;

    register memory_refile_write_address_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(padded_memory_regfile_write_address),
        .out(padded_write_regfile_write_address)
    );
	assign write_regfile_write_address = padded_write_regfile_write_address[4:0];

/************************************************
 **** REGFILE WRITE ENABLE CONTROL FLIP-FLOP ****
 ************************************************/
    dflipflop memory_write_enable_flip_flop(
        .q(write_refile_write_en), 
        .d(memory_refile_write_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/**************************************************
 **** RAM TO REGISTER ENABLE CONTROL FLIP-FLOP ****
 **************************************************/
    dflipflop memory_ram_to_register_enable_flip_flop(
        .q(write_ram_to_register_en), 
        .d(memory_ram_to_register_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );
    
/****************************
 **** OVERFLOW FLIP FLOP ****
 ****************************/
    dflipflop overflow_flip_flop(
        .q(write_overflow), 
        .d(memory_overflow), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );
    
endmodule