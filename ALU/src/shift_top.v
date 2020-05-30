`timescale 1ns / 1ps

module shift_top
    #(  parameter BUS_WIDTH = 8,
        parameter INST_WIDTH = 3,
        parameter BUS_WIDTH_BITS = 3,
        parameter SHIFT_B_BITS = 5) (
        input [BUS_WIDTH - 1 : 0] A, 
        input [SHIFT_B_BITS - 1 : 0] B,
        input [INST_WIDTH - 1 : 0] inst,  
        input Cin, 
        output [BUS_WIDTH - 1 : 0] Y, 
        output Cout
    );
    
    wire [BUS_WIDTH - 1 : 0] arith_bus; 
    wire [BUS_WIDTH - 1 : 0] logic_bus; 
    wire [BUS_WIDTH - 1 : 0] rotation_bus;
    
    arith_shift #(BUS_WIDTH, BUS_WIDTH_BITS) ARITH (
        .A(A), 
        .B(B[BUS_WIDTH_BITS:0]), 
        .Y(arith_bus)
    );     
    
    logic_shift #(BUS_WIDTH, BUS_WIDTH_BITS) LOGIC (
        .A(A), 
        .B(B[BUS_WIDTH_BITS:0]), 
        .Y(logic_bus)
    );   
      
    rotate_shift #(BUS_WIDTH, BUS_WIDTH_BITS) ROTATE (
        .A(A), 
        .B(B), 
        .Y(rotation_bus),
        .Cin(Cin), 
        .Cout(Cout)
    ); 
    
    assign Y = (inst[1:0] == 0) ? arith_bus : 
            (inst[1:0] == 1) ? logic_bus : rotation_bus;    //(inst[1:0] == 2)
    
endmodule
