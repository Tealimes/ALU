module ALU_control(
    input iClk,
    input iRstN, 
    input [7:0] pc,
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input [4:0] shamt,
    output [2:0] aluop,
    output [7:0] pcout
    );
    
    always@(posedge iClk or negedge iRstN) begin
        if(!iRstN) begin
            aluop <= 0;
        end else begin 
            case(funct3)
                
            
            endcase
        end
    
    end
endmodule
