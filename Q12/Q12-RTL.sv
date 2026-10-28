// Question 12: Implement 4-to-1 MUX using 2-to-1 MUXs.

module Q12 (
  input logic a,
  input logic b,
  input logic c,
  input logic d,
  input logic s1,
  input logic s2,
  output logic f
);
  
  logic f1, f2;
  
  mux stage1_a (
    .A(a),
    .B(b),
    .S(s2),
    .f(f1)
  );
  
  mux stage1_b (
    .A(c),
    .B(d),
    .S(s2),
    .f(f2)
  );
  
  mux stage2 (
    .A(f1),
    .B(f2),
    .S(s1),
    .f(f)
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