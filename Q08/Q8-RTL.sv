/*
From claude: 
- appending a binary value from LSB doubles the number and adds the bit
- kinda like how you add a number from the right in decimal, it mulitples the number by 10 and adds the digit
*/

module Q8 (
    input logic clk, 
    input logic rstn, 
    input logic lsb, 
    output logic divisible
);

localparam logic [1:0] R0 = 2'b00, R1 = 2'b01, R2 = 2'b10;
logic [1:0] state, next_state;

always_comb begin
    case (state)
        R0: if (lsb) next_state = R1; else next_state = R0;
        R1: if (lsb) next_state = R0; else next_state = R2;
        R2: if (lsb) next_state = R2; else next_state = R1;
        default: next_state = R0;
    endcase
    
    if (state == R0) divisible = 1; else divisible = 0;
end

always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn) begin
        state <= R0;
    end else begin
        state <= next_state;
    end
end

endmodule