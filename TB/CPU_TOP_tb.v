// CPU_TOP_tb.v (Testbench)
// ============================================
`timescale 1ns/1ps
 
module CPU_TOP_tb;
 
    reg clk;
    reg reset_n;
 
    CPU_TOP dut (
        .clk     (clk),
        .reset_n (reset_n),
        .debug_led ()    
    );
 
    // Clock: 10ns period (100MHz)
    always #5 clk = ~clk;
 
    // Monitor signals
    initial begin
        $display("==========================================================================");
        $display("RISC-V Processor Simulation Starting");
        $display("==========================================================================");
        $display("Time(ns)    PC          Instruction  ALUResult    MemRead MemWrite RegWrite");
        $display("==========================================================================");
    end
 
    always @(posedge clk) begin
        if (reset_n)
            $display("%0t      %h  %h  %h      %b       %b        %b",
                     $time, dut.PC, dut.instr, dut.alu_result,
                     dut.MemRead, dut.MemWrite, dut.RegWrite);
    end
 
    initial begin
        clk     = 0;
        reset_n = 0;
 
        #20;
        reset_n = 1;
 
        #200;
 
        $display("\n");
        $display("==========================================================================");
        $display("SIMULATION COMPLETE - RESULTS");
        $display("==========================================================================");
 
        $display("\n=== REGISTER FILE CONTENTS ===");
        $display("x1  = 0x%h (%0d)", dut.reg_file.regs[1],  dut.reg_file.regs[1]);
        $display("x2  = 0x%h (%0d)", dut.reg_file.regs[2],  dut.reg_file.regs[2]);
        $display("x3  = 0x%h (%0d)", dut.reg_file.regs[3],  dut.reg_file.regs[3]);
        $display("x4  = 0x%h (%0d)", dut.reg_file.regs[4],  dut.reg_file.regs[4]);
        $display("x6  = 0x%h (%0d)", dut.reg_file.regs[6],  dut.reg_file.regs[6]);
        $display("x7  = 0x%h (%0d)", dut.reg_file.regs[7],  dut.reg_file.regs[7]);
        $display("x8  = 0x%h (%0d)", dut.reg_file.regs[8],  dut.reg_file.regs[8]);
        $display("x9  = 0x%h (%0d)", dut.reg_file.regs[9],  dut.reg_file.regs[9]);
 
        $display("\n=== DATA MEMORY CONTENTS ===");
        for (integer i = 0; i < 10; i = i + 1) begin
            if (dut.data_mem.memory[i] != 0) begin
                $display("Byte Address %0d (Word %0d) = 0x%h",
                         i * 4,
                         i,
                         dut.data_mem.memory[i]);
            end
        end
 
        $display("\n=== EXECUTION SUMMARY ===");
        $display("Final PC = 0x%h", dut.PC);
        $display("Total instructions = %0d", dut.PC / 4);
 
        $display("\n==========================================================================");
        $display("Simulation Finished Successfully");
        $display("==========================================================================");
 
        $finish;
    end
 
endmodule
