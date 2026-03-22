// МОДУЛЬ УПРАВЛЕНИЯ МОТОРАМИ

module MOTOR_MANAGER(
    input  wire CMD_OUT,
    input  wire [1:0] MOTOR_CTRL,
    input  wire RESET_LOW, 
    output wire MOTOR_LEFT,
    output wire MOTOR_RIGHT
);

    D_FLIPFLOP_74HC74 REGISTR_OUT_MOTOR(
        .CLK1(CMD_OUT),            // Команда обновить значения
        .RESET1(RESET_LOW),        // Асинхронный сброс первого триггера (активный LOW) - Reset 1
        .D1(MOTOR_CTRL[0]),        // Вход данных первого триггера - Data 1
        .Q1(MOTOR_LEFT),           // Прямой выход первого триггера - Output 1    
        .CLK2(CMD_OUT),            // Команда обновить значения
        .RESET2(RESET_LOW),        // Асинхронный сброс второго триггера (активный LOW) - Reset 2
        .D2(MOTOR_CTRL[1]),        // Вход данных второго триггера - Data 2
        .Q2(MOTOR_RIGHT)           // Прямой выход второго триггера - Output 2
    );

endmodule