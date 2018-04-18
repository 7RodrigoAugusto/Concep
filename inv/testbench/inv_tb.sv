`timescale 1ns / 100ps module inv_tb;
	
	logic clk, rst;
	logic [3:0] a, y, y_esperado;
	logic [7:0] entrace [0:8];
	logic [0:3] counter,erros;
	
const int MEMSIZE = 4;	//Numero de linhas do meu test_vector.tv 
	
		inv dut(.a(a),.y(y));
		
	always begin
		clk = 1;
		#7;
		clk = 0;
		#5;
	end
	
	//O test bench, esse arquivo atual, ele realiza a leitura do golden model(arquivo .tv)
	initial
	  begin
	  counter = 0;
	  erros=0;  
		$display("Começo do Testbench\n");
		$readmemb("inv.tv",entrace);	//Leitura da entrada do arquivo .tv
		
		$display("Linhas do teste vector");
		$display("%b",entrace[0]);
		$display("%b",entrace[1]);
		$display("%b",entrace[2]);
		$display("%b\n",entrace[3]);
		
		rst = 1;
		#7;		//Delay?
		rst = 0;
		end
		
	always @(posedge clk)
	if (~rst)
    begin // Pula no reset
			a[3:0]= entrace[counter][7:4];			// A entrada são os 4 primeiros bits
			y_esperado[3:0] = entrace[counter][3:0];// A saída são os 4 ultimos bits 
		end
		
	always @(negedge clk)
	if (~rst)
	begin // Pula no reset
	
	//Prints de comparacao dos elementos do vetor de entrada com o vetor de saida
	$display("Elementos da entrada: %b", entrace[counter][7:4]);
	$display("Elementos da saida: %b", entrace[counter][3:0]);
	$display("Elementos da saida do programa: %b\n", y);	
	
	
	for(int k = 0; k < 4; k++)
		begin
		assert (y[k]=== y_esperado[k]) else //assert como if
			begin 
			  // Se o valor do elemento daquela linha for diferente do esperado incrementa erros=erros+1;
              $error("counter=%d",counter,"  y%d",k,"=%b",y[k],"  y_esperado%d",k,"  =%b",y_esperado[k]);
              erros++;
			end;
      end    
		counter = counter + 1;	
		if (counter == (MEMSIZE) )
		    begin
				            $display("Número de testes efetuados=%d",counter);
				            $display("Número de erros encontrados=%d",erros);
				            $display("Teste encerrado com testvector=%b",entrace[counter-1]);
				            
			  
				$stop;
		    end	
		end

endmodule
