module secure_boot(

    input logic clk,
    input logic rst,

    output logic boot_ok
);

logic [31:0] expected_hash;
logic [31:0] firmware_hash;

logic [3:0] state;

always_ff @(posedge clk or posedge rst) begin

    if(rst) begin

        expected_hash <= 32'hDEADBEEF;
        firmware_hash <= 32'hDEADBEEF;

        state <= 0;
        boot_ok <= 0;

    end

    else begin

        case(state)

            0: state <= 1;

            1: begin

                if(expected_hash == firmware_hash)
                    boot_ok <= 1;
                else
                    boot_ok <= 0;

                state <= 2;

            end

        endcase

    end

end

endmodule
