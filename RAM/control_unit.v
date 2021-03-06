// `include "/ALU/ALU_32.v"
// `include "/RegisterFile.v"
`define DEFAULT_IR 32'b11100010000000010000000000000000
`define START 6'b000000
`define FIRST 6'b000001
`define SECOND 6'b000010
`define MOC 6'b000011
`define CONDITIONAL 6'b000100
`define ARITH_OP_IMM 6'b000101
`define REG_REG 6'b000110
`define ARITH_OP_SHIFT 6'b000111
`define LD_IMM_OFFSET 6'b001000
`define LD_IMM_POST 6'b001001
`define LD_IMM_PRE 6'b001010

`define LD_IMM_REG_OFFSET 6'b001011
`define LD_IMM_REG_POST 6'b001100
`define LD_IMM_REG_PRE 6'b001101

`define LD_SCALED_OFFSET 6'b001110
`define LD_SCALED_POST 6'b001111
`define LD_SCALED_PRE 6'b010000

`define SEVENTEENTH 6'b010001
`define EIGHTEENTH 6'b010010
`define NINETEENTH 6'b010011
`define TWENTIETH 6'b010100
`define TWENTY_FIRST 6'b010101
`define TWENTY_SECOND 6'b010110
`define TWENTY_THIRD 6'b010111
`define TWENTY_FOURTH 6'b011000
`define TWENTY_FIFTH 6'b011001

`define STR_IMM_OFFSET 6'b011010
`define STR_IMM_POST 6'b011011
`define STR_IMM_PRE 6'b011100

`define STR_REG_OFFSET 6'b011101
`define STR_REG_POST 6'b011110
`define STR_REG_PRE 6'b011111

`define STR_SCALED_OFFSET 6'b100000
`define STR_SCALED_POST 6'b100001
`define STR_SCALED_PRE 6'b100010

`define THIRTY_FIFTH 6'b100011
`define THIRTY_SIXTH 6'b100100
`define THIRTY_SEVENTH 6'b100101
`define THIRTY_EIGHTH 6'b100110
`define THIRTY_NINTH 6'b100111

`define FORTIETH 6'b101000
`define FORTY_FIRST 6'b101001
`define FORTY_SECOND 6'b101010
`define FORTY_THIRD 6'b101011
`define BRANCH 6'b101100
`define MOV 6'b101101
`define CMP 6'b101110

module ControlUnit(output FR,RF,input[31:0]IR,output MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP4,OP3,OP2,OP1,OP0,IR_ld,
                     input Moc, Cond, Reset, Clk , output[5:0] CS);

	wire[5:0] NS , CS;

	NextStateDecoder NSD( NS , CS , IR , Cond , Moc);
	ControlSignalsEncoder SE( FR , RF , IR , MDR , MAR , R_W , MOV , MA_1 , MA_0 , MB_1 , MB_0 , MC_1 , MC_0 , MD , ME , OP4 , OP3 , OP2 , OP1 , OP0 ,  IR_ld , CS  );
	StateReg SR(CS , NS , Clr , Clk);
	

endmodule




/**

	I think you are using moc as a state ? Im confused

	Creo que tienes el done ese haciendo la misma funcion que el moc 
**/



module NextStateDecoder(output reg [5:0] NextState,
                         input[5:0] State, input[31:0] IR, input Cond ,Moc);

   always@*

		
		case(State)
				
			6'd0:
				NextState <= 6'd1;

			6'd1:
				NextState <= 6'd2;
				
			6'd2:
				NextState <= 6'd3;
				
			6'd3:
				NextState <= 6'd4;

			default:begin  NextState = 5'b1; end

		endcase


	
endmodule


