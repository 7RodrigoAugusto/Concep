module mux2(d0, d1, s, y);
	input logic [3:0] d0, d1;
	output logic [3:0] y;
	input logic s;
	assign y = s ? d1 : d0;	//Baseado na entrada inicial o operador condicial ?: escolhe a 
							//segunda opção se for "1" e a terceira expressão se for "0"
							//Resumo: Escolhe d1 se for "1" e escolhe d0 se for "0"
endmodule
