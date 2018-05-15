module predecoder(
    /* Port Declarations */
    input  [3:0]  input_address, 
    output [15:0] decoded_output
);
    
/* Pre-decoder Logic */
    /** 
     * Predecoder creates smaller logic networks out of NAND and NOT gates
     * to facilitate decoding the 4-bit chunk. It was also a conscious 
     * decision to not parameterize this module. For more about the 
     * predecoder see the README.md in the memory_elements folder.
     */
    genvar address_index;
    generate
        for(address_index = 0; address_index < 16; address_index = address_index + 1)
        begin: decode_logic_generation
            // Generate the proper input to the decode subnetwork
            // The address_index determines to use A or !A for subnetwork
            wire [3:0] inputs_combination;
            assign inputs_combination[3] = address_index[3] ? input_address[3] : ~input_address[3];
            assign inputs_combination[2] = address_index[2] ? input_address[2] : ~input_address[2];
            assign inputs_combination[1] = address_index[1] ? input_address[1] : ~input_address[1];
            assign inputs_combination[0] = address_index[0] ? input_address[0] : ~input_address[0];
            // Subnetwork Logic
            wire [2:0] subnetwork_wires;
            nand n1(
                subnetwork_wires[0],
                inputs_combination[3], inputs_combination[2]
            );
            nand n2(
                subnetwork_wires[1],
                inputs_combination[1], inputs_combination[0]
            );
            nand n3(
                subnetwork_wires[2],
                subnetwork_wires[0], subnetwork_wires[1]
            );
            assign decoded_output[address_index] = ~subnetwork_wires[2];

        end 
    endgenerate

endmodule