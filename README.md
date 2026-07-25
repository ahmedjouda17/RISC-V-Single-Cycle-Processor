<p align="center">
  <img src="Images/RISCV_Datapath.png" width="900">
</p>

<h1 align="center">
🚀 32-bit Single-Cycle RISC-V Processor
</h1>

<p align="center">
Verilog HDL • RV32I • Xilinx Vivado • FPGA
</p>

---

## 📖 Overview

This project presents a complete implementation of a **32-bit Single-Cycle RISC-V Processor** using **Verilog HDL**.

The processor executes each instruction in a single clock cycle and demonstrates the complete datapath and control path of a basic RISC-V CPU. The project was designed in a modular way to simplify understanding, debugging, simulation, and future extensions.

---

## ✨ Features

- 32-bit RISC-V Processor (RV32I)
- Single-Cycle Architecture
- Modular Verilog Design
- Program Counter (PC)
- Register File
- Arithmetic Logic Unit (ALU)
- ALU Control Unit
- Main Control Unit
- Immediate Generator
- Instruction Memory
- Data Memory
- Branch and Jump Support
- Parameterized Multiplexers
- Complete Top-Level Integration
- Functional Testbench
- Behavioral Simulation using Vivado

---

## 🏗️ Architecture

The processor is composed of the following modules:

```
CPU_TOP
│
├── Program Counter
├── Instruction Memory
├── Control Unit
├── Register File
├── Immediate Generator
├── ALU Control
├── ALU
├── Data Memory
└── Multiplexers
```

---

## 📂 Project Structure

```
.
├── CPU_TOP.v
├── ProgramCounter.v
├── InstructionMemory.v
├── RegisterFile.v
├── ControlUnit.v
├── ALUControl.v
├── ALU.v
├── ImmGen.v
├── DataMemory.v
├── Mux.v
├── CPU_TOP_tb.v
├── mem.dat
└── README.md
```

---

## 🧪 Simulation

The design was verified using **Xilinx Vivado Simulator (XSIM)**.

Simulation validates:

- Program Counter operation
- Instruction Fetch
- Instruction Decode
- ALU Operations
- Register Write Back
- Memory Read / Write
- Branch Execution
- Jump Execution

---

## 📸 Simulation Results

### Processor Waveform

<p align="center">
<img src="Screenshots/waveform.png" width="1000">
</p>

### Register File Verification

<p align="center">
<img src="Screenshots/register_file.png" width="1000">
</p>

### Data Memory Verification

<p align="center">
<img src="Screenshots/data_memory.png" width="1000">
</p>

### Program Counter Verification

<p align="center">
<img src="Screenshots/program_counter.png" width="1000">
</p>

---

## 🛠️ Tools

- Verilog HDL
- Xilinx Vivado 2018.2
- Vivado Simulator (XSIM)

---

## 🎯 Learning Outcomes

This project demonstrates practical knowledge of:

- Computer Architecture
- Digital Logic Design
- RTL Design
- Processor Datapath Design
- Processor Control Design
- FPGA Design Flow
- Hardware Verification
- Verilog HDL

---

## 🚀 Future Improvements

- Five-Stage Pipeline Processor
- Hazard Detection Unit
- Forwarding Unit
- Pipeline Registers
- Instruction Cache
- Data Cache
- UART Interface
- FPGA Implementation
- Performance Optimization

---

## 👨‍💻 Author

**Ahmed Goda Ali Sharawy**

Electronics and Communications Engineering

Digital IC Design Track

---

## ⭐ If you found this project useful, consider giving it a Star!
