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

dec2bin()