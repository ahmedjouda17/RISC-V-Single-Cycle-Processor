module ALUControl (
    input      [1:0] ALUOp,
    input      [2:0] funct3,
    input      [6:0] funct7,
    output reg [2:0] ALUControl
);
 
    always @(*) begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000;   // ADD for LW/SW
            2'b01: ALUControl = 3'b010;   // SUB for BEQ
 
            2'b10: begin
                case (funct3)
                    3'b000: begin
                        if (funct7[5] == 1'b1)
                            ALUControl = 3'b010;   // SUB
                        else
                            ALUControl = 3'b000;   // ADD
                    end
                    3'b111: ALUControl = 3'b111;   // AND
                    3'b110: ALUControl = 3'b110;   // OR
                    3'b100: ALUControl = 3'b100;   // XOR
                    3'b001: ALUControl = 3'b001;   // SLL
                    3'b101: begin
                        if (funct7[5] == 1'b1)
                            ALUControl = 3'b011;   // SRA
                        else
                            ALUControl = 3'b101;   // SRL
                    end
                    default: ALUControl = 3'b000;
                endcase
            end
 
            default: ALUControl = 3'b000;
        endcase
    end
 
endmodule
