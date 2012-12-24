`timescale 1ns / 1ps

///////////////////////////////////////////////////
// Driver file to use the seven-seg display as a //
// hexadecimal display. Digits A-F are displayed //
// as 1. 2. 3. 4. and 5.                         //
//                                               //
// Instantiate with the board's 'seg' and 'an'   //
// pins connected to the outputs                 //
///////////////////////////////////////////////////
module seven_segment_display(
    input clk,
    input reset,
    input [15:0] data,
    output reg [7:0] seg_char,
    output reg [3:0] seg_anode
    );

    reg [1:0] cnt = 0;         // Tracks the current digit
    reg [3:0] nibble = 0;      // Hexadecimal digit to display
    
    // Delay the anode change to 1ms assuming clock is 100MHz
    // (1 clock cycle = 10ns, 1e5*10ns = 1ms)
    wire disp_cnt;
    counter #(.count_to(100000)) c(.clk(clk),
                                   .reset(reset),
                                   .ready(disp_cnt));

    always @(posedge disp_cnt) cnt <= cnt + 1;
    always @(posedge disp_cnt) begin
        case(cnt)
            // Anode pins assert low
            2'b00: begin
                seg_anode <= 4'b1110;
                nibble    <= data[3:0];
            end
            
            2'b01: begin
                seg_anode <= 4'b1101;
                nibble    <= data[7:4];
            end
            
            2'b10: begin
                seg_anode <= 4'b1011;
                nibble    <= data[11:8];
            end
            
            2'b11: begin
                seg_anode <= 4'b0111;
                nibble    <= data[15:12];
            end
            
            default: begin
                seg_anode <= 4'b1111;
                nibble     <= 4'h0;
            end
        endcase
    end
    
    always @(*) begin
        case(nibble)
            // Pins assert low <P_GFE_DCBA> 
            4'd0:  seg_char <= 8'b1_111_1111;
            4'd1:  seg_char <= 8'b1_111_1001;
            4'd2:  seg_char <= 8'b1_010_0100;
            4'd3:  seg_char <= 8'b1_011_0000;
            4'd4:  seg_char <= 8'b1_001_1001;
            4'd5:  seg_char <= 8'b1_001_0010;
            4'd6:  seg_char <= 8'b1_000_0010;
            4'd7:  seg_char <= 8'b1_111_1000;
            4'd8:  seg_char <= 8'b1_000_0000;
            4'd9:  seg_char <= 8'b1_001_0000;
            // Add decimal point for digits 10-15
            4'd10: seg_char <= 8'b0_111_1001;
            4'd11: seg_char <= 8'b0_010_0100;
            4'd12: seg_char <= 8'b0_011_0000;
            4'd13: seg_char <= 8'b0_001_1001;
            4'd14: seg_char <= 8'b0_001_0010;
            4'd15: seg_char <= 8'b0_000_0010;
            default: seg_char <= 8'b0_1111111;
        endcase
    end
endmodule
