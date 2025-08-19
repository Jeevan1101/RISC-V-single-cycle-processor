`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Midatana Jeevan Kumar
// Create Date: 17.07.2025 20:37:31
// Module Name: Immediate_value
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module Immediate_value(
input wire [31:0] Instruction,
input wire [1:0] immsrc,
output reg [31:0] imm_val 
    );
    always @(*) begin
    case (immsrc) 
         2'b00 : imm_val = { {20{Instruction[31]}},Instruction[31:20] } ;
         2'b01 : imm_val = { {20{Instruction[31]}}, Instruction[31:25], Instruction[11:7] } ;
         2'b10 : imm_val = { Instruction[31:12], {12{1'b0}} } ;
         2'b11 : imm_val = { {13{Instruction[31]}} , Instruction[18:12], Instruction[19], Instruction[30:20] } ;
         default: imm_val = {32{1'b0}} ;
    endcase
    end
endmodule
