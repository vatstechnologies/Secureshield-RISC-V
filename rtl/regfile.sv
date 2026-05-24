module regfile(

    input logic clk,

    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,

    input logic [31:0] write_data,
    input logic reg_write,

    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);

logic [31:0] registers [0:31];

integer i;

initial begin
    for(i=0;i<32;i=i+1)
        registers[i] = i;
end

always_ff @(posedge clk) begin

    if(reg_write && rd != 0)
        registers[rd] <= write_data;

end

assign rs1_data = registers[rs1];
assign rs2_data = registers[rs2];

endmodule
