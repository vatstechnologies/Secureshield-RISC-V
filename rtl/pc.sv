module pc(
    input logic clk,
    input logic rst,
    input logic enable,
    output logic [31:0] pc
);

always_ff @(posedge clk or posedge rst) begin
    if(rst)
        pc <= 0;
    else if(enable)
        pc <= pc + 4;
end

endmodule
