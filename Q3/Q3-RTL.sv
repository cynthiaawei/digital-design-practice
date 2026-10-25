// Question 3: Implement a Round-Robin Arbiter with 3 I/p requests

module Q3 (
  input logic clk,
  input logic rst_n,
  input logic [2:0] req,
  output logic [2:0] gnt
);
  logic [1:0] prev;
  logic [1:0] curr;
  logic wrap_around;
  
  
  always_comb begin
    wrap_around = '1;
    curr = prev;
    for(int i = 2; i>=0; i--)begin
      if(req[i] & i > prev) begin
        curr = i;
        wrap_around = '0;
      end else if (req[i] & wrap_around) begin
        curr = i;
      end 
    end
  end
    
    always_ff @(posedge clk or negedge rst_n) begin
      if(~rst_n)begin
        gnt <= '0;
        prev <= 2;
      end else begin
        prev <= curr;
        for(int i = 0; i<3; i++) begin
          if(i == curr & req[i]) begin
            gnt[i] <= '1;
          end else begin
            gnt [i] <= '0;
          end
        end
      end
    end
  
endmodule