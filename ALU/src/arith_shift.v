`timescale 1ns / 1ps

/*
    Arithmetic logical shift module. The sign bit of A is preserved. 
    if B[MSB] == 1 then left shift by B[MSB - 1 : 0]
    else right shift. 
*/
module arith_shift
    #(parameter BUS_WIDTH = 8, 
      parameter BUS_WIDTH_BITS = 3)(
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH_BITS : 0] B, 
        output [BUS_WIDTH - 1 : 0] Y  
    );
    
    localparam MSB = BUS_WIDTH_BITS; 
    
    assign Y = (B[MSB]) ? A <<< B[BUS_WIDTH_BITS - 1 : 0] : A >>> B[BUS_WIDTH_BITS - 1 : 0];
    
endmodule
