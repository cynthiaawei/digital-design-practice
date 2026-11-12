/*
    Fixed Point Summary:
    - used to store fractional numbers as plain integers
    - Notation: Qm.n , m is number if integer bits, n is number of fractional bits
    - Store Integer X : Decimal value = X / 2^n
 
    Converting
    - FP from decimal:
        eg. 1/3 = 0.333333 = 0.25 + 0.0625 + 0.015625 + 0.00390625 = 2^(-2) + 2^(-4) + 2^(-6) + 2^(-8)
    - multiplying a number by 2^-k = right shift the number by k
*/

module Q22 # (parameter int N = 4)( // allow N to be modifiable for accuracy
    input logic [7:0] R,
    input logic [7:0] G,
    input logic [7:0] B,
    output logic [7:0] grayscale
);
logic [10:0] sum;
always_comb begin
    sum = R + G + B; // u can later make it more accurate by left shifting then, and then after everything is done shift it back right by same amount
    grayscale = 0;
    for (int i = 1; i <= N; i++) begin
        grayscale = grayscale + ( sum >> (2*i) );
    end
end
endmodule