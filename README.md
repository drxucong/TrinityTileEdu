# Trinity Tile Educational Edition  
**Adaptive Reconfigurable Computing Tile — Educational RTL Implementation**

---

## 📘 Overview

**Trinity Tile Educational Edition** is an instructional RTL implementation derived from the patented architecture:

> *“Trinity Tile: A Scalable and Reconfigurable Computing Framework for Adaptive Edge Intelligence”*  
> © 2025 **Cong Xu**, Land O’ Lakes, Florida, United States.

This repository demonstrates the key concepts of **adaptive edge computing** and **runtime reconfiguration** through a synthesizable Verilog model.  
It showcases how a single processing tile can dynamically reorganize internal resources to emulate **CPU-max**, **GPU-max**, and **MEM-max** operational modes under a unified control interface.

The design is intended **exclusively for personal study and educational research**, providing a legal, simplified platform for teaching and experimentation with reconfigurable architectures.

---

## 🧠 Core Concepts

Trinity Tile represents a next-generation **adaptive compute cell**.  
Instead of static CPU/GPU allocation, it merges multiple dataflow topologies into one logic tile that can reconfigure itself at runtime:

| Mode | Description | Typical Function |
|------|--------------|------------------|
| **CPU-max** | Scalar datapath configuration | Control-intensive workloads |
| **GPU-max** | Parallel arithmetic datapath | Vector and AI workloads |
| **MEM-max** | Local memory and buffer emphasis | Data movement, caching, buffering |

Each mode is activated by a broadcast control bus and changes how compute, memory, and routing resources interconnect internally.

---

## 🧩 Architecture

The educational implementation is composed of four functional blocks integrated in a single 2×2 tile layout:

| Block | Function |
|--------|-----------|
| **Mode Control (FSM)** | Manages operational mode and broadcast control signals |
| **Compute Core** | Implements adaptive arithmetic pipeline (CPU/GPU/MEM behavior) |
| **Local Memory Buffer** | Provides distributed storage and data feedback path |
| **Router / NoC Stub** | Demonstrates inter-tile scalability and communication concept |

All modules operate under a unified clock domain (`sys_clk`) and an active-low reset (`sys_rst_n`).

---

## ⚙️ Unified I/O Interface (UII)

| Signal | Width | Direction | Description |
|---------|--------|------------|-------------|
| `uii_in[7:0]` | 8 | Input | General-purpose command / operand input bus |
| `uii_out[7:0]` | 8 | Output | General-purpose result / status output bus |
| `uii_link_in[7:0]` | 8 | Input | External broadcast / synchronization input |
| `uii_link_out[7:0]` | 8 | Output | Internal broadcast frame from mode controller |
| `uii_link_oe[7:0]` | 8 | Output | Drive enable (active only for controller) |
| `sys_clk` | 1 | Input | System clock |
| `sys_rst_n` | 1 | Input | Asynchronous active-low reset |

### Broadcast Frame Format

| Bit | Name | Description |
|-----|------|-------------|
| [7] | `valid` | Broadcast frame valid flag |
| [6] | `reserved` | Reserved for future use |
| [5:4] | `group_id` | Multi-tile grouping ID (default 00) |
| [3] | `cfg` | Configuration command (future use) |
| [2] | `exec` | Single-cycle execution pulse |
| [1:0] | `mode_sel` | Mode select: 00=CPU, 01=GPU, 10=MEM |

---

## 🧮 Design Composition

```
src/
 ├── trinity_tile_edu.v        → Top-level integration (single 2×2 tile)
 ├── trinity_mode_ctrl.v       → FSM-based mode & exec broadcaster
 ├── trinity_core.v            → Adaptive compute datapath
 ├── trinity_mem.v             → Local memory buffer
 └── trinity_router.v          → Router / status stub
```

---

## 🔬 Example Operation

1. **Set Mode**  
   ```verilog
   uii_in[7:6] = 2'b01; // SET_MODE
   uii_in[1:0] = 2'b01; // Select GPU-max
   ```
   → Internal broadcast updates `mode_sel = 01`.

2. **Execute Operation**  
   ```verilog
   uii_in[7:6] = 2'b10; // EXEC command
   uii_in[7:0] = operand
   ```
   → Core performs mode-specific computation.

3. **Read Output**  
   ```verilog
   uii_out[7:0] // Result (accumulator or status)
   ```

---

## 🧾 Licensing and Intellectual Property Notice

This repository is an **educational derivative** of the patented invention:  
**“Trinity Tile: A Scalable and Reconfigurable Computing Framework for Adaptive Edge Intelligence”**, filed **Nov 8 2025**, Inventor: **Cong Xu**.

### ✅ Permitted
- Personal, academic, and non-commercial educational use  
- Integration in accredited laboratory courses or teaching materials  
- Non-commercial research referencing this work

### 🚫 Prohibited
- Commercial product integration or monetization  
- Redistribution, sublicensing, or derivative publication  
- Modification or repackaging for secondary release  
- Any use that implies endorsement or association without authorization

### Copyright
© 2025 **Cong Xu** — All Rights Reserved  
All patent rights, architectural design, schematics, diagrams, and code remain the intellectual property of the inventor.

For licensing, partnership, or academic collaboration inquiries:  
📧 **drxucong@gmail.com**

---

## 🧭 Citation

If referenced in academic or research materials, please cite as:

> Cong Xu. *Trinity Tile Educational Edition — Adaptive Edge Computing Tile Model.*  
> 2025. GitHub Repository: https://github.com/drxuc/TrinityTileEdu

---

## 🧰 Tool Compatibility

- Synthesizable with Yosys / OpenLane / commercial ASIC flows  
- FPGA-compatible for education (tested on Xilinx Artix-7 and Lattice ECP5)  
- Clock frequency ≤ 10 MHz recommended for timing closure in open-source PDKs

---

## 📄 Version

**Trinity Tile Educational Edition v1.0**  
- Patent-based educational RTL release  
- 2×2 tile logical footprint  
- Last Updated: November 2025  
- Author: **Cong Xu**

---

© 2025 Cong Xu — All Rights Reserved.  
Use of this repository implies acceptance of the accompanying educational license.
