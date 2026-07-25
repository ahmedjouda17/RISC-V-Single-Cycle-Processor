// CPU_TOP (Main Processor )
module CPU_TOP (
    input  wire clk,
    input  wire reset_n,
    output wire [7:0] debug_led
);
    // PC and fetch
    wire [31:0] PC;
    wire [31:0] next_PC;
    wire [31:0] PCPlus4;
    wire [31:0] PCTarget;
    wire        PCSrc;
    wire branch_taken;

 
    // Instruction
    wire [31:0] instr;
 
    // Control signals
    wire        MemRead, MemWrite, ResultSrc, Branch, ALUSrc, RegWrite, load;
    wire [1:0]  ALUOp;
    wire [1:0]  ImmSrc;
 
    // ALU signals
    wire [2:0]  ALUControl_sig;
    wire [31:0] alu_result;
    wire        alu_zero;
    wire sign;
  
    // Register file signals
    wire [31:0] reg_read_data1, reg_read_data2;
 
    // Immediate generation
    wire [31:0] imm_out;
 
    // ALU inputs
    wire [31:0] alu_src_b;
 
    // Data memory read data
    wire [31:0] mem_read_data;
 
    // Write back data
    wire [31:0] write_back_data;
 
    // Instruction fields
    wire [6:0]  opcode = instr[6:0];
    wire [4:0]  rs1    = instr[19:15];
    wire [4:0]  rs2    = instr[24:20];
    wire [4:0]  rd     = instr[11:7];
    wire [2:0]  funct3 = instr[14:12];
    wire [6:0]  funct7 = instr[31:25];
 
    // Module Instantiations
    

    // PC Register block)
    pc pc_reg (
        .nextPc (next_PC),
        .clk    (clk),
        .resetn (reset_n),
        .load   (load),         
        .pc     (PC)
    );
 
    // Instruction Memory  
    InstructionMemory instr_mem (
        .pc    (PC),
        .instr (instr)
    );
 
    // Control Unit  
    ControlUnit control_unit (
        .opcode   (opcode),
        .MemRead  (MemRead),
        .MemWrite (MemWrite),
        .ResultSrc(ResultSrc),
        .Branch   (Branch),
        .ALUSrc   (ALUSrc),
        .RegWrite (RegWrite),
        .ALUOp    (ALUOp),
        .load     (load),
        .ImmSrc   (ImmSrc)
    );
 
    // ALU Control 
    ALUControl alu_control (
        .ALUOp      (ALUOp),
        .funct3     (funct3),
        .funct7     (instr[30]),
        .OP5        (opcode[5]),
        .ALUControl (ALUControl_sig)
    );
 
    // Register File
    RegisterFile reg_file (
        .clk        (clk),
        .reset_n    (reset_n),
        .rs1        (rs1),
        .rs2        (rs2),
        .rd         (rd),
        .write_data (write_back_data),
        .reg_write  (RegWrite),
        .read_data1 (reg_read_data1),
        .read_data2 (reg_read_data2)
    );
 
    // Immediate Generator 
    ImmGen imm_gen (
        .instr   (instr),
        .ImmSrc  (ImmSrc),
        .imm_out (imm_out)
    );
 
    // ALU Source Mux 
    Mux2_32 alu_src_mux (
        .a   (reg_read_data2),
        .b   (imm_out),
        .sel (ALUSrc),
        .out (alu_src_b)
    );
 
    // ALU
    ALU alu (
        .A          (reg_read_data1),
        .B          (alu_src_b),
        .ALUControl (ALUControl_sig),
        .ALUResult  (alu_result),
        .Zero_flag  (alu_zero),
        .sign       (sign)
    );

 
    // Data Memory
    DataMemory data_mem (
        .clk        (clk),
        .addr       (alu_result),
        .write_data (reg_read_data2),
        .WE         (MemWrite),
        .read_data  (mem_read_data)
    );
 
    // Write Back Mux
    Mux2_32 result_mux (
        .a   (alu_result),
        .b   (mem_read_data),
        .sel (ResultSrc),
        .out (write_back_data)
    );
 
    // PC Adder (+4)
    Adder32 pc_adder (
        .a (PC),
        .b (32'd4),
        .y (PCPlus4)
    );
 
    // Branch Target Adder
    Adder32 branch_adder (
        .a (PC),
        .b (imm_out),
        .y (PCTarget)
    );
 
    // Branch condition 
   assign branch_taken =
        Branch &&
        (
            (funct3 == 3'b000 && alu_zero) ||   // BEQ
            (funct3 == 3'b100 && sign)          // BLT
        );
 
    // PC Mux
    Mux2_32 pc_mux (
        .a   (PCPlus4),
        .b   (PCTarget),
        .sel (branch_taken),
        .out (next_PC)
    );
 
    // Debug
    always @(posedge clk) begin
        if (reset_n && (PC != next_PC)) begin
            $display("[%0t] PC=%h | instr=%h | opcode=%b | RegWrite=%b | ALUOp=%b | ALUResult=%h",
                     $time, PC, instr, opcode, RegWrite, ALUOp, alu_result);
        end
    end
    assign PCSrc = branch_taken;
    assign debug_led = PC[7:0];    // for the test 
    
 
endmodule
