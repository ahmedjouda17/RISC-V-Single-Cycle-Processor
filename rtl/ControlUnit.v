module ControlUnit (
    input  [6:0]     opcode,
    output reg       MemRead,
    output reg       MemWrite,
    output reg       ResultSrc,
    output reg       Branch,
    output reg       ALUSrc,
    output reg       RegWrite,
    output reg [1:0] ALUOp,
    output reg       load,
    output reg [1:0] ImmSrc
);
 
    always @(*) begin
        // Default values
        Branch =0;
        MemWrite = 0;
        ResultSrc =0;
        Branch   = 0;
        ALUSrc   = 0;
        RegWrite = 0;
        ALUOp    = 2'b00;
        ImmSrc=2'b00;
        load =1;
 if (|opcode)begin 
 load=1;
        case (opcode)
                    // load (000_0011)
            7'b000_0011:begin
                   Branch =0;
                   MemWrite = 0;
                   ResultSrc =1;
                   Branch   = 0;
                   ALUSrc   = 1;
                   RegWrite = 1;
                   ALUOp    = 2'b00;
                   ImmSrc = 2'b00;
                   end 
            // R-TYPE (011_0011)
            7'b011_0011: begin
                RegWrite = 1;
                ALUSrc   = 0;
                ALUOp    = 2'b10;
                 Branch =0;
                 ResultSrc =0;
                 MemWrite = 0;
                 
            end
 
            // I-TYPE (ADDI = 001_0011)
            7'b001_0011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b10;
                ImmSrc = 2'b00;      
                Branch =0;
                ResultSrc =0;
                MemWrite = 0;
            end
 
            // STORE (SW = 0100_011)
            7'b010_0011: begin
               RegWrite = 0;
               ALUSrc   = 1;
                ALUOp    = 2'b00;
                ImmSrc = 2'b01;      
                 Branch =0;
                  MemWrite = 1;
            end
 
            // BRANCH (BEQ = 110_0011)
            7'b110_0011: begin
                 RegWrite = 0;
                 ALUSrc   = 0;
                 ALUOp    = 2'b01;
                 ImmSrc = 2'b10;      
                 Branch =1;
                 MemWrite = 0;
            end
        endcase
        end else begin 
        load =0;
    end
  end
 
endmodule
