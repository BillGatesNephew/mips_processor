module dflipflop (q, d, clk, ena, clrn, prn);

    /* Port Declarations */
        input d, clk, ena, clrn, prn;
        output q;
        reg  q;

    always @ (posedge clk or negedge clrn or negedge prn) begin
    // Async active-low preset
        if (~prn)
            begin
            if (clrn)
                q = 1'b1;
            else
                q = 1'bx;
            end
    // Async active-low reset
        else if (~clrn)
            q = 1'b0;
    // Enable
        else if (ena)
            q = d;
		  
    end
endmodule