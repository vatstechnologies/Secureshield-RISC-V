module uart_tx(

    input logic clk,
    input logic rst,

    input logic start,
    input logic [7:0] data,

    output logic tx
);

logic [3:0] bit_index;
logic [9:0] shift_reg;

always_ff @(posedge clk or posedge rst) begin

    if(rst) begin

        tx <= 1;
        bit_index <= 0;

    end

    else begin

        if(start) begin

            shift_reg <= {1'b1, data, 1'b0};
            bit_index <= 0;

        end

        else if(bit_index < 10) begin

            tx <= shift_reg[bit_index];
            bit_index <= bit_index + 1;

        end

    end

end

endmodule
