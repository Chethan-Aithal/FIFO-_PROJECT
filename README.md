# FIFO-_PROJECT
FIFO (First In, First Out) is an inventory management and accounting method where the oldest stock (first-in) is assumed to be sold or used first.
# 🚀 Synchronous FIFO Buffer

A lightweight, parameterised **Synchronous FIFO** memory controller written in Verilog.

---

### 📥 Key Features
* **Parameterised:** Easily adjust `Data_width` and `Fifo_depth`.
* **Status Flags:** Real-time `Full` and `Empty` indicators.
* **Synchronous:** All operations tied to a single clock edge.
* **Clean Logic:** Simple pointer-based circular buffer.

---

### 🔌 Interface Signals


| Signal | Dir | Description |
| :--- | :---: | :--- |
| **clk** | In | System Clock |
| **reset** | In | Active-high Reset |
| **Wr_en** | In | Write Enable (Push) |
| **Rd_en** | In | Read Enable (Pop) |
| **Data_in** | In | Data to store |
| **Data_out** | Out | Data to retrieve |
| **Full** | Out | Logic '1' when buffer is maxed |
| **Empty** | Out | Logic '1' when buffer is void |

---

### 🛠 Architecture at a Glance
* **Memory:** Uses a Verilog register array (`memory`).
* **Pointers:** Dual pointers (`Wr_ptr`, `Rd_ptr`) track data positions.
* **Counter:** A `Depth_cnt` manages the status flags to prevent overflow/underflow.

---

### 🧪 Verifying with the Testbench
The included `fifo_tb.v` performs a full cycle test:
1. **Reset:** Clears all pointers.
2. **Fill:** Writes data until the `Full` flag triggers.
3. **Empty:** Reads data back until the `Empty` flag triggers.
4. **Validate:** Ensures the first value written is the first value read.

---

### 🤝 Contributing
Feel free to fork this repo, report bugs, or suggest improvements (like adding an Asynchronous version with Gray coding for different clock domains!).

**Author:** Chethan Aithal  
**Date:** February 2026
