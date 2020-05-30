`timescale 1ns / 1ps

/*
    Arithmetic module top
        INST    :       OP          :   EXP
        -----------------------------------
        3'b000  :       ADD         :   A+B
        3'b001  :     ADD Carry     :   A+B+Cin
        3'b010  :       SUB         :   A-B
        3'b011  :     SUB Carry     :   A-B+Cin
        3'b100  :     2's Comp      :   0-B
        3'b101  :       INC         :   A+1
        3'b110  :       DEC         :   A-1
        3'b111  :     PASS THRU     :   A
*/

module arithmetic_top 
    #(  parameter BUS_WIDTH = 8,
        parameter INST_WIDTH = 3)
    (
        input [BUS_WIDTH - 1 : 0] A, 
        input [BUS_WIDTH - 1 : 0] B,
        input [INST_WIDTH - 1 : 0] inst,  
        input Cin, 
        output [BUS_WIDTH - 1 : 0] Y,
        output Cout,
        output negative
    );
    
    wire [BUS_WIDTH-1:0] A_bus; 
    wire [BUS_WIDTH-1:0] B_bus; 
    wire [BUS_WIDTH-1:0] Y_bus; 
    wire mode, Cin_temp, negative_potential; 
    
    adder_8bit #(BUS_WIDTH) ADD (
        .A(A_bus),
        .B(B_bus), 
        .Cin(Cin_temp), 
        .mode(mode), 
        .sum(Y_bus),
        .Cout(Cout)
    );
    
    // assign addition or subtraction mode
    assign mode =   inst == 3'b000 ? 1'b1 : 
                    inst == 3'b001 ? 1'b1 :
                    inst == 3'b101 ? 1'b1 :
                    inst == 3'b111 ? 1'b1 : 1'b0;
                    
    // assign value busses based on inst
    assign A_bus =  inst == 3'b000 ? A :    // Add A+B
                    inst == 3'b001 ? A :    // Add with carry A+B
                    inst == 3'b010 ? A :    // Sub A-B
                    inst == 3'b011 ? A :    // Sub with borrow A-B
                    inst == 3'b100 ? 0 :    // two's complement (0) - B
                    inst == 3'b101 ? A :    // increment A, A+1
                    inst == 3'b110 ? A :    // decrement A, A+(-1)
                    A;                      // pass through A
                    
    assign B_bus =  inst == 3'b000 ? B :    // Add A+B
                    inst == 3'b001 ? B :    // Add with carry A+B
                    inst == 3'b010 ? B :    // Sub A-B
                    inst == 3'b011 ? B :    // Sub with borrow A-B
                    inst == 3'b100 ? B :    // two's complement (0) - B
                    inst == 3'b101 ? 8'b1 : // increment A, A+1
                    inst == 3'b110 ? 8'b1 : // decrement A, A+(-1)
                    B;                      // pass through B
    
    // pass through option
    assign Y = (inst == 3'b111) ? A : Y_bus; 
    
    // enable or disable Cin
    assign Cin_temp =   inst == 3'b001 ? Cin :
                        inst == 3'b011 ? Cin : 1'b0; 
    
    // these would result in negative numbers depending on the instruction
    assign negative_potential =     (B > A) ? 1'b1 :
                                    (A == 0) ? 1'b1 : 1'b0;
                                    
    assign negative =   inst == 3'b010 ? negative_potential :    // Sub A-B
                        inst == 3'b011 ? negative_potential :    // Sub with borrow A-B
                        1'b0;
    
endmodule
