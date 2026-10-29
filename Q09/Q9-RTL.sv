// Question 9: Asynchronous FIFO implementation details.

module Q9 #(
  parameter int DEPTH = 8,
  parameter int WIDTH = 4
)(
  input logic wr_clk,
  input logic wr_rstn,
  input logic [WIDTH-1:0] wr_data,
  input logic wr_en,
  input logic rd_clk,
  input logic rd_rstn,
  output logic [WIDTH-1:0] rd_data,
  input logic rd_en
);
  
  localparam int WIDTH_OF_DEPTH_PTR = DEPTH != 1 ? $clog2(DEPTH) : 1; // question mark first
  
  logic [(WIDTH_OF_DEPTH_PTR - 1)+1: 0] wr_ptr, rd_ptr, wr_ptr_next, rd_ptr_next, wr_ptr_gray, rd_ptr_gray, wr_ptr_gray_rd_clk, rd_ptr_gray_wr_clk, wr_ptr_rd_clk, rd_ptr_wr_clk;
  
  logic [WIDTH-1:0] FIFO [DEPTH-1:0]; // USE DEPTH NOT POINTER DEPTH (NUMBER OF ENTRIES VERTICALLY)
  
  logic full, empty;
  
  always_comb begin // chat gpt reference, need this wr_ptr_next and rd_ptr_next logic to get a correct full and empty
    if (wr_en & ~full) begin
        wr_ptr_next <= wr_ptr + 1;
    end else begin
      	wr_ptr_next = wr_ptr;
    end
    
    if (rd_en & ~empty) begin
        rd_ptr_next <= rd_ptr + 1;
    end else begin
      	rd_ptr_next = rd_ptr;
    end
  end
  
  // update write pointer logic
  
  always_ff @ (posedge wr_clk or negedge wr_rstn) begin
    if(~wr_rstn)begin
      wr_ptr <= '0;
    end else begin
      if (wr_en & ~full) begin
        FIFO[wr_ptr[WIDTH_OF_DEPTH_PTR-1:0]] <= wr_data;
        wr_ptr <= wr_ptr + 1;
      end 
    end
  end
  
  // update read pointer logic
  
  always_ff @ (posedge rd_clk or negedge rd_rstn) begin
    if(~rd_rstn)begin
      rd_ptr <= '0;
    end else begin
      if (rd_en & ~empty) begin
        rd_data <= FIFO[rd_ptr[WIDTH_OF_DEPTH_PTR-1:0]];
        rd_ptr <= rd_ptr + 1;
      end 
    end
  end
  
  // check full condition
  
  always_ff @ (posedge wr_clk or negedge wr_rstn) begin
    if(~wr_rstn)begin
      full <= '0;
    end else begin
      if ({~wr_ptr_next[WIDTH_OF_DEPTH_PTR],wr_ptr_next[WIDTH_OF_DEPTH_PTR-1:0]} == rd_ptr_wr_clk) begin
        full <= '1;
      end else begin
        full <= '0;
      end
    end
  end
  
  // check empty condition
  
  always_ff @ (posedge rd_clk or negedge rd_rstn) begin
    if(~rd_rstn)begin
      empty <= '1;
    end else begin
      if (rd_ptr_next == wr_ptr_rd_clk) begin
        empty <= '1;
      end else begin
        empty <= '0;
      end
    end
  end
  
  // convert write pointer to read domain
  
  BtoG # (
    .N(WIDTH_OF_DEPTH_PTR)
  ) get_write_gray (
    .binary(wr_ptr),
    .gray(wr_ptr_gray)
  );
  
  twoflopsync # (
    .N(WIDTH_OF_DEPTH_PTR)
  ) sync_to_rd_domain (
    .clk_B(rd_clk),
    .rstn_B(rd_rstn),
    .data_in(wr_ptr_gray),
    .data_out(wr_ptr_gray_rd_clk)
  );
  
  GtoB # (
    .N(WIDTH_OF_DEPTH_PTR)
  ) return_write_binary (
    .gray(wr_ptr_gray_rd_clk),
    .binary(wr_ptr_rd_clk)
  );
  
  // convert read pointer to write domain
  
    BtoG # (
      .N(WIDTH_OF_DEPTH_PTR)
  ) get_read_gray (
    .binary(rd_ptr),
    .gray(rd_ptr_gray)
  );
  
  twoflopsync # (
    .N(WIDTH_OF_DEPTH_PTR)
  ) sync_to_wr_domain (
    .clk_B(wr_clk),
    .rstn_B(wr_rstn),
    .data_in(rd_ptr_gray),
    .data_out(rd_ptr_gray_wr_clk)
  );
  
  GtoB # (
    .N(WIDTH_OF_DEPTH_PTR)
  ) return_read_binary (
    .gray(rd_ptr_gray_wr_clk),
    .binary(rd_ptr_wr_clk)
  );

  
  
endmodule

// next time make BtoG and GtoB use always_ff instead of always_comb

module BtoG # (parameter int N = 2)( input logic[N:0] binary, output logic[N:0] gray);
  always_comb begin
    gray = binary ^ (binary >> 1);
  end
endmodule
  
module GtoB # (parameter int N = 2)(input logic[N:0] gray, output logic[N:0]binary);
  always_comb begin
    for(int i = 0; i <= N; i++) begin
      binary[i] =^ (gray >> i);
    end
  end
endmodule

module twoflopsync # ( parameter int N = 2 
)(
 input logic clk_B,
 input logic rstn_B,
  input logic [N:0] data_in,
  output logic [N:0] data_out
);
  logic [N:0] Q_unstable;
  
  always_ff @ (posedge clk_B or negedge rstn_B)begin
    if(~rstn_B)begin
      	data_out <= '0;
      	Q_unstable <= '0;
    end else begin
      	Q_unstable <= data_in;
      	data_out <= Q_unstable;
    end
  end
endmodule
  