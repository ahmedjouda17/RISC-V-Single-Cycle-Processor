module ALUControl (
    input      [1:0] ALUOp,
    input      [2:0] funct3,
    input      funct7,
    input      OP5,
    output reg [2:0] ALUControl
);
 
   always @(*) begin
    ALUControl = 3'b000; // Default value

    casex({ALUOp, funct3, OP5, funct7})

        7'b00_xxx_xx: ALUControl = 3'b000; // ADD

        7'b01_000_xx: ALUControl = 3'b010; // SUB
        7'b01_001_xx: ALUControl = 3'b010; // SUB
        7'b01_100_xx: ALUControl = 3'b010; // SUB

        7'b10_000_00: ALUControl = 3'b000; // ADD
        7'b10_000_10: ALUControl = 3'b000; // ADD
        7'b10_000_01: ALUControl = 3'b000; // ADD

        7'b10_000_11: ALUControl = 3'b010; // SUB

        7'b10_001_xx: ALUControl = 3'b001; // SHL
        7'b10_100_xx: ALUControl = 3'b100; // XOR
        7'b10_101_xx: ALUControl = 3'b101; // SHR
        7'b10_110_xx: ALUControl = 3'b110; // OR
        7'b10_111_xx: ALUControl = 3'b111; // AND

        default: ALUControl = 3'b000; // Default case

    endcase
end
 
endmodule
