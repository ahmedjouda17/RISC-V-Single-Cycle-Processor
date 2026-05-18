// CPU_TOP (Main Processor)
module CPU_TOP (
    input  wire clk,
    input  wire reset_n,
    output wire [7:0] debug_led
);
    // PC and fetch
    reg  [31:0] PC;
    wire [31:0] next_PC;
    wire [31:0] pc_plus4;
    wire [31:0] branch_target;
    wire        branch_taken;
 
    // Instruction
    wire [31:0] instr;
 
    // Control signals
    wire        MemRead, MemWrite, MemToReg, Branch, ALUSrc, RegWrite;
    wire [1:0]  ALUOp;
 
    // ALU signals
    wire [2:0]  ALUControl_sig;
    wire [31:0] alu_result;
    wire        alu_zero;
 
    // Register file signals
    wire [31:0] reg_read_data1, reg_read_data2;
 
    // Immediate generation
    wire [31:0] imm_out;
 
    // ALU inputs
    wire [31:0] alu_src_b;
    wire [31:0] alu_result_temp;
 
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
 
    // ========================================
    // Module Instantiations
    // ========================================
 
    // Instruction Memory
    InstructionMemory instr_mem (
        .addr  (PC),
        .instr (instr)
    );
 
    // Control Unit
    ControlUnit control_unit (
        .opcode   (opcode),
        .MemRead  (MemRead),
        .MemWrite (MemWrite),
        .MemToReg (MemToReg),
        .Branch   (Branch),
        .ALUSrc   (ALUSrc),
        .RegWrite (RegWrite),
        .ALUOp    (ALUOp)
    );
 
    // ALU Control
    ALUControl alu_control (
        .ALUOp      (ALUOp),
        .funct3     (funct3),
        .funct7     (funct7),
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
        .imm_out (imm_out)
    );
 
    // ALU Source Mux
    Mux2_32 alu_src_mux (
        .a   (reg_read_data2),
        .b   (imm_out),
        .sel (ALUSrc),
        .y   (alu_src_b)
    );
 
    // ALU
    ALU alu (
        .A          (reg_read_data1),
        .B          (alu_src_b),
        .ALUControl (ALUControl_sig),
        .ALUResult  (alu_result_temp),
        .Zero_flag  (alu_zero)
    );
 
    // Data Memory
    DataMemory data_mem (
        .clk        (clk),
        .addr       (alu_result_temp),
        .write_data (reg_read_data2),
        .WE         (MemWrite),
        .read_data  (mem_read_data)
    );
 
    // Write Back Mux
    Mux2_32 mem_to_reg_mux (
        .a   (alu_result_temp),
        .b   (mem_read_data),
        .sel (MemToReg),
        .y   (write_back_data)
    );
 
    // PC Adder (+4)
    Adder32 pc_adder (
        .a (PC),
        .b (32'd4),
        .y (pc_plus4)
    );
 
    // Branch Target Adder
    Adder32 branch_adder (
        .a (PC),
        .b (imm_out),
        .y (branch_target)
    );
 
    // Branch condition
    assign branch_taken = Branch & alu_zero;
 
    // PC Mux
    Mux2_32 pc_mux (
        .a   (pc_plus4),
        .b   (branch_target),
        .sel (branch_taken),
        .y   (next_PC)
    );
 
    // PC Register
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            PC <= 32'b0;
        else
            PC <= next_PC;
    end
 
    // Debug signals
    assign alu_result = alu_result_temp;
 
    always @(posedge clk) begin
        if (reset_n && (PC != next_PC)) begin
            $display("[%0t] PC=%h | instr=%h | opcode=%b | RegWrite=%b | ALUOp=%b | ALUResult=%h",
                     $time, PC, instr, opcode, RegWrite, ALUOp, alu_result_temp);
        end
    end
 
    assign debug_led = PC[7:0];
 
endmodule
