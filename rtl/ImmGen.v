module ImmGen (
    input  [31:0]     instr,
    input [1:0]       ImmSrc,
    output reg [31:0] imm_out
);
 
    wire [6:0] opcode = instr[6:0];
 
    always @(*) begin
        case (ImmSrc)
            // I-type
            2'b00: begin
                imm_out = {{20{instr[31]}}, instr[31:20]};
            end
 
            // S-type
            2'b01: begin
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};
            end
 
            // B-type
            2'b10: begin
                imm_out = {{20{instr[31]}}, instr[7],
                           instr[30:25], instr[11:8], 1'b0};
            end
 
            default: imm_out = 32'b0;
        endcase
    end
 
endmodule
