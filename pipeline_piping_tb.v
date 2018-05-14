`timescale 1 ns / 100 ps
`define TRUE  1
`define FALSE 0

module pipeline_piping_tb();
	/* Checks Outputs after each clock cycle finishes latching on negative edge */

    reg clock, reset;

    /* Reg/Changing Inputs */
    reg [31:0] q_imem, q_dmem, 
               data_readRegA, 
               data_readRegB;


    /* Wire/Non-Changing Inputs */
    wire [4:0]  ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [11:0] address_dmem, address_imem;
    wire [31:0] data_writeReg, data;
    wire ctrl_writeEnable, wren;

    /* Instruction Array For Testing */
    integer cycle;
    reg [5 * 32 - 1:0] instructions        = {
        32'b00000_00001_00010_00011_00000_00000_00,
        32'b00000_00100_00101_00110_00000_00000_00,
        32'b00000_00111_01000_01001_00000_00000_00,
        32'b00000_01010_01011_01100_00000_00000_00,
        32'b00000_01101_01110_01111_00000_00000_00
    };
    reg [5 * 5 - 1:0]  ex_ctrl_writeReg    = { 5'bz, 5'bz, 5'bz, 5'bz, 5'b00001 };
    reg [5 * 5 - 1:0]  ex_ctrl_readRegA    = { 5'bz, 5'b00010, 5'b00101, 5'b01000, 5'b01011 };
    reg [5 * 5 - 1:0]  ex_ctrl_readRegB    = { 5'bz, 5'b00011, 5'b00110, 5'b01001, 5'b01100 };
    reg [5 * 12 - 1:0] ex_address_dmem     = { 12'bz, 12'bz, 12'bz, 12'bz, 12'bz };
    reg [5 * 12 - 1:0] ex_address_imem     = { 12'd0, 12'd1, 12'd2, 12'd3, 12'd4 };
    reg [5 * 32 - 1:0] ex_data_writeReg    = { 32'dz, 32'dz, 32'dz, 32'dz, 32'd0 };
    reg [5 * 32 - 1:0] ex_data             = { 32'dz, 32'dz, 32'dz, 32'dz, 32'dz };
    reg [5 * 1 - 1:0]  ex_ctrl_writeEnable = { 1'b0, 1'b0, 1'b0, 1'b0, 1'b1 };
    reg [5 * 1 - 1:0]  ex_wren             = { 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 };

    /* Instantiate Module */
    processor cpu(
        .clock(clock),
        .reset(reset),
        .address_imem(address_imem),
        .q_imem(q_imem),
        .address_dmem(address_dmem),
        .data(data),
        .wren(wren),
        .q_dmem(q_dmem),
        .ctrl_writeEnable(ctrl_writeEnable),               
        .ctrl_writeReg(ctrl_writeReg),                  
        .ctrl_readRegA(ctrl_readRegA),                   
        .ctrl_readRegB(ctrl_readRegB),                  
        .data_writeReg(data_writeReg),                  
        .data_readRegA(data_readRegA),                
        .data_readRegB(data_readRegB)     
    );


    initial

    begin
        $display($time, "<< Starting the pipeline_piping_tb >>");
        // Initialize clock to 0
        clock = 1'b0;
		  
		  data_readRegA = 32'd0;
		  data_readRegB = 32'd0;
		  // Setup registers
		 // q_imem = instructions[32 * (5) - 1 -:32];
		  
		  reset = 1'b1;
		  @(negedge clock);
		  reset =  1'b0;
		  	//	  q_imem = instructions[32 * (5) - 1 -:32];

		  //@(negedge clock);
		  	//	  @(negedge clock);


		  //@(negedge clock);
		  //@(negedge clock);
		  
        /*****************************
         **** CHECK INITIAL STATE ****
         *****************************/
        if(address_imem !== 12'd0) begin
            $display($time, "   Initial Address Wrong: E: %b | A: %b", 12'd0, address_imem);
        end
        if(ctrl_writeEnable !== `FALSE) begin
            $display("   RegFile Write Enable Wrong: E: %b | A: %b", `FALSE, ctrl_writeEnable);
        end
        if(wren !== `FALSE) begin
            $display("   RAM Write Enable Wrong: E: %b | A: %b", `FALSE, wren);
        end

        /**************************
         **** RUN INSTRUCTIONS ****
         **************************/
        for(cycle = 0; cycle < 5 ; cycle = cycle + 1) begin
            run_cycle();
        end 

        /********************
         **** END TEST ****
         ********************/
        $display("Test finished");

        /* End Test Simulation */
        $stop;
    end

    
    task run_cycle;
        begin  
				$display("-Cycle Number: %d", cycle);
				// Insert Instruction before Running Cycle
            @(posedge clock);
				q_imem = instructions[32 * (5 - cycle) - 1 -:32];
            // Run Cycle
				@(negedge clock);
            // Check Results 
            check_state();


        end 
    endtask

    /* Checks Outputs For Pipeline */
    task check_state;
        begin
            if(ctrl_writeReg !== ex_ctrl_writeReg[5 * (5 - cycle) - 1 -:5] && ex_ctrl_writeReg[5 * (5 - cycle) - 1 -:5] !== 5'bz) begin 
                $display($time, "   ctrl_writeReg Wrong: E: %b | A: %b", ex_ctrl_writeReg[5 * (5 - cycle) - 1 -:5], ctrl_writeReg);
            end
            if(ctrl_readRegA !== ex_ctrl_readRegA[5 * (5 - cycle) - 1 -:5] && ex_ctrl_readRegA[5 * (5 - cycle) - 1 -:5] !== 5'bz) begin 
                $display($time, "   ctrl_readRegA Wrong: E: %b | A: %b", ex_ctrl_readRegA[5 * (5 - cycle) - 1 -:5], ctrl_readRegA);
            end
            if(ctrl_readRegB !== ex_ctrl_readRegB[5 * (5 - cycle) - 1 -:5] && ex_ctrl_readRegB[5 * (5 - cycle) - 1 -:5] !== 5'bz) begin 
                $display($time, "   ctrl_readRegB Wrong: E: %b | A: %b", ex_ctrl_readRegB[5 * (5 - cycle) - 1 -:5], ctrl_readRegB);
            end
            if(address_dmem !== ex_address_dmem[12 * (5 - cycle) - 1 -:12] && ex_address_dmem[12 * (5 - cycle) - 1 -:12] !== 12'bz) begin 
                $display($time, "   Dmem Address Wrong: E: %b | A: %b", ex_address_dmem[12 * (5 - cycle) - 1 -:12], address_dmem);
            end
            if(address_imem !== ex_address_imem[12 * (5 - cycle) - 1 -:12] && ex_address_imem[12 * (5 - cycle) - 1 -:12] !== 12'bz) begin 
                $display($time, "   Imem Address Wrong: E: %b | A: %b", ex_address_imem[12 * (5 - cycle) - 1 -:12], address_imem);
            end
            if(data_writeReg !== ex_data_writeReg[32 * (5 - cycle) - 1 -:32] && ex_data_writeReg[32 * (5 - cycle) - 1 -:32] !== 32'bz) begin 
                $display($time, "   data_writeReg Wrong: E: %b | A: %b", ex_data_writeReg[32 * (5 - cycle) - 1 -:32], data_writeReg);
            end
            if(data !== ex_data[32 * (5 - cycle) - 1 -:32] && ex_data[32 * (5 - cycle) - 1 -:32] !== 32'bz) begin 
                $display($time, "   data Wrong: E: %b | A: %b", ex_data[32 * (5 - cycle) - 1 -:32], data);
            end
            if(ctrl_writeEnable !== ex_ctrl_writeEnable[1 * (5 - cycle) - 1 -:1] && ex_ctrl_writeEnable[1 * (5 - cycle) - 1 -:1] !== 1'bz) begin 
                $display($time, "   ctrl_writeEnable Wrong: E: %b | A: %b", ex_ctrl_writeEnable[1 * (5 - cycle) - 1 -:1], ctrl_writeEnable);
            end
            if(wren !== ex_wren[1 * (5 - cycle) - 1 -:1] && ex_wren[1 * (5 - cycle) - 1 -:1] !== 1'bz) begin 
                $display($time, "   wren Wrong: E: %b | A: %b", ex_wren[1 * (5 - cycle) - 1 -:1], wren);
            end
        end 
    endtask
    /* Clock generator */
    always
        #10 clock = ~clock;
endmodule
