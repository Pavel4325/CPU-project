echo "=== НАЧАЛО КОМПИЛЯЦИИ ==="

iverilog -Wall -Wno-timescale -g2012 -o robot_test \
    cpu/*.v chips/*.v test_bench/test_bench.v

COMPILE_RESULT=$?

echo "=== РЕЗУЛЬТАТ КОМПИЛЯЦИИ (код: $COMPILE_RESULT) ==="

if [ $COMPILE_RESULT -eq 0 ]; then
    read -p "Продолжить выполнение симуляции? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "=== ЗАПУЩЕНА СИМУЛЯЦИЯ ==="
        vvp robot_test > simulation.log 2>&1
    else
        echo "Выполнение прервано пользователем"
        exit 0
    fi
else
    echo "!!! КОМПИЛЯЦИЯ ПРОВАЛЕНА - СИМУЛЯЦИЯ НЕ ЗАПУЩЕНА !!!"
    exit 1
fi