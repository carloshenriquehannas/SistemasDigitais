//CARLOS HENRIQUE HANNAS DE CARVALHO
//NUMERO USP: 11965988
//DATA: 14/06/2021

module circuit(output Flout, Feout, Fgout, input Ai, Bi, Fein, Flin, Fgin);
 
 //portas not
 not(nAi, Ai);
 not(nBi, Bi);
  
 //primeiro nivel
 and(P1, Ai, nBi);
 xnor(P2, Ai, Bi);
 and(P3, nAi, Bi);
  
 //segundo nivel 
 and(P4, Fein, P1);
 and(P5, Fein, P3);
  
 //portas de saida
 or(Flout, Flin, P5);
 and(Feout, Fein, P2);
 or(Fgout, Fgin, P4);
  
endmodule