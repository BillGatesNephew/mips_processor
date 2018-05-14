module hazard_detection_unit(
    execute_instruction,
	 decode_instruction,
	 hazard_detected
);

    /* Port Declarations */
		input [31:0] execute_instruction, decode_instruction;
		output       hazard_detected;
	
/**********************************
 ***** HAZARD DETECTION LOGIC ***** 
 **********************************/
	
	/* (D/X.IR.OP == LOAD) */
	wire load_instruction_flag;
	register_comparator is_load_instruction_comparator(
		.register_address_a(execute_instruction[31:27]),
		.register_address_b(5'b01000),
		.equal(load_instruction_flag)
	);
	
	/* (F/D.IR.OP != STORE) */
	wire store_instruction_flag;
	register_comparator is_store_instruction_comparator(
		.register_address_a(decode_instruction[31:27]),
		.register_address_b(5'b00111),
		.equal(store_instruction_flag)
	); 
	
	/* (F/D.IR.RS == D/X.IR.RD) */
	wire decode_rs_equals_execute_rd; 
	register_comparator decode_rs_equals_execute_rd_comparator(
		.register_address_a(decode_instruction[27:17]),
		.register_address_b(execute_instruction[26:22]),
		.equal(decode_rs_equals_execute_rd)
	); 
	
	/* (F/D.IR.Rt == D/X.IR.RD) */
	wire decode_rt_equals_execute_rd; 
	register_comparator decode_rt_equals_execute_rd_comparator(
		.register_address_a(decode_instruction[16:12]),
		.register_address_b(execute_instruction[26:22]),
		.equal(decode_rt_equals_execute_rd)
	); 
	
	/* Stall = (D/X.IR.OP == LOAD) && (
		(F/D.IR.RS == D/X.IR.RD) ||
		((F/D.IR.Rt == D/X.IR.RD) && (F/D.IR.OP != STORE)) 
	*/
	assign hazard_detected = (
		load_instruction_flag && (
			decode_rs_equals_execute_rd || (
				decode_rt_equals_execute_rd && store_instruction_flag
			)
		)
	) ? 1'b1 : 1'b0;
	
	
	
endmodule