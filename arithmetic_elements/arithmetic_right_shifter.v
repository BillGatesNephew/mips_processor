module arithmetic_right_shifter(
    /* Port Declaration */
    input  [31:0] in, 
    input  [4:0]  shiftamt,
    output [31:0] out
);

/* Arithmetic Right Shifter Logic */

    wire [31:0] first_bit_out, second_bit_out, third_bit_out, fourth_bit_out, fifth_bit_out;
    // 16 bit shift
    assign first_bit_out[15:0]  = shiftamt[4] ? in[31:16] : in[15:0];
    assign first_bit_out[31:16] = shiftamt[4] ? (in[31] ? 16'b11111111_11111111 : 16'b00000000_00000000) : in[31:16];
    // 8 bit shift
    assign second_bit_out[23:0]  = shiftamt[3] ? first_bit_out[31:8] : first_bit_out[23:0];
    assign second_bit_out[31:24] = shiftamt[3] ? (in[31] ? 8'b11111111 : 8'b00000000) : first_bit_out[31:24];
    // 4 bit shift
    assign third_bit_out[27:0]  = shiftamt[2] ? second_bit_out[31:4] : second_bit_out[27:0];
    assign third_bit_out[31:28] = shiftamt[2] ? (in[31] ? 4'b1111 : 4'b0000) : second_bit_out[31:28];
    // 2 bit shift
    assign fourth_bit_out[29:0]  = shiftamt[1] ? third_bit_out[31:2] : third_bit_out[29:0];
    assign fourth_bit_out[31:30] = shiftamt[1] ? (in[31] ? 2'b11 : 2'b00) : third_bit_out[31:30];
    // 1 bit shift 
    assign fifth_bit_out[30:0] = shiftamt[0] ? fourth_bit_out[31:1] : fourth_bit_out[30:0];
    assign fifth_bit_out[31]   = shiftamt[0] ? in[31] : fourth_bit_out[31];
    
    assign out = fifth_bit_out;
endmodule