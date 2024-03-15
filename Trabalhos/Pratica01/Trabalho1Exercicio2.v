
module Trabalho2(I1, I2, I3, I4, a, b, c, d, e, f, g, h, i, j, k, x);

input I1, I2, I3, I4;
output a, b, c, d, e, f, g, h, i, j, k, x;

assign a = (~I2 & I4) | (~I1 & I3) | (I2 & I3) | (I1 & ~I4) | (~I1 & I2 & I4) | (I1 & ~I2 & ~I3);

assign b = (~I1 & ~I3 & ~I4) | (~I1 & ~I2 & I4) | (I1 & ~I2 & ~I4) | (I1 & ~I3 & ~I4);

assign c = (~I1 & ~I3) | (~I3 & I4) | (I1 & ~I2) | (~I1 & I2 & ~I4);

assign d = (I1 & ~I3) | (~I1 & ~I2 & ~I4) | (I2 & ~I3 & I4) | (I2 & I3 & ~I4) | (I1 & ~I2 & I4);

assign e = (~I2 & ~I3 & ~I4) | (I1 & ~I2 & ~I4) | (I1 & I3 & I4) | (I1 & I2 & ~I3) | (~I1 & I2 & I3 & ~I4);

assign f = (~I3 & ~I4) | (I1 & ~I2) | (~I1 & I3 & ~I4) | (~I1 & I2 & ~I4) | (I1 & I3 & I4);

assign g = (I1 & ~I2) | (I1 & I4) | (~I1 & I2 & ~I3) | (~I1 & I2 & ~I4);

assign h = (~I1 & ~I2 & ~I3 & ~I4) | (I1 & I2 & I3 & ~I4);

assign i = (~I1 & ~I2) | (~I1 & I3 & I4);

assign j = (~I1 & ~I2 & ~I4) | (I2 & I3 & ~I4);

assign k = (~I1 & ~I2 & ~I3 & ~I4) | (~I1 & ~I2 & I3 & I4);

assign x = (~I1) | (~I2 & ~I3);

endmodule
