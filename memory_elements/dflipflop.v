module dflipflop (
    /* Port Declarations */
    input d,     // Input Data
    input clk,   // Clock Signal
    input en,    // Enable Flip-Flop
    input rst,   // Reset Flip-Flop
    output reg q // Flip-Flop Stored Data
);
    /* D Flip-Flop Logic */
    always @ (posedge clk, posedge rst) begin
        if(rst) 
        begin: reset_flip_flop
            q <= 1'b0;
        end
        else if(en)
        begin: register_input_data
            q <= d;
        end
    end
endmodule