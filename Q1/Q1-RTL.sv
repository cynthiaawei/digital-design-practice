// Question 1: write a fixed priority arbiter with decreasing priority from LSB to MSB

module Q1 #(
    parameter int N = 8
)(
    input logic [0:0] 	req [N],
    output logic [0:0] 	gnt [N]
);
    logic found;
    always_comb begin
        found = '0; // default should go inside of always
    	for (int i = 0; i < N; i++) begin
        	if (req[i] & ~found) begin
            	gnt[i] = 1'b1;
            	found = 1'b1;
         	end else
              	gnt [i] = '0;
        end
    end
endmodule