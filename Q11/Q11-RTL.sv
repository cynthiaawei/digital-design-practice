// Question 11: Implement NAND, XOR, and NOT gate using 2-to-1 MUX.

module Q11 (
  input logic a,
  input logic b,
  output logic NAND,
  output logic XOR,
  output logic NOT_a,
  output logic NOT_b
);
  
  
  mux NAND_module (
    .A('1),
    .B(NOT_b),
    .S(a),
    .f(NAND)
  );
  
  mux XOR_module (
    .A(b),
    .B(NOT_b),
    .S(a),
    .f(XOR)
  );
  
  mux NOTA (
    .A('1),
    .B('0),
    .S(a),
    .f(NOT_a)
  );
  
  mux NOTB (
    .A('1),
    .B('0),
    .S(b),
    .f(NOT_b)
  );
  
endmodule


module mux (
  input logic A,
  input logic B,
  input logic S,
  output logic f
);
  always_comb begin
    f = (~S & A) | (S & B);
  end
endmodule