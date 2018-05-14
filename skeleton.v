/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton(clock, reset, 

	address_imem_val, 
	q_imem_val,

	address_dmem_val,
	data_val,
	wren_val,
	q_dmem_val,


    ctrl_writeEnable_val,
    ctrl_writeReg_val,    
    ctrl_readRegA_val,
    ctrl_readRegB_val,
    data_writeReg_val,
    data_readRegA_val,
    data_readRegB_val,
	 
	 hazard_detected_val,
     write_overflow_val,
     bypass_ram_en_val,
     write_input_a_val,
     write_input_b_val,
     execute_input_a_val,
     branch_taken_val,
     bypass_B_mux_selector_val
);
    input clock, reset;

	 output [11:0] address_imem_val, address_dmem_val;
	 output [31:0] q_imem_val, data_val, q_dmem_val,
                   data_writeReg_val;
	 output wren_val, ctrl_writeEnable_val, hazard_detected_val, write_overflow_val, bypass_ram_en_val, branch_taken_val;
     output [4:0] ctrl_writeReg_val, ctrl_readRegA_val, ctrl_readRegB_val;
	 output [31:0] write_input_a_val, write_input_b_val, execute_input_a_val, data_readRegA_val, data_readRegB_val;
     output [1:0] bypass_B_mux_selector_val;
	 
    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
	
    wire [11:0] address_imem;
    wire [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
	    .clock        (~clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );
	 
	 assign address_imem_val = address_imem;
	 assign q_imem_val = q_imem;

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (~clock),                  // may need to invert the clock
        .data	    (data),    // data you want to write
        .wren	    (wren),      // wri
        .q          (q_dmem)    // data from dmem
    );
	 
	 assign address_dmem_val = address_dmem;
	 assign data_val = data; 
	 assign wren_val = wren;
	 assign q_dmem_val = q_dmem;
	 

    /** REGFILE **/
    // Instantiate your regfile
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        clock,
        ctrl_writeEnable,
        ctrl_reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    assign ctrl_writeEnable_val = ctrl_writeEnable;
    assign ctrl_writeReg_val = ctrl_writeReg;
    assign ctrl_readRegA_val = ctrl_readRegA;
    assign ctrl_readRegB_val = ctrl_readRegB;
    assign data_writeReg_val = data_writeReg;
    assign data_readRegA_val = data_readRegA;
    assign data_readRegB_val = data_readRegB;
    /** PROCESSOR **/
    processor my_processor(
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

endmodule
