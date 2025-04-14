module top #(
parameter led_number = 6
)(
input clk,
output [led_number-1:0] leds
);

reg count_1s_flag;
reg [23:0] count_1s = 24'd0;

// Таймер ~4 Гц
always @(posedge clk) begin
    if (count_1s < 27000000/4) begin
        count_1s <= count_1s + 1;
        count_1s_flag <= 0;
    end else begin
        count_1s <= 0;
        count_1s_flag <= 1;
    end
end

reg [2:0] pos = 0;
reg [led_number-1:0] leds_value = 0;

always @(posedge clk) begin
    if (count_1s_flag) begin
        if (pos < led_number - 1)
            pos <= pos + 1;
        else
            pos <= 0;

        leds_value <= (2'b11 << pos);
end
end

assign leds = ~leds_value;  // Инверсия — если светодиоды активны по LOW

endmodule
