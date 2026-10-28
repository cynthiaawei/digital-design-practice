// Question 14: RTL for a 3-input sorting logic.

module Q14 #(
  parameter int N = 8
)(
  input logic [N:0] a,
  input logic [N:0] b,
  input logic [N:0] c,
  output logic [N:0] max,
  output logic [N:0] mid,
  output logic [N:0] min
);
  logic [N:0] temp;
  always_comb begin
    temp = '0;
    if (a >= b && a >= c) begin // a is max
      	max = a;
      	min = c;
      	mid = b;
    end else if (b > a && b >= c) begin // b is max
      	max = b;
      	min = c;
       	mid = a;
    end else begin // c is max
      	max = c;
      	min = b;
      	mid = a;
    end
    
    if (min > mid) begin
      	temp = min;
      	min = mid;
      	mid = temp;
    end
  end
      
endmodule