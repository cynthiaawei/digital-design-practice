// Question 20: 11011 sequence detector FSM.

module Q20 (
  input logic i,
  input logic clk,
  input logic rst_n,
  output logic detected
);
  localparam logic [2:0] state_rst = 3'b000;
  localparam logic [2:0] state_A = 3'b001;
  localparam logic [2:0] state_B = 3'b010;
  localparam logic [2:0] state_C = 3'b011;
  localparam logic [2:0] state_D = 3'b100;
  logic [2:0] current_state, next_state;
  
  always_comb begin
    case(current_state) 
      state_rst: if (i) next_state = state_A; else next_state = state_rst;
      state_A: if (i) next_state = state_B; else next_state = state_rst;
      state_B: if (i) next_state = state_B; else next_state = state_C;
      state_C: if (i) next_state = state_D; else next_state = state_rst;
      state_D: if (i) next_state = state_B; else next_state = state_rst;
      default: next_state = state_rst;
      endcase
  end
  
  always_ff @ (posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      	current_state <= state_rst;
      	detected <= '0;
    end else begin
      	current_state <= next_state;
      if(current_state == state_D & i == '1) begin
        	detected <= '1;
      end else begin
        	detected <= '0;
      end
    end
  end
      
endmodule