// Q18: RTL ready-valid downsizer. 16-bit input with ready/valid gets sent at output 1-byte at a time. Both I/p and O/P use ready/valid.

module Q18 (
    input  logic        clk,
    input  logic        rstn,

    // Input interface (16-bit)
    input  logic [15:0] in_data,
    input  logic        in_valid,
    output logic        in_ready,

    // Output interface (8-bit)
    output logic [7:0]  out_data,
    output logic        out_valid,
    input  logic        out_ready
);
  
  localparam logic [1:0] EMPTY = 2'b00, SEND_LOW = 2'b01, SEND_HIGH = 2'b10;
  logic [1:0] state, next_state;
  logic [7:0] low, high; 

  
  always_comb begin

    
    case (state) 
        EMPTY:  next_state = in_valid == '1 ? SEND_LOW : EMPTY;
        SEND_LOW: next_state = out_ready == '1 ? SEND_HIGH : SEND_LOW;
        SEND_HIGH: next_state = out_ready == '1 ? EMPTY : SEND_HIGH;
        default: next_state = EMPTY;
      endcase
    
    in_ready = (state == EMPTY); // depends on current state, not past state
    out_valid = (state == SEND_LOW || state == SEND_HIGH);
    
    out_data = '0;
    if (state == SEND_LOW) begin // out_data does not need to remember smth from prev cycle
      out_data = low;
    end else if (state == SEND_HIGH) begin
      out_data = high;
    end
  end
  
  always_ff @ (posedge clk or negedge rstn) begin
    if(~rstn) begin
      state <= EMPTY;
      low <= '0;
      high <= '0;
    end else begin
      state <= next_state;
      if(in_valid && in_ready) begin
        low <= in_data[7:0]; // need to remember low and high across diff states
        high <= in_data[15:8];
      end
    end
  end
  
  
endmodule