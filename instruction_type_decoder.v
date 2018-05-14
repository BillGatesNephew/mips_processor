/**
 *  Determines the type of the provided instruction, and then
 *  sets the proper output flag appropriately. Note that only
 *  one of the four outputs will ever be 1.
 *  
 *  Ports:
 *      opcode   - Input  - [4:0] - The instructions opcode segment
 *      R_type   - Output - 1 if opcode represents an R-type instruction
 *      I_type   - Output - 1 if opcode represents an I-type instruction
 *      JI_type  - Output - 1 if opcode represents an JI-type instruction
 *      JII_type - Output - 1 if opcode represents an JII-type instruction
 *
 */
module instruction_type_decoder(opcode, R_type, I_type, JI_type, JII_type);
    
    /* Port Declarations */
        input  [4:0] opcode;
        output R_type, I_type, JI_type, JII_type;

/**********************
 **** R Type Check ****
 **********************/
    // Check for R Type 00000 Opcode
    assign R_type = (~opcode[4] && ~opcode[3] && ~opcode[2] && ~opcode[1] && ~opcode[0]);

/**********************
 **** I Type Check ****
 **********************/
    wire I_op_00010, I_op_00101, I_op_00110, I_op_00111, I_op_01000;

    // Check for I Type 00010 Opcode
    assign I_op_00010 = (~opcode[4] && ~opcode[3] && ~opcode[2] && opcode[1] && ~opcode[0]);

    // Check for I Type 00101 Opcode
    assign I_op_00101 = (~opcode[4] && ~opcode[3] && opcode[2] && ~opcode[1] && opcode[0]);

    // Check for I Type 00110 Opcode
    assign I_op_00110 = (~opcode[4] && ~opcode[3] && opcode[2] && opcode[1] && ~opcode[0]);

    // Check for I Type 00111 Opcode
    assign I_op_00111 = (~opcode[4] && ~opcode[3] && opcode[2] && opcode[1] && opcode[0]);

    // Check for I Type 01000 Opcode
    assign I_op_01000 = (~opcode[4] && opcode[3] && ~opcode[2] && ~opcode[1] && ~opcode[0]);

    assign I_type = (I_op_00010 || I_op_00101 || I_op_00110 || I_op_00111 || I_op_01000);

/***********************
 **** JI Type Check ****
 ***********************/
    wire JI_op_00001, JI_op_00011, JI_op_10101, JI_op_10110;

    // Check for JI Type 00001 Opcode
    assign JI_op_00001 = (~opcode[4] && ~opcode[3] && ~opcode[2] && ~opcode[1] && opcode[0]);

    // Check for JI Type 00011 Opcode
    assign JI_op_00011 = (~opcode[4] && ~opcode[3] && ~opcode[2] && opcode[1] && opcode[0]);

    // Check for JI Type 10101 Opcode
    assign JI_op_10101 = (opcode[4] && ~opcode[3] && opcode[2] && ~opcode[1] && opcode[0]);

    // Check for JI Type 10110 Opcode
    assign JI_op_10110 = (opcode[4] && ~opcode[3] && opcode[2] && opcode[1] && ~opcode[0]);

    assign JI_type = (JI_op_00001 || JI_op_00011 || JI_op_10101 || JI_op_10110);

 /************************
 **** JII Type Check ****
 ************************/
    // Check for JII Type 00100 Opcode
    assign JII_type = (~opcode[4] && ~opcode[3] && opcode[2] && ~opcode[1] && ~opcode[0]);

endmodule