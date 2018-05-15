module register_file(
    clock, reset, write_en, 
    write_reg_addr, read_reg_a_addr, read_reg_b_addr,
    write_reg_data_in, reg_a_data_out, reg_b_data_out     
);
    /* Parameter Declarations */
    parameter ADDRESS_WIDTH = 5; // Number of bits used for addressing a register
    parameter REG_SIZE     = 32; // Bits stored in a register

    /* Port Declarations */
    input  clock, reset, write_en;
    input  [ADDRESS_WIDTH-1:0] write_reg_addr, read_reg_a_addr, read_reg_b_addr;
    input  [REG_SIZE-1:0] write_reg_data_in;
    output [REG_SIZE-1:0] reg_a_data_out, reg_b_data_out;

/* Register File Logic */
    
    // Decode each address to the register file
    wire [(1 << ADDRESS_WIDTH):0] decoded_read_a, decoded_read_b, decoded_write;
    decoder decode_a(
        .input_address(read_reg_a_addr),
        .decoded_output(decoded_read_a)
    );
    decoder decode_b(
        .input_address(read_reg_b_addr),
        .decoded_output(decoded_read_b)
    );
    decoder decode_write(
        .input_address(write_reg_addr),
        .decoded_output(decoded_write)
    );

    // Generates 2^(ADDRESS_WIDTH) different registers
    genvar register_index;
    generate
        for(register_index = 0; register_index < (1 << ADDRESS_WIDTH); register_index = register_index + 1)
        begin: register_creation_loop
            // Determine whether or not to write to the register
            wire write_to;
            assign write_to = decoded_write[register_index] ? (register_index ? 1'b1 : 1'b0) : 1'b0;
            // Create new register and assign to output if needed
            wire [REG_SIZE-1:0] data_from_register;
            register new_register(
                .REGISTER_SIZE(REG_SIZE),
                .data_in(write_reg_data_in),
                .clock(clock),
                .enable(write_to),
                .reset(reset),
                .data_out(data_from_register)
            );
            assign reg_a_data_out = decoded_read_a[register_index] ? data_from_register : 32'bz;
            assign reg_b_data_out = decoded_read_b[register_index] ? data_from_register : 32'bz;
        end 
    endgenerate 
endmodule