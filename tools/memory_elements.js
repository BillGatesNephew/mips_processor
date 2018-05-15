
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

// generateDecoderTV();
generatePredecoderTV();
