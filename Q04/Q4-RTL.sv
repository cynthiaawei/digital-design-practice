// Question 4: RTL Design synchronous FIFO buffer for generic depth 

module Q4 #(
  parameter int DEPTH = 8,
  parameter int WIDTH = 4
)(
  input logic clk,
  input logic rst_n,
  input logic [WIDTH-1:0] wr_data,
  output logic [WIDTH-1:0] rd_data,
  input logic wr_en,
  input logic rd_en
);
  
  
  localparam int DEPTH_PTR_WIDTH = (DEPTH > 1) ? $clog2(DEPTH) : 1; // referenced chatgpt > need to account if FIFO size = 1
  
  logic [WIDTH-1:0] FIFO [DEPTH-1:0]; 
  
  logic [DEPTH_PTR_WIDTH-1:0] rd_ptr, wr_ptr; 
  
  logic full, empty;
  
  logic [$clog2(DEPTH+1)-1:0] count; // referenced chatgpt > COUNTER NEEDS TO SHOW OCCUPANCY FROM 0 TO DEPTH
  
 
  
  // full & empty conditions
  always_comb begin
    full = (count == DEPTH);
    empty = (count == '0);
  end
  
  
  // WRITE FF
  always_ff @(posedge clk or negedge rst_n) begin
      if(~rst_n)begin
          wr_ptr <= '0;
      end else begin
        if (wr_en & ~full) begin
          	  FIFO[wr_ptr] <= wr_data;
              wr_ptr <= wr_ptr == DEPTH-1 ? '0 : wr_ptr + 1'b1; // pointer wrap around logic 
          end else begin
              wr_ptr <= wr_ptr;
          end
      end	
  end
      
      
  // READ FF       
  always_ff @(posedge clk or negedge rst_n) begin
      if(~rst_n)begin
         rd_ptr <= '0;
         rd_data <= '0;
      end else begin
        if (rd_en & ~empty) begin
           rd_data <= FIFO[rd_ptr];
           rd_ptr <= rd_ptr == DEPTH-1 ? '0 : rd_ptr + 1'b1;
         end else begin
           rd_ptr <= rd_ptr;
         end
      end
  end
        
  
  always_ff @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
      	count <= '0;
    end else begin
      case({rd_en & ~empty,wr_en & ~full})
        2'b10: count <= count - 1;
        2'b01: count <= count + 1;
        default: count <= count;
       endcase
    end
  end
  
endmodule
