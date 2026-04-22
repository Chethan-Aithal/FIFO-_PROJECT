`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2026 22:18:06
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module fifo_tb;

parameter DATA_WIDTH = 8;
parameter FIFO_DEPTH = 4;   // Small depth to easily see Full

reg clk;
reg reset;
reg wr_en;
reg rd_en;
reg [DATA_WIDTH-1:0] Data_in;

wire [DATA_WIDTH-1:0] Data_out;
wire Full;
wire Empty;

// Instantiate FIFO
FIFO #(
    .Data_width(DATA_WIDTH),
    .Fifo_depth(FIFO_DEPTH)
) DUT (
    .Data_out(Data_out),
    .Full(Full),
    .Empty(Empty),
    .Data_in(Data_in),
    .Wr_en(wr_en),
    .Rd_en(rd_en),
    .clk(clk),
    .reset(reset)
);

////////////////////////////////////////
// Clock Generation (10ns period)
////////////////////////////////////////
always #5 clk = ~clk;

////////////////////////////////////////
// Test Procedure
////////////////////////////////////////
initial begin
    // Initialize
    clk = 0;
    reset = 1;
    wr_en = 0;
    rd_en = 0;
    Data_in = 0;

    // Apply Reset
    #20;
    reset = 0;

    //////////////////////////////////////////////////
    // WRITE 4 VALUES (FIFO_DEPTH = 4)
    //////////////////////////////////////////////////
    @(posedge clk);
    wr_en = 1; Data_in = 8'hA1;

    @(posedge clk);
    Data_in = 8'hB2;

    @(posedge clk);
    Data_in = 8'hC3;

    @(posedge clk);
    Data_in = 8'hD4;   // FIFO should become FULL here

    @(posedge clk);
    wr_en = 0;

    //////////////////////////////////////////////////
    // READ 4 VALUES
    //////////////////////////////////////////////////
    @(posedge clk);
    rd_en = 1;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);   // FIFO should become EMPTY here

    @(posedge clk);
    rd_en = 0;

    #20;
    $finish;
end

////////////////////////////////////////
// Monitor
////////////////////////////////////////
initial begin
    $monitor("Time=%0t | Wr=%b Rd=%b | In=%h | Out=%h | Full=%b Empty=%b",
              $time, wr_en, rd_en, Data_in, Data_out, Full, Empty);
end

endmodule
