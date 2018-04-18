//`include "somador2_rfwild.sv"
`timescale 1ns/10ps
module tb();

//Variaveis auxiliares para conexões e testes
logic clk,rst; //para futuros testes em circuitos sequenciais
logic [3:0] A;
logic [3:0] B;
logic CIN;
logic [3:0] S;
logic COUT;

//Valores para comparação
logic [3:0] S_esperado;
logic COUT_esperado;

//variaveis de testbench
logic [31:0]vector_ind,erros;
logic [7:0] testvectors[1000:0];

//instancia do módulo a ser verificado
somador4 DUV(
                .A(A[3:0]),
                .B(B[3:0]),
                .CIN(CIN),
		.S(S[3:0]),
		.COUT(COUT)
);


/////////testbench propriamente dito
//gera o clock
//altera estado a cada #n unidades de tempo
//início padrão em zero
//always #5 clk = ~clk;
always
    begin
    clk =1; #5; clk=0; #5; // ~clk;
    end
//carrega vetores, inicializa variaveis
//reset simbolico no momento
initial begin
	//"read mem b"
	//le arquivo de vetores em binário
	//ignora "_" (para legibilidade do arquivo)
	//alternativa: readmemh
	//-> hexadecimal
	$readmemb("vetores.tv",testvectors);
	//inicia variáveis auxiliares
	//vector_ind = indice do vetor de dados
	//erros = erros encontrados
	vector_ind=0; erros=0;
	//rst sinal de reinício "nível alto ativo"
	//não se aplica ao circuito somador por ser combinacional
	// e sem 'rst'/'reset'
	rst=1'b1; #8; rst=0;

end

//condicoes iniciais
//todo initial compartilha da mesma origem de tempo
/*initial begin
  clk = 1'b0;
  //rst = 1'b0;
end */

//carrega dados nas variaveis na rising edge de 'clk'
always @(posedge clk)
begin
	//espera 1 instante de tempo para não ter problemas
	//de clock e dados alterando na mesma borda
	//contatena-se variaveis entre { }. Nesse caso, a igualdade é bit a bit
	//{MSb,b7,b6,...,b2,b1,LSb} = {MSb_carregado,...,LSb carregado}
	//#1;
	{A[3:0],B[3:0],CIN,S_esperado[3:0],COUT_esperado} = testvectors[vector_ind];

end

//verifica na falling edge
//aqui que vai o código de verificação
always @(negedge clk)
if (~rst) begin // skip during reset
//begin
	//verifica se a saida do modulo é diferente da carregada no vetor
	if (S !== S_esperado) begin
		$display("Erro: entradas= %b",{A[3:0],B[3:0],CIN});
		$display("S = %b (%b esperado)",S,S_esperado);
		erros = erros + 1;
	end
	if (COUT !== COUT_esperado) begin
		$display("Erro: entradas= %b",{A[3:0],B[3:0],CIN});
		$display("COUT = %b (%b esperado)",COUT,COUT_esperado);
		erros = erros + 1;
	end

	//incrementa o índice do vetor a ser carregado
	vector_ind = vector_ind + 1;
	
	//as variaveis são iniciadas com X, logo
	//quando o vetor carregado terminar,
	//testvector[vector_ind] == 8'bX
	if(testvectors[vector_ind] === 8'bx) begin
		//relatorio de fim
		$display("%d testes completados com %d erros", vector_ind, erros);
		//diretiva para terminar simulação
		$finish;
	end
end

//fim do modulo "tb"
endmodule
