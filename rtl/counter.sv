module counter#(
    parameter W = 8,
    parameter INIT_VAL = 0
)(
    input logic clk,
    input logic rst,
    input logic enable,
    input logic srst,
    input logic [W-1:0] count_to,
    output logic done
);

    logic [W-1:0] counter;

    assign done = counter == count_to;
    always @(posedge clk or posedge rst) begin
        if (rst) counter <= INIT_VAL;
        else if (enable) counter <= (srst | done) ? INIT_VAL : counter+'d1;

    end

endmodule
