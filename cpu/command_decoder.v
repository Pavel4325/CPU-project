// МОДУЛЬ ДЕКОДЕРА КОМАНД

module COMMAND_DECODER(
    input  wire [2:0] OPCODE,
    input wire RESET_LOW,
    output wire CMD_WAIT_N,
    output wire CMD_OUT,
    output wire CMD_JMP_N, 
    output wire CMD_JS_N,
    output wire CMD_JD_N
);

    wire [7:0] decryptor_out_bus;
    wire CMD_OUT_N;

    DECRYPTOR_74HC138 command_decoder(
        .A(OPCODE),
        .E1_n(1'b0),
        .E2_n(1'b0),
        .E3(RESET_LOW),
        .Y_n(decryptor_out_bus)
    );

    assign {CMD_JD_N, CMD_JMP_N, CMD_JS_N, CMD_OUT_N, CMD_WAIT_N} = decryptor_out_bus[4:0];

    INVERTER_74HC04 Invert_cmd(
        .A1(CMD_OUT_N), .Y1(CMD_OUT)
    );

endmodule