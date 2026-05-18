module ALU(
    input  [31:0] A, B,
    input  [2:0]  ALUControl,
    output reg [31:0] ALUResult,
    output        Zero_flag
);
 
    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = A + B;
            3'b001: ALUResult = A << B[4:0];
            3'b010: ALUResult = A - B;
            3'b011: ALUResult = $signed(A) >>> B[4:0];  // SRA (arithmetic right shift)
            3'b100: ALUResult = A ^ B;
            3'b101: ALUResult = A >> B[4:0];             // SRL (logical right shift)
            3'b110: ALUResult = A | B;
            3'b111: ALUResult = A & B;
            default: ALUResult = 32'b0;
        endcase
    end
 
    assign Zero_flag = (ALUResult == 32'b0);
 
endmodule
