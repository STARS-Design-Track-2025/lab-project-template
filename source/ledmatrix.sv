`default_nettype none
module ledmatrix (
  input logic [7:0] [7:0] matdata, //unpacked array matrix data ROWS COLS
  input logic clk, en, nrst,
  output logic [7:0] rowdata, coldata,
  output logic shiftrow, shiftcol
);
  //rows are given 1 to select while cols are 0 to select
  logic [2:0] row, row_n; //selected row

  always_ff @(posedge clk, negedge nrst) begin
    if (~nrst) begin
      row <= 3'd0;
      state <= 2'd0;
      delay <= 16'd0;
    end else if (en) begin
      row <= row_n;
      state <= state_n;
      delay <= delay_n;
    end else begin
      row <= row;
      state <= state;
      delay <= delay;
    end
  end

  typedef enum logic [1:0] {
    LOAD_DATA   = 0, //load one row's data into the column shift register. Also loads the decoded row into the row shift register
    SHIFT_DATA  = 1, //starts the column and row data shift
    WAIT        = 2 //wait to prevent unwanted illumination
  } states;

  logic [1:0] state, state_n;
  logic [15:0] delay, delay_n;

  always_comb begin
    coldata = 8'd0;
    rowdata = 8'd0;
    shiftcol = 1'd0;
    shiftrow = 1'd0;
    state_n = state;
    row_n = row;
    delay_n = delay;
    case(state)
      LOAD_DATA: begin
        coldata = ~matdata [row]; //bitwise invert for active low

        case (row) //3to8 decoder
          3'd0: rowdata = 8'b10000000;
          3'd1: rowdata = 8'b01000000;
          3'd2: rowdata = 8'b00100000;
          3'd3: rowdata = 8'b00010000;
          3'd4: rowdata = 8'b00001000;
          3'd5: rowdata = 8'b00000100;
          3'd6: rowdata = 8'b00000010;
          3'd7: rowdata = 8'b00000001;
        endcase

        state_n = SHIFT_DATA;
      end
      SHIFT_DATA: begin
        shiftcol = 1'd1;
        coldata = ~matdata [row];

        shiftrow = 1'd1;
        row_n = row + 1;
        case (row) //3to8 decoder
          3'd0: rowdata = 8'b10000000;
          3'd1: rowdata = 8'b01000000;
          3'd2: rowdata = 8'b00100000;
          3'd3: rowdata = 8'b00010000;
          3'd4: rowdata = 8'b00001000;
          3'd5: rowdata = 8'b00000100;
          3'd6: rowdata = 8'b00000010;
          3'd7: rowdata = 8'b00000001;
        endcase

        state_n = WAIT;
      end
      WAIT: begin
        if (delay < 10000) begin
          delay_n = delay + 1;
        end else begin
          state_n = LOAD_DATA;
          delay_n = 16'd0;
        end
      end
      default: begin
        state_n = LOAD_DATA;
      end
    endcase
  end
endmodule
