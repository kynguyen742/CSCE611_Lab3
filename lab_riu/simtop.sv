/* Copyright 2020 Jason Bakos, Philip Conrad, Charles Daniels */

/* Top-level module for CSCE611 RISC-V CPU, for running under simulation.  In
 * this case, the I/Os and clock are driven by the simulator. */

module simtop;

	logic clk;
	logic [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
	logic [3:0] KEY;
	logic [17:0] SW;
	logic [31:0] hex_output;
	logic rst_n;

	top dut
	(
		//////////// CLOCK //////////
		.CLOCK_50(clk),
		.CLOCK2_50(),
	    .CLOCK3_50(),

		//////////// LED //////////
		.LEDG(),
		.LEDR(),

		//////////// KEY //////////
		.KEY(KEY),

		//////////// SW //////////
		.SW(SW),

		//////////// SEG7 //////////
		.HEX0(HEX0),
		.HEX1(HEX1),
		.HEX2(HEX2),
		.HEX3(HEX3),
		.HEX4(HEX4),
		.HEX5(HEX5),
		.HEX6(HEX6),
		.HEX7(HEX7)
	);

	// pulse reset (active low)
	initial begin
	logic fail;
		fail = 1'b0;
		#10
		
		clk = 1'b0; 
		#5;
		clk = 1'b1;
		#5;
		
		rst_n <= 1'b1;
		#10
		
		clk = 1'b0; 
		#5;
		
		while (hex_output === 32'hxxxxxxxx) begin
			clk <= ~clk;
			#5;
		end
		
		if(hex_output !== 32'h88000000) begin
			$display("Failed, expecting h88000000");
			fail = 1'b1;
		end
		if(~fail)begin
			$display("PASSED");
		end
		
	end
	
	// drive clock
//	always begin
//		clk <= 1'b0; #5;
//		clk <= 1'b1; #5;
//	end
	
	// assign simulated switch values
	assign SW = 18'd12345;
	//Ky Nguyen and Azariah Laulusa testbench
	
	
	
	
	
	
	
endmodule