module ControlSignalsEncoder( output reg FR_ld,RF_ld,output reg[31:0]IR, output reg MDR_ld,MAR_ld,R_W,MOV,MA1,MA0,MB1,MB0,MC1,MC0,MD, ME, OP4,OP3,OP2,OP1,OP0,
       IR_ld, input [5:0]State);

    always@*

    case(State)

			`START:
			begin
				FR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 1;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
			end
                

			`FIRST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 1.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0;
				OP4 <= 1.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`SECOND:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 1.0;
				MOV <= 1.0;
				MA1 <= 1.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 1.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 1.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
            

			`MOC:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 1.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 1.0;
				MOV <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`CONDITIONAL:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`ARITH_OP_IMM:
			begin
				FR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`REG_REG:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`ARITH_OP_SHIFT:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            


			`LD_IMM_OFFSET:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`LD_IMM_POST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 1.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`LD_IMM_PRE:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`LD_IMM_REG_OFFSET:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`LD_IMM_REG_POST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`LD_IMM_REG_PRE:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`LD_SCALED_OFFSET:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`LD_IMM_REG_POST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`LD_SCALED_PRE:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`SEVENTEENTH:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`EIGHTEENTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 1.0;
				MDR_ld <= 0.0;
				R_W <= 1.0;
				MOV <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`NINETEENTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 1.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 1.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
            

			`TWENTIETH:
			begin
				FR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`TWENTY_FIRST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 1.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
            

			`TWENTY_SECOND:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 1.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
            

			`TWENTY_THIRD:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 1.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
            

			`TWENTY_FOURTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 1.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
             

			`TWENTY_FIFTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 1.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 1.0;
			end
            

			`STR_IMM_OFFSET:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`STR_IMM_POST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 1.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`STR_IMM_PRE:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`STR_REG_OFFSET:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`STR_REG_POST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`STR_REG_PRE:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`STR_SCALED_OFFSET:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`STR_SCALED_POST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`STR_SCALED_PRE:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`THIRTY_FIFTH:
			begin
				FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`THIRTY_SIXTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`THIRTY_SEVENTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`THIRTY_EIGHTH:
			begin
				FR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`THIRTY_NINTH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`FORTIETH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`FORTY_FIRST:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`FORTY_SECOND:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`BRANCH:
			begin
				FR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 1.0;
				MC1 <= 1.0;
				MC0 <= 0.0;
				MD <= 1.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 1.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
			end
            

			`MOV:
			begin
				FR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 1;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end
            

			`CMP:
			begin
				FR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end
			9'd48:
			begin
				FR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
			end

  


        default:
                begin
                FR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
                end
    endcase

endmodule

module StateReg(output reg[5:0]State,
                input[5:0] NextState,
                          input Clr, Clk);

    always @(posedge Clk, negedge Clr)

    if(!Clr)
       State <= 6'b000000;

    else
       State <= NextState;
    
endmodule

// module mux_4_1(input [3:0]a , input [3:0]b, input [3:0]c, input [3:0]d,input sel1, input sel2, output[3:0] out  );

//     assign out = sel2 ? (sel1 ? d : c) : (sel1 ? b: a);

// endmodule

// module CU_tester_with_ALU_and_REG;


//     reg Done, Reset, Clk, Cond, Moc, RF_Ld;
	
//     wire[5:0] State;
//     wire FR,RF,IR, MDR,MAR,R_W,MOV,
//             MA_1,MA_0,MB_1,MB_0,
//             MC_1,MC_0,MD, ME,
//              OP4,OP3,OP2,OP1,OP0;

//     wire N, Z, V , Cout;
//     wire[31:0] O;//Sign extender & shifter bits
//     reg[0:31] A;
//     reg[0:31] B;
//     reg[0:3] OP;
//     reg Cin;

//     reg [31:0]PC;
//     reg [3:0] R_A;
//     reg [3:0] R_B;

//     wire [31:0]PA;
//     wire [31:0]PB;

//     reg [3:0] IR_16_19;
//     reg [3:0] IR_15_12;
//     reg [3:0] IR_24_21;

//     reg[3:0] all_on = 4b'1111;
//     reg[3:0] dont_care = 4b'0000;

//     regfile reg_file(PC, 
//                         C,R_A,R_B,
//                         RF_Ld, Reset, Clk, 
//                         PA, PB);

