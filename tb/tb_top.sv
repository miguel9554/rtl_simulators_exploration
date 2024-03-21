`timescale 1ns/1ps

module tb_top;

    localparam W = 6;
    localparam INIT_VAL = 0;

    real CLK_FREQ = 8e6;
    real CLK_PERIOD = 1/CLK_FREQ;

    logic clk = 0;
    logic rst = 1;
    logic enable = 1;
    logic srst = 0;
    logic [W-1:0] count_to = 2**W-1;
    logic done;

    // Clock and reset
    always clk = #(1s*(CLK_PERIOD/2)) ~clk;
    initial @(negedge clk) rst = 0;

    // RTL module
    counter#(.W(W), .INIT_VAL(INIT_VAL)) u_counter(.*);

    // Waveform dump
    initial begin
        string database_name;
        if (!$value$plusargs("WAVES=%s", database_name)) begin
            $fatal(1, "Please provide WAVES database name");
        end
        $dumpfile(database_name);
        $dumpvars(0, tb_top);
    end

    // Time format config
    initial $timeformat(-9, -12, " ns", 10);

    // Simulation control
    always @(posedge clk) begin
        if (done) begin
            $display("[%0t] counter is done", $time);
            $finish();
        end
    end

endmodule
