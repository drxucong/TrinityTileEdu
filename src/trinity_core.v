`default_nettype none

module trinity_core (
    input  wire [7:0] data_in,
    input  wire [7:0] bus_in,
    output reg  [7:0] data_out,
    input  wire       sys_clk,
    input  wire       sys_rst_n
);
    wire       bus_valid = bus_in[7];
    wire [1:0] bus_mode  = bus_in[1:0];
    wire       bus_exec  = bus_in[2];

    reg  [31:0] acc;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            acc      = 32'd0;
            data_out = 8'd0;
        end else begin
            if (bus_valid && bus_exec) begin
                case (bus_mode)
                    2'd0: acc <= acc + data_in;
                    2'd1: acc <= acc + (data_in * 8'd3);
                    2'd2: acc <= acc ^ {24'd0, data_in};
                    default: acc <= acc;
                endcase
                data_out <= acc[7:0];
            end
        end
    end

endmodule

`default_nettype wire
