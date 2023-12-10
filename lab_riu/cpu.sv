module cpu (  input reg clck, input reg rst_n, input reg [31:0] in, output reg [31:0] out);
// Instruction memory portion
logic [31:0] inst_ram [4095:0];
initial $readmemh("program.rom",inst_ram);
logic [11:0] PC_FETCH;


//Instruction declaration 
logic [31:0] instruction_EX;
logic [4:0] regdest_WB;
logic [31:0] A_EX;
logic [31:0] B_EX;
logic alusrc_EX;
logic [31:0] regdata2_EX;
logic hex_we_EX;
logic regwrite_WB;
logic regwrite_EX;
logic [2:0] regsel_WB,regsel_EX;
logic [31:0] lui_val_WB;
logic [31:0] R_WB, R_EX;
logic [31:0] writedata_WB;
logic [3:0] aluop_EX;
logic [6:0] funct7_EX; 
logic [6:0] op_EX;
logic [2:0] funct3_EX;
logic [4:0] r1_EX; 
logic [4:0] r2_EX; 
logic [4:0] r_d;
logic [11:0] imm12_EX;
logic [19:0] imm20_EX;
logic [31:0] in_WB;
logic zero_cpu;

always_ff @(posedge clck)
  if (~rst_n) begin
    PC_FETCH <= 12'b0;
    instruction_EX <= 32'b0;
  end else begin
    PC_FETCH <= PC_FETCH + 1'b1;
    instruction_EX <= inst_ram[PC_FETCH];
  end


//output display
always_ff @(posedge clck) begin
    regdest_WB <= instruction_EX[11:7];
    regwrite_WB <= regwrite_EX;
    regsel_WB <= regsel_EX;
    in_WB <= in;
    lui_val_WB <= {instruction_EX[31:12], 12'b0};
    R_WB <= R_EX;

    if (hex_we_EX) begin
        out <= A_EX;
        $display("%h", out);
    end
end

//sign extend
always @(*) begin
    if (alusrc_EX == 1'b0) begin
        B_EX = regdata2_EX;
    end else begin
        B_EX = {{20{instruction_EX[31]}}, instruction_EX[31:20]};
    end
end


//mux check
always @(*) begin
    case (regsel_WB)
        2'b00: writedata_WB = in_WB;
        2'b01: writedata_WB = lui_val_WB;
        default: writedata_WB = R_WB;
    endcase
end
// calling decoder 
decoder dc(.instructionaddr(instruction_EX), .funct7(funct7_EX), .rs2(r2_EX), .rs1(r1_EX), .funct3(funct3_EX), .rd(r_d), .opcode(op_EX), .imm20(imm20_EX), .imm12(imm12_EX));
//calling Control Unit
ControlUnit cu (.funct7(funct7_EX), .rs2(r2_EX), .rs1(r1_EX), .funct3(funct3_EX), .rd(r_d), .opcode(op_EX),
                .imm20(imm20_EX), .imm12(imm12_EX), .alusrc(alusrc_EX), .regwrite(regwrite_EX), .regsel(regsel_EX),
                .op(aluop_EX), .gpio_we(hex_we_EX));

//calling regfile		
regfile regfile_cpu (.clk(clck), .we(regwrite_WB), .readaddr1(instruction_EX[19:15]), .readaddr2(instruction_EX[24:20]),
             .writeaddr(regdest_WB), .writedata(writedata_WB), .readdata1(A_EX), .readdata2(regdata2_EX));
//calling alu
alu alu_cpu (.A(A_EX), .B(B_EX), .op(aluop_EX), .R(R_EX), .zero(zero_cpu));


endmodule

