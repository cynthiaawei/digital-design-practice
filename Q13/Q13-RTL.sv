module Q13 (
    input logic clk, 
    input logic rstn, 
    input logic [1:0] last_used, 
    output logic [1:0] LRU
);

logic [1:0] LRU_array [3:0];
logic [1:0] LRU_array_next [3:0];

always_comb begin
    LRU = '0; // initialize before the for loop

    for(int i = 0; i < 4; i++) begin
        if(last_used == i) begin
            LRU_array_next[i] = 2'b11;
        end else if (LRU_array[last_used] < LRU_array[i]) begin // compare last used VALUE with the VALUE at that index in CURRENT array
            LRU_array_next[i] = LRU_array[i] - 1'b1;
        end else begin
            LRU_array_next[i] = LRU_array[i];
        end

    // set LRU
    if(LRU_array[i] == '0) begin
        LRU = i;
    end 
    end
end

always_ff @ (posedge clk or negedge rstn) begin
    if (~rstn) begin
        for(int i = 0; i < 4; i++) begin
            LRU_array[i] <= i;
        end
    end else begin
        for(int i = 0; i < 4; i++) begin
            LRU_array[i] <= LRU_array_next[i];
        end
    end
end
endmodule