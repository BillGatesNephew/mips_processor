`timescale 1 ns / 100 ps
`define TRUE  1
`define FALSE 0

module control_unit_tb();

    reg clock;

    /* Reg/Changing Inputs */
    reg [31:0] instruction;
    reg [4:0]  ex_regfile_write_address;
    reg ex_regfile_write_en, ex_ram_to_register_en,
        ex_pc_plus_n_en, ex_pc_equals_t_en,
        ex_pc_equals_rd_en, ex_immediate_en, 
        ex_write_to_ram_en, ex_read_rd_register_en;
    /* Wire/Non-Changing Inputs */
    wire [4:0] regfile_write_address;
    wire regfile_write_en, ram_to_register_en,
         pc_plus_n_en, pc_equals_t_en,
         pc_equals_rd_en, immediate_en,
         write_to_ram_en, read_rd_register_en;

    /* Instantiate Module */
    control control_unit(
        .instruction(instruction),
        .regfile_write_address(regfile_write_address),
        .regfile_write_en(regfile_write_en),
        .ram_to_register_en(ram_to_register_en),
        .pc_plus_n_en(pc_plus_n_en),
        .pc_equals_t_en(pc_equals_t_en),
        .pc_equals_rd_en(pc_equals_rd_en),
        .immediate_en(immediate_en),
        .write_to_ram_en(write_to_ram_en),
        .read_rd_register_en(read_rd_register_en)
    );

    initial

    begin
        $display($time, " << Starting the control_unit_tb >>");
        // Initialize clock to 0
        clock = 1'b0;

        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing Add Instruction: >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00000000100000000000000000000000;
            check_instruction();
        $display("<<< Add Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing Addi Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `TRUE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00101000100000000000000000000000;
            check_instruction();
        $display("<<< Addi Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing sub Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00000_00010_00000_00000_00000_00001_00;
            check_instruction();
        $display("<<< sub Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing and Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00000_00010_00000_00000_00000_00010_00;
            check_instruction();
        $display("<<< and Instruction Test finished >>>");
        /******************
         **** END TEST ****
         ******************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing or Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00000_00010_00000_00000_00000_00011_00;
            check_instruction();
        $display("<<< or Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing sll Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00000_00010_00000_00000_00000_00100_00;
            check_instruction();
        $display("<<< sll Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing sra Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00000_00010_00000_00000_00000_00101_00;
            check_instruction();
        $display("<<< sra Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing sw Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `FALSE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `TRUE;
            ex_write_to_ram_en       = `TRUE;
            ex_read_rd_register_en   = `TRUE;
            instruction = 32'b00111_00010_00000_00000000000000100;
            check_instruction();
        $display("<<< sw Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing lw Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `TRUE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `TRUE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b01000_00010_00000_00000000000000100;
            check_instruction();
        $display("<<< lw Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing j Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `FALSE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `TRUE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00001_000100000000000000000000100;
            check_instruction();
        $display("<<< j Instruction Test finished >>>");
        /********************
         **** END TEST ****
         ********************/
         /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing bne Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `FALSE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `TRUE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `TRUE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `TRUE;
            instruction = 32'b00010_00010_00000_00000000000000100;
            check_instruction();
        $display("<<< bne Instruction Test finished >>>");
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing jal Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b11111;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `TRUE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b00011_000100000000000000000000100;
            check_instruction();
        $display("<<< jal Instruction Test finished >>>");
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing jr Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `FALSE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `TRUE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `TRUE;
            instruction = 32'b00100_00010_0000000000000000000000;
            check_instruction();
        $display("<<< jr Instruction Test finished >>>");
         /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing blt Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `FALSE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `TRUE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `TRUE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `TRUE;
            instruction = 32'b00110_00010_00000_00000000000000100;
            check_instruction();
        $display("<<< blt Instruction Test finished >>>");
         /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing bex Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b00010;
            ex_regfile_write_en      = `FALSE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `TRUE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b10110_000100000000000000000000100;
            check_instruction();
        $display("<<< bex Instruction Test finished >>>");
        /********************
         **** BEGIN TEST ****
         ********************/
        $display("<<< Testing setx Instruction >>>");
            @(negedge clock);
            /* Assign Reg Values */
            // $rd = 00010 (2)
            ex_regfile_write_address = 5'b11110;
            ex_regfile_write_en      = `TRUE;
            ex_ram_to_register_en    = `FALSE;
            ex_pc_plus_n_en          = `FALSE;
            ex_pc_equals_t_en        = `FALSE;
            ex_pc_equals_rd_en       = `FALSE;
            ex_immediate_en          = `FALSE;
            ex_write_to_ram_en       = `FALSE;
            ex_read_rd_register_en   = `FALSE;
            instruction = 32'b10101_000100000000000000000000100;
            check_instruction();
        $display("<<< setx Instruction Test finished >>>");

        $stop;
    end

    /* Clock generator */
    always
        #10 clock = ~clock;

    task check_instruction;
        begin 
            @(negedge clock);
                if(regfile_write_address !== ex_regfile_write_address) begin
                    $display(
                        "   Write Address Wrong: E: %b | A: %b",
                        ex_regfile_write_address, 
                        regfile_write_address
                    );
                end
                if(regfile_write_en !== ex_regfile_write_en) begin
                    $display(
                        "   RegFile Write Wrong : E: %b | A: %b",
                        ex_regfile_write_en, 
                        regfile_write_en
                    );
                end
                if(ram_to_register_en !== ex_ram_to_register_en) begin
                    $display(
                        "   Ram to Register Wrong: E: %b | A: %b",
                        ex_ram_to_register_en, 
                        ram_to_register_en
                    );
                end
                if(pc_plus_n_en !== ex_pc_plus_n_en) begin
                    $display(
                        "   PC + N Enable Wrong: E: %b | A: %b",
                        ex_pc_plus_n_en, 
                        pc_plus_n_en
                    );
                end
                if(pc_equals_t_en !== ex_pc_equals_t_en) begin
                    $display(
                        "   PC = T Enable Wrong: E: %b | A: %b",
                        ex_pc_equals_t_en, 
                        pc_equals_t_en
                    );
                end
                if(pc_equals_rd_en !== ex_pc_equals_rd_en) begin
                    $display(
                        "   PC = $rd Enable Wrong: E: %b | A: %b",
                        ex_pc_equals_rd_en, 
                        pc_equals_rd_en
                    );
                end
                if(immediate_en !== ex_immediate_en) begin
                    $display(
                        "   Immediate Enable Wrong: E: %b | A: %b",
                        ex_immediate_en, 
                        immediate_en
                    );
                end
                if(write_to_ram_en !== ex_write_to_ram_en) begin
                    $display(
                        "   Write To Ram Wrong: E: %b | A: %b",
                        ex_write_to_ram_en, 
                        write_to_ram_en
                    );
                end
                if(read_rd_register_en !== ex_read_rd_register_en) begin
                    $display(
                        "   Read $rd Enable Wrong: E: %b | A: %b",
                        ex_read_rd_register_en, 
                        read_rd_register_en
                    );
                end
        end
    endtask
endmodule
