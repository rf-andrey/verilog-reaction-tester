module BCD_counter (Clock, Clear, Enable, count);

input Clock, Clear, Enable;
output reg [17:0] count;

always @(posedge Clock)
begin
	if (Clear)
		count <= 0;
	else if (Enable)
	begin
		count <= count + 1;
	end
end

//wire [4:1] Carry;
//
//BCD_stage stage0 (Clock, Clear, Enable, BCD0, Carry[1]);
//BCD_stage stage1 (Clock, Clear, (Carry[1] & Enable), BCD1, Carry[2]);
//BCD_stage stage2 (Clock, Clear, (Carry[2] & Carry[1] & Enable), BCD2, Carry[3]);
//BCD_stage stage3 (Clock, Clear, (Carry[3] & Carry[2] & Carry[1] & Enable), BCD3, Carry[4]);

endmodule

module BCD_stage (Clock, Clear, Ecount, BCDq, Value9);

input Clock, Clear, Ecount;

output reg [3:0] BCDq;
output reg Value9;

always @(posedge Clock)
begin
	if (Clear)
		BCDq <= 0;
	else if (Ecount)
	begin
		if (BCDq == 4'b1001)
			BCDq <= 0;
		else
			BCDq <= BCDq + 1;
	end
end

always @(BCDq)
	if (BCDq == 4'b1001)
		Value9 <= 1'b1;
	else
		Value9 <= 1'b0;

endmodule