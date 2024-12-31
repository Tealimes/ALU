`timescale 1ns / 1ns

class Checker;
    parameter BWIDTH = 32;
    logic [BWIDTH-1:0] C_comp;
    logic [BWIDTH-1:0] C_real;
    
    function void equation(input logic A, B, C, opcode, funct7, funct3);
        C_real = C;
        if(opcode == 7'b0110011) begin
            case(funct3)
               3'b000 : C_comp = A + B;
               3'b100 : C_comp <= A ^ B;
            endcase
        end
    endfunction
    function void display();
        if(C_comp == C_real) begin
            $display("Valid Output!");
        end else begin
            $display("C should be 0x%0h, but is instead 0x%0h", C_comp, C_real);
        end
        
    endfunction
endclass


module ALU_tb();
    parameter BWIDTH = 32;
    logic iClk, iRstN;
    logic signed [BWIDTH-1:0] RS1, RS2;
    logic [11:0] imm_r;
    logic [7:0] pc;
    logic [BWIDTH-1:0] RS1;
    logic [BWIDTH-1:0] RS2;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [4:0] shamt;
    logic [BWIDTH-1:0] RD;
    
    Checker check;
    
    ALU#(
        .BWIDTH(BWIDTH)
    ) u_ALU (
        .iClk(iClk), .iRstN(iRstN), .RS1(RS1), .RS2(RS2),
        .imm_r(imm_r), .pc(pc), .opcode(opcode), .funct3(funct3),
        .funct7(funct7), .shamt(shamt), .RD(RD)
    );
    
    always #5 iClk = ~iClk;
    
    initial begin
        $dumpfile("ALU_tb"); $dumpvars;
        check = new();
        iClk = 1;
        iRstN = 0;
        
        #10 iRstN = 1;
        
        //XOR Test
        opcode = 7'b0110011;
        funct7 = 0;
        funct3 = 3'b100;
        RS1 = $random;
        RS2 = $random;
        
        check.equation(RS1,RS2,RD,opcode,funct7,funct3);
        check.display();
       
        #10;
        
        //ADD test
        opcode = 7'b0110011;
        funct7 = 0;
        funct3 = 3'b000;
        RS1 = $random;
        RS2 = $random;
        
        check.equation(RS1,RS2,RD,opcode,funct7,funct3);
        check.display();
        #100;
        
        
        
        $finish;
    end
endmodule
