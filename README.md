# FIFO-_PROJECT
FIFO (First In, First Out) is an inventory management and accounting method where the oldest stock (first-in) is assumed to be sold or used first.

This is a solid Verilog implementation of a Synchronous FIFO. Since you're putting this on GitHub, you want a README that explains the architecture, the interface, and how to run the simulation.
Here is a clean, professional, and "humanized" README template for your repository.
Synchronous FIFO Buffer (Verilog)
A lightweight, parameterised Synchronous FIFO (First-In, First-Out) memory buffer designed in Verilog. This module is ideal for data buffering between logic blocks operating on the same clock domain.
🚀 Overview
This FIFO uses a circular pointer logic to manage data flow. It includes a built-in depth counter to accurately track the status of the buffer, providing real-time Full and Empty flags to prevent data overflow or underflow.
Key Features:
Parameterised Design: Easily adjust Data_width and Fifo_depth to fit your specific needs.
Synchronous Operation: All operations (Read/Write/Reset) are synchronized to the rising edge of the clock.
Status Flags: Immediate feedback via Full and Empty signals.
Testbench Included: A complete simulation environment to verify the FIFO logic.
🛠 Hardware Architecture
The design consists of three main logic blocks:
Write Logic (Push): Increments the write pointer and stores data into memory if Wr_en is high and the buffer isn't full.
Read Logic (Pop): Increments the read pointer and fetches data if Rd_en is high and the buffer isn't empty.
Status Logic: Tracks the Depth_cnt to determine if the buffer is at capacity or totally empty.
Ports
Signal	Type	Description
clk	Input	System Clock
reset	Input	Active-high synchronous reset
Data_in	Input	Data to be written
Wr_en	Input	Write Enable
Rd_en	Input	Read Enable
Data_out	Output	Data being read
Full	Output	High when FIFO is at max capacity
Empty	Output	High when FIFO has no data
💻 Simulation & Testing
The repository includes fifo_tb.v, which simulates a real-world scenario:
Reset Phase: Initializes all pointers to zero.
Write Phase: Fills the FIFO to its maximum depth (4 entries in the TB) to verify the Full flag.
Read Phase: Pulls all data out to verify the Empty flag and ensures the data output matches the input sequence (First-In, First-Out).
How to run:
Add FIFO.v and fifo_tb.v to your preferred simulator (Vivado, ModelSim, or Icarus Verilog).
Run the simulation for at least 200ns.
Observe the $monitor output in the console to see the data flow in real-time.
📝 Example Monitor Output
text
Time=25 | Wr=1 Rd=0 | In=A1 | Out=xx | Full=0 Empty=0
Time=35 | Wr=1 Rd=0 | In=B2 | Out=xx | Full=0 Empty=0
...
Time=65 | Wr=0 Rd=0 | In=D4 | Out=xx | Full=1 Empty=0
Time=75 | Wr=0 Rd=1 | In=D4 | Out=A1 | Full=0 Empty=0
Use code with caution.
🤝 Contributing
Feel free to fork this repo, report bugs, or suggest improvements (like adding an Asynchronous version with Gray coding for different clock domains!).
Author: Chethan Aithal
Date: February 2026
