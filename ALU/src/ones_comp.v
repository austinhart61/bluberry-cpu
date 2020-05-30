`timescale 1ns / 1ps

/*
    Return A or B inverted depending on operand_flag
        if(operand_flag == 1) return A inverted
        else return B inverted
*/
module ones_comp    
    #(parameter BUS_WIDTH = 8)
    (
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH - 1 : 0] B, 
        input operand_flag, 
        output [BUS_WIDTH - 1 : 0] Y        
    );
    
    assign Y = (operand_flag) ? ~(A) : ~(B); 
    
endmodule
