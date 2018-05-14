Memory Elements for Processor
===============================
## Folder Description
This folder contains the modules used to store memory in various places throughout the processor. The module's are detailed more in depth below.

### Modules Included:
- **dflipflop**     - D Flip-Flop
- **register**      - Register
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


### Register File
----------
**File Name:**  regfile.v

**Module Declaration:**
```verilog
    /**
      *
      *
      */
    regfile dff();
```

**Description:**

**Specifications:**

**Dependencies:**



### Component Name
----------
**File Name:** 

**Module Declaration:**
```verilog
```

**Description:**

**Specifications:**

**Dependencies:**
