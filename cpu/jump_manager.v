// МОДУЛЬ УПРАВЛЕНИЯ ПЕРЕХОДАМИ

module JUMP_MANAGER(
    input  wire CMD_JMP_N,
    input  wire CMD_JS_N, 
    input  wire CMD_JD_N,
    input  wire SENSOR_DISTANCE_N,
    input  wire SENSOR_SOUND_N,
    output wire PC_LOAD_N
);

    // Внутренние сигналы
    wire jump_distance_temp_n;
    wire jump_sound_temp_n;
    wire jump_conddition_n;
    
    AND_GATE_74HC08 jump_controller(
        .A1(jump_sound_temp_n), .B1(jump_distance_temp_n), .Y1(jump_conddition_n), // sound or distance condition +
        .A2(jump_conddition_n), .B2(CMD_JMP_N), .Y2(PC_LOAD_N) // Управление загрузкой счетчика
        
    );

    OR_GATE_74HC32 jump_controller_or(
        .A1(CMD_JD_N), .B1(SENSOR_DISTANCE_N), .Y1(jump_distance_temp_n), // Условный переход по расстоянию
        .A2(CMD_JS_N), .B2(SENSOR_SOUND_N), .Y2(jump_sound_temp_n) // Условный переход по sound 
    );

endmodule