`timescale 1 ns / 100 ps

module module_name_tb();

    reg clock;

    /* Reg/Changing Inputs */
    reg signed [31:0];

    /* Wire/Non-Changing Inputs */
    wire signed [31:0];
    wire;

    /* Instantiate Module */
    
    initial

    begin
        /********************
         **** BEGIN TEST ****
         ********************/
        $display($time, "<< Starting the module_name_tb >>");
        // Initialize clock to 0
        clock = 1'b0;

        $display("Test Desc");
        @(negedge clock);
        /* Assign Reg Values */
        
        @(posedge clock);
        
        /* Wait and then test results */

        @(posedge clock);

        $display("Test finished");

        /* Check test results */

        /********************
         **** END TEST ****
         ********************/

        /* End Test Simulation */
        $stop;
    end

    /* Clock generator */
    always
        #10 clock = ~clock;
endmodule
