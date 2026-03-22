// ОСНОВНОЙ МОДУЛЬ ПРОЦЕССОРА С 8-БИТНЫМИ КОМАНДАМИ

module PROCESSOR_CORE(
    input  wire        CLK,              // Тактовый сигнал
    input  wire        RESET,            // Сигнал сброса
    input  wire        SENSOR_DISTANCE,  // Сигнал датчика расстояния (1 - препятствие)
    input  wire        SENSOR_SOUND,     // Сигнал датчика звука (1 - звук)
    output wire        MOTOR_LEFT,       // Управление левым мотором (1 - вперед)
    output wire        MOTOR_RIGHT,      // Управление правым мотором (1 - вперед)
    output wire [3:0]  MEM_ADDR,         // Адрес памяти (4 бита) - 16 ячеек
    input  wire [6:0]  MEM_DATA         // Данные памяти (8 бит) - команда
    //output wire        MEM_READ          // Сигнал чтения памяти (1 - чтение)
);

    // ============================================================================
    // ДЕКОДИРОВАНИЕ КОМАНДЫ
    // ============================================================================
    
    // Формат команды: [7:5] - код операции, [4:0] - операнд
    wire [2:0] OPCODE = MEM_DATA[6:4];  // 3 бита - код операции
    wire [4:0] OPERAND = MEM_DATA[3:0];
    // Разбиение операнда для разных команд:
    wire [3:0] JUMP_ADDR = OPERAND[3:0];    // Для JMP/JS/JD - адрес перехода
    wire [1:0] MOTOR_CTRL = OPERAND[1:0];   // Для OUT - управление моторами
    wire [3:0] WAIT_TIME = OPERAND[3:0];
    
    // ============================================================================
    // ВНУТРЕННИЕ СИГНАЛЫ ПРОЦЕССОРА
    // ============================================================================
    
    wire CMD_WAIT_N, CMD_OUT, CMD_JMP_N, CMD_JS_N, CMD_JD_N;
    wire WAIT_ACTIVE_N;
    wire SENSOR_DISTANCE_N, SENSOR_SOUND_N;  
    wire PC_LOAD_N, RESET_LOW;
    
    // ============================================================================
    // ИНВЕРТОР
    // ============================================================================
    
    INVERTER_74HC04 INVERT_RESET(
        .A1(RESET), .Y1(RESET_LOW),
        .A2(SENSOR_DISTANCE), .Y2(SENSOR_DISTANCE_N),
        .A3(SENSOR_SOUND), .Y3(SENSOR_SOUND_N)
    );
     
    // ============================================================================
    // ДЕКОДЕР КОМАНД
    // ============================================================================
    
    COMMAND_DECODER command_decoder(
        .OPCODE(OPCODE),
        .RESET_LOW(RESET_LOW),
        .CMD_WAIT_N(CMD_WAIT_N),
        .CMD_OUT(CMD_OUT), 
        .CMD_JMP_N(CMD_JMP_N),
        .CMD_JS_N(CMD_JS_N),
        .CMD_JD_N(CMD_JD_N)
    );

    // ============================================================================
    // МОДУЛЬ УПРАВЛЕНИЯ ПЕРЕХОДАМИ
    // ============================================================================
    
    JUMP_MANAGER jump_manager(
        .CMD_JMP_N(CMD_JMP_N),
        .CMD_JS_N(CMD_JS_N),
        .CMD_JD_N(CMD_JD_N),
        .SENSOR_DISTANCE_N(SENSOR_DISTANCE_N),
        .SENSOR_SOUND_N(SENSOR_SOUND_N),
        .PC_LOAD_N(PC_LOAD_N)
    );

    // ============================================================================
    // СЧЕТЧИК КОМАНД
    // ============================================================================
    
    PROGRAM_COUNTER program_counter(
        .CLK(CLK),
        .RESET_LOW(RESET_LOW),
        .WAIT_ACTIVE_N(WAIT_ACTIVE_N),
        .PC_LOAD_N(PC_LOAD_N),
        .JUMP_ADDR(JUMP_ADDR),
        .MEM_ADDR(MEM_ADDR)
    );

    // ============================================================================
    // УПРАВЛЕНИЕ МОТОРАМИ
    // ============================================================================
    
    MOTOR_MANAGER motor_manager(
        .CMD_OUT(CMD_OUT),
        .RESET_LOW(RESET_LOW),
        .MOTOR_CTRL(MOTOR_CTRL),
        .MOTOR_LEFT(MOTOR_LEFT),
        .MOTOR_RIGHT(MOTOR_RIGHT)
    );

    // ============================================================================
    // УПРАВЛЕНИЕ ЗАДЕРЖКОЙ
    // ============================================================================
    
    DELAY_MANAGER delay_manager(
        .CMD_WAIT_N(CMD_WAIT_N),
        .CLK(CLK),
        .WAIT_TIME(WAIT_TIME),
        .WAIT_ACTIVE_N(WAIT_ACTIVE_N)
    );

endmodule