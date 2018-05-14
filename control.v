module control(
    instruction,
    regfile_write_address,
    regfile_write_en,
    ram_to_register_en,
    immediate_en,
    write_to_ram_en,
    read_rd_register_en,
    pc_plus_n_en,
    pc_equals_t_en,
    pc_equals_rd_en
);

    /* Port Declarations */
        input  [31:0] instruction;
        output [4:0] regfile_write_address;
        output regfile_write_en, 
            ram_to_register_en,
            immediate_en, 
            write_to_ram_en,
            read_rd_register_en,
            pc_plus_n_en,
            pc_equals_t_en,
            pc_equals_rd_en;

/************************************
 **** DETERMINE INSTRUCTION TYPE ****
 ************************************/
    wire R_type, I_type, JI_type, JII_type;
    instruction_type_decoder type_decoder(
        .opcode(instruction[31:27]),
        .R_type(R_type), 
        .I_type(I_type),
        .JI_type(JI_type),
        .JII_type(JII_type)
    );

/***************************
 **** SETUP WIRE VALUES ****
 ***************************/

    /**
    *   The purpose of this section is to assign the appropriate 
    *   instruction values to wires for easier control signal
    *   generation logic.
    */
        wire [4:0] opcode, rd;
        assign opcode    = instruction[31:27];
        assign rd        = instruction[26:22];

/************************************************
 **** REGFILE WRITING CONTROL SIGNALS VALUES ****
 ************************************************/
    /**
     *  Determines the address of the register to 
     *  write to, and whether or not the instruction
     *  writes to RegFile at all.
    */
        write_regfile_control regfile_writing_control(
            .opcode(opcode),
            .rd(rd), 
            .write_reg(regfile_write_address), 
            .write_en(regfile_write_en)
        ); 

/****************************************
 **** RAM TO REGISTER CONTROL SIGNAL ****
 ****************************************/

    /* Control Signal For Choosing Data To Write */
    // NOTE: This data is only the data from RAM on
    // lw instruction (Opcode: 01000). Also, note 
    // that this is the only instruction with a 1
    // at opcode[3].
        assign ram_to_register_en = opcode[3] ? 1'b1 : 1'b0;

/******************************************
 **** ENABLE PC + 1 + N CONTROL SIGNAL ****
 ******************************************/
    
    /* Enables PC to Switch Value to PC + 1 + N */
        assign pc_plus_n_en = (
            (~opcode[4] && ~opcode[3] && ~opcode[2] && opcode[1] && ~opcode[0]) || // Enable for bne
            (~opcode[4] && ~opcode[3] &&  opcode[2] && opcode[1] && ~opcode[0])   // Enable for blt
        ) ? 1'b1 : 1'b0;

/**************************************
 **** ENABLE PC = T CONTROL SIGNAL ****
 **************************************/
    
    /* Enables PC to Switch Value to T */
        assign pc_equals_t_en = (
            JI_type &&
            ~(opcode[4] && ~opcode[3] &&  opcode[2] && ~opcode[1] && opcode[0])   // Disable for setx
        ) ? 1'b1 : 1'b0;

/****************************************
 **** ENABLE PC = $RD CONTROL SIGNAL ****
 ****************************************/
    
    /* Enables PC to Switch Value to $rd */
        assign pc_equals_rd_en = JII_type ? 1'b1 : 1'b0;

/*****************************************
 **** ENABLE IMMEDIATE CONTROL SIGNAL ****
 *****************************************/

    /* Enables Use of Immediate Value for ALU */
        assign immediate_en = (I_type & ~pc_plus_n_en) ? 1'b1 : 1'b0;

/*************************************
 **** WRITE TO RAM CONTROL SIGNAL ****
 *************************************/

    /* Enables Writing to RAM */
    // NOTE: Writing is only ever enabled
    // on the sw instruction (Opcode: 00111).
        assign write_to_ram_en = (
            opcode[2] && opcode[1] && opcode[0]
        ) ? 1'b1 : 1'b0;

/*********************************
 **** READ $RD CONTROL SIGNAL ****
 *********************************/
    /* Enables Reading From $rd */
        assign read_rd_register_en = (I_type | JII_type) ? 1'b1 : 1'b0;
    
endmodule