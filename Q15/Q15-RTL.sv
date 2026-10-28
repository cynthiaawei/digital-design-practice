// Question 15: RTL for three input Median circuit

module Q15 #(
  parameter int N = 8
)(
  input logic [N:0] a,
  input logic [N:0] b,
  input logic [N:0] c,
  output logic [N:0] mid
);
  logic [N:0] temp;
  logic [N:0] min;
  logic [N:0] max;
  
  always_comb begin
    temp = '0;
	max = a;
    mid = b;
    min = c;
    
    if (max < mid) begin
      temp = max;
      max = mid;
      mid = temp;
    end 
    
    if (mid < min) begin
      temp = mid;
      mid = min;
      min = temp;
    end
    
    if (max < mid) begin
      temp = max;
      max = mid;
      mid = temp;
    end
  end
      
endmodule