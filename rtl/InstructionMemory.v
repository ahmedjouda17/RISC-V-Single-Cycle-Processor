module InstructionMemory (
    input  [31:0] pc,
    output reg [31:0] instr
);

    reg [31:0] memory [0:63];
   
   always@(pc)begin
        instr = memory [pc[31:2]];
end
endmodule
