module fa4 (
input logic [3:0] A,B, 
input logic Cin,
output logic [3:0] S, 
output logic Cout
);
logic Cout1, Cout2, Cout3;
fa fulladder1 (.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(Cout1));
fa fulladder2 (.A(A[1]), .B(B[1]), .Cin(Cout1), .S(S[1]), .Cout(Cout2));
fa fulladder3 (.A(A[2]), .B(B[2]), .Cin(Cout2), .S(S[2]), .Cout(Cout3));
fa fulladder4 (.A(A[3]), .B(B[3]), .Cin(Cout3), .S(S[3]), .Cout(Cout));
endmodule
