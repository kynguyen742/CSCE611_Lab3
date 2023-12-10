module decoder(
	input logic  [31:0]instructionaddr,
	output logic [6:0] opcode,
	output logic [11:7]rd,
	output logic [14:12]funct3,
	output logic [31:25]funct7,
	output logic [31:20]imm12,
	output logic [31:12]imm20,
	output logic [19:15]rs1,
	output logic [24:20]rs2
);
	//common instrucitons decoder for all
	assign opcode = instructionaddr[6:0];
	assign rd = instructionaddr[11:7];
	
	//R-type and I-type instructions decoder
	assign rs1 = instructionaddr[19:15];
	assign funct3 = instructionaddr[14:12];
	
	//R-type instructions decoder
	assign rs2 = instructionaddr[24:20];
	assign funct7 = instructionaddr[31:25];
	
	//U-type instruction decoder
	assign imm20 = instructionaddr[31:12];
	
	//I-type instruction decoder
	assign imm12 = instructionaddr[31:20];
endmodule 