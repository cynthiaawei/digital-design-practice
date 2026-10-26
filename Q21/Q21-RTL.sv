// Question 21: RTL for a) the index of the first set bit in 32-bit input. b) Number of 1’s in 32-bit input signal.

module Q21 (
  input logic [31:0] num,
  output logic [5:0] count,
  output logic [5:0] index
);
  
  logic found;
  logic  [31:0]  shifted_num; 
  assign shifted_num = num >> 1;
  
  always_comb begin
    found = 0;
    count = 0;
    index = -1;
    for(int i=0; i<32; i++) begin
      if(((num >> i) & 1'b1) == 1'b1) begin
        	count = count + 1'b1;
        	if (~found) begin
        		index = i;
        		found = '1;
            end
      end
    end
  end
  
endmodule