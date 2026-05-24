module cpu_top(
    input logic clk,
    input logic rst,
    output logic uart_tx_line
);

logic [31:0] pc;
logic [31:0] instruction;

logic [31:0] rs1_data;
logic [31:0] rs2_data;
logic [31:0] alu_result;

logic [4:0] rs1;
logic [4:0] rs2;
logic [4:0] rd;

logic [2:0] alu_op;

logic firewall_alert;
logic intrusion_alert;
logic boot_ok;

logic uart_start;
logic [7:0] uart_data;

//////////////////////////////////////////
// SECURE BOOT
//////////////////////////////////////////

secure_boot BOOT(
    .clk(clk),
    .rst(rst),
    .boot_ok(boot_ok)
);

//////////////////////////////////////////
// PROGRAM COUNTER
//////////////////////////////////////////

pc PC(
    .clk(clk),
    .rst(rst),
    .enable(boot_ok),
    .pc(pc)
);

//////////////////////////////////////////
// INSTRUCTION MEMORY
//////////////////////////////////////////

instr_mem IMEM(
    .addr(pc),
    .instruction(instruction)
);

//////////////////////////////////////////
// DECODER
//////////////////////////////////////////

decoder DEC(
    .instruction(instruction),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .alu_op(alu_op)
);

//////////////////////////////////////////
// REGISTER FILE
//////////////////////////////////////////

regfile RF(
    .clk(clk),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(alu_result),
    .reg_write(1'b1),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

//////////////////////////////////////////
// ALU
//////////////////////////////////////////

alu ALU(
    .a(rs1_data),
    .b(rs2_data),
    .op(alu_op),
    .result(alu_result)
);

//////////////////////////////////////////
// FIREWALL
//////////////////////////////////////////

firewall FW(
    .addr(alu_result),
    .alert(firewall_alert)
);

//////////////////////////////////////////
// INTRUSION DETECTOR
//////////////////////////////////////////

intrusion_detector IDS(
    .clk(clk),
    .illegal_access(firewall_alert),
    .intrusion_detected(intrusion_alert)
);

//////////////////////////////////////////
// UART LOGGER
//////////////////////////////////////////

assign uart_start = intrusion_alert;
assign uart_data  = 8'h41;

uart_tx UART(
    .clk(clk),
    .rst(rst),
    .start(uart_start),
    .data(uart_data),
    .tx(uart_tx_line)
);

endmodule
