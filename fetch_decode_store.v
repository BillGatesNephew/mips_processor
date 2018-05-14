module fetch_decode_store(
    fetch_pc_address,
    fetch_instruction,
    decode_pc_address,
    decode_instruction,
    clock, reset
);

    /* Port Declaration */
        input  [11:0] fetch_pc_address;
        output [11:0] decode_pc_address;
        input  [31:0] fetch_instruction;
        output [31:0] decode_instruction;
        input clock, reset;
        
/*****************************
 **** PC ADDRESS REGISTER ****
 *****************************/
	wire [31:0] padded_fetch_pc_address, padded_decode_pc_address;
	assign padded_fetch_pc_address[11:0] = fetch_pc_address;

    register fetch_pc_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(padded_fetch_pc_address),
        .out(padded_decode_pc_address)
    );
	assign decode_pc_address = padded_decode_pc_address[11:0];

/******************************
 **** INSTRUCTION REGISTER ****
 ******************************/
    register fetch_instruction_register(
        .clock(clock),
        .enable(clock),
        .reset(reset),
        .data(fetch_instruction),
        .out(decode_instruction)
    );

endmodule