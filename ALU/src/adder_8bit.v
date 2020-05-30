`timescale 1ns / 1ps

/*
    8 bit adder / 2's complement subtractor
    Set mode = 0 for subtraction
    else addition
    
    Does A+B or A-B
*/

module adder_8bit #(parameter BUS_WIDTH = 8)(
    input [BUS_WIDTH - 1:0] A, 
    input [BUS_WIDTH - 1:0] B,
    input Cin,  
    input mode, 
    output [BUS_WIDTH - 1:0] sum, 
    output Cout
    );
    
    wire cout_1, cout_2, cout_3, cout_4, cout_5, cout_6, cout_7; 
    wire [7:0] B_bus; 
    
    full_adder A1 (
        .A(A[0]),
        .B(B_bus[0]), 
        .Cin(Cin), 
        .sum(sum[0]),
        .Cout(cout_1)
    );     
    full_adder A2 (
        .A(A[1]),
        .B(B_bus[1]), 
        .Cin(cout_1), 
        .sum(sum[1]),
        .Cout(cout_2)    
    );     
    full_adder A3 (
        .A(A[2]),
        .B(B_bus[2]), 
        .Cin(cout_2), 
        .sum(sum[2]),
        .Cout(cout_3)    
    );     
    full_adder A4 (
        .A(A[3]),
        .B(B_bus[3]), 
        .Cin(cout_3), 
        .sum(sum[3]),
        .Cout(cout_4)    
    );     
    full_adder A5 (
        .A(A[4]),
        .B(B_bus[4]), 
        .Cin(cout_4), 
        .sum(sum[4]),
        .Cout(cout_5)    
    );     
    full_adder A6 (
        .A(A[5]),
        .B(B_bus[5]), 
        .Cin(cout_5), 
        .sum(sum[5]),
        .Cout(cout_6)    
    );     
    full_adder A7 (
        .A(A[6]),
        .B(B_bus[6]), 
        .Cin(cout_6), 
        .sum(sum[6]),
        .Cout(cout_7)    
    );     
    full_adder A8 (
        .A(A[7]),
        .B(B_bus[7]), 
        .Cin(cout_7), 
        .sum(sum[7]),
        .Cout(Cout)    
    ); 
    
    assign B_bus = (mode) ? B : ~B + 1'b1;
    
endmodule
