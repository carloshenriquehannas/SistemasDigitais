module exercicio(input p, q, r, output f)
   
   not(np,p);
   not(nq,q);
   not(nr,r);
   
   and(P1,p,nr);
   and(P2,q,r);
   and(P3,np,nq,r);
   
   or(f,P1,P2,P3);

endmodule
//Carlos Henrique Hannas de Carvalho
//NºUSP: 11965988