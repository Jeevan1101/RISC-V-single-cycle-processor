`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:  Midatana Jeevan Kumar
// Create Date: 18.07.2025 06:22:39
// Module Name: Instruction_memory
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_memory(
input wire [9:0] address,
input wire reset,
output wire [31:0] instruction
    );
    
    reg [31:0] instruction_mem [1023:0] ;
    
    initial 
           $readmemh("instruction_mem.mem",instruction_mem) ;
    
    assign instruction = (reset==1'b1) ? 32'h00000000 : instruction_mem[address] ;
    
endmodule
