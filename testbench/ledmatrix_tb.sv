`timescale 1ms/10ps
module ledmatrix_tb;
  logic [7:0] [7:0] matdata; //unpacked array matrix data COLS ROWS
  logic clk, en, nrst;
  logic [7:0] rowdata, coldata;
  logic shiftrow, shiftcol;
    ledmatrix dut (.*);
    always #5 clk = ~clk;
    initial begin
        // make sure to dump the signals so we can see them in the waveform
        $dumpfile("waves/ledmatrix.vcd");
        $dumpvars(0, ledmatrix_tb);

        //initialize inputs
        clk = 1'd0;
        en = 1'd1;
        nrst = 1'd0;
        matdata = 64'h0011223344556677;
        #5
        nrst = 1'd1; //release
        #100000 $finish;
    end
endmodule