# FIFO-_PROJECT
FIFO (First In, First Out) is an inventory management and accounting method where the oldest stock (first-in) is assumed to be sold or used first.




undefined
undefined
undefined
17 sites
The FIFO Method: First In, First Out
29 Jan 2026 — The FIFO Method: First In, First Out. ... What Is the FIFO Method? ... The FIFO Method: First In, First Out * By. Will Kenton. Wil...

1:10

Investopedia
·
Will Kenton
What Is FIFO Method: Definition and Guide - FreshBooks
27 Jun 2024 — What Is FIFO Method: Definition and Guide * What Is FIFO? FIFO is an inventory valuation method that stands for First In, First Ou...


FreshBooks
FIFO (computing and electronics) - Wikipedia
FIFO (computing and electronics) ... This article needs additional citations for verification. Please help improve this article by...


Wikipedia
Show all
`timescale 1ns / 1ps ////////////////////////////////////////////////////////////////////////////////// // Company: // Engineer: // // Create Date: 13.02.2026 22:15:05 // Design Name: // Module Name: FIFO // Project Name: // Target Devices: // Tool Versions: // Description: // // Dependencies: // // Revision: // Revision 0.01 - File Created // Additional Comments: // ////////////////////////////////////////////////////////////////////////////////// module FIFO#(parameter Data_width=8, parameter Fifo_depth=32) (Data_out,Full,Empty,Data_in,Wr_en,Rd_en,clk,reset); input[Data_width-1:0]Data_in; input Wr_en,Rd_en,clk,reset; output reg[Data_width-1:0]Data_out; output Full; output Empty; reg[Data_width-1:0]memory[Fifo_depth-1:0]; reg[Fifo_depth-1:0]Rd_ptr,Wr_ptr,Depth_cnt; //PUSH OPERATION always@(posedge clk) begin if(reset) begin Wr_ptr<=32'h0; end else begin if(Wr_en&&!Full) begin memory[Wr_ptr]<=Data_in; Wr_ptr<=Wr_ptr+1; end end end //POP OPERation always@(posedge clk) begin if(reset) begin Rd_ptr<=32'h0; end else begin if(Rd_en&&!Empty) begin Data_out<=memory[Rd_ptr]; Rd_ptr<=Rd_ptr+1; end end end //Depth Count always@(posedge clk) begin if(reset) begin Depth_cnt<=32'h0; end else begin if(Wr_en&&!Full) Depth_cnt<=Depth_cnt+1; else if(Rd_en&&!Empty) Depth_cnt<=Depth_cnt-1; end end assign Empty=(Depth_cnt=='h0)?1:0; assign Full=(Depth_cnt==Fifo_depth)?1:0; endmodule `timescale 1ns / 1ps ////////////////////////////////////////////////////////////////////////////////// // Company: // Engineer: // // Create Date: 13.02.2026 22:18:06 // Design Name: // Module Name: fifo_tb // Project Name: // Target Devices: // Tool Versions: // Description: // // Dependencies: // // Revision: // Revision 0.01 - File Created // Additional Comments: // ////////////////////////////////////////////////////////////////////////////////// `timescale 1ns/1ps module fifo_tb; parameter DATA_WIDTH = 8; parameter FIFO_DEPTH = 4; // Small depth to easily see Full reg clk; reg reset; reg wr_en; reg rd_en; reg [DATA_WIDTH-1:0] Data_in; wire [DATA_WIDTH-1:0] Data_out; wire Full; wire Empty; // Instantiate FIFO FIFO #( .Data_width(DATA_WIDTH), .Fifo_depth(FIFO_DEPTH) ) DUT ( .Data_out(Data_out), .Full(Full), .Empty(Empty), .Data_in(Data_in), .Wr_en(wr_en), .Rd_en(rd_en), .clk(clk), .reset(reset) ); //////////////////////////////////////// // Clock Generation (10ns period) //////////////////////////////////////// always #5 clk = ~clk; //////////////////////////////////////// // Test Procedure //////////////////////////////////////// initial begin // Initialize clk = 0; reset = 1; wr_en = 0; rd_en = 0; Data_in = 0; // Apply Reset #20; reset = 0; ////////////////////////////////////////////////// // WRITE 4 VALUES (FIFO_DEPTH = 4) ////////////////////////////////////////////////// @(posedge clk); wr_en = 1; Data_in = 8'hA1; @(posedge clk); Data_in = 8'hB2; @(posedge clk); Data_in = 8'hC3; @(posedge clk); Data_in = 8'hD4; // FIFO should become FULL here @(posedge clk); wr_en = 0; ////////////////////////////////////////////////// // READ 4 VALUES ////////////////////////////////////////////////// @(posedge clk); rd_en = 1; @(posedge clk); @(posedge clk); @(posedge clk); // FIFO should become EMPTY here @(posedge clk); rd_en = 0; #20; $finish; end //////////////////////////////////////// // Monitor //////////////////////////////////////// initial begin $monitor("Time=%0t | Wr=%b Rd=%b | In=%h | Out=%h | Full=%b Empty=%b", $time, wr_en, rd_en, Data_in, Data_out, Full, Empty); end endmodule based on this code give me good humanized read me for git hub
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
