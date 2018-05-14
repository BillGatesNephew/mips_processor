module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);
	
	/* Port Declarations */
	
   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
   output [31:0] data_readRegA, data_readRegB;
	
	/* Step 1: Decode register selection controls */
	
	wire [31:0] decoded_read_a, decoded_read_b, decoded_write;
	decoder decodeA(.in(ctrl_readRegA), .hot_encoding(decoded_read_a));
	decoder decodeB(.in(ctrl_readRegB), .hot_encoding(decoded_read_b));
	decoder decodeW(.in(ctrl_writeReg), .hot_encoding(decoded_write));

	/* Step 2: Iterate over the registers */
	
	wire [31:0] write_to_reg; // Holds output of write control input
	wire [1023:0] makeshift_mux; //Holds output of all registers for selection
	
	
	// Handle zero register
	assign makeshift_mux[31: 0] = 32'b0;
	assign data_readRegA = (decoded_read_a[0]) ? 32'b0 : 32'bz;
	assign data_readRegB = (decoded_read_b[0]) ? 32'b0 : 32'bz;

	    and enableWrite1(write_to_reg[1], ctrl_writeEnable, decoded_write[1]);
    register reg1(
        .clock(clock),
        .enable(write_to_reg[1]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[63:32])
    );
    assign data_readRegA = (decoded_read_a[1]) ? makeshift_mux[63: 32] : 32'bz;
    assign data_readRegB = (decoded_read_b[1]) ? makeshift_mux[63:32] : 32'bz;

    and enableWrite2(write_to_reg[2], ctrl_writeEnable, decoded_write[2]);
    register reg2(
        .clock(clock),
        .enable(write_to_reg[2]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[95:64])
    );
    assign data_readRegA = (decoded_read_a[2]) ? makeshift_mux[95: 64] : 32'bz;
    assign data_readRegB = (decoded_read_b[2]) ? makeshift_mux[95:64] : 32'bz;

    and enableWrite3(write_to_reg[3], ctrl_writeEnable, decoded_write[3]);
    register reg3(
        .clock(clock),
        .enable(write_to_reg[3]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[127:96])
    );
    assign data_readRegA = (decoded_read_a[3]) ? makeshift_mux[127: 96] : 32'bz;
    assign data_readRegB = (decoded_read_b[3]) ? makeshift_mux[127:96] : 32'bz;

    and enableWrite4(write_to_reg[4], ctrl_writeEnable, decoded_write[4]);
    register reg4(
        .clock(clock),
        .enable(write_to_reg[4]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[159:128])
    );
    assign data_readRegA = (decoded_read_a[4]) ? makeshift_mux[159: 128] : 32'bz;
    assign data_readRegB = (decoded_read_b[4]) ? makeshift_mux[159:128] : 32'bz;

    and enableWrite5(write_to_reg[5], ctrl_writeEnable, decoded_write[5]);
    register reg5(
        .clock(clock),
        .enable(write_to_reg[5]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[191:160])
    );
    assign data_readRegA = (decoded_read_a[5]) ? makeshift_mux[191: 160] : 32'bz;
    assign data_readRegB = (decoded_read_b[5]) ? makeshift_mux[191:160] : 32'bz;

    and enableWrite6(write_to_reg[6], ctrl_writeEnable, decoded_write[6]);
    register reg6(
        .clock(clock),
        .enable(write_to_reg[6]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[223:192])
    );
    assign data_readRegA = (decoded_read_a[6]) ? makeshift_mux[223: 192] : 32'bz;
    assign data_readRegB = (decoded_read_b[6]) ? makeshift_mux[223:192] : 32'bz;

    and enableWrite7(write_to_reg[7], ctrl_writeEnable, decoded_write[7]);
    register reg7(
        .clock(clock),
        .enable(write_to_reg[7]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[255:224])
    );
    assign data_readRegA = (decoded_read_a[7]) ? makeshift_mux[255: 224] : 32'bz;
    assign data_readRegB = (decoded_read_b[7]) ? makeshift_mux[255:224] : 32'bz;

    and enableWrite8(write_to_reg[8], ctrl_writeEnable, decoded_write[8]);
    register reg8(
        .clock(clock),
        .enable(write_to_reg[8]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[287:256])
    );
    assign data_readRegA = (decoded_read_a[8]) ? makeshift_mux[287: 256] : 32'bz;
    assign data_readRegB = (decoded_read_b[8]) ? makeshift_mux[287:256] : 32'bz;

    and enableWrite9(write_to_reg[9], ctrl_writeEnable, decoded_write[9]);
    register reg9(
        .clock(clock),
        .enable(write_to_reg[9]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[319:288])
    );
    assign data_readRegA = (decoded_read_a[9]) ? makeshift_mux[319: 288] : 32'bz;
    assign data_readRegB = (decoded_read_b[9]) ? makeshift_mux[319:288] : 32'bz;

    and enableWrite10(write_to_reg[10], ctrl_writeEnable, decoded_write[10]);
    register reg10(
        .clock(clock),
        .enable(write_to_reg[10]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[351:320])
    );
    assign data_readRegA = (decoded_read_a[10]) ? makeshift_mux[351: 320] : 32'bz;
    assign data_readRegB = (decoded_read_b[10]) ? makeshift_mux[351:320] : 32'bz;

    and enableWrite11(write_to_reg[11], ctrl_writeEnable, decoded_write[11]);
    register reg11(
        .clock(clock),
        .enable(write_to_reg[11]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[383:352])
    );
    assign data_readRegA = (decoded_read_a[11]) ? makeshift_mux[383: 352] : 32'bz;
    assign data_readRegB = (decoded_read_b[11]) ? makeshift_mux[383:352] : 32'bz;

    and enableWrite12(write_to_reg[12], ctrl_writeEnable, decoded_write[12]);
    register reg12(
        .clock(clock),
        .enable(write_to_reg[12]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[415:384])
    );
    assign data_readRegA = (decoded_read_a[12]) ? makeshift_mux[415: 384] : 32'bz;
    assign data_readRegB = (decoded_read_b[12]) ? makeshift_mux[415:384] : 32'bz;

    and enableWrite13(write_to_reg[13], ctrl_writeEnable, decoded_write[13]);
    register reg13(
        .clock(clock),
        .enable(write_to_reg[13]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[447:416])
    );
    assign data_readRegA = (decoded_read_a[13]) ? makeshift_mux[447: 416] : 32'bz;
    assign data_readRegB = (decoded_read_b[13]) ? makeshift_mux[447:416] : 32'bz;

    and enableWrite14(write_to_reg[14], ctrl_writeEnable, decoded_write[14]);
    register reg14(
        .clock(clock),
        .enable(write_to_reg[14]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[479:448])
    );
    assign data_readRegA = (decoded_read_a[14]) ? makeshift_mux[479: 448] : 32'bz;
    assign data_readRegB = (decoded_read_b[14]) ? makeshift_mux[479:448] : 32'bz;

    and enableWrite15(write_to_reg[15], ctrl_writeEnable, decoded_write[15]);
    register reg15(
        .clock(clock),
        .enable(write_to_reg[15]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[511:480])
    );
    assign data_readRegA = (decoded_read_a[15]) ? makeshift_mux[511: 480] : 32'bz;
    assign data_readRegB = (decoded_read_b[15]) ? makeshift_mux[511:480] : 32'bz;

    and enableWrite16(write_to_reg[16], ctrl_writeEnable, decoded_write[16]);
    register reg16(
        .clock(clock),
        .enable(write_to_reg[16]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[543:512])
    );
    assign data_readRegA = (decoded_read_a[16]) ? makeshift_mux[543: 512] : 32'bz;
    assign data_readRegB = (decoded_read_b[16]) ? makeshift_mux[543:512] : 32'bz;

    and enableWrite17(write_to_reg[17], ctrl_writeEnable, decoded_write[17]);
    register reg17(
        .clock(clock),
        .enable(write_to_reg[17]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[575:544])
    );
    assign data_readRegA = (decoded_read_a[17]) ? makeshift_mux[575: 544] : 32'bz;
    assign data_readRegB = (decoded_read_b[17]) ? makeshift_mux[575:544] : 32'bz;

    and enableWrite18(write_to_reg[18], ctrl_writeEnable, decoded_write[18]);
    register reg18(
        .clock(clock),
        .enable(write_to_reg[18]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[607:576])
    );
    assign data_readRegA = (decoded_read_a[18]) ? makeshift_mux[607: 576] : 32'bz;
    assign data_readRegB = (decoded_read_b[18]) ? makeshift_mux[607:576] : 32'bz;

    and enableWrite19(write_to_reg[19], ctrl_writeEnable, decoded_write[19]);
    register reg19(
        .clock(clock),
        .enable(write_to_reg[19]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[639:608])
    );
    assign data_readRegA = (decoded_read_a[19]) ? makeshift_mux[639: 608] : 32'bz;
    assign data_readRegB = (decoded_read_b[19]) ? makeshift_mux[639:608] : 32'bz;

    and enableWrite20(write_to_reg[20], ctrl_writeEnable, decoded_write[20]);
    register reg20(
        .clock(clock),
        .enable(write_to_reg[20]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[671:640])
    );
    assign data_readRegA = (decoded_read_a[20]) ? makeshift_mux[671: 640] : 32'bz;
    assign data_readRegB = (decoded_read_b[20]) ? makeshift_mux[671:640] : 32'bz;

    and enableWrite21(write_to_reg[21], ctrl_writeEnable, decoded_write[21]);
    register reg21(
        .clock(clock),
        .enable(write_to_reg[21]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[703:672])
    );
    assign data_readRegA = (decoded_read_a[21]) ? makeshift_mux[703: 672] : 32'bz;
    assign data_readRegB = (decoded_read_b[21]) ? makeshift_mux[703:672] : 32'bz;

    and enableWrite22(write_to_reg[22], ctrl_writeEnable, decoded_write[22]);
    register reg22(
        .clock(clock),
        .enable(write_to_reg[22]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[735:704])
    );
    assign data_readRegA = (decoded_read_a[22]) ? makeshift_mux[735: 704] : 32'bz;
    assign data_readRegB = (decoded_read_b[22]) ? makeshift_mux[735:704] : 32'bz;

    and enableWrite23(write_to_reg[23], ctrl_writeEnable, decoded_write[23]);
    register reg23(
        .clock(clock),
        .enable(write_to_reg[23]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[767:736])
    );
    assign data_readRegA = (decoded_read_a[23]) ? makeshift_mux[767: 736] : 32'bz;
    assign data_readRegB = (decoded_read_b[23]) ? makeshift_mux[767:736] : 32'bz;

    and enableWrite24(write_to_reg[24], ctrl_writeEnable, decoded_write[24]);
    register reg24(
        .clock(clock),
        .enable(write_to_reg[24]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[799:768])
    );
    assign data_readRegA = (decoded_read_a[24]) ? makeshift_mux[799: 768] : 32'bz;
    assign data_readRegB = (decoded_read_b[24]) ? makeshift_mux[799:768] : 32'bz;

    and enableWrite25(write_to_reg[25], ctrl_writeEnable, decoded_write[25]);
    register reg25(
        .clock(clock),
        .enable(write_to_reg[25]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[831:800])
    );
    assign data_readRegA = (decoded_read_a[25]) ? makeshift_mux[831: 800] : 32'bz;
    assign data_readRegB = (decoded_read_b[25]) ? makeshift_mux[831:800] : 32'bz;

    and enableWrite26(write_to_reg[26], ctrl_writeEnable, decoded_write[26]);
    register reg26(
        .clock(clock),
        .enable(write_to_reg[26]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[863:832])
    );
    assign data_readRegA = (decoded_read_a[26]) ? makeshift_mux[863: 832] : 32'bz;
    assign data_readRegB = (decoded_read_b[26]) ? makeshift_mux[863:832] : 32'bz;

    and enableWrite27(write_to_reg[27], ctrl_writeEnable, decoded_write[27]);
    register reg27(
        .clock(clock),
        .enable(write_to_reg[27]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[895:864])
    );
    assign data_readRegA = (decoded_read_a[27]) ? makeshift_mux[895: 864] : 32'bz;
    assign data_readRegB = (decoded_read_b[27]) ? makeshift_mux[895:864] : 32'bz;

    and enableWrite28(write_to_reg[28], ctrl_writeEnable, decoded_write[28]);
    register reg28(
        .clock(clock),
        .enable(write_to_reg[28]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[927:896])
    );
    assign data_readRegA = (decoded_read_a[28]) ? makeshift_mux[927: 896] : 32'bz;
    assign data_readRegB = (decoded_read_b[28]) ? makeshift_mux[927:896] : 32'bz;

    and enableWrite29(write_to_reg[29], ctrl_writeEnable, decoded_write[29]);
    register reg29(
        .clock(clock),
        .enable(write_to_reg[29]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[959:928])
    );
    assign data_readRegA = (decoded_read_a[29]) ? makeshift_mux[959: 928] : 32'bz;
    assign data_readRegB = (decoded_read_b[29]) ? makeshift_mux[959:928] : 32'bz;

    and enableWrite30(write_to_reg[30], ctrl_writeEnable, decoded_write[30]);
    register reg30(
        .clock(clock),
        .enable(write_to_reg[30]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[991:960])
    );
    assign data_readRegA = (decoded_read_a[30]) ? makeshift_mux[991: 960] : 32'bz;
    assign data_readRegB = (decoded_read_b[30]) ? makeshift_mux[991:960] : 32'bz;

    and enableWrite31(write_to_reg[31], ctrl_writeEnable, decoded_write[31]);
    register reg31(
        .clock(clock),
        .enable(write_to_reg[31]),
        .reset(ctrl_reset),
        .data(data_writeReg),
        .out(makeshift_mux[1023:992])
    );
    assign data_readRegA = (decoded_read_a[31]) ? makeshift_mux[1023: 992] : 32'bz;
    assign data_readRegB = (decoded_read_b[31]) ? makeshift_mux[1023:992] : 32'bz;
endmodule