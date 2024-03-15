
//Carlos Henrique Hannas de Carvalho 11965988
//Matheus Baptistella 11223117

module DFF(clock, reset, d, q, qb);
	
	//Sinal de clock
	input clock;
	//Sinal de reset
	input reset;
	
	//Entrada
	input d;
	//Saidas
	output q;
	output qb;

	reg q;

	assign qb = ~q;

	always @(posedge clock or posedge reset)
	begin
		if(reset) begin
			q <= 1'b0;
			
		end else begin
			q <= d;
			
		end
	end

endmodule


module CreateRegister(clock, enable, reset, A, q);
	
	//Sinal de clock
	input clock;
	//Sinal de enable
	input enable;
	//Sinal de reset
	input reset;
	
	//Barramento de entrada
	input [31:0] A;
	
	//Barramento de saida
	output wire [31:0] q;
	wire [31:0] qb;
	
	//Cria cada um dos flip flops tipo D para cada bit armazenador do registrador
	genvar i;
	reg[31:0] d;
	generate for(i = 0; i < 32; i = i + 1) begin: label 
			DFF array(clock, reset, d[i], q[i], qb[i]);
		end
	endgenerate
 
	always @(posedge clock)
	if(clock) begin
		d[31:0] = A[31:0];
		
	end
		
endmodule

module Trabalho4(opcode, clock, reset, data_out);
 
	//Barramento de entrada que determina a operacao
	input [5:0] opcode;

	//Sinal de Clock
	input clock;
	//Sinal de reset
	input reset;

	//Barramento para saida de dados
	output reg [10:0]data_out;
	
	//Registrador de estados
	reg [3:0]estado;
	CreateRegister register1(clock, enable, reset, estado);
	
	//Flag se ocorreu overflow na conta
	parameter overflow = 0;
	
	reg RegDst;
	CreateRegister register2(clock, enable, reset, RegDst);
	
	reg RegWrite;
	CreateRegister register3(clock, enable, reset, RegWrite);
	
	reg MemtoReg;
	CreateRegister register4(clock, enable, reset, MemtoReg);
	
	reg IntCause;
	CreateRegister register5(clock, enable, reset, IntCause);
	
	reg CauseWrite;
	CreateRegister register6(clock, enable, reset, CauseWrite);
	
	reg EPCWrite;
	CreateRegister register7(clock, enable, reset, EPCWrite);
	
	//Declaracao dos estados
	parameter s0 = 0;
	parameter s1 = 1;
	parameter s6 = 6;
	parameter s7 = 7;
	parameter s9 = 9;
	parameter s11 = 11;
	
	//Saida depende do estado atual
	always @ (estado) begin
		case (estado)
			s0:
				data_out = 11'b10010100100;
				
			s1:
				data_out = 11'b10011100100;
				
			s6:
				data_out = 11'b11010010100;
				
			s7:
				begin
					RegDst <= 1'b1;
					RegWrite <= 1'b1;
					MemtoReg <= 1'b0;
				end
				
			s9:
				data_out = 11'b10010100110;
				
			s11:
				begin
					data_out = 11'b10010101111;
					IntCause <= 1'b1;
					CauseWrite <= 1'b1;
					EPCWrite <= 1'b1;
				end
				
				
			default:
				data_out = 11'b00000000000;
		endcase	
	end
	
	//Determina o proximo estado
	always @ (posedge clock or posedge reset) begin
		if (reset)
			estado <= s0;
		else
			case (estado)
				s0:
					estado <= s1;
					
				s1:
					if (opcode == 6'b000000)
						estado <= s6;
						
				s6:
					estado <= s7;
					
				s7:
					if (overflow)
						estado <= s11;
					else
						estado <= s0;
						
				s9:
					estado <= s0;
						
				s11:
					estado <= s0;
					
				default:
					estado <= s0;
			endcase
	end
		
endmodule
