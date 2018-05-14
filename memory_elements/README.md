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
```

**Description:**

**Specifications:**

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
