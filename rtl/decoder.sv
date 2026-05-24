module decoder(
    input logic [31:0] instruction,

    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,

    output logic [2:0] alu_op
);

assign rd  = instruction[11:7];
assign rs1 = instruction[19:15];
assign rs2 = instruction[24:20];

always_comb begin

    case(instruction[14:12])

        3'b000: alu_op = 3'b000;
        3'b001: alu_op = 3'b001;
        3'b111: alu_op = 3'b010;
        3'b110: alu_op = 3'b011;

        default: alu_op = 3'b000;

    endcase

end

endmodule
