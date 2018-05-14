module execute_memory_store(
    execute_instruction,
    memory_instruction,
    execute_input_a,
    memory_input_a,
    execute_input_b,
    memory_input_b,
    execute_regfile_write_address,
    memory_regfile_write_address,
    execute_refile_write_en,
    memory_refile_write_en,
    execute_ram_to_register_en,
    memory_ram_to_register_en,
    execute_write_to_ram_en,
    memory_write_to_ram_en,
	 execute_overflow,
	 memory_overflow,
    clock, reset
);

    /* Port Declarations */
        // Instruction 
        input  [31:0] execute_instruction;
        output [31:0] memory_instruction;

        // Register Values
        input  [31:0] execute_input_a, execute_input_b;
        output [31:0] memory_input_a, memory_input_b;
        
        // Instruction Controls
        input  [4:0] execute_regfile_write_address;
        output [4:0] memory_regfile_write_address;
        input  execute_refile_write_en;
        output memory_refile_write_en;
        input  execute_ram_to_register_en;
        output memory_ram_to_register_en;
        input  execute_write_to_ram_en;
        output memory_write_to_ram_en;

        // Other 
		  input execute_overflow;
		  output memory_overflow;
        input clock, reset;

/******************************
 **** INSTRUCTION REGISTER ****
 ******************************/
    register execute_instruction_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(execute_instruction),
        .out(memory_instruction)
    );

/********************************
 **** PRIMARY INPUT REGISTER ****
 ********************************/
    register execute_input_a_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(execute_input_a),
        .out(memory_input_a)
    );

 /*********************************
 **** SECONDARY INPUT REGISTER ****
 **********************************/
    register execute_input_b_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(execute_input_b),
        .out(memory_input_b)
    );

/****************************************
 **** REGFILE WRITE CONTROL REGISTER ****
 ****************************************/
    wire [31:0] padded_execute_regfile_write_address, 
                padded_memory_regfile_write_address;
	assign padded_execute_regfile_write_address[4:0] = execute_regfile_write_address;

    register execute_refile_write_address_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(padded_execute_regfile_write_address),
        .out(padded_memory_regfile_write_address)
    );
	assign memory_regfile_write_address = padded_memory_regfile_write_address[4:0];

/************************************************
 **** REGFILE WRITE ENABLE CONTROL FLIP-FLOP ****
 ************************************************/
    dflipflop execute_write_enable_flip_flop(
        .q(memory_refile_write_en), 
        .d(execute_refile_write_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/**************************************************
 **** RAM TO REGISTER ENABLE CONTROL FLIP-FLOP ****
 **************************************************/
    dflipflop execute_ram_to_register_enable_flip_flop(
        .q(memory_ram_to_register_en), 
        .d(execute_ram_to_register_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/***********************************************
 **** WRITE TO RAM ENABLE CONTROL FLIP-FLOP ****
 ***********************************************/
    dflipflop execute_write_to_ram_enable_flip_flop(
        .q(memory_write_to_ram_en), 
        .d(execute_write_to_ram_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );
    
endmodule