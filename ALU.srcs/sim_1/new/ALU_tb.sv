`timescale 1ns / 1ps


module ALU_tb();
    parameter BWIDTH = 32;
    logic iClk, iRstN;
    logic signed [BWIDTH-1:0] RS1, RS2;
    logic [11:0] imm_r;
    logic [7:0] pc;
    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [4:0] shamt;
    logic [BWIDTH-1:0] RD;
    
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
        
        iClk = 1;
        
        $finish;
    end
endmodule
