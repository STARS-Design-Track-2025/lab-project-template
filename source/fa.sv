module fa
 (
input logic A, B, Cin,
output logic S, Cout
);

assign Cout = (A & B)|((A ^ B) & Cin);
assign S = A ^ B ^ Cin;

endmodule
