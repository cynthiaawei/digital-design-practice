// Question 1: write a fixed priority arbiter with decreasing priority from LSB to MSB

module Q1 #(
    parameter int N = 8
)(

input logic req [N:0];
output logic gnt [N:0];

always_comb begin
    for (int i = N-1; i = 0; i--) begin
        if (req[i]) begin
            gnt = '0 | (1'b1 >> i);
        end
    end
end

)endmodule