`timescale 100ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: MIdatana Jeevan kumar
// Create Date: 18.08.2025 10:35:23
// Design Name: testbench
// Module Name: riscv_testbench
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////


module riscv_testbench();

 reg clock,reset ;
 
 Processor riscv (.clock(clock),.reset(reset)) ;
 initial begin 
 clock = 0 ;
 reset = 1 ;
 #10 reset = 0 ;
 end
 
  always begin
        #5 clock = ~clock;
  end
  
  initial #8000 $finish ;
endmodule
