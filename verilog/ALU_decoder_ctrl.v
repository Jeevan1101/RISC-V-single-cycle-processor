`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Midatana Jeevan Kumar
// Create Date: 17.07.2025 19:45:13
// Module Name: ALU_decoder_ctrl
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module ALU_decoder_ctrl(
input wire [1:0] ALU_op,
input wire [3:0] funccode,
output reg [3:0] ALU_control
    );
    
    parameter [3:0] ADD = 4'b0010;
    parameter [3:0] SUB= 4'b0110;
    parameter [3:0] AND = 4'b0000;
    parameter [3:0] OR  = 4'b0001;
    parameter [3:0] SLL = 4'b1000;
    parameter [3:0] GTE = 4'b0111;
    parameter [3:0] LTE = 4'b1001;
    
        always@(*) begin
        case (ALU_op)
            2'b00: ALU_control = ADD;                
            2'b01: begin
                case (funccode[2:0])                 
                    3'b000: ALU_control = SUB;
                    3'b101: ALU_control = GTE;
                    3'b100: ALU_control = LTE;
                    default: ALU_control = SUB;
                endcase
            end
            2'b10: begin
                case (funccode)                 
                    4'b0000: ALU_control = ADD;
                    4'b1000: ALU_control = SUB;
                    4'b0111: ALU_control = AND;
                    4'b0110: ALU_control = OR;
                    default: ALU_control = ADD;
                endcase
            end
            2'b11: begin
                case (funccode[2:0])                 
                    3'b000: ALU_control = ADD;
                    3'b001: ALU_control = SLL;
                    default: ALU_control = ADD;
                endcase    
            end              
        endcase
    end
endmodule
