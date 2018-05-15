const register_tests = [
    {
        desc: "Initial state should be 0",
        data_in: 0,
        enable: 0,
        data_out: 0    
    },
    {
        desc: "Set register to 5 with enable disabled",
        data_in: 5,
        enable: 0,
        data_out: 0
    },
    {
        desc: "Set register to 7 with enable enabled",
        data_in: 7,
        enable: 1,
        data_out: 0
    },
    {
        desc:"Set register to 1000 with enable disabled",
        data_in:1000,
        enable:0,
        data_out:7
    },
    {
        desc:"Set register to 4534 with enable enabled",
        data_in:4534,
        enable:1,
        data_out:7
    },
    {
        desc:"Check previous write of 4534",
        data_in:0,
        enable:0,
        data_out:4534
    }
]

const registerFile_tests = [
    {
        desc: "Write 17 to register 3",
        write_enable: 1,
        write_addr: 3,
        a_addr: 1,
        b_addr:7,
        write_data: 17,
        a_expected: 0,
        b_expected: 0   
    },
    {
        desc: "Write 10000 to register 8",
        write_enable: 1,
        write_addr: 8,
        a_addr: 3,
        b_addr: 9,
        write_data: 10000,
        a_expected: 17,
        b_expected: 0,     
    },
    {
        desc: "Read register 8 and 3",
        write_enable: 0,
        write_addr: 8,
        a_addr: 8,
        b_addr: 3,
        write_data: 89,
        a_expected: 10000,
        b_expected: 17,     
    },
]
/**
 * Converts an integer to its binary representation
 * @param {Number} dec - The INTEGER to be converted 
 * @param {Number} binaryWidth - The number of bits used for binary
 */
function dec2bin(dec, binaryWidth){
    let binaryVersion = (dec >>> 0).toString(2);
    while(binaryVersion.length < binaryWidth)
        binaryVersion = "0" + binaryVersion;
    return binaryVersion;
}

/**
 * Generates the test vector file for the decoder
 */
function generateDecoderTV() {
    console.log("// Format: {input address}_{encoded output}");
    let input, encoding;
    for(input = 0; input < 32; input++) {
        encoding = dec2bin(Math.pow(2, input), 32);
        console.log(
            dec2bin(input, 5) + "_" + encoding
        );
    }
}

/**
 * Generates the test vector file for the predecoder
 */
function generatePredecoderTV() {
    console.log("// Format: {input address}_{encoded output}");
    let input, encoding;
    for(input = 0; input < 16; input++) {
        encoding = dec2bin(Math.pow(2, input), 16);
        console.log(
            dec2bin(input, 4) + "_" + encoding
        );
    }
}

/**
 * Generates the test vector file for the register
 */
function generateRegisterTV() {
    register_tests.forEach((test,ind) => {
        console.log("/* Test " + (ind + 1) + ": " + test.desc + " */");
        console.log(
            dec2bin(test.data_in, 32) + "_" + 
            dec2bin(test.enable,1) + "_" +
            dec2bin(test.data_out, 32)
        );
    });
}

/**
 * Generates the test vector file for the register_file
 */
function generateRegisterFileTV() {
    registerFile_tests.forEach((test,ind) => {
        console.log("/* Test " + (ind + 1) + ": " + test.desc + " */");
        console.log(
            dec2bin(test.write_enable, 1) + "_" + 
            dec2bin(test.write_addr,5) + "_" +
            dec2bin(test.a_addr, 5) + "_" +
            dec2bin(test.b_addr,5) + "_" + 
            dec2bin(test.write_data, 32) + "_" +
            dec2bin(test.a_expected, 32) + "_" +
            dec2bin(test.b_expected, 32)
        );
    })
}

// generateDecoderTV();
// generatePredecoderTV();
// generateRegisterTV();
generateRegisterFileTV();