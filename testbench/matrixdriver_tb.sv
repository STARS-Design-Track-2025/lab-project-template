`timescale 1ms/10ps
module matrixdriver_tb;
  logic [7:0] [7:0] matdata;
  logic clk, en, nrst;
  logic srowdata, scoldata, sck;
    matrixdriver dut (.*);
    always #5 clk = ~clk;
    initial begin
        // make sure to dump the signals so we can see them in the waveform
        $dumpfile("waves/matrixdriver.vcd");
        $dumpvars(0, matrixdriver_tb);

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