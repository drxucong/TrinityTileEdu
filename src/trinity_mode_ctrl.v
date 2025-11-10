`default_nettype none

// Broadcast frame:
// [7] valid
// [6] reserved
// [5:4] group_id (00)
// [3] cfg (0)
// [2] exec (pulse)
// [1:0] mode_sel
module trinity_mode_ctrl (
    input  wire [7:0] uii_in,
    output wire [7:0] status_out,
    output wire [7:0] bus_out,
    input  wire       sys_clk,
    input  wire       sys_rst_n
);
    wire [1:0] cmd      = uii_in[7:6];
    wire [1:0] new_mode = uii_in[1:0];

    reg  [1:0] mode_sel;
    reg        exec_pulse;

    always @(posedge sys_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            mode_sel   <= 2'd0;
            exec_pulse <= 1'b0;
        end else begin
            exec_pulse <= 1'b0;
            case (cmd)
                2'b01: mode_sel   <= new_mode;
                2'b10: exec_pulse <= 1'b1;
                default: ;
            endcase
        end
    end

    wire [1:0] group_id = 2'b00;

    assign bus_out    = {1'b1, 1'b0, group_id, 1'b0, exec_pulse, mode_sel};
    assign status_out = {6'd0, mode_sel};

endmodule

`default_nettype wire
