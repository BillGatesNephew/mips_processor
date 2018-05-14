module decode_execute_store(
    decode_pc_address,
    execute_pc_address,
    decode_instruction,
    execute_instruction,
    data_readRegA,
    primary_input,
    data_readRegB,
    secondary_input,
    decode_regfile_write_address,
    execute_regfile_write_address,
    decode_refile_write_en,
    execute_refile_write_en,
    decode_ram_to_register_en,
    execute_ram_to_register_en,
    decode_pc_plus_n_en,
    execute_pc_plus_n_en,
    decode_pc_equals_t_en,
    execute_pc_equals_t_en,
    decode_pc_equals_rd_en,
    execute_pc_equals_rd_en,
    decode_immediate_en,
    execute_immediate_en,
    decode_write_to_ram_en,
    execute_write_to_ram_en,
    clock, reset
);

    /* Port Declarations */
        // PC Address Control
        input  [11:0] decode_pc_address;
        output [11:0] execute_pc_address;

        // Instruction 
        input  [31:0] decode_instruction;
        output [31:0] execute_instruction;

        // Register Values
        input  [31:0] data_readRegA, data_readRegB;
        output [31:0] primary_input, secondary_input;
        
        // Instruction Controls
        input  [4:0] decode_regfile_write_address;
        output [4:0] execute_regfile_write_address;
        input  decode_refile_write_en;
        output execute_refile_write_en;
        input  decode_ram_to_register_en;
        output execute_ram_to_register_en;
        input  decode_pc_plus_n_en;
        output execute_pc_plus_n_en;
        input  decode_pc_equals_t_en;
        output execute_pc_equals_t_en;
        input  decode_pc_equals_rd_en;
        output execute_pc_equals_rd_en;
        input  decode_immediate_en;
        output execute_immediate_en;
        input  decode_write_to_ram_en;
        output execute_write_to_ram_en;

        // Other 
        input clock, reset;

/*****************************
 **** PC ADDRESS REGISTER ****
 *****************************/
	wire [31:0] padded_decode_pc_address, padded_execute_pc_address;
	assign padded_decode_pc_address[11:0] = decode_pc_address;

    register decode_pc_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(padded_decode_pc_address),
        .out(padded_execute_pc_address)
    );
	assign execute_pc_address = padded_execute_pc_address[11:0];

/******************************
 **** INSTRUCTION REGISTER ****
 ******************************/
    register decode_instruction_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(decode_instruction),
        .out(execute_instruction)
    );

/********************************
 **** PRIMARY INPUT REGISTER ****
 ********************************/
    register decode_regA_data_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(data_readRegA),
        .out(primary_input)
    );

 /*********************************
 **** SECONDARY INPUT REGISTER ****
 **********************************/
    register decode_regB_data_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(data_readRegB),
        .out(secondary_input)
    );

/****************************************
 **** REGFILE WRITE CONTROL REGISTER ****
 ****************************************/
    wire [31:0] padded_decode_regfile_write_address, 
                padded_execute_regfile_write_address;
	assign padded_decode_regfile_write_address[4:0] = decode_regfile_write_address;

    register decode_refile_write_address_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(padded_decode_regfile_write_address),
        .out(padded_execute_regfile_write_address)
    );
	assign execute_regfile_write_address = padded_execute_regfile_write_address[4:0];

/************************************************
 **** REGFILE WRITE ENABLE CONTROL FLIP-FLOP ****
 ************************************************/
    dflipflop decode_write_enable_flip_flop(
        .q(execute_refile_write_en), 
        .d(decode_refile_write_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/**************************************************
 **** RAM TO REGISTER ENABLE CONTROL FLIP-FLOP ****
 **************************************************/
    dflipflop decode_ram_to_register_enable_flip_flop(
        .q(execute_ram_to_register_en), 
        .d(decode_ram_to_register_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/*********************************************
 **** PC + 1 + N ENABLE CONTROL FLIP-FLOP ****
 *********************************************/
    dflipflop decode_pc_plus_n_enable_flip_flop(
        .q(execute_pc_plus_n_en), 
        .d(decode_pc_plus_n_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/*****************************************
 **** PC = T ENABLE CONTROL FLIP-FLOP ****
 *****************************************/
    dflipflop decode_pc_equals_t_enable_flip_flop(
        .q(execute_pc_equals_t_en), 
        .d(decode_pc_equals_t_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/*******************************************
 **** PC = $RD ENABLE CONTROL FLIP-FLOP ****
 *******************************************/
    dflipflop decode_pc_equals_rd_enable_flip_flop(
        .q(execute_pc_equals_rd_en), 
        .d(decode_pc_equals_rd_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/********************************************
 **** IMMEDIATE ENABLE CONTROL FLIP-FLOP ****
 ********************************************/
    dflipflop decode_immediate_enable_flip_flop(
        .q(execute_immediate_en), 
        .d(decode_immediate_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );

/***********************************************
 **** WRITE TO RAM ENABLE CONTROL FLIP-FLOP ****
 ***********************************************/
    dflipflop decode_write_to_ram_enable_flip_flop(
        .q(execute_write_to_ram_en), 
        .d(decode_write_to_ram_en), 
        .clk(clock), 
        .ena(clock), 
        .clrn(~reset),
        .prn(1'b1)
    );
    
endmodule