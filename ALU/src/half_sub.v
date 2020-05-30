`timescale 1ns / 1ps

/*
    Half subtractor with borrow out.
    Does A-B
*/

module half_sub(
    input A, 
    input B, 
    output D, 
    output Bout
    );
    
    assign D = A ^ B; 
    assign Bout = ~A & B; 
    
endmodule
