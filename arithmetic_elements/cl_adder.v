module cl_adder(
    input_a, input_b, subtract_ctrl,
    sum, overflow, lt, neq
);
    /* Port Declaratons */
    input [31:0] input_a, input_b;
    input subtract_ctrl; 
    output [31:0] sum;
    output overflow, lt, neq;

    /* CLA Logic */

    // Subtraction Case
    wire [31:0] adjusted_b_input;
    assign adjusted_b_input = subtract_ctrl ? ~input_b : input_b;

    // Wires for outputs
    wire [32:0] generate_signal, propogate_signal, carry_signal, temp;

    // Assignment for initial cell
    assign generate_signal[0] = subtract_ctrl ? 1'b1 : 1'b0; // If subtraction, then need an intial one carry in value 
    assign propogate_signal[0] = 1'b0;
    assign carry_signal[0] = 1'b0; 

    // Actual Adder Module Creation:
    
        // Instantiates 32 cl_cell modules
        // The basic idea is to generate the carry-in value for the next adder using the following
        // expression: C_i = (P_{i-1})(C_{i-1}) + G_{i-1} where i represents the bit index (Starting from 0).
        // Note: cellIndex represents i for the actual cell being created and it represents i-1 for the formula above

         /* Cell Number 0 */
        and tempAnd0(temp[0], propogate_signal[0], carry_signal[0]);
        or carryOr0(carry_signal[1], temp[0], generate_signal[0]);
        cl_cell cell0(
            .a(input_a[0]),
            .b(adjusted_b_input[0]),
            .cin(carry_signal[1]),
            .p(propogate_signal[1]),
            .g(generate_signal[1]),
            .s(sum[0])
        );


        /* Cell Number 1 */
        and tempAnd1(temp[1], propogate_signal[1], carry_signal[1]);
        or carryOr1(carry_signal[2], temp[1], generate_signal[1]);
        cl_cell cell1(
            .a(input_a[1]),
            .b(adjusted_b_input[1]),
            .cin(carry_signal[2]),
            .p(propogate_signal[2]),
            .g(generate_signal[2]),
            .s(sum[1])
        );


        /* Cell Number 2 */
        and tempAnd2(temp[2], propogate_signal[2], carry_signal[2]);
        or carryOr2(carry_signal[3], temp[2], generate_signal[2]);
        cl_cell cell2(
            .a(input_a[2]),
            .b(adjusted_b_input[2]),
            .cin(carry_signal[3]),
            .p(propogate_signal[3]),
            .g(generate_signal[3]),
            .s(sum[2])
        );


        /* Cell Number 3 */
        and tempAnd3(temp[3], propogate_signal[3], carry_signal[3]);
        or carryOr3(carry_signal[4], temp[3], generate_signal[3]);
        cl_cell cell3(
            .a(input_a[3]),
            .b(adjusted_b_input[3]),
            .cin(carry_signal[4]),
            .p(propogate_signal[4]),
            .g(generate_signal[4]),
            .s(sum[3])
        );


        /* Cell Number 4 */
        and tempAnd4(temp[4], propogate_signal[4], carry_signal[4]);
        or carryOr4(carry_signal[5], temp[4], generate_signal[4]);
        cl_cell cell4(
            .a(input_a[4]),
            .b(adjusted_b_input[4]),
            .cin(carry_signal[5]),
            .p(propogate_signal[5]),
            .g(generate_signal[5]),
            .s(sum[4])
        );


        /* Cell Number 5 */
        and tempAnd5(temp[5], propogate_signal[5], carry_signal[5]);
        or carryOr5(carry_signal[6], temp[5], generate_signal[5]);
        cl_cell cell5(
            .a(input_a[5]),
            .b(adjusted_b_input[5]),
            .cin(carry_signal[6]),
            .p(propogate_signal[6]),
            .g(generate_signal[6]),
            .s(sum[5])
        );


        /* Cell Number 6 */
        and tempAnd6(temp[6], propogate_signal[6], carry_signal[6]);
        or carryOr6(carry_signal[7], temp[6], generate_signal[6]);
        cl_cell cell6(
            .a(input_a[6]),
            .b(adjusted_b_input[6]),
            .cin(carry_signal[7]),
            .p(propogate_signal[7]),
            .g(generate_signal[7]),
            .s(sum[6])
        );


        /* Cell Number 7 */
        and tempAnd7(temp[7], propogate_signal[7], carry_signal[7]);
        or carryOr7(carry_signal[8], temp[7], generate_signal[7]);
        cl_cell cell7(
            .a(input_a[7]),
            .b(adjusted_b_input[7]),
            .cin(carry_signal[8]),
            .p(propogate_signal[8]),
            .g(generate_signal[8]),
            .s(sum[7])
        );


        /* Cell Number 8 */
        and tempAnd8(temp[8], propogate_signal[8], carry_signal[8]);
        or carryOr8(carry_signal[9], temp[8], generate_signal[8]);
        cl_cell cell8(
            .a(input_a[8]),
            .b(adjusted_b_input[8]),
            .cin(carry_signal[9]),
            .p(propogate_signal[9]),
            .g(generate_signal[9]),
            .s(sum[8])
        );


        /* Cell Number 9 */
        and tempAnd9(temp[9], propogate_signal[9], carry_signal[9]);
        or carryOr9(carry_signal[10], temp[9], generate_signal[9]);
        cl_cell cell9(
            .a(input_a[9]),
            .b(adjusted_b_input[9]),
            .cin(carry_signal[10]),
            .p(propogate_signal[10]),
            .g(generate_signal[10]),
            .s(sum[9])
        );


        /* Cell Number 10 */
        and tempAnd10(temp[10], propogate_signal[10], carry_signal[10]);
        or carryOr10(carry_signal[11], temp[10], generate_signal[10]);
        cl_cell cell10(
            .a(input_a[10]),
            .b(adjusted_b_input[10]),
            .cin(carry_signal[11]),
            .p(propogate_signal[11]),
            .g(generate_signal[11]),
            .s(sum[10])
        );


        /* Cell Number 11 */
        and tempAnd11(temp[11], propogate_signal[11], carry_signal[11]);
        or carryOr11(carry_signal[12], temp[11], generate_signal[11]);
        cl_cell cell11(
            .a(input_a[11]),
            .b(adjusted_b_input[11]),
            .cin(carry_signal[12]),
            .p(propogate_signal[12]),
            .g(generate_signal[12]),
            .s(sum[11])
        );


        /* Cell Number 12 */
        and tempAnd12(temp[12], propogate_signal[12], carry_signal[12]);
        or carryOr12(carry_signal[13], temp[12], generate_signal[12]);
        cl_cell cell12(
            .a(input_a[12]),
            .b(adjusted_b_input[12]),
            .cin(carry_signal[13]),
            .p(propogate_signal[13]),
            .g(generate_signal[13]),
            .s(sum[12])
        );


        /* Cell Number 13 */
        and tempAnd13(temp[13], propogate_signal[13], carry_signal[13]);
        or carryOr13(carry_signal[14], temp[13], generate_signal[13]);
        cl_cell cell13(
            .a(input_a[13]),
            .b(adjusted_b_input[13]),
            .cin(carry_signal[14]),
            .p(propogate_signal[14]),
            .g(generate_signal[14]),
            .s(sum[13])
        );


        /* Cell Number 14 */
        and tempAnd14(temp[14], propogate_signal[14], carry_signal[14]);
        or carryOr14(carry_signal[15], temp[14], generate_signal[14]);
        cl_cell cell14(
            .a(input_a[14]),
            .b(adjusted_b_input[14]),
            .cin(carry_signal[15]),
            .p(propogate_signal[15]),
            .g(generate_signal[15]),
            .s(sum[14])
        );


        /* Cell Number 15 */
        and tempAnd15(temp[15], propogate_signal[15], carry_signal[15]);
        or carryOr15(carry_signal[16], temp[15], generate_signal[15]);
        cl_cell cell15(
            .a(input_a[15]),
            .b(adjusted_b_input[15]),
            .cin(carry_signal[16]),
            .p(propogate_signal[16]),
            .g(generate_signal[16]),
            .s(sum[15])
        );


        /* Cell Number 16 */
        and tempAnd16(temp[16], propogate_signal[16], carry_signal[16]);
        or carryOr16(carry_signal[17], temp[16], generate_signal[16]);
        cl_cell cell16(
            .a(input_a[16]),
            .b(adjusted_b_input[16]),
            .cin(carry_signal[17]),
            .p(propogate_signal[17]),
            .g(generate_signal[17]),
            .s(sum[16])
        );


        /* Cell Number 17 */
        and tempAnd17(temp[17], propogate_signal[17], carry_signal[17]);
        or carryOr17(carry_signal[18], temp[17], generate_signal[17]);
        cl_cell cell17(
            .a(input_a[17]),
            .b(adjusted_b_input[17]),
            .cin(carry_signal[18]),
            .p(propogate_signal[18]),
            .g(generate_signal[18]),
            .s(sum[17])
        );


        /* Cell Number 18 */
        and tempAnd18(temp[18], propogate_signal[18], carry_signal[18]);
        or carryOr18(carry_signal[19], temp[18], generate_signal[18]);
        cl_cell cell18(
            .a(input_a[18]),
            .b(adjusted_b_input[18]),
            .cin(carry_signal[19]),
            .p(propogate_signal[19]),
            .g(generate_signal[19]),
            .s(sum[18])
        );


        /* Cell Number 19 */
        and tempAnd19(temp[19], propogate_signal[19], carry_signal[19]);
        or carryOr19(carry_signal[20], temp[19], generate_signal[19]);
        cl_cell cell19(
            .a(input_a[19]),
            .b(adjusted_b_input[19]),
            .cin(carry_signal[20]),
            .p(propogate_signal[20]),
            .g(generate_signal[20]),
            .s(sum[19])
        );


        /* Cell Number 20 */
        and tempAnd20(temp[20], propogate_signal[20], carry_signal[20]);
        or carryOr20(carry_signal[21], temp[20], generate_signal[20]);
        cl_cell cell20(
            .a(input_a[20]),
            .b(adjusted_b_input[20]),
            .cin(carry_signal[21]),
            .p(propogate_signal[21]),
            .g(generate_signal[21]),
            .s(sum[20])
        );


        /* Cell Number 21 */
        and tempAnd21(temp[21], propogate_signal[21], carry_signal[21]);
        or carryOr21(carry_signal[22], temp[21], generate_signal[21]);
        cl_cell cell21(
            .a(input_a[21]),
            .b(adjusted_b_input[21]),
            .cin(carry_signal[22]),
            .p(propogate_signal[22]),
            .g(generate_signal[22]),
            .s(sum[21])
        );


        /* Cell Number 22 */
        and tempAnd22(temp[22], propogate_signal[22], carry_signal[22]);
        or carryOr22(carry_signal[23], temp[22], generate_signal[22]);
        cl_cell cell22(
            .a(input_a[22]),
            .b(adjusted_b_input[22]),
            .cin(carry_signal[23]),
            .p(propogate_signal[23]),
            .g(generate_signal[23]),
            .s(sum[22])
        );


        /* Cell Number 23 */
        and tempAnd23(temp[23], propogate_signal[23], carry_signal[23]);
        or carryOr23(carry_signal[24], temp[23], generate_signal[23]);
        cl_cell cell23(
            .a(input_a[23]),
            .b(adjusted_b_input[23]),
            .cin(carry_signal[24]),
            .p(propogate_signal[24]),
            .g(generate_signal[24]),
            .s(sum[23])
        );


        /* Cell Number 24 */
        and tempAnd24(temp[24], propogate_signal[24], carry_signal[24]);
        or carryOr24(carry_signal[25], temp[24], generate_signal[24]);
        cl_cell cell24(
            .a(input_a[24]),
            .b(adjusted_b_input[24]),
            .cin(carry_signal[25]),
            .p(propogate_signal[25]),
            .g(generate_signal[25]),
            .s(sum[24])
        );


        /* Cell Number 25 */
        and tempAnd25(temp[25], propogate_signal[25], carry_signal[25]);
        or carryOr25(carry_signal[26], temp[25], generate_signal[25]);
        cl_cell cell25(
            .a(input_a[25]),
            .b(adjusted_b_input[25]),
            .cin(carry_signal[26]),
            .p(propogate_signal[26]),
            .g(generate_signal[26]),
            .s(sum[25])
        );


        /* Cell Number 26 */
        and tempAnd26(temp[26], propogate_signal[26], carry_signal[26]);
        or carryOr26(carry_signal[27], temp[26], generate_signal[26]);
        cl_cell cell26(
            .a(input_a[26]),
            .b(adjusted_b_input[26]),
            .cin(carry_signal[27]),
            .p(propogate_signal[27]),
            .g(generate_signal[27]),
            .s(sum[26])
        );


        /* Cell Number 27 */
        and tempAnd27(temp[27], propogate_signal[27], carry_signal[27]);
        or carryOr27(carry_signal[28], temp[27], generate_signal[27]);
        cl_cell cell27(
            .a(input_a[27]),
            .b(adjusted_b_input[27]),
            .cin(carry_signal[28]),
            .p(propogate_signal[28]),
            .g(generate_signal[28]),
            .s(sum[27])
        );


        /* Cell Number 28 */
        and tempAnd28(temp[28], propogate_signal[28], carry_signal[28]);
        or carryOr28(carry_signal[29], temp[28], generate_signal[28]);
        cl_cell cell28(
            .a(input_a[28]),
            .b(adjusted_b_input[28]),
            .cin(carry_signal[29]),
            .p(propogate_signal[29]),
            .g(generate_signal[29]),
            .s(sum[28])
        );


        /* Cell Number 29 */
        and tempAnd29(temp[29], propogate_signal[29], carry_signal[29]);
        or carryOr29(carry_signal[30], temp[29], generate_signal[29]);
        cl_cell cell29(
            .a(input_a[29]),
            .b(adjusted_b_input[29]),
            .cin(carry_signal[30]),
            .p(propogate_signal[30]),
            .g(generate_signal[30]),
            .s(sum[29])
        );


        /* Cell Number 30 */
        and tempAnd30(temp[30], propogate_signal[30], carry_signal[30]);
        or carryOr30(carry_signal[31], temp[30], generate_signal[30]);
        cl_cell cell30(
            .a(input_a[30]),
            .b(adjusted_b_input[30]),
            .cin(carry_signal[31]),
            .p(propogate_signal[31]),
            .g(generate_signal[31]),
            .s(sum[30])
        );


        /* Cell Number 31 */
        and tempAnd31(temp[31], propogate_signal[31], carry_signal[31]);
        or carryOr31(carry_signal[32], temp[31], generate_signal[31]);
        cl_cell cell31(
            .a(input_a[31]),
            .b(adjusted_b_input[31]),
            .cin(carry_signal[32]),
            .p(propogate_signal[32]),
            .g(generate_signal[32]),
            .s(sum[31])
        );


    /* Information Signals */

    // Overflow Check 
    wire tempWire, finalCout; 
    and ovfAnd(tempWire, propogate_signal[32], carry_signal[32]);
    or ovfOr(finalCout, tempWire, generate_signal[32]);
    xor ovf_xor(overflow, finalCout, carry_signal[32]);

    // Less Than Check
    // Just check highest bit. If 1, then sum is negative so A must be less than B.
    xor lt_xor(lt, overflow, sum[31]);

    // Not Equal Check
    // If the xor of the two inputs is 0, then they are equal, so flag should be 0.
    wire [31:0] bit_comparisons;
    genvar bit_index; 
    generate
        for(bit_index = 0; bit_index < 32; bit_index = bit_index + 1) begin: neq_check
            xor bit_compare(
                bit_comparisons[bit_index], 
                input_a[bit_index],
                input_b[bit_index]
            );
        end 
    endgenerate

    assign neq = ( | bit_comparisons) ? 1'b1 : 1'b0;

endmodule