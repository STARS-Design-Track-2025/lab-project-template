`default_nettype none
module driver74hc164 (
  input logic [7:0] data,
  input logic clk, shift, en, nrst,
  output logic sda, sck, done
);
  logic started, started_n;
  logic [7:0] data_reg, data_n;
  assign done = !started;

  always_ff @(posedge clk, negedge nrst) begin
    if (~nrst) begin
      started <= 1'd0;
      count <= 3'd0;
      data_reg <= 8'd0;
    end else if (en) begin
      started <= started_n;
      count <= count_n;
      data_reg <= data_n;
    end else begin
      started <= started;
      count <= count;
      data_reg <= data_reg;
    end
  end

  logic [2:0] count, count_n;

  always_comb begin
    sda = 1'd0;
    started_n = started;
    count_n = count;
    data_n = data_reg;
    sck = 1'd0;
    if (shift) begin
      started_n = 1'd1;
      data_n = data;
    end else if ((started == 1'd1)) begin
      count_n = count + 3'd1;
      sda = data_reg[7-count];
      sck = clk;
      if (count == 3'd7) begin
        started_n = 1'd0;
      end
    end
  end
endmodule
