`timescale 1ns / 1ps
///////////////////////////////////////////////////
// Top-level file for the Digilent Nexys 3 board //
//            (Under construction)               //
//                                               //
// Comment out all assignments on I/O you'll use //
///////////////////////////////////////////////////
module nexys3_top
    (
    clk,                          // Master clock

    sw,                           // Switches input
    btns, btnu, btnl, btnd, btnr, // Push buttons

    JA, JB, JC, JD,               // PMOD inout pins

    led,                          // LEDs
    seg, an                       // 7-segment display pins
    );

    input clk;
    input [7:0] sw;
    input btns, btnu, btnl, btnd, btnr;

    inout [7:0] JA;
    inout [7:0] JB;
    inout [7:0] JC;
    inout [7:0] JD;

    output [7:0] led;
    output [3:0] an;
    output [7:0] seg;

    ////////////////////////
    // DEFAULT ASSIGNMENT //
    ////////////////////////

    assign JA = 8'hZ;
    assign JB = 8'hZ;
    assign JC = 8'hZ;
    assign JD = 8'hZ;

    assign led = 8'h0;
    assign an = 4'hF;
    assign seg = 8'b1111_1111;

    ///////////////////////
    // BUTTON DEBOUNCING //
    ///////////////////////

    wire button_center, button_up, button_left, button_down, button_right;
    debounce db0(.reset(reset), .clock(clk), .noisy(btns), .clean(button_center));
    debounce db1(.reset(reset), .clock(clk), .noisy(btnu), .clean(button_up));
    debounce db2(.reset(reset), .clock(clk), .noisy(btnl), .clean(button_left));
    debounce db3(.reset(reset), .clock(clk), .noisy(btnd), .clean(button_down));
    debounce db4(.reset(reset), .clock(clk), .noisy(btnr), .clean(button_right));

    ///////////////////////
    // YOUR PROJECT HERE //
    ///////////////////////

endmodule
