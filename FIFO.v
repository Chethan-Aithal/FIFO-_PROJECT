`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2026 22:15:05
// Design Name: 
// Module Name: FIFO
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

module FIFO#(parameter Data_width=8,
parameter Fifo_depth=32)
(Data_out,Full,Empty,Data_in,Wr_en,Rd_en,clk,reset);
input[Data_width-1:0]Data_in;
input Wr_en,Rd_en,clk,reset;
output reg[Data_width-1:0]Data_out;
output  Full;
output Empty;
reg[Data_width-1:0]memory[Fifo_depth-1:0];
reg[Fifo_depth-1:0]Rd_ptr,Wr_ptr,Depth_cnt;
//PUSH OPERATION
always@(posedge clk)
begin
if(reset)
begin
Wr_ptr<=32'h0;
end 
else
begin
if(Wr_en&&!Full)
 begin
  memory[Wr_ptr]<=Data_in;
  Wr_ptr<=Wr_ptr+1;
 end
end
end
//POP OPERation
always@(posedge clk)
begin
if(reset)
begin
Rd_ptr<=32'h0;
end
else
begin
if(Rd_en&&!Empty)
begin
Data_out<=memory[Rd_ptr];
Rd_ptr<=Rd_ptr+1;
end
end
end
//Depth Count
always@(posedge clk)
begin
if(reset)
begin
Depth_cnt<=32'h0;
end
else
begin
if(Wr_en&&!Full)
Depth_cnt<=Depth_cnt+1;
else if(Rd_en&&!Empty)
Depth_cnt<=Depth_cnt-1;
end
end
assign Empty=(Depth_cnt=='h0)?1:0;
assign Full=(Depth_cnt==Fifo_depth)?1:0;
endmodule
