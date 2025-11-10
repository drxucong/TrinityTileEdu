`default_nettype none

module trinity_mem (
    input  wire [7:0] data_in,
    input  wire [7:0] bus_in,
    output reg  [7:0] data_out,
    input  wire       sys_clk,
    input  wire       sys_rst_n
);
    wire       bus_valid = bus_in[7];
    wire [1:0] bus_mode  = bus_in[1:0];
    wire       bus_exec  = bus_in[2];

    reg [7:0] mem [0:7];
    integer i;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            for (i = 0; i < 8; i = i + 1) begin
                mem[i] <= 8'd0;
            end
            data_out <= 8'd0;
        end else begin
            if (bus_valid && bus_exec) begin
                if (bus_mode == 2'd2) begin
                    mem[data_in[2:0]] <= data_in;
                    data_out          <= mem[data_in[2:0]];
                end else begin
                    data_out          <= data_in;
                end
            end
        end
    end

endmodule

`default_nettype wire
