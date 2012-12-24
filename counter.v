`timescale 1ns / 1ps

module counter 
    #(parameter count_to=10) 
    (
    input clk,
    input reset,
    output ready
    );

     reg [26:0] count = 0;
     reg enable = 0;

     always @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if (count == count_to) begin
                count <= 0;
            end
        end
     end

    assign ready = (count == count_to);
endmodule