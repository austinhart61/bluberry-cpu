`timescale 1ns / 1ps
    
module op_decode 
    #(
        parameter BUS_WIDTH = 8,
        parameter BUS_WIDTH_BITS = 3, 
        parameter SHIFT_B_BITS = 5, 
        parameter PREFIX_WIDTH = 2, 
        parameter INST_WIDTH = 3,
        parameter INST_WIDTH_SHIFT = 2
    ) (
        input [PREFIX_WIDTH + INST_WIDTH - 1:0] opcode,
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH - 1 : 0] B,
        input Cin, 
        output [BUS_WIDTH - 1 : 0] Y, 
        output Cout,
        output zero,
        output negative
    );
    
    wire [BUS_WIDTH-1:0] bitwise_bus; 
    wire [BUS_WIDTH-1:0] shift_bus; 
    wire [BUS_WIDTH-1:0] arith_bus;
    wire Cout_shift;
    wire Cout_arith; 
    
    bitwise_top #(BUS_WIDTH, INST_WIDTH) BITWISE (
        .A(A), 
        .B(B), 
        .inst(opcode[INST_WIDTH-1:0]),
        .Y(bitwise_bus)
    ); 
    
    shift_top #(BUS_WIDTH, INST_WIDTH_SHIFT, BUS_WIDTH_BITS, SHIFT_B_BITS) SHIFT (
        .A(A), 
        .B(B[SHIFT_B_BITS - 1 : 0]), 
        .inst(opcode[INST_WIDTH_SHIFT-1:0]),
        .Cin(Cin), 
        .Cout(Cout_shift),
        .Y(shift_bus)
    );
    
    arithmetic_top #(BUS_WIDTH, INST_WIDTH) ARITHMETIC (
        .A(A), 
        .B(B), 
        .inst(opcode[INST_WIDTH-1:0]),
        .Cin(Cin), 
        .Y(arith_bus), 
        .Cout(Cout_arith),
        .negative(negative)
    );
    
    assign Y = (opcode[PREFIX_WIDTH + INST_WIDTH - 1:INST_WIDTH] == 0) ? bitwise_bus : 
               (opcode[PREFIX_WIDTH + INST_WIDTH - 1:INST_WIDTH] == 1) ? shift_bus : 
               (opcode[PREFIX_WIDTH + INST_WIDTH - 1:INST_WIDTH] == 2) ? arith_bus : 8'b0;
    
    assign Cout =   (opcode[PREFIX_WIDTH + INST_WIDTH - 1:INST_WIDTH] == 1) ? Cout_shift : 
                    (opcode[PREFIX_WIDTH + INST_WIDTH - 1:INST_WIDTH] == 2) ? Cout_arith : 1'b0;
                    
    assign zero = (Y != 0) ? 1'b0 : 1'b1; 
    
endmodule
