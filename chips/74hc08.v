// 74hc08.v - Quad 2-input AND Gate

module AND_GATE_74HC08(
    input A1, B1, output Y1,
    input A2, B2, output Y2,
    input A3, B3, output Y3,
    input A4, B4, output Y4
);
    assign Y1 = A1 & B1;
    assign Y2 = A2 & B2;
    assign Y3 = A3 & B3;
    assign Y4 = A4 & B4;
endmodule