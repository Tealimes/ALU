module ALU #(
    parameter BWIDTH = 32 ) (
    input iClk,
    input iRstN, 
    input signed [BWIDTH-1:0] RS1,
    input signed [BWIDTH-1:0] RS2,
    input [7:0] pc,
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input [4:0] shamt,
    output [WIDTH-1:0] RD
    );
    
    reg [WIDTH-1:0] RD_t
    
    always@(posedge iClk or negedge iRstN) begin
        if(!iRstN) begin
            RD_t <= 0;
        end else if(opcode == 7'b0110011) begin 
            case(funct3)
                3'b000 : RD_t <= (Funct7 == 7'b0100000) ? RS1 + RS2 : RS1 - RS2;
            
            endcase
        end
    
    end
endmodule
