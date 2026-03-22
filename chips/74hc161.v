
module COUNTER_4BIT_74HC161(
    input MR,      // Асинхронный сброс (активный LOW)
    input CLK,
    input ENP,
    input ENT,
    input LOAD,    // Загрузка (активный LOW)
    input D0, D1, D2, D3,
    output reg Q0, Q1, Q2, Q3,
    output RCO
);
    reg [3:0] counter;
    
    always @(posedge CLK or negedge MR) begin
        if (!MR)
            counter <= 4'b0000;
        else if (!LOAD)
            counter <= {D3, D2, D1, D0};
        else if (ENP && ENT)
            counter <= counter + 1'b1;
    end
    
    assign {Q3, Q2, Q1, Q0} = counter;
    assign RCO = (counter == 4'b1111) && ENP && ENT;
endmodule