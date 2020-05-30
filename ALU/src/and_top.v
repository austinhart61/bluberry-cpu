`timescale 1ns / 1ps


module and_top 
    #(parameter BUS_WIDTH = 8)
    (
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH - 1 : 0] B, 
        output [BUS_WIDTH - 1 : 0] Y
    );
    
    assign Y = A & B; 
    
endmodule
