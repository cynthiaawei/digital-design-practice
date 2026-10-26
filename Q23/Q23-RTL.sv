// Question 23: Clock divide by 10 with a duty cycle of 40

module Q23 (
  input logic ick,
  input logic rst_n,
  output logic ock
);
  logic [$clog2(10)-1:0] count;

  // set count
  always_ff @ (posedge ick or negedge rst_n) begin
    if (~rst_n) begin
      	count <= 0;
    end else begin
      	count <= count + 1'b1;
      if (count == 9) begin
         	count <= 0; // on prev cycle, count == N-1, next cycle count = 0
        end
    end
  end
  
  // set output ock
  always_ff @ (posedge ick or negedge rst_n) begin
    if(~rst_n)begin
      	ock <= '0;
    end else begin
      if (count == 4 || count == '0) begin
          	ock <= ~ock;
      end
    end 
  end

    
endmodule
