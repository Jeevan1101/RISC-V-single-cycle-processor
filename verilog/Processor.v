`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Midatana Jeevan Kumar
// Create Date: 19.07.2025 09:23:42
// Module Name: Processor
// Project Name: RISC-V single cycle processor 
//////////////////////////////////////////////////////////////////////////////////

module Processor(
input wire clock,
input wire reset
    );
    
    // main_decoder
    wire [6:0] opcode ;
    wire [1:0] ALU_op ;
    wire  ALUsrc,Memrite,Regwrite,branch,jump ;
    wire [1:0] Memtoreg ;
    wire [1:0] immsrc ;
    
    //ALU decoder
    wire [3:0] funccode ;
    wire [3:0] ALU_control ;
    
    // ALU 
    wire  [31:0] op1,op2 ;
    wire zero ;
    wire [31:0] ALU_result ;
    
    //Register file 
    wire [4:0] read_reg1,read_reg2,write_reg ;
    wire [31:0] write_data,read_data1,read_data2 ;
    
    // Instruction Memory 
    wire [9:0] address ;
    wire [31:0] instruction ;
    wire [31:0] imm_val ;
    
    //Data_mempory 
    wire [31:0] read_mem ;
    
    // PC 
    reg  [31:0] PC; // should be 10 bit wide but can have this width 
    wire [31:0] PC_plus,PC_branch,PC_next ;
    wire PC_sel ;
    
    // Connecting signals 
    assign PC_sel = (branch & zero) | jump ;
    assign PC_plus = PC + 1 ;
    assign PC_branch = PC + imm_val ;
    assign PC_next = (PC_sel==1'b1) ? PC_branch : PC_plus ;
    assign address = PC[9:0] ;
    assign read_reg1 = instruction[19:15] ;
    assign read_reg2 = instruction[24:20] ;
    assign write_reg = instruction[11:7] ;
    assign write_data = (Memtoreg == 2'b00) ? ALU_result : (Memtoreg ==2'b01) ? read_mem : (Memtoreg ==2'b10) ? PC_plus : imm_val ;
    assign op1 = read_data1 ;
    assign op2 = (ALUsrc) ? imm_val : read_data2 ;
    assign opcode = instruction[6:0] ;
    assign funccode = { instruction[30] , instruction[14:12] }  ;
    
    always@(posedge clock)begin
        PC <= (reset) ? 32'd0 : PC_next;   
    end
    
    Instruction_memory instruction_mem (.address(address),.reset(reset),.instruction(instruction)) ;
    Register_file reg_file(.read_reg1(read_reg1),.read_reg2(read_reg2),.write_reg(write_reg),.write_data(write_data),.Regwrite(Regwrite),.clock(clock),.reset(reset),.read_data1(read_data1),.read_data2(read_data2)) ;
    Immediate_value imm_value (
            .Instruction(instruction),
            .immsrc(immsrc),
            .imm_val(imm_val)
    ) ;
    ALU alu ( .op1(op1),.op2(op2),.ALU_control(ALU_control),.zero(zero),.ALU_result(ALU_result)) ;
    main_decoder_ctrl main_decoder (
        .opcode(opcode),
        .ALU_op(ALU_op),
        .ALUsrc(ALUsrc),
        .Memtoreg(Memtoreg),
        .Memwrite(Memwrite),
        .Regwrite(Regwrite),
        .branch(branch),
        .jump(jump),
        .immsrc(immsrc)
    );
    
     ALU_decoder_ctrl alu_decoder (
        .ALU_op(ALU_op),
        .funccode(funccode),
        .ALU_control(ALU_control)
    );
    
    Data_memory data_mem(
         .clock(clock),
         .Memwrite(Memwrite),
         .address(ALU_result),
         .write_mem(read_data2),
         .read_mem(read_mem)
    ) ;
   
endmodule
