`timescale 1ns / 1ps

module full_sub(
    input A,
    input B, 
    input Bin, 
    output D, 
    output Bout
    );

    wire U1_xor; 
    wire U1_and; 
    wire U2_and;

    half_sub U1 (
        .A(A), 
        .B(B), 
        .D(U1_xor), 
        .Bout(U1_and)
    );

    half_sub U2 (
        .A(U1_xor), 
        .B(Bin), 
        .D(D), 
        .Bout(U2_and)
    );

    assign Bout = U2_and | U1_and;

endmodule
