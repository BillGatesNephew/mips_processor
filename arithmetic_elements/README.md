Memory Elements for Processor
===============================
## Folder Description
This folder contains the modules used for arithmetic in various places throughout the processor. The module's are detailed more in depth below.

### Modules Included:
- **alu**                      - ALU
- **bitwise_and**              - Bitwise AND Operation  
- **bitwise_or**               - Bitwise OR Operation  
- **arithmetic_right_shifter** - Arithmetic Right Bit Shifter  
- **logical_left_shifter**     - Logical Left Bit Shifter  
- **cl_cell**                  - Carry Lookahead Adder Cell 
- **cl_adder**                 - Carry Lookahead Complete Adder   

### Arithmetic Right Shifter
----------
**File Name:** arithmetic_right_shifter.v

**Module Declaration:**
```verilog
module arithmetic_right_shifter(
    /**
     * in [31:0] - Input - Value to be shifted right
     * shiftamt [4:0] - Input - Amount to shift by
     * out [31:0] - Output - The original value shifted
     */
    arithmetic_right_shifter shifter(in, shiftamt, out);
```

**Description:**

A simple arithmetic right shifter for 32-bit inputs.

**Specifications:**
- Input must be a **32-bit** number
- Can shift a maximum of **31** times

**Dependencies:**
- No dependencies
