module (
    input             clk,
    input      [31:0] addr,
    input      [31:0] write_data,
    input             WE,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:63];
    integer j;
 
    // FIX: Use named slice to suppress unconnected addr[31:8] warnings
    wire [5:0] mem_addr = addr[7:2];
 
    initial begin
        for (j = 0; j < 64; j = j + 1)
            memory[j] = 32'b0;
        $display("DataMemory initialized");
    end
 
    always @(*) begin
        read_data = memory[mem_addr];
    end
 
    always @(posedge clk) begin
        if (WE) begin
            memory[mem_addr] <= write_data;
            $display("[%0t] DataMemory WRITE: addr=%h, data=%h", $time, addr, write_data);
        end
    end
