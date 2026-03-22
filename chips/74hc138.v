
module DECRYPTOR_74HC138(
    input [2:0] A,
    input E1_n, E2_n, E3,
    output [7:0] Y_n
);
    wire enable = E3 & ~E1_n & ~E2_n;
    
    assign Y_n[0] = ~(enable & (A == 3'b000));
    assign Y_n[1] = ~(enable & (A == 3'b001));
    assign Y_n[2] = ~(enable & (A == 3'b010));
    assign Y_n[3] = ~(enable & (A == 3'b011));
    assign Y_n[4] = ~(enable & (A == 3'b100));
    assign Y_n[5] = ~(enable & (A == 3'b101));
    assign Y_n[6] = ~(enable & (A == 3'b110));
    assign Y_n[7] = ~(enable & (A == 3'b111));
endmodule