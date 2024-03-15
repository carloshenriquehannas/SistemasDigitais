
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

module Trabalho3(address, data_in, read_write, clock, enable, data_out);
 
	//Barramento de enderecos
	input [2:0] address;
	//Barramento de entrada de dados
	input [31:0] data_in;

	//Sinal para leitura/escrita
	//0 -> escrita
	//1 -> leitura
	input read_write;
	//Sinal de Clock
	input clock;
	//Sinal de Enable
	//1 representa true, ou seja, esta habilitado
	input enable;

	//Barramento para saida de dados
	output [31:0] data_out;

	//Registrador de saida de dados
	reg [31:0] reg_out;
	

	//Banco de registradores
	reg [31:0] reg1;
	reg [31:0] reg2;
	reg [31:0] reg3;
	reg [31:0] reg4;
	reg [31:0] reg5;
	reg [31:0] reg6;
	reg [31:0] reg7;
	reg [31:0] reg8;	
	
	//Inicializa os registradores
	CreateRegister register1(clock, enable, reset, reg1);
	CreateRegister register2(clock, enable, reset, reg2);
	CreateRegister register3(clock, enable, reset, reg3);
	CreateRegister register4(clock, enable, reset, reg4);
	CreateRegister register5(clock, enable, reset, reg5);
	CreateRegister register6(clock, enable, reset, reg6);
	CreateRegister register7(clock, enable, reset, reg7);
	CreateRegister register8(clock, enable, reset, reg8);
	
	
	
	always @(posedge clock)
	begin
		
		//So executa se o enable estiver habilitado
		if(enable == 1) begin
			//Escrita
			if(read_write == 0) begin
			//Verifica em qual endereco deve escrever
				if(address == 3'b000) begin
					reg1 <= data_in;
					
				end else if(address == 3'b001) begin
					reg2 <= data_in;
				
				end else if(address == 3'b010) begin
					reg3 <= data_in;
				
				end else if(address == 3'b011) begin
					reg4 <= data_in;
				
				end else if(address == 3'b100) begin
					reg5 <= data_in;
				
				end else if(address == 3'b101) begin
					reg6 <= data_in;
				
				end else if(address == 3'b110) begin
					reg7 <= data_in;
				
				end else if(address == 3'b111) begin
					reg8 <= data_in;
				
				end
			end
			//Leitura
			else begin
			//Verifica de qual endereco deve ler
				if(address == 3'b000) begin
					reg_out <= reg1;
					
				end else if(address == 3'b001) begin
					reg_out <= reg2;
				
				end else if(address == 3'b010) begin
					reg_out <= reg3;
				
				end else if(address == 3'b011) begin
					reg_out <= reg4;
				
				end else if(address == 3'b100) begin
					reg_out <= reg5;
				
				end else if(address == 3'b101) begin
					reg_out <= reg6;
				
				end else if(address == 3'b110) begin
					reg_out <= reg7;
				
				end else if(address == 3'b111) begin
					reg_out <= reg8;
				
				end
			end
		end
	end

	assign data_out = reg_out;

endmodule

