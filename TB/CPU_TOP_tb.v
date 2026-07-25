module CPU_TOP_tb;

    reg clk;
    reg reset_n;
    integer i;

    // Device under test
    CPU_TOP dut (
        .clk       (clk),
        .reset_n   (reset_n),
        .debug_led ()
    );

    initial begin 
        $display("Starting simulation...");

        /
     $readmemh(" path of file mem.dat  ", dut.instr_mem.memory);     // go to file mem.dat ex, C:/Users/ahmds/Desktop/RISC--V/ALU/mem.txt
        for (i = 0; i < 32; i = i + 1) begin
            dut.reg_file.regs[i] = 32'b0;       // Initialize register file to zero
        end
        for (i = 0; i < 64; i = i + 1) begin
            dut.data_mem.memory[i] = 32'b0;     // Initialize data memory to zero
        end

        reset_n = 0;
        clk     = 0; 
        forever #5 clk = ~clk;                  // Clock period of 10 time units
    end

    initial begin
        #1000;
        for (i = 0; i < 64; i = i + 1) begin
            if (dut.data_mem.memory[i] != 0)
             $display("Byte Address %0d (Word %0d) = 0x%h", i*4, i, dut.data_mem.memory[i]); 
        end
        $display("Simulation Finished Successfully");
        $stop;                                  // Stop after 1000 time units
    end

endmodule
