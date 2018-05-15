module cl_cell(a, b, cin, p, g, s);
    /* Port Declarations */
    input a, b, cin; 
    output p, g, s; 
    /* Carry-lookahead Single Cell Logic */
    and generate_signal(g, a, b);
    or propogate_signal(p, a, b);
    xor sum(s, a, b, cin);
endmodule