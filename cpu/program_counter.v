// МОДУЛЬ СЧЕТЧИКА КОМАНД

module PROGRAM_COUNTER(
    input  wire CLK,
    input  wire RESET_LOW,
    input  wire WAIT_ACTIVE_N,
    input  wire PC_LOAD_N, 
    input  wire [3:0] JUMP_ADDR,
    output wire [3:0] MEM_ADDR
);

    COUNTER_4BIT_74HC161 pc_counter(
        .MR(RESET_LOW),           // Сброс (активный низкий)
        .CLK(CLK),                // Тактовый сигнал  
        .ENP(1'b1),               // Разрешение счета от контроля состояни ???????????????????????????????
        .ENT(WAIT_ACTIVE_N),      // Отсутствие задержки
        .LOAD(PC_LOAD_N),         // Загрузка (активный низкий)
        .D0(JUMP_ADDR[0]), .D1(JUMP_ADDR[1]), .D2(JUMP_ADDR[2]), .D3(JUMP_ADDR[3]),
        .Q0(MEM_ADDR[0]), .Q1(MEM_ADDR[1]), .Q2(MEM_ADDR[2]), .Q3(MEM_ADDR[3]),
        .RCO()
    );

endmodule