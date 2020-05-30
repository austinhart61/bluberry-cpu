`timescale 1ns / 1ps

/*
    Rotate register A, this is limited to 1 rotation in either direction. 
        - Use B[BUS_WIDTH_BITS + 1] to activate rotate through carry
        - Use B[BUS_WIDTH_BITS] to determine direction. 
        - Use B[BUS_WIDTH_BITS-1:0] for amount
*/
module rotate_shift
    #(parameter BUS_WIDTH = 8, 
      parameter BUS_WIDTH_BITS = 3)(
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH_BITS + 1 : 0] B, 
        input Cin, 
        output [BUS_WIDTH - 1 : 0] Y,
        output Cout 
    );
    
    assign {Y, Cout} =  (B[BUS_WIDTH_BITS + 1]) ?                                       // Use rotate through carry
                    (B[BUS_WIDTH_BITS]) ?                                               // Determine direction of rotation
                        {{A, Cin}, {A, Cin}} << BUS_WIDTH - B[BUS_WIDTH_BITS-1:0]       // left rotate through carry
                    : 
                        ({{A, Cin}, {A, Cin}} >> B[BUS_WIDTH_BITS-1:0]) >> BUS_WIDTH + 1    // Left rotate through carry
                :                                                                       // Use rotation without carry
                    (B[BUS_WIDTH_BITS]) ?                                               // Determine direction of rotation
                        {{A,A} << BUS_WIDTH - B[BUS_WIDTH_BITS-1:0], Cin}               // left rotation
                    :
                        {({A,A} >> B[BUS_WIDTH_BITS-1:0]) >> BUS_WIDTH, Cin}            // right rotation
                ;
    
endmodule
