module intrusion_detector(

    input logic clk,
    input logic illegal_access,

    output logic intrusion_detected
);

logic [3:0] counter;

always_ff @(posedge clk) begin

    if(illegal_access)
        counter <= counter + 1;

    if(counter > 3)
        intrusion_detected <= 1;
    else
        intrusion_detected <= 0;

end

endmodule
