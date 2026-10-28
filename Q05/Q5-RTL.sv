// Question 5: Improve FIFO for high speed - registered flags, registered read (what additional logic will be needed to make sure we can still write and read to same address in consecutive cycles)

module Q5 #(
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
  
  
  localparam int DEPTH_PTR_WIDTH = (DEPTH > 1) ? $clog2(DEPTH) : 1;
  
  logic [WIDTH-1:0] FIFO [DEPTH-1:0]; 
  
  logic [DEPTH_PTR_WIDTH-1:0] rd_ptr, wr_ptr; 
  
  logic full, empty;
  
  logic write_through, replace;
  
  logic [$clog2(DEPTH+1)-1:0] count, count_next; // COUNTER NEEDS TO SHOW OCCUPANCY FROM 0 TO DEPTH
  
  always_comb begin
    write_through = wr_en & rd_en & empty;
    replace = wr_en & rd_en & full;
  end
  
  // WRITE FF
  always_ff @(posedge clk or negedge rst_n) begin
      if(~rst_n)begin
          wr_ptr <= '0;
      end else begin
        if ((wr_en & ~full & !write_through) || replace) begin // need to exclude write_through
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
        end else if (write_through) begin
            rd_data <= wr_data;
          	rd_ptr <= rd_ptr;
        end else begin
           rd_ptr <= rd_ptr;
         end
      end
  end
  
  always_comb begin // COMBINATIONALLY determine the count on the next posedge based on current inputs
    case({rd_en & ~empty & !replace,wr_en & ~full & ~write_through}) // needs to account for right_through & replace
        2'b10: count_next = count - 1;
        2'b01: count_next = count + 1;
        default: count_next = count;
      endcase
  end
    
  
  always_ff @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
      	count <= '0;
      	full <= '0;
      	empty <= '1;
    end else begin
      count <= count_next; // SET the new current count to the combinationally determined next count 
      full <= (count_next == DEPTH); // DETERMINE full and empty based on the NEW CURRENT COUNT
      empty <= (count_next == '0);
    end
  end
  
endmodule