//     ALU alu( N, Z, V, Cout, O, Cin ,PA, B , OP);



//     ControlUnit CU (State,
//                      FR,RF,IR, MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP4,OP3,OP2,OP1,OP0,
//                      Moc, Cond, Done, Reset, Clk);
    

//     //NO SE COMO HACER ESTO

//     reg DS_IR;//del IR
//     reg Ds; //Del MDR
//     mux_4_1 muxA(IR_16_19, IR_15_12, all_on, dont_care, MA1, MA0, A);
//     mux_4_1 muxB(PB, O, Qs_MDR, dont_care, MB1, MB0, B);
//     mux_4_1 muxC( IR_15_12, all_on, MC, C);
//     mux_4_1 muxD(OP_4_0, IR_24_21, MD, OP);
//     mux_4_1 muxE( DS_IR, PC, ME, Ds);//Ds is for MDR, missing DS_IR

//     
//     initial begin
//         State = 6'b000000;
//         Clk = 1'b0;
//         Cond =1'b0;
//         Moc = 1'b0;
//         repeat(100) #5 State += 6'b000001;
//         repeat(100) #5 Clk = ~Clk;
//         repeat(100) #5 Moc = ~Moc;
//         repeat(100) #5 Cond = ~Cond;
//     end

//     initial fork
//         Reset = 1'b0;
//         #3 Reset = 1'b1;
//         #80 Reset = 1'b0;
//         #83 Reset = 1'b1;

//         Done = 1'b0;
//         #50 Done = 1'b1;
//         #60 Done = 1'b0;
//     join

//         initial begin
//             $display("===Control-Unit===\n");
//             $display("State FR RF IR MDR MAR R_W MOV MA_1 MA_0 MB_1 MB_0 MC_1 MC_0 MD ME OP4 OP3 OP2 OP1 OP0 Moc, Cond Done Reset     Time");
//             $monitor("%d  %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %d",
//                     State, FR,RF,IR, MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP4,OP3,OP2,OP1,OP0, Moc, Cond, Done, Reset, $time);
//             $display("=== Ouput===\n")
//             $monitor("%d  %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %d",
//                     State, FR,RF,IR, MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP4,OP3,OP2,OP1,OP0, Moc, Cond, Done, Reset, $time);
//         end
    






module CU_tester;

    reg[31:0] IR;
    wire FR,RF, IR_ld ,MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP4,OP3,OP2,OP1,OP0;
	wire [5:0]State;
    reg Moc, Clk, Reset, Cond;
	parameter sim_time  = 1000;

    ControlUnit cu( FR,RF,IR, MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP4,OP3,OP2,OP1,OP0,IR_ld , Moc, Cond, Reset, Clk , State);
	

	initial begin


		Clk <= 1'b0;
		Reset <= 1'b1;
		#10 Reset <= 1'b0;
		Cond <= 1'b1;
		Moc <= 1'b1;
		IR <= `DEFAULT_IR;

		#5
		begin
			
			$display("Control Signals");
			$display("FR  |  RF  |  IR 			 |  MDR   |  MAR  | R_W  |  MOV  | MA_1 |  MA_0  |  MB_1  |  MB_0  |  MC_1  |  MC_0  |  MD  |  ME  |  OP  |  MOC  |  COND  |  RESET  |  Clk  |   State ");
			$monitor("%b  	|  %b  	|  %d 	 |  %b	  |  %b 	 |  %b  	|   %b  	|  %b  	|  %b  	 |  %b 	 |  %b 	 |  %b  	|  %b  	|  %b 	 |  %b  	|  %b  	|  %b 	 |  %b  	|  %b  	|  %b 	 | %d   ",FR,RF,IR, MDR,MAR,R_W,MOV,MA_1,MA_0,MB_1,MB_0,MC_1,MC_0,MD, ME, OP1 ,Moc, Cond, Reset, Clk , State );
			repeat(100) #5 Clk = ~Clk;
		end
	end



endmodule

