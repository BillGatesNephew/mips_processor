module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // Decode the opcode 
   wire [31:0] encoding;
   decoder decoding_unit(.in(ctrl_ALUopcode), .hot_encoding(encoding));

   // Determine if subtraction is taking place
   wire subtract_flag = encoding[1];

   // Operation Outputs
   wire [31:0] sum, bw_and, bw_or, sll, sra;
   cl_adder adder(
       .input_a(data_operandA),
       .input_b(data_operandB),
       .subtract_ctrl(subtract_flag),
       .sum(sum),
       .overflow(overflow),
       .lt(isLessThan),
       .neq(isNotEqual)
   );
   bitwise_and bw_and_unit(
       .input_a(data_operandA), 
       .input_b(data_operandB),
       .out(bw_and)
    );
    bitwise_or bw_or_unit(
       .input_a(data_operandA), 
       .input_b(data_operandB),
       .out(bw_or)
    );
    logical_left_shifter left_shifter(
        .in(data_operandA),
        .shiftamt(ctrl_shiftamt),
        .out(sll)
    );
    arithmetic_right_shifter right_shifter(
        .in(data_operandA),
        .shiftamt(ctrl_shiftamt),
        .out(sra)
    );

    // Assign proper output based on ALU code
    assign data_result = encoding[0] ? sum[31:0] : 32'bz;
    assign data_result = encoding[1] ? sum[31:0] : 32'bz;
    assign data_result = encoding[2] ? bw_and[31:0] : 32'bz; 
    assign data_result = encoding[3] ? bw_or[31:0] : 32'bz;
    assign data_result = encoding[4] ? sll[31:0] : 32'bz;
    assign data_result = encoding[5] ? sra[31:0] : 32'bz;

endmodule
