`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Midatana Jeevan Kumar
// Create Date: 17.07.2025 19:31:34
// Module Name: main_decoder
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module main_decoder_ctrl(
input  wire [6:0] opcode,
output wire [1:0] ALU_op,
output wire  ALUsrc,
output wire [1:0] Memtoreg,
output wire Memwrite,
output wire Regwrite,
output wire branch,
output wire jump,
output wire [1:0] immsrc
);

    parameter R_TYPE  = 7'b0110011;
    parameter I_TYPE_L = 7'b0000011;
    parameter I_TYPE_A = 7'b0010011;
    parameter S_TYPE  = 7'b0100011;
    parameter SB_TYPE = 7'b1100111;
    parameter U_TYPE  = 7'b0110111;
    parameter UJ_TYPE = 7'b1101111;
    
    assign ALU_op[1] = (opcode == R_TYPE | opcode == I_TYPE_A) ;
    assign ALU_op[0] = (opcode == SB_TYPE  | opcode == I_TYPE_A) ;
    assign ALUsrc   = (opcode == I_TYPE_L | opcode == I_TYPE_A | opcode == S_TYPE);
    assign Memtoreg[1] = (opcode == U_TYPE | opcode == UJ_TYPE ) ;
    assign Memtoreg[0] = (opcode == U_TYPE | opcode == I_TYPE_L ) ;
    assign Memwrite = (opcode == S_TYPE) ;
    assign Regwrite = ~ (opcode == S_TYPE | opcode == SB_TYPE) ;
    assign branch = (opcode == SB_TYPE) ;
    assign jump = (opcode==UJ_TYPE) ;
    assign immsrc[1] = (opcode == U_TYPE | opcode == UJ_TYPE) ;
    assign immsrc[0] = (opcode == S_TYPE | opcode == SB_TYPE | opcode == UJ_TYPE ) ;
    
endmodule
