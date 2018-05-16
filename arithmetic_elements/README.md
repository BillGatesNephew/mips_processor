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


### Bitwise AND
----------
**File Name:** bitwise_and.v

**Module Declaration:**
```verilog
    /**
     * input_a [31:0] - Input  - First input 
     * input_b [31:0] - Input  - Second input
     * out     [31:0] - Output - The value resulting from the AND of every bit in the inputs
     */
    bitwise_and and_unit(input_a, input_b, out);
```

**Description:**

A module that performs the bitwise AND operation, commonly seen as "&" in programming languages, on two different inputs.

**Specifications:**
- Inputs are each **32-bits**

**Dependencies:**
- No dependencies

### Bitwise OR
----------
**File Name:** bitwise_or.v

**Module Declaration:**
```verilog
    /**
     * input_a [31:0] - Input  - First input 
     * input_b [31:0] - Input  - Second input
     * out     [31:0] - Output - The value resulting from the OR of every bit in the inputs
     */
    bitwise_or or_unit(input_a, input_b, out);
```

**Description:**

A module that performs the bitwise OR operation, commonly seen as "|" in programming languages, on two different inputs.

**Specifications:**
- Inputs are each **32-bits**

**Dependencies:**
- No dependencies

