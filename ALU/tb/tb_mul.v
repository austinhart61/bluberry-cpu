`timescale 1ns / 1ps

module tb_mul();

    parameter BUS_WIDTH = 8;
    parameter BUS_WIDTH_BITS = 3; 
    parameter SHIFT_B_BITS = 5;
    parameter PREFIX_WIDTH = 2; 
    parameter INST_WIDTH = 3;
    parameter INST_WIDTH_SHIFT = 2;

    // instantation variables
    reg [PREFIX_WIDTH + INST_WIDTH - 1:0] opcode = 0;
    reg [BUS_WIDTH - 1 : 0] A = 0; 
    reg [BUS_WIDTH - 1 : 0] B = 0;
    reg Cin = 0;
    wire [BUS_WIDTH - 1 : 0] Y; 
    wire Cout;
    
    // other stuff
    reg clk = 0;
    reg [7:0] counter = 0; 
    
    reg [7:0] mul_1 = 25;
    reg [7:0] mul_2 = 9; 
    reg [7:0] accumulator = 0;
    
    op_decode ALU(
        .opcode(opcode), 
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .Y(Y), 
        .Cout(Cout)
    );    

    always begin
        #10; 
        clk = ~clk; 
    end
    
    always @(posedge clk) begin
        if(counter != mul_2) begin
            {opcode, A, B} <= {5'b10000, mul_1, accumulator};
            #1;
            accumulator <= Y;
            counter = counter + 1'b1;
            $display("Accumulator: %d", accumulator);
        end
        else begin
            $display("%d * %d = %d", mul_1, mul_2, accumulator);
            $stop; 
        end
    end

endmodule
