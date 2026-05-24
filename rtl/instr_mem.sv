module instr_mem(
    input logic [31:0] addr,
    output logic [31:0] instruction
);

logic [31:0] mem [0:255];

initial begin

    mem[0] = 32'h002081B3;
    mem[1] = 32'h40310233;
    mem[2] = 32'h0020F2B3;
    mem[3] = 32'h0020E333;

end

assign instruction = mem[addr[9:2]];

endmodule
