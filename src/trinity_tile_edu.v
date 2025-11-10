`default_nettype none
`timescale 1ns/1ps

// Trinity Tile Educational Edition
// Single-top module for a 2x2 tile area.
module trinity_tile_edu (
    input  wire [7:0] uii_in,
    output wire [7:0] uii_out,
    input  wire [7:0] uii_link_in,
    output wire [7:0] uii_link_out,
    output wire [7:0] uii_link_oe,
    input  wire       sys_clk,
    input  wire       sys_rst_n
);

    wire [7:0] bus_broadcast;
    wire [7:0] core_out;
    wire [7:0] mem_out;
    wire [7:0] rt_out;

    // 1) mode / exec broadcaster
    trinity_mode_ctrl u_mode (
        .uii_in     (uii_in),
        .status_out (),
        .bus_out    (bus_broadcast),
        .sys_clk    (sys_clk),
        .sys_rst_n  (sys_rst_n)
    );

    // 2) compute core
    trinity_core u_core (
        .data_in   (uii_in),
        .bus_in    (bus_broadcast),
        .data_out  (core_out),
        .sys_clk   (sys_clk),
        .sys_rst_n (sys_rst_n)
    );

    // 3) local memory
    trinity_mem u_mem (
        .data_in   (uii_in),
        .bus_in    (bus_broadcast),
        .data_out  (mem_out),
        .sys_clk   (sys_clk),
        .sys_rst_n (sys_rst_n)
    );

    // 4) router / status
    trinity_router u_rt (
        .data_in   (uii_in),
        .bus_in    (bus_broadcast),
        .data_out  (rt_out),
        .sys_clk   (sys_clk),
        .sys_rst_n (sys_rst_n)
    );

    // expose core result
    assign uii_out      = core_out;

    // expose broadcast
    assign uii_link_out = bus_broadcast;
    assign uii_link_oe  = 8'hFF;

endmodule

`default_nettype wire
