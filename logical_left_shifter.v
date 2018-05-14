module logical_left_shifter(in, shiftamt, out);
    /* Port Declaration */
    input [31:0] in;
    input [4:0] shiftamt; 
    output [31:0] out; 

    wire [31:0] first_bit_out, second_bit_out, third_bit_out, fourth_bit_out, fifth_bit_out;

    // 16 bit shift
    assign first_bit_out[15:0] = shiftamt[4] ? 16'b0 : in[15:0];
    assign first_bit_out[31:16] = shiftamt[4] ? in[15:0] : in[31:16];

    // 8 bit shift
    assign second_bit_out[7:0] = shiftamt[3] ? 8'b0 : first_bit_out[7:0];
    assign second_bit_out[31:8] = shiftamt[3] ? first_bit_out[23:0] : first_bit_out[31:8];

    // 4 bit shift
    assign third_bit_out[3:0] = shiftamt[2] ? 4'b0 : second_bit_out[3:0];
    assign third_bit_out[31:4] = shiftamt[2] ? second_bit_out[27:0] : second_bit_out[31:4];

    // 2 bit shift
    assign fourth_bit_out[1:0] = shiftamt[1] ? 2'b0 : third_bit_out[1:0];
    assign fourth_bit_out[31:2] = shiftamt[1] ? third_bit_out[29:0] : third_bit_out[31:2];

    // 1 bit shift 
    assign fifth_bit_out[0] = shiftamt[0] ? 1'b0 : fourth_bit_out[0];
    assign fifth_bit_out[31:1] = shiftamt[0] ? fourth_bit_out[30:0] : fourth_bit_out[31:1];

    assign out = fifth_bit_out;
endmodule