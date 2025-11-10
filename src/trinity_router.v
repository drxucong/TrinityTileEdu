`default_nettype none

module trinity_router (
    input  wire [7:0] data_in,
    input  wire [7:0] bus_in,
    output reg  [7:0] data_out,
    input  wire       sys_clk,
    input  wire       sys_rst_n
);
    wire       bus_valid = bus_in[7];
    wire [1:0] bus_mode  = bus_in[1:0];
    wire       bus_exec  = bus_in[2];

    reg [5:0] exec_cnt;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            exec_cnt <= 6'd0;
            data_out <= 8'd0;
        end else begin
            if (bus_valid && bus_exec) begin
                exec_cnt <= exec_cnt + 6'd1;
                data_out <= {bus_mode, exec_cnt};
            end
        end
    end

endmodule

`default_nettype wire
