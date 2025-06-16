`default_nettype none
module matrixdriver (
  input logic [7:0] [7:0] matdata,
  input logic clk, en, nrst,
  output logic srowdata, scoldata, sck
);
  logic [7:0] rowdata, coldata;
  logic colshift, rowshift;

  driver74hc164 srdriver0(.data(rowdata), .shift(rowshift), .clk(clk), .en(en), .nrst(nrst), .sda(srowdata), .sck(sck), .done());
  driver74hc164 srdriver1(.data(coldata), .shift(colshift), .clk(clk), .en(en), .nrst(nrst), .sda(scoldata), .sck(), .done());
  ledmatrix matrix(.matdata(matdata), .clk(clk), .en(en), .nrst(nrst), .coldata(coldata), .rowdata(rowdata), .shiftrow(rowshift), .shiftcol(colshift));
endmodule