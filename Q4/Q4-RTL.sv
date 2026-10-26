// Question 4: RTL Design synchronous FIFO buffer for generic depth 

module Q4 #(
  parameter int DEPTH = 8,
  parameter int WIDTH = 4
)(
  input logic clk,
  input logic rst_n,
  input logic [WIDTH-1:0] write_input,
  output logic [WIDTH-1:0] read_output,
  input logic wr_en,
  input logic rw_en
);
  logic [WIDTH-1:0] FIFO [DEPTH-1:0]; // unpacked array (access horizontally)
  logic [$clog2(DEPTH)-1:0] read_ptr, write_ptr; // eg. depth = 0, these are [3-1:0]
  logic full, empty, read_success, write_success, bypass;
  logic [$clog2(DEPTH+1)-1:0] count; // COUNTER NEEDS TO BE 1 BIT BIGGER THAN FIFO SIZE (EXTRA BIT FOR EMPTY)
  
  // SET FULL & EMPTY AND ARRAY DEFAULT
  assign full = (count == DEPTH);
  assign empty = (count == '0);
  
  assign bypass = (read_ptr==write_ptr) & rw_en & wr_en;
  assign write_success = bypass || (wr_en & ~full);
  assign read_success = bypass || (rw_en & ~empty);
  
  
  // WRITE FF
  always_ff @(posedge clk or negedge rst_n) begin
      if(~rst_n)begin
          write_ptr <= '0;
      end else begin
          if (wr_en) begin
              if((write_ptr == read_ptr) & rw_en & empty) begin // write-through logic
                    write_ptr <= write_ptr;
              end else if (~full || (full & rw_en)) begin // normal logic OR rw & wr when full logic
                    FIFO[write_ptr] <= write_input;
                    write_ptr <= write_ptr == DEPTH-1 ? '0 : write_ptr + 1'b1; // pointer wrap around logic
              end 
          end else begin
              write_ptr <= write_ptr;
          end
      end	
  end
      
      
  // READ FF       
  always_ff @(posedge clk or negedge rst_n) begin
      if(~rst_n)begin
         read_ptr <= '0;
      end else begin
         if (rw_en) begin
           if((write_ptr == read_ptr) & wr_en & empty) begin // write through logic
             	read_output <= write_input;
             	read_ptr <= read_ptr;
           end else if (~empty) begin
             	read_output <= FIFO[read_ptr];
             	read_ptr <= read_ptr == DEPTH-1 ? '0 : read_ptr + 1'b1;
           end
         end else begin
           read_ptr <= read_ptr;
         end
      end
  end
        
  
  always_ff @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
      	count <= '0;
    end else begin
      case({write_success,read_success})
        2'b10: count <= count + 1;
        2'b01: count <= count - 1;
        default: count <= count;
       endcase
    end
  end
  
endmodule
