module bypassing_unit(
    execute_instruction,
    memory_instruction,
    write_instruction,
    bypass_A_mux_selector,
    bypass_B_mux_selector,
    bypass_ram_en
);

    /* Port Declarations */
    input [31:0] execute_instruction, memory_instruction, write_instruction; 
    output [1:0] bypass_A_mux_selector, bypass_B_mux_selector;
	 output bypass_ram_en;

/*************************************
 ***** EXECUTE INPUT A MUX LOGIC ***** 
 *************************************/

    // Checks if D/X.IR.RS == X/M.IR.RD -> Select 0 
    wire execute_input_a_select_0;
    register_comparator execute_input_a_comparator_1(
        .register_address_a(execute_instruction[21:17]),
        .register_address_b(memory_instruction[26:22]),
        .equal(execute_input_a_select_0)
    );

    // Checks if D/X.IR.RS == M/W.IR.RD -> Select 1
    wire execute_input_a_select_1;
    register_comparator execute_input_a_comparator_2(
        .register_address_a(execute_instruction[21:17]),
        .register_address_b(write_instruction[26:22]),
        .equal(execute_input_a_select_1)
    );

    assign bypass_A_mux_selector = execute_input_a_select_0 ? 2'b00 : 2'bzz;
    assign bypass_A_mux_selector = execute_input_a_select_1 ? 2'b01 : 2'bzz;
    assign bypass_A_mux_selector = (
        ~execute_input_a_select_0 && ~execute_input_a_select_1
    ) ? 2'b10 : 2'bzz; 

/*************************************
 ***** EXECUTE INPUT B MUX LOGIC ***** 
 *************************************/

    // Checks if D/X.IR.RT == X/M.IR.RD -> Select 0 
    wire execute_input_b_select_0;
    register_comparator execute_input_b_comparator_1(
        .register_address_a(execute_instruction[16:12]),
        .register_address_b(memory_instruction[26:22]),
        .equal(execute_input_b_select_0)
    );

    // Checks if D/X.IR.RT == M/W.IR.RD -> Select 1
    wire execute_input_b_select_1;
    register_comparator execute_input_b_comparator_2(
        .register_address_a(execute_instruction[16:12]),
        .register_address_b(write_instruction[26:22]),
        .equal(execute_input_b_select_1)
    );

    assign bypass_B_mux_selector = execute_input_b_select_0 ? 2'b00 : 2'bzz;
    assign bypass_B_mux_selector = execute_input_b_select_1 ? 2'b01 : 2'bzz;
    assign bypass_B_mux_selector = (
        ~execute_input_b_select_0 && ~execute_input_b_select_1
    ) ? 2'b10 : 2'bzz; 


/***************************************
 ***** RAM DATA INPUT BYPASS LOGIC ***** 
 ***************************************/

    // Checks if (X/M.IR.OP == SW) && (X/M.IR.RD == M/W.IR.RD)
    wire memory_is_sw;
    register_comparator store_word_comparator(
        .register_address_a(memory_instruction[31:27]),
        .register_address_b(5'b00111),
        .equal(memory_is_sw)
    );
    wire memory_rd_equals_write_rd;
    register_comparator memory_rd_equals_write_rd_comparator(
        .register_address_a(memory_instruction[26:22]),
        .register_address_b(write_instruction[26:22]),
        .equal(memory_rd_equals_write_rd)
    );

    assign bypass_ram_en = (
        memory_is_sw && memory_rd_equals_write_rd
    ) ? 1'b1 : 1'b0;

endmodule