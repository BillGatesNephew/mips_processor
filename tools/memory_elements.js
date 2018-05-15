
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
    const tests = [
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
    tests.forEach((test,ind) => {
        console.log("/* Test " + (ind + 1) + ": " + test.desc + " */");
        console.log(
            dec2bin(test.data_in, 32) + "_" + 
            dec2bin(test.enable,1) + "_" +
            dec2bin(test.data_out, 32)
        );
    });
}

// generateDecoderTV();
// generatePredecoderTV();
generateRegisterTV();