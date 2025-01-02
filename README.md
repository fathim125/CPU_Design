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

### Datapath
The CPU consists of a carefully designed datapath to handle the instruction execution process. Key components include:
- **Instruction Memory**: Stores instructions for execution.
- **Data Memory**: Stores data values used by the CPU.
- **General-Purpose Registers**: A register file for temporary storage.
- **ALU**: Performs arithmetic and logical operations.
- **Controller**: Decodes instructions and generates control signals.

### Instruction Set
The instruction encoding follows the ARM LRM specification:
- **Data Processing Instructions**: Encoded with register and immediate value support.
- **Memory Instructions**: Support for pre-indexed and post-indexed addressing modes.
- **Branch Instructions**: Conditional and unconditional branching.

### Status Registers
The CPU updates the N (negative), Z (zero), C (carry), and V (overflow) flags in the Current Program Status Register (CPSR) based on the instruction outcome, enabling conditional execution.

---

## File Structure
- `datapath.v`: Verilog code for the datapath design.
- `controller.v`: Verilog code for the control unit.
- `alu.v`: Verilog code for the Arithmetic Logic Unit.
- `regfile.v`: Verilog code for the register file.
- `imem.v`: Instruction memory implementation.
- `dmem.v`: Data memory implementation.
- `extender.v`: Sign and zero extender module.
- `top.v`: Top-level Verilog module for integration.
- `design.sv`: Testbench for simulating the CPU functionality.

---

## Simulation
The CPU functionality has been verified using ModelSim. Test cases for different instruction types ensure correctness, including:
- Data processing instructions (e.g., ADD, SUB).
- Memory operations (e.g., LDR, STR).
- Branching instructions (e.g., B).
- Conditional mnemonics (e.g., EQ, NE, GT).

---

## How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/username/CPU-Design.git
   cd CPU-Design

