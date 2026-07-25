module DataMemory(
    input             clk,
    input      [31:0] addr,
    input      [31:0] write_data,
    input             WE,   // enable to write
    output reg [31:0] read_data
);

    reg [31:0] memory [0:63];
    wire [5:0] mem_addr = addr[7:2];
    integer k;

always@(*) begin
  read_data = memory [addr[31:2]];     // read from memory
end
 
 always@(posedge clk)begin
     if (WE)
       memory [addr[31:2]] <= write_data;   // write in memory
     end
     endmodule
