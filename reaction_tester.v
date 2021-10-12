module reaction_tester(CLOCK_50, number, control, LEDR, LEDG);

input [4:0]number;
input control, CLOCK_50;

wire [2:0] KEY;

output wire [8:0] LEDG;
output wire [17:0] LEDR;

wire [17:0] count;
wire reset, request_test, stop_test, clear;
wire run, start_test, test_active, enable_bcd, sec_100th;

virtual_input VI (.number(number), .control(control), .button0(KEY[0]), .button1(KEY[1]), .button2(KEY[2]));

assign reset = KEY[0];
assign request_test = KEY[1];
assign stop_test = KEY[2];
assign clear = reset | stop_test;
assign enable_bcd = test_active & sec_100th;
assign LEDG = test_active;
assign LEDR = count;

control_ff run_signal (CLOCK_50, request_test, clear, run);
control_ff test_signal (CLOCK_50, start_test, clear, test_active);
hundredth hundredth_sec (CLOCK_50, enable_bcd, sec_100th);
delay_counter foursec_delay (CLOCK_50, clear, run, start_test);
BCD_counter bcdcount (CLOCK_50, request_test, enable_bcd, count);
bcd7seg digit3 (BCD3, HEX3);
bcd7seg digit2 (BCD2, HEX2);
bcd7seg digit1 (BCD1, HEX1);
bcd7seg digit0 (BCD0, HEX0);

endmodule