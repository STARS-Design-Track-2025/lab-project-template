`timescale 1ms/10ps
module driver74hc164_tb;
    logic [7:0] data;
    logic clk, shift, en, nrst;
    logic sda, sck, done;
    driver74hc164 dut (.*);
    always #5 clk = ~clk;
    initial begin
        // make sure to dump the signals so we can see them in the waveform
        $dumpfile("waves/driver74hc164.vcd");
        $dumpvars(0, driver74hc164_tb);

        //initialize inputs
        clk = 1'd0;
        shift = 1'd0;
        en = 1'd1;
        nrst = 1'd1;
        data = 8'd0;
        #1
        nrst = 1'd0; //reset held for 1 clock cycle
        #5
        nrst = 1'd1;
        data = 8'h4A; //load parallel input
        #5
        shift = 1'd1; //begin shift
        #5
        data = 8'd0;
        shift = 1'd0;
        // (posedge done) //wait for first conversion
        #100
        data = 8'hDE;
        #5
        shift = 1'd1;
        #5
        data = 8'd0;
        shift = 1'd0;
        // @(posedge done)
        // finish the simulation
        #100 $finish;
    end
endmodule