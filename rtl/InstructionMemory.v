module InstructionMemory (
    input  [31:0] addr,
    output [31:0] instr
);
    reg [31:0] memory [0:63];
    integer i;
 
    initial begin
        for (i = 0; i < 64; i = i + 1)
            memory[i] = 32'h00000000;
 
        memory[0]  = 32'h00100093;  // addi x1, x0, 1      (x1 = 1)
        memory[1]  = 32'h00200113;  // addi x2, x0, 2      (x2 = 2)
        memory[2]  = 32'h00300193;  // addi x3, x0, 3      (x3 = 3)
        memory[3]  = 32'h00400213;  // addi x4, x0, 4      (x4 = 4)
        memory[4]  = 32'h00500293;  // addi x5, x0, 5      (x5 = 5)
        memory[5]  = 32'h00600313;  // addi x6, x0, 6      (x6 = 6)
        memory[6]  = 32'h00700393;  // addi x7, x0, 7      (x7 = 7)
        memory[7]  = 32'h00800413;  // addi x8, x0, 8      (x8 = 8)
        memory[8]  = 32'h00208133;  // add  x2, x1, x2     (x2 = 1+2 = 3)  
        memory[9]  = 32'h002084B3;  // add  x9, x1, x2     (x9 = 1+3 = 4) 
                        /*.    
                          .
                          .
                          .
                          .
                        
       memory[63] = 32'hxxxxxxxx; to 63 memory locations
                                      */
    end
 
    assign instr = memory[addr[7:2]];
 
endmodule
