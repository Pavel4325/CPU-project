
module D_FLIPFLOP_74HC74(
    input CLK1, RESET1, SET1, D1, output reg Q1, output QN1,
    input CLK2, RESET2, SET2, D2, output reg Q2, output QN2
);
    always @(posedge CLK1 or negedge RESET1 or negedge SET1) begin
        if (!RESET1)
            Q1 <= 1'b0;
        else if (!SET1)
            Q1 <= 1'b1;
        else
            Q1 <= D1;
    end
    assign QN1 = ~Q1;

    always @(posedge CLK2 or negedge RESET2 or negedge SET2) begin
        if (!RESET2)
            Q2 <= 1'b0;
        else if (!SET2)
            Q2 <= 1'b1;
        else
            Q2 <= D2;
    end
    assign QN2 = ~Q2;
endmodule