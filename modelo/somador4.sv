`timescale 1ns/1ps
//escala de 1ns para #n
//precisão de 1ps

module somador4(input [3:0] A,input [3:0] B,input CIN, output [3:0] S,output COUT);

//atribui o resultado aritmético de A+B+CIN a {COUT,S[1:0]} (sendo COUT o MSb)
assign {COUT,S[3:0]}= A+B+CIN;

endmodule 


