`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: JEEVAN KUMAR MIDATANA
// Create Date: 17.07.2025 17:04:06
// Design Name:  RISC-V
// Module Name: ALU
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
input wire  [31:0] op1,op2 ,
input wire [3:0] ALU_control,
output wire zero,
output reg [31:0] ALU_result
 );
 
    parameter [3:0] ADD = 4'b0010;
    parameter [3:0] SUB = 4'b0110;
    parameter [3:0] AND = 4'b0000;
    parameter [3:0] OR  = 4'b0001;
    parameter [3:0] SLL = 4'b1000;
    parameter [3:0] GTE = 4'b0111;
    parameter [3:0] LTE = 4'b1001;

    always @ (*) begin
        case (ALU_control)
             ADD: ALU_result = op1 + op2 ;
             SUB: ALU_result = op1 - op2 ;
             AND: ALU_result = op1 & op2 ;
             OR: ALU_result = op1 | op2 ;
             SLL: ALU_result = op1 << op2[5:0] ;
             GTE: ALU_result = (op1>=op2) ? 32'b0 : 32'b1 ;
             LTE: ALU_result = (op1<op2) ?  32'b0 : 32'b1  ;
             default: ALU_result = op1 & op2 ;
        endcase 
    end
    
    assign zero = (ALU_result==0) ;
    
endmodule
