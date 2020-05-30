`timescale 1ns / 1ps

module bitwise_top
    #(  parameter BUS_WIDTH = 8,
        parameter INST_WIDTH = 3) (
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH - 1 : 0] B,
        input [INST_WIDTH - 1 : 0] inst,  
        output [BUS_WIDTH - 1 : 0] Y  
    );
    
    wire [BUS_WIDTH - 1 : 0] and_bus; 
    wire [BUS_WIDTH - 1 : 0] or_bus; 
    wire [BUS_WIDTH - 1 : 0] xor_bus; 
    wire [BUS_WIDTH - 1 : 0] ones_comp_bus; 
    
    and_top AND( 
        .A(A), 
        .B(B), 
        .Y(and_bus)
    );    
    
    or_top OR( 
        .A(A), 
        .B(B), 
        .Y(or_bus)
    );    
    
    xor_top XOR( 
        .A(A), 
        .B(B), 
        .Y(xor_bus)
    );    
    
    ones_comp ONES( 
        .A(A), 
        .B(B),
        .operand_flag(inst[INST_WIDTH - 1]),
        .Y(ones_comp_bus)
    );
    
    assign Y =  (inst[1:0] == 0) ? and_bus : 
                (inst[1:0] == 1) ? or_bus : 
                (inst[1:0] == 2) ? xor_bus : ones_comp_bus;  //(inst[1:0] == 3)
    
endmodule
