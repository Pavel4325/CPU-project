// МОДУЛЬ УПРАВЛЕНИЯ ЗАДЕРЖКОЙ

module DELAY_MANAGER(
    input  wire CMD_WAIT_N,
    input wire  CLK, 
    input wire [3:0] WAIT_TIME,
    output wire WAIT_ACTIVE_N
);

    wire [3:0] time_up;
    wire [3:0] compare_time;
    wire [1:0] temporary_comparer;
    wire wait_act, wait_act_n;

    IC_74HC4060_COUNT DELAY_COUNT(
        .CLK_IN(CLK),        // Clock Input (pin 9) - тактовый вход
        .CLK_INHIBIT(1'b0),  // Clock Inhibit (pin 10) - запрет тактирования
        .RESET(CMD_WAIT_N),  // Reset (pin 11) - асинхронный сброс
        .Q8(time_up[0]),
        .Q9(time_up[1]),
        .Q10(time_up[2]),
        .Q12(time_up[3])
    );

    XOR_GATE_74HC86 COMPARE_TIME(
        .A1(time_up[0]), .B1(WAIT_TIME[0]), .Y1(compare_time[0]),
        .A2(time_up[1]), .B2(WAIT_TIME[1]), .Y2(compare_time[1]),
        .A3(time_up[2]), .B3(WAIT_TIME[2]), .Y3(compare_time[2]),
        .A4(time_up[3]), .B4(WAIT_TIME[3]), .Y4(compare_time[3])
    );

    OR_GATE_74HC32 LOGIC_DELAY(
        .A1(compare_time[0]), .B1(compare_time[1]), .Y1(temporary_comparer[0]),
        .A2(compare_time[2]), .B2(compare_time[3]), .Y2(temporary_comparer[1]),
        .A3(temporary_comparer[0]), .B3(temporary_comparer[1]), .Y3(wait_act),
        .A4(wait_act_n), .B4(CMD_WAIT_N), .Y4(WAIT_ACTIVE_N)
    );

    INVERTER_74HC04 Invert_DELAY_LOGIC(
        .A1(wait_act), .Y1(wait_act_n)
    );

endmodule