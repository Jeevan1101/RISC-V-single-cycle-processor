`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:  Midatana Jeevan Kumar
// Create Date: 18.07.2025 06:20:36
// Project Name: RISC-V single cycle processor
// Module Name: Register_file
//////////////////////////////////////////////////////////////////////////////////


module Register_file(
input wire [4:0] read_reg1,
input wire [4:0] read_reg2,
input wire [4:0] write_reg,
input wire [31:0] write_data,
input wire Regwrite,
input wire clock,
input wire reset,
output wire [31:0] read_data1,
output wire [31:0] read_data2
    );
    
    reg [31:0] registers [31:0] ;
    integer i ;
    
    assign read_data1 = registers [read_reg1] ;
    assign read_data2 = registers [read_reg2] ;
    
    always @ (posedge clock)begin
    
    if(reset) begin 
            for(i=0; i<32; i=i+1) begin
                registers[i] <= 32'd0 ; 
            end
    end
    
    if(Regwrite) begin
         if(write_reg != 5'b0) begin
                registers[write_reg] <= write_data ;
         end
    end
    
    end 
    
endmodule
