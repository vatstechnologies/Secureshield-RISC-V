module firewall(

    input logic [31:0] addr,
    output logic alert
);

parameter SECURE_START = 32'h00000080;
parameter SECURE_END   = 32'h000000FF;

always_comb begin

    if(addr >= SECURE_START &&
       addr <= SECURE_END)
        alert = 1;
    else
        alert = 0;

end

endmodule
