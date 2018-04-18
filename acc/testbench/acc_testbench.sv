`timescale 1ns / 100ps

 module acc_tb;
 
	logic [3:0] d, q, q_expected;		//Entrada d, saída q e saída q esperada
	logic a_clk;						//Clok do acumulador.
	logic [31:0] counter, errors;		//Contadores de vetor e erro
	logic [8:0] vectors [10000:0];		//Capacidade máxima 10000 vetores de 9 bits
	logic clk, rst;						//Sinais de clock e reset
	 
	acc dut(a_clk, rst, d, q);	//Instância DUT
	 
	initial	//No início (de toda execução)
		begin 		
			$display("starting Test_bench");
			$readmemb("acc.tv", vectors);	//Carrega os vetores descritos em acc.tv em vectors
			counter = 0; errors = 0;		//Inicializa contadores
			rst = 1; #100; rst = 0;			//Reset em 1 por 100 ns
		end
		
	always	//Sempre
		begin
			clk = 1; #10;	//clock em 1 dura 10 ns
			clk = 0; #10;	//clock em 0 dura 10 ns
		end

	always @(posedge clk)	//Clock subindo
		if(~rst)
		begin
		//Atribui valores do vetor nas entradas do DUT e nos valores esperados.
		{d, a_clk, q_expected} = vectors[counter];	
		end	
		
	always @(negedge clk)	//Clock descendo
		if(~rst)
		begin
			assert(q === q_expected) $display("d = %b a_clk = %b q = %b OK", d, a_clk, q);
			else
				begin 
					//Mostra mensagem de erro se a saída do DUT for diferente da saída esperada
					$error("d = %b clk = %b q = %b (q expected: %b) ", d, a_clk, q, q_expected);
					errors = errors + 1;	//Incrementa contador de erros
				end
				
			counter = counter + 1;	//Incrementa contador dos vertores de teste
			
			if(vectors[counter] === 9'bx) //Quando os vetores de teste acabarem
			begin
				$display("Numero de testes efetuados = %0d", counter);
				$display("Numero de erros encontrados = %0d", errors);
				$stop;
			end
		end
		
 endmodule
