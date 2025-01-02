# CPU_Design

## Overview
This project implements a Reduced Instruction Set Computer (RISC)-based CPU using Verilog HDL. The CPU is designed to execute a basic set of instructions categorized into Data Processing, Memory Operations, and Branching. It supports conditional execution as defined by the ARM Architecture Reference Manual (ARM LRM).

---

## Features
The CPU supports the following operations:

### Data Processing
1. **ADD** - Add two registers or a register and an immediate value.
2. **SUB** - Subtract one register or an immediate value from another.
3. **AND** - Perform a bitwise AND operation.
4. **ORR** - Perform a bitwise OR operation.

### Memory Operations
1. **STR** - Store data from a register into memory.
2. **LDR** - Load data from memory into a register.

### Branching
1. **B** - Branch to a specified address, supporting conditional execution.

### Conditional Mnemonics
The CPU handles all conditional mnemonics specified in the ARM LRM, including but not limited to:
- **EQ**: Equal
- **NE**: Not Equal
- **GT**: Greater Than
- **LT**: Less Than
- **GE**: Greater Than or Equal
- **LE**: Less Than or Equal
- **AL**: Always (unconditional execution)

---

## Architecture
  <img src="Images/Overview.png" alt="Overview" width="600">
  
### Datapath
<img src="Images/Datapath.png" alt="Datapath Diagram" width="800">

#### Branch Instruction
  <img src="Images/Datapath_Branch.png" alt="Datapath for Branch Instruction" width="600">

#### Data Processing with Immediate Values
  <img src="Images/Datapath_Dataprocessing_Imm.png" alt="Datapath for Data Processing(Immediate)" width="600">

#### Data Processing
  <img src="Images/Datapath_Dataprocessing.png" alt="Datapath for Data Processing" width="600">

#### Load Instruction (LDR)
  <img src="Images/Datapath_Memory_LDR.png" alt="Datapath for LDR Instruction" width="600">

#### Store Instruction (STR)
  <img src="Images/Datapath_Memory_STR.png" alt="str path" width="600">

The CPU consists of a carefully designed datapath to handle the instruction execution process. Key components include:
- **Instruction Memory**: Stores instructions for execution.
- **Data Memory**: Stores data values used by the CPU.
- **General-Purpose Registers**: A register file for temporary storage.
- **ALU**: Performs arithmetic and logical operations.
- **Controller**: Decodes instructions and generates control signals.

### Instruction Set
The instruction encoding follows the ARM LRM specification:
- **Data Processing Instructions**: Encoded with register and immediate value support.
  <img src="Images/Instruction_Dataprocessing.png" alt="Data Processing Instructions" width="600">

- **Memory Instructions**: Support for pre-indexed and post-indexed addressing modes.
  <img src="Images/Instruction_Memory.png" alt="Memory Instructions" width="600">

- **Branch Instructions**: Conditional and unconditional branching.
  <img src="Images/Instruction_Branch.png" alt="Branch Instructions" width="600">
  
  <img src="Images/Instruction_Branch_2.png" alt="Branch Instructions" width="180">

---

### Control
The control logic for the CPU has been detailed to show how signals are routed to different components. Below is an image of the controller logic
  <img src="Images/Controller_1.png" alt="Controller Overview" width="500">


#### Control Signals to Datapath
  <img src="Images/Controller_2.png" alt="Controller Datapath" width="700">


#### ALU Control Logic
  <img src="Images/Controller_3.png" alt="Controller ALU" width="500">

---

## Simulation
To verify the functionality of the CPU, follow these steps:

1. **Open a Verilog Simulation Tool:**
   Use ModelSim or any other compatible Verilog simulation tool.

2. **Compile Verilog Files:**
   Compile all the Verilog files provided in the repository.

3. **Load the Testbench:**
   Load the `design.sv` testbench into the simulator.

4. **Run the Simulation:**
   Simulate the design and inspect the waveform or log output to validate the CPU's behavior.

---

## Future Enhancements
Here are some ideas for extending the capabilities of the CPU:

1. **Pipeline Implementation:**
   Introduce pipelining to increase the CPU's throughput by overlapping instruction execution.

2. **Interrupt Handling:**
   Add support for interrupts to handle asynchronous events.

3. **Floating-Point Operations:**
   Extend the ALU to perform floating-point arithmetic for more complex computations.

