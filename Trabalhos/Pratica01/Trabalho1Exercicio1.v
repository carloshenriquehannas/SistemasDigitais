
module Trabalho2Exercicio1(X, Y, op1, op2, op3, op4, sel, enable, Z);

/*
	op1 = resultado da operacao de soma
	op2 = resultado da operacao de multiplicacao
	op3 = resultado da operacao de AND logico
	op4 = resultado da operacao de OR logico
	
	sel = seletor de qual operacao sera executada (MUX)
*/

input [1:0] X;
input [1:0] Y;
input [1:0] sel;
input enable;

output [3:0] op1;
output [3:0] op2;
output [3:0] op3;
output [3:0] op4;
output reg [3:0] Z;

SOMAula S1(
	.X (X),
	.Y (Y),
	.enable (enable),
	.op1 (op1)
);

MULula M1(
	.X (X),
	.Y (Y),
	.enable (enable),
	.op2 (op2)
);

ANDula A1(
	.X (X),
	.Y (Y),
	.enable (enable),
	.op3 (op3)
);

ORula O1(
	.X (X),
	.Y (Y),
	.enable (enable),
	.op4 (op4)
);


always @ (posedge enable)
	begin
		if(sel == 2'b00)
		begin
			Z[3:0] = op1[3:0];
			Z = op1;
		end
		
		if(sel == 2'b01)
		begin
			Z[3:0] = op2[3:0];
		end
		
		if(sel == 2'b10)
		begin
			Z[3:0] = op3[3:0];
		end
		
		if(sel == 2'b11)
		begin
			Z[3:0] = op4[3:0];
		end
		
	end

endmodule

/*
	MODULO DA SOMA
*/

module SOMAula(X, Y, enable, op1);

input [1:0] X;
input [1:0] Y;
input enable;

output reg [3:0] op1;

always @ (posedge enable)
	begin
		op1[0] = (X[0] & ~Y[0]) | (~X[0] & Y[0]);
		op1[1] = (~X[1] & X[0] & ~Y[1] & Y[0]) | (X[1] & X[0] & Y[1] & Y[0]) | (~X[1] & ~X[0] & Y[1]) | (X[1] & ~X[0] & ~Y[1]) | (~X[1] & Y[1] & ~Y[0]) | (X[1] & ~Y[1] & ~Y[0]);
		op1[2] = (X[1] & Y[1]) | (X[1] & X[0] & Y[0]) | (X[0] & Y[1] & Y[0]);
		op1[3] = 1'b0;
	end

endmodule

/*
	MODULO DA MULTIPLICACAO
*/

module MULula(X, Y, enable, op2);

input [1:0] X;
input [1:0] Y;
input enable;

output reg [3:0] op2;

always @ (posedge enable)
	begin
		op2[0] = X[0] & Y[0];
		op2[1] = (X[0] & Y[1]) ^ (X[1] & Y[0]);
		op2[2] = (X[1] & ~X[0] & Y[1]) | (X[1] & Y[1] & ~Y[0]);
		op2[3] = X[1] & X[0] & Y[1] & Y[0];
	end

endmodule

/*
	MODULO DO AND
*/

module ANDula(X, Y, enable, op3);

input [1:0] X;
input [1:0] Y;
input enable;

output reg [3:0] op3;

always @ (posedge enable)
	begin
		op3[1:0] = X[1:0] & Y[1:0];
		op3[2] = 1'b0;
		op3[3] = 1'b0;
	end
	
endmodule

/*
	MODULO DO OR
*/

module ORula(X, Y, enable, op4);

input [1:0] X;
input [1:0] Y;
input enable;

output reg [3:0] op4;

always @ (posedge enable)
	begin
		op4[1:0] = X[1:0] | Y[1:0];
		op4[2] = 1'b0;
		op4[3] = 1'b0;
	end
endmodule
