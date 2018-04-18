module modelo(input logic [3:0]  A,
			input logic	clk,
			input reset,
			input logic	sel0,sel1,
			output logic [3:0] S,
			output	somador_cout);
			//Acho que nao preciso ficar declarando as saidas
			//output logic [3:0] inv_out,somador_out, acc_out, 
			//output logic somador_cout);
			
	logic [3:0] inv_out, mux0_out, somador_out, acc_out;
	
	inv		inv0(A,inv_out);
	mux2	mux0(A,inv_out,sel0,mux0_out);
	somador4	somador1(mux0_out,acc_out,sel0,somador_out,somador_cout);
	mux2	mux1(somador_out,mux0_out,sel1,S);
	acc		acc1(clk,reset,S,acc_out);
	

	endmodule