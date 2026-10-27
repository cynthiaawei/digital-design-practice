// Question 7: RTL and Circuit for a Pulse Synchronization Circuit 

module Q7 (
  input logic data,
  output logic pulse,
  input logic clk_A,
  input logic clk_B,
  input logic rst_n
);
  
  logic QA, QB_1, QB_2, QB_3;
  
  assign pulse = QB_2 ^ QB_3;
  
  always_ff @ (posedge clk_A or negedge rst_n) begin
    if (~rst_n) begin
      QA <= '0;
    end else begin
      if (data) begin
        QA <= ~QA;
      end
    end
  end
  
  always_ff @ (posedge clk_B or negedge rst_n) begin
    if (~rst_n) begin
      	QB_1 <= '0;
      	QB_2 <= '0;
      	QB_3 <= '0;
    end else begin
      	QB_1 <= QA;
      	QB_2 <= QB_1;
      	QB_3 <= QB_2;
    end
  end
  
endmodule