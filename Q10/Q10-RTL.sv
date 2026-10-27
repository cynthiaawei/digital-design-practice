// Question 10: RTL for binary to gray and gray to binary logic.

module Q10 #(
  parameter int N = 5
  
)(
  input logic [N-1:0] data,
  output logic [N-1:0] gray,
  output logic [N-1:0] binary
);
  
  always_comb begin
    gray = data ^ (data >>1);
    
    for(int i = 0; i < N; i++) begin
      binary[i] =^ (gray >> i);
    end
  end
  
  
endmodule