/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile
	 
	 hazard_detected_val,
     write_overflow_val,
     bypass_ram_en_val,
     write_input_a_val,
     write_input_b_val,
     execute_input_a_val,
     branch_taken_val,
     bypass_B_mux_selector_val
);

    /* Port Declarations */
        // Control signals
        input clock, reset;

        // Imem Ports
        input  [31:0] q_imem;
        output [11:0] address_imem;

        // Dmem Ports
        input  [31:0] q_dmem;
        output [11:0] address_dmem;
        output [31:0] data;
        output wren;

        // RegFile Ports
        input  [31:0] data_readRegA, data_readRegB;
        output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
        output [31:0] data_writeReg;
        output ctrl_writeEnable;
		  
		  output hazard_detected_val, write_overflow_val, bypass_ram_en_val, branch_taken_val;
		  output [31:0] write_input_a_val, write_input_b_val, execute_input_a_val;
          output [1:0] bypass_B_mux_selector_val;
          assign branch_taken_val = branch_taken;
		  // Hazard detection flag
		  wire hazard_detected; 
		  assign hazard_detected_val = hazard_detected;
/***********************
 ***** FETCH STAGE ***** 
 ***********************/
    
    /* CPU Program Counter */
        wire [31:0] current_address, next_address;		  
		  
		  
        register program_counter(
            .clock(clock), 
            .enable(clock), 
            .reset(reset), 
            .data(next_address),
            .out(current_address)
        );
			

    /*  Default PC Increment of 1 */
        wire [31:0] current_address_plus_one;
		  wire [31:0] pc_value_incrementer;
		  assign pc_value_incrementer = (hazard_detected || branch_taken) ? 32'd0 : 32'b1;
        cl_adder pc_incrementer(
            .input_a(current_address), 
            .input_b(pc_value_incrementer), 
            .subtract_ctrl(1'b0),
            .sum(current_address_plus_one), 
            .overflow(), .lt(), .neq()
        );

    /* Instruction Returned from Memory */
        wire [31:0] fetch_instruction;
        assign fetch_instruction = q_imem;

    /* Next Instruction to Fetch */
	     wire [31:0] execute_generated_next_address;
        assign next_address = execute_generated_next_address;
		 assign address_imem = current_address[11:0];
		 

/****************************
 ***** BYPASS DETECTION ***** 
 ****************************/	
	 wire [31:0] execute_instruction, memory_instruction, write_instruction;
	 wire [1:0] bypass_A_mux_selector, bypass_B_mux_selector;
	 wire bypass_ram_en;
    /* Bypassing Unit */
        bypassing_unit bypassor(
            .execute_instruction(execute_instruction),
            .memory_instruction(memory_instruction),
            .write_instruction(write_instruction),
            .bypass_A_mux_selector(bypass_A_mux_selector),
            .bypass_B_mux_selector(bypass_B_mux_selector),
            .bypass_ram_en(bypass_ram_en)
        );
		
/****************************
 ***** HAZARD DETECTION ***** 
 ****************************/

	 /* Hazard Detection Unit */
	   wire [4:0] execute_regfile_write_address;
		wire [4:0] memory_regfile_write_address;
	   wire [31:0] decode_instruction;
		hazard_detection_unit hazard_detector(
			.execute_instruction(execute_instruction),
			.decode_instruction(decode_instruction),
			.hazard_detected(hazard_detected)
		);
/********************************************
 ***** FETCH AND DECODE STAGE SEPARATOR ***** 
 ********************************************/
    /* Store Used for Pipeline between Fetch and Decode */
    // NOTE: Currently uses the incremented value of first PC 
        wire [11:0] decode_pc_address;
		  wire [31:0] new_insn_or_same_instruction; 
          // If hazard detected then stall instruction
		  assign new_insn_or_same_instruction = (hazard_detected) ? decode_instruction : 32'bz;
          // For Branching you need to flush the pipeline  
          assign new_insn_or_same_instruction = (branch_taken)    ? 32'b0 : 32'bz; 
          // Default Case
          assign new_insn_or_same_instruction = (~hazard_detected && ~branch_taken) ? fetch_instruction : 32'bz;
        fetch_decode_store fetch_decode_pipeline_store(
            .fetch_pc_address(next_address[11:0]),
            .fetch_instruction(new_insn_or_same_instruction),
            .decode_pc_address(decode_pc_address),
            .decode_instruction(decode_instruction),
            .clock(~clock),
            .reset(reset)
        );

/************************
 ***** DECODE STAGE ***** 
 ************************/

		
		wire [31:0] decode_insn_or_noop;
		assign decode_insn_or_noop = (hazard_detected || branch_taken) ? 32'd0 : decode_instruction;

    /* Decode the Instruction */
        wire [4:0] decode_regfile_write_address;
        wire decode_refile_write_en, decode_ram_to_register_en,
            decode_immediate_en, decode_write_to_ram_en,
            decode_read_rd_register_en, decode_pc_plus_n_en,
            decode_pc_equals_t_en, decode_pc_equals_rd_en;
        control cpu_control_unit(
            .instruction(decode_insn_or_noop),
            .regfile_write_address(decode_regfile_write_address),
            .regfile_write_en(decode_refile_write_en),
            .ram_to_register_en(decode_ram_to_register_en),
            .pc_plus_n_en(decode_pc_plus_n_en),
            .pc_equals_t_en(decode_pc_equals_t_en),
            .pc_equals_rd_en(decode_pc_equals_rd_en),
            .immediate_en(decode_immediate_en),
            .write_to_ram_en(decode_write_to_ram_en),
            .read_rd_register_en(decode_read_rd_register_en)
        );

    /* Read from RegFile */
    // NOTE: For some reason, the instruction format assumes a 5-bit
    // register selector.
        assign ctrl_readRegA = decode_instruction[21:17];  
        // Select between reading $rd, $rt, and $rstatus 
        wire decode_instruction_bex = (decode_instruction[31] && ~decode_instruction[30] && decode_instruction[29] && decode_instruction[28] && ~decode_instruction[27]);
        assign ctrl_readRegB = decode_read_rd_register_en ? 
            decode_instruction[26:22] : 5'bz;
        assign ctrl_readRegB = decode_instruction_bex ? 5'd30 : 5'bz;
        assign ctrl_readRegB = (
            ~decode_read_rd_register_en && ~decode_instruction_bex
        ) ? decode_instruction[16:12] : 5'bz;

		
/**********************************************
 ***** DECODE AND EXECUTE STAGE SEPARATOR ***** 
 **********************************************/
    /* Store Used for Pipeline between Decode and Execute */
        wire [31:0] primary_input, secondary_input;
        wire [11:0] execute_pc_address;
        wire execute_refile_write_en, execute_ram_to_register_en,
            execute_immediate_en, execute_write_to_ram_en,
            execute_pc_plus_n_en, execute_pc_equals_t_en,
            execute_pc_equals_rd_en;
        decode_execute_store decode_execute_pipeline_store(
            .decode_pc_address(decode_pc_address),
            .execute_pc_address(execute_pc_address),
            .decode_instruction(decode_insn_or_noop),
            .execute_instruction(execute_instruction),
            .data_readRegA(data_readRegA),
            .primary_input(primary_input),
            .data_readRegB(data_readRegB),
            .secondary_input(secondary_input),
            .decode_regfile_write_address(decode_regfile_write_address),
            .execute_regfile_write_address(execute_regfile_write_address),
            .decode_refile_write_en(decode_refile_write_en),
            .execute_refile_write_en(execute_refile_write_en),
            .decode_ram_to_register_en(decode_ram_to_register_en),
            .execute_ram_to_register_en(execute_ram_to_register_en),
            .decode_pc_plus_n_en(decode_pc_plus_n_en),
            .execute_pc_plus_n_en(execute_pc_plus_n_en),
            .decode_pc_equals_t_en(decode_pc_equals_t_en),
            .execute_pc_equals_t_en(execute_pc_equals_t_en),
            .decode_pc_equals_rd_en(decode_pc_equals_rd_en),
            .execute_pc_equals_rd_en(execute_pc_equals_rd_en),
            .decode_immediate_en(decode_immediate_en),
            .execute_immediate_en(execute_immediate_en),
            .decode_write_to_ram_en(decode_write_to_ram_en),
            .execute_write_to_ram_en(execute_write_to_ram_en),
            .clock(~clock),
            .reset(reset)
        );
    
/*************************
 ***** EXECUTE STAGE ***** 
 *************************/
	 
    /* Extend Immediate Value */
        wire [31:0] extended_immediate;
        assign extended_immediate[16:0] =  execute_instruction[16:0];
        assign extended_immediate[31:17] = execute_instruction[16] ? 15'b111111111111111 : 15'b000000000000000; 

	 /* Bypass Adjustments */
		 // Input A
		 wire [31:0] memory_input_a;
		 wire [31:0] adjusted_primary_input;
		 assign adjusted_primary_input = (
			~bypass_A_mux_selector[1] && ~bypass_A_mux_selector[0]
		 ) ? memory_input_a : 32'bz;
		 assign adjusted_primary_input = (
			~bypass_A_mux_selector[1] && bypass_A_mux_selector[0]
		 ) ? data_writeReg : 32'bz;
		 assign adjusted_primary_input = (
			bypass_A_mux_selector[1] && ~bypass_A_mux_selector[0]
		 ) ? primary_input : 32'bz;
		 
		 // Input B
		 wire [31:0] adjusted_secondary_input; 
		 assign adjusted_secondary_input = (
			~bypass_B_mux_selector[1] && ~bypass_B_mux_selector[0]
		 ) ? memory_input_a : 32'bz;
		 assign adjusted_secondary_input = (
			~bypass_B_mux_selector[1] && bypass_B_mux_selector[0]
		 ) ? data_writeReg : 32'bz;
		 assign adjusted_secondary_input = (
			bypass_B_mux_selector[1] && ~bypass_B_mux_selector[0]
		 ) ? secondary_input : 32'bz;
		 
         assign bypass_B_mux_selector_val = bypass_B_mux_selector;
    /* Select Input B for ALU Ops */
        wire [31:0] alu_input_b;
        assign alu_input_b = execute_immediate_en ? extended_immediate : adjusted_secondary_input; // Possibly consider using tristate buffer here
		
    /* Perform ALU Operation */
        wire [31:0] execute_alu_output;
        wire [4:0] alu_op;
        assign alu_op = execute_immediate_en ? 5'b00000 : execute_instruction[6:2];
        wire execute_alu_neq, execute_alu_lt, execute_alu_overflow;
        alu execute_alu(
            .data_operandA(adjusted_primary_input),
            .data_operandB(alu_input_b),
            .ctrl_ALUopcode(alu_op), 
            .ctrl_shiftamt(execute_instruction[11:7]), 
            .data_result(execute_alu_output), 
            .isNotEqual(execute_alu_neq), 
            .isLessThan(execute_alu_lt), 
            .overflow(execute_alu_overflow)
        );


    /* Select Next PC Address */
        wire branch_taken, t_branch_taken, rd_branch_taken, n_branch_taken;
        /* PC = PC + 1 + N */
            // Generate PC + 1 + N Value 
            wire [31:0] padded_execute_pc_address, padded_pc_plus_n;
            assign padded_execute_pc_address[11:0] = execute_pc_address;
            assign padded_execute_pc_address[31:12] = 20'd0;
            cl_adder pc_plus_n_adder(
                .input_a(padded_execute_pc_address), 
                .input_b(extended_immediate), 
                .subtract_ctrl(1'b0),
                .sum(padded_pc_plus_n),     
                .overflow(), .lt(), .neq()
            );

            // Compare $rd and $rs
            wire rd_lt_rs, rd_neq_rs;
            cl_adder rd_and_rs_comparator(
                .input_a(adjusted_secondary_input),
                .input_b(adjusted_primary_input),
                .subtract_ctrl(1'b1),
                .sum(),
                .overflow(),
                .lt(rd_lt_rs),
                .neq(rd_neq_rs)
            );

            // Determine Instruction Type
            wire execute_instruction_bne;
            assign execute_instruction_bne = (~execute_instruction[31] && ~execute_instruction[30] && ~execute_instruction[29] && execute_instruction[28] && ~execute_instruction[27]) ? 1'b1 : 1'b0;
            wire execute_instruction_blt = (~execute_instruction[31] && ~execute_instruction[30] && execute_instruction[29] && execute_instruction[28] && ~execute_instruction[27]);

            // Determine if PC = PC + 1 + N Branch taken or not
            assign n_branch_taken = (
                (execute_instruction_bne && rd_neq_rs) ||
                (execute_instruction_blt && rd_lt_rs)
            ) ? 1'b1 : 1'b0;

            assign execute_generated_next_address = n_branch_taken ? padded_pc_plus_n : 32'bz;

        /* PC = T */
            // Create T 
            wire [31:0] execute_t_address;
            assign execute_t_address[31:27] = 5'b00000;
            assign execute_t_address[26:0] =  execute_instruction[26:0];
            assign execute_generated_next_address = execute_pc_equals_t_en  ? execute_t_address : 32'bz;
            // Determine if performing bex instruction
            wire execute_instruction_bex = (execute_instruction[31] && ~execute_instruction[30] && execute_instruction[29] && execute_instruction[28] && ~execute_instruction[27]);
            // General PC = T case
            assign execute_generated_next_address = (
                execute_pc_equals_t_en && ~execute_instruction_bex 
            ) ? execute_t_address : 32'bz; 
            // bex PC = T case
            assign execute_generated_next_address = (
                execute_pc_equals_t_en && execute_instruction_bex && 
                adjusted_secondary_input
            ) ? execute_t_address : 32'bz;
            // Determine if PC = T branch taken
            assign t_branch_taken = (
                (execute_pc_equals_t_en && execute_instruction_bex && adjusted_secondary_input) ||
                (execute_pc_equals_t_en && ~execute_instruction_bex)
            ) ? 1'b1 : 1'b0;

        /*  PC = $rd */
            assign execute_generated_next_address = execute_pc_equals_rd_en ? secondary_input : 32'bz;
            assign rd_branch_taken = execute_pc_equals_rd_en ? 1'b1 : 1'b0;


        /* Default Case where PC = PC + 1 */
            assign branch_taken = ( n_branch_taken || t_branch_taken || rd_branch_taken) ? 1'b1 : 1'b0;
            assign execute_generated_next_address = ~branch_taken ? current_address_plus_one : 32'bz;

    /* Set Proper execute_input_a for Memory Stage */
        wire [31:0] execute_input_a;

        // Determine if performing setx instruciton
        wire execute_instruction_setx = (execute_instruction[31] && ~execute_instruction[30] && execute_instruction[29] && ~execute_instruction[28] && execute_instruction[27]);

        // Set execute_input_a = PC + 1
        // NOTE: Uses the padded execute PC address created above
        assign execute_input_a = execute_pc_equals_t_en ? padded_execute_pc_address : 32'bz;

        // Set execute_input_a = T
        // TODO: Make sure the logic for the padding is correct
        wire [31:0] execute_padded_t;
        assign execute_padded_t[31:27] = 5'b0; 
        assign execute_padded_t[26:0]  = execute_instruction[26:0];
        assign execute_input_a = execute_instruction_setx ? execute_padded_t : 32'bz;

        // Defaut Case where execute_input_a = execute_alu_output
        assign execute_input_a = (
            ~execute_pc_equals_t_en && ~execute_instruction_setx
        ) ? execute_alu_output : 32'bz;
    assign execute_input_a_val = execute_input_a;
    /* TODO: Handle overflow errors */

/**********************************************
 ***** EXECUTE AND MEMORY STAGE SEPARATOR ***** 
 **********************************************/

    /* Store Used for Pipeline between Execute and Memory */
        wire [31:0] memory_input_b;
		  wire memory_overflow;
        wire memory_refile_write_en, memory_ram_to_register_en,
            memory_write_to_ram_en;
        execute_memory_store execute_memory_pipeline_store(
            .execute_instruction(execute_instruction),
            .memory_instruction(memory_instruction),
            .execute_input_a(execute_input_a),
            .memory_input_a(memory_input_a),
            .execute_input_b(adjusted_secondary_input),
            .memory_input_b(memory_input_b),
            .execute_regfile_write_address(execute_regfile_write_address),
            .memory_regfile_write_address(memory_regfile_write_address),
            .execute_refile_write_en(execute_refile_write_en),
            .memory_refile_write_en(memory_refile_write_en),
            .execute_ram_to_register_en(execute_ram_to_register_en),
            .memory_ram_to_register_en(memory_ram_to_register_en),
            .execute_write_to_ram_en(execute_write_to_ram_en),
            .memory_write_to_ram_en(memory_write_to_ram_en),
			.execute_overflow(execute_alu_overflow),
			.memory_overflow(memory_overflow),
            .clock(~clock),
            .reset(reset)
        );

/************************
 ***** MEMORY STAGE ***** 
 ************************/

    /* Set Memory Address */
        assign address_dmem = memory_input_a[11:0];

    /* Assign Memory Write Data */ 
		assign data = bypass_ram_en ? data_writeReg : memory_input_b;
        assign bypass_ram_en_val = bypass_ram_en;
    /* Enable Memory Write*/
        assign wren = memory_write_to_ram_en;

/********************************************
 ***** MEMORY AND WRITE STAGE SEPARATOR ***** 
 ********************************************/
    /* Store Used for Pipeline between Execute and Memory */
		  wire write_overflow;
        wire [31:0] write_input_a, write_input_b;
        wire [4:0] write_regfile_write_address;
        wire write_refile_write_en, write_ram_to_register_en;
        memory_write_store memory_write_pipeline_store(
            .memory_instruction(memory_instruction),
            .write_instruction(write_instruction),
            .memory_input_a(memory_input_a),
            .write_input_a(write_input_a),
            .memory_input_b(q_dmem),
            .write_input_b(write_input_b),
            .memory_regfile_write_address(memory_regfile_write_address),
            .write_regfile_write_address(write_regfile_write_address),
            .memory_refile_write_en(memory_refile_write_en),
            .write_refile_write_en(write_refile_write_en),
            .memory_ram_to_register_en(memory_ram_to_register_en),
            .write_ram_to_register_en(write_ram_to_register_en),
			.memory_overflow(memory_overflow),
			.write_overflow(write_overflow),
            .clock(~clock),
            .reset(reset)
        );
   
/***********************
 ***** WRITE STAGE ***** 
 ***********************/
	 /* Select Error Data */ 
		assign is_R_type = (
			~write_instruction[31] && ~write_instruction[30] && ~write_instruction[29] && ~write_instruction[28] && ~write_instruction[27]
		) ? 1'b1 : 1'b0; 
		
		assign is_addition = (
			is_R_type &&
			~write_instruction[31] && ~write_instruction[30] && ~write_instruction[29] && ~write_instruction[28] && ~write_instruction[27]
		) ? 1'b1 : 1'b0;
		
		assign is_addi = (
			~write_instruction[31] && ~write_instruction[30] && write_instruction[29] && ~write_instruction[28] && write_instruction[27]
		) ? 1'b1 : 1'b0;
		
		assign is_subtraction = (
			is_R_type &&
			~write_instruction[31] && ~write_instruction[30] && ~write_instruction[29] && ~write_instruction[28] && write_instruction[27]
		) ? 1'b1 : 1'b0;
		
		 assign data_writeReg = (
			is_addition && write_overflow
		 ) ? 32'd1 : 32'bz;
		 
		 assign data_writeReg = (
			is_addi && write_overflow
		 ) ? 32'd2 : 32'bz;
		 
		 assign data_writeReg = (
			is_subtraction && write_overflow
		 ) ? 32'd3 : 32'bz;
		 
		 /* Select Data To Write to RegFile */
		 assign data_writeReg = (
			~write_overflow &&
			write_ram_to_register_en
		 ) ? write_input_b : 32'bz;
		 assign data_writeReg = (
			~write_overflow &&
			~write_ram_to_register_en
		 ) ? write_input_a : 32'bz; 			 
		
        assign write_overflow_val = write_overflow;
        assign write_input_a_val = write_input_a;
        assign write_input_b_val = write_input_b;
    /* Set the Register to Write To */
        assign ctrl_writeReg = write_overflow ? 5'd30 : write_regfile_write_address;

    /* Enable Writing If Needed */
        assign ctrl_writeEnable = write_refile_write_en;
		  

endmodule
