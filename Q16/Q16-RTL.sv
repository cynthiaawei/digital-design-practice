/*
    asked claude how to determine output bit size
    claude said to first determine max N to determine max bit size
 
    with 33 bits [32:0], max N for fibonnaci is: 48, max N for factorial is 13
*/

module Q16 #(parameter int N = 8)(
    input logic clk,
    input logic rstn,
    output logic [32:0] factorial,
    output logic [32:0] fibonnaci
);

logic [32:0] f1, f0; 
logic [$clog2(32)-1:0] count;

always_ff @ (posedge clk or negedge rstn) begin
    if(~rstn) begin
        fibonnaci <= '0;
        factorial <= 1'b1;
        f1 <= 1'b1;
        f0 <= '0;
        count <= '0;
    end else begin
    if (count < N-1) begin
        fibonnaci <= f1 + f0;
        f0 <= f1;
        f1 <= f1 + f0;
        factorial <= factorial * (count+2'b10);
        count <= count + 1;
    end if (N==1) begin
        fibonnaci <= 1'b1; // edge case if N = 1
    end
    end
end

endmodule