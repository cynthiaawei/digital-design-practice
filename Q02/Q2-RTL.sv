// Question 2: RTL for a fixed priority arbiter with decreasing priority from MSB to LSB

module Q2 #(
  parameter int N=8
)(
  input logic [N-1:0] req,
  output logic [N-1:0] gnt
);
  logic found;
  always_comb begin
    gnt = '0;
    found = '0;
    for(int i = N-1; i>=0; i--)begin
      if(req[i] & ~found) begin
        gnt[i] = 1'b1;
        found = '1;
      end
    end
  end
  
endmodule