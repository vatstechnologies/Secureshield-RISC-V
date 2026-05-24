module attack_monitor(

    input logic clk,
    input logic intrusion,

    output logic attack_detected
);

logic [7:0] attack_counter;

always_ff @(posedge clk) begin

    if(intrusion)
        attack_counter <= attack_counter + 1;

    if(attack_counter > 5)
        attack_detected <= 1;

end

endmodule
