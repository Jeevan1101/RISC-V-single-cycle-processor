`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Midatana Jeevan kumar
// Create Date: 18.07.2025 06:21:43
// Module Name: Data_memory
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module Data_memory(
input wire clock,
input wire Memwrite,
input wire [31:0] address,
input wire [31:0] write_mem,
output wire [31:0] read_mem
    );
    
    reg [31:0] data_mem [1023:0] ;
    
    assign read_mem = data_mem[address] ;
    always @ (posedge clock) begin
          
          if(Memwrite) begin
                   data_mem[address] <= write_mem ;
          end
          
    end
    
endmodule
