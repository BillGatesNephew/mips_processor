Memory Elements for Processor
===============================
## Folder Description
This folder contains the modules used to store memory in various places throughout the processor. The module's are detailed more in depth below.

### Modules Included:
- **dflipflop**     - D Flip-Flop
- **register**      - Register
- **predecoder**    - 4 to 16 Predecoder
- **decoder**       - 5 to 32 Decoder
- **register_file** - Register File

### D Flip-Flop
----------
**File Name:**  dflipflop.v

**Module Declaration:**
```verilog
    /**
     * Port Declarations:
     * d   - Input  - Data to store in the flip-flop
     * clk - Input  - Clock signal used for the flip-flop
     * en  - Input  - Enable signal for the flip-flop to store data
     * rst - Input  - Reset signal for the flip-flop  
     * q   - Output - Data stored in the flip-flop
     */
    dflipflop dff(d, clk, en, rst, q);
```

**Description:**

Basic D Flip-Flop module that stores a single bit of information within it. The flip-flop is triggered on the rising edge of the clock, and possesses both an asynchronous reset signal as well as an enable signal.  

**Specifications:**
- Stores **1 Bit**
- Data is latched on the **positive edge** of clock signal (clk)
- Enable signal (en) is **active high**
- Reset signal (rst) is **asynchronous** and **active high**

**Dependencies:**
- No dependencies

### Register
----------
**File Name:** register.v

**Module Declaration:**
```verilog
    /**
     * Parameters:
     * REGISTER_SIZE - 32 by Default - Number of bits stored by the register 
     * Port Declarations:
     * data_in  [REGISTER_SIZE-1:0] - Input - Data to store in the register
     * clock  - Input - Clock signal used for the register
     * enable - Input - Enable signal for the register to store data
     * reset  - Input - Reset signal for the register  
     * data_out [REGISTER_SIZE-1:0] - Output - Data stored in the register
     */
    register register1(data_in, clock, enable, reset, data_out);
```

**Description:**
Basic Register module that stores a specified number of bits of information within it. The register is triggered on the rising edge of the clock, and possesses both an asynchronous reset signal as well as an enable signal.  

**Specifications:**
- Stores **REGISTER_SIZE Bit(s)**
- Data is latched on the **positive edge** of clock signal (clock)
- Enable signal (enable) is **active high**
- Reset signal (reset) is **asynchronous** and **active high**

**Dependencies:**
- dflipflop.v

### 4 to 16 Predecoder
----------
**File Name:** predecoder.v 

**Module Declaration:**
```verilog
    /**
     * Port Declarations:
     * input_address  [3:0]  - Input  - Input to predecode
     * decoded_output [15:0] - Output - Decoded output 
     */
    predecoder predecoder1(input_address, decoded_output);
```

**Description:**

A predecoder used to speed up the decoding process in the decoder. The predecoder essentially decodes a 4-bit input that corresponds to a grouping of 4 consectutive inputs for the decoder. In example, an 8-bit address decoder would use a predecoder for the following two input groups: input_address[7:4] and input_address[3:0]. Predecoding allows for fast elimination of potential outputs in the decoder while at the same time using logic gates with small fanouts. Also, predecoding is optimized in actual hardware when an input group size of 4 wires is used, and so the predecoder is **not parameterized**. 

**Specifications:**
- Fixed at a **4-bit input**
- Produces a **one-hot** encoding

**Dependencies:**
- No dependencies

### 5 to 32 Decoder
----------
**File Name:** decoder.v

**Module Declaration:**
```verilog
    /**
     * Port Declarations:
     * input_address  [3:0]  - Input  - Input to decode
     * decoded_output [31:0] - Output - Decoded output 
     */
    decoder decoder1(input_address, decoded_output);
```

**Description:**

A simple decoder that decodes a 5-bit address into a 32-bit, **one-hot** encoding.

**Specifications:**
    - Fixed at a **5-bit input**
    - Produces a **one-hot** encoding

**Dependencies:**
- predecoder.v

### Register File
----------
**File Name:**  register_file.v

**Module Declaration:**
```verilog
    /**
     * Parameter Declarations:
     *  ADDRESS_WIDTH - Number of bits to use for selecting a register
     *  REG_SIZE      - The size of the bits stored by each register
     * Port Declarations:
     *  clock                    - Input - Clock signal used for the register file
     *  reset                    - Input - Reset signal for the register file
     *  write_en                 - Input - Specifies whether or not to write to a register
     *  write_reg_addr    [4:0]  - Input - Address of the register to write to
     *  read_reg_a_addr   [4:0]  - Input - Address of the register A to read from
     *  read_reg_b_addr   [4:0]  - Input - Address of the register B to read from
     *  write_reg_data_in [31:0] - Input - Data to write to the write_reg_addr register
     *  reg_a_data_out    [31:0] - Output - Data read from read_reg_a_addr register
     *  reg_b_data_out    [31:0] - Output - Data read from read_reg_b_addr register
     */
    register_file regfile(
        clock, reset, write_en, 
        write_reg_addr, read_reg_a_addr, read_reg_b_addr,
        write_reg_data_in, reg_a_data_out, reg_b_data_out     
    );
```

**Description:**

A register file containing 32 different registers. Two different registers can be read from at any point in time; not dependent on clock. A register can also be written to within the register file, and it is recommended that this operation is performed on a **falling edge** of the clock cycle. Also, the register file has the $0 register hardwired to be 0 as is the MIPS standard.

**Specifications:**
- Write on **negative edge** of clock signal
- Reset is performed **asynchronously** and resets **every register**
- The register at address 0 will **always** have a value of 0
- Reading **and** writing to the same register at the same time will produce undefined behavior 

**Dependencies:**
- dflipflop.v
- register.v
- predecoder.v
- decoder.v