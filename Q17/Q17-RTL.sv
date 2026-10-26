// Question 17: Design clock divider logic for divide by 2,3,4,5. 

module Q17 #(
  parameter int N = 2
)(
  input logic ick,
  input logic rst_n,
  output logic ock
);
  logic [$clog2(N)-1:0] count;
  logic even;
  assign even = (N%2 == 0);
  logic posedge_data, negedge_data;
  assign ock = posedge_data | negedge_data;
  
  // set count
  always_ff @ (posedge ick or negedge rst_n) begin
    if (~rst_n) begin
      	count <= 0;
    end else begin
      	count <= count + 1'b1;
      if (count == N-1) begin
         	count <= 0; // on prev cycle, count == N-1, next cycle count = 0
        end
    end
  end
  
  // set output ock
  always_ff @ (posedge ick or negedge rst_n) begin
    if(~rst_n)begin
      	posedge_data <= '0;
    end else begin
    	// EVEN
      if(even)begin
        if (count == N/2 || count == '0) begin
          	posedge_data <= ~posedge_data;
        end
      end else begin // ODD
        if (count == (N-1)/2 || count == '0) begin
          	posedge_data <= ~posedge_data;
        end
      end
      
    end
  end

    
  always_ff @ (negedge ick or negedge rst_n) begin
    if (~rst_n) begin
      negedge_data <= '0;
    end else begin
      // EVEN
      if (even) begin
        	negedge_data <= '0;
      // ODD
      end else begin
        	negedge_data <= posedge_data;
      end
    end
  end
 
endmodule
