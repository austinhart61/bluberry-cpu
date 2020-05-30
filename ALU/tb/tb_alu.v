`timescale 1ns / 1ps

module tb_alu();
    
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
    reg Cin_tester = 0; 
    
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
        if(Cin_tester) begin
            opcode = opcode + 1;
            Cin_tester = 0;
            Cin = 1;   
        end
        else begin
            Cin_tester = 1; 
            Cin = 0; 
        end
        A = $random % 256; 
        B = $random % 256; 
        
        $display("OPCODE: %b\t A: %b\t B: %b\t Cin: %b", opcode, A, B, Cin);
        $display("RESULT: %b", Y);
    end
    
endmodule
