
module IC_74HC4060_COUNT(
    input CLK_IN,
    input CLK_INHIBIT,
    input RESET,   // Асинхронный сброс (активный HIGH)
    output Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14
);
    reg [13:0] counter;
    
    always @(posedge CLK_IN or posedge RESET) begin
        if (RESET)
            counter <= 14'b00000000000000;
        else if (!CLK_INHIBIT)
            counter <= counter + 1'b1;
    end
    
    assign Q4  = counter[4];
    assign Q5  = counter[5];
    assign Q6  = counter[6];
    assign Q7  = counter[7];
    assign Q8  = counter[8];
    assign Q9  = counter[9];
    assign Q10 = counter[10];
    assign Q11 = counter[11];
    assign Q12 = counter[12];
    assign Q13 = counter[13];
    assign Q14 = counter[14];
endmodule