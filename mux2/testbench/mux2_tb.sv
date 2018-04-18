`timescale 1ns / 100ps
 module mux2_tb;
	logic [3:0] da, db, y1;
	logic [3:0] counter;
	logic clk,s;
	logic [12:0] vectors [0:3];
	logic [0:3] erros;
	
	//mux2tristate dut(.d0(da), .d1(db), .s(s), .y(y1));
	mux2 dut(.d0(da), .d1(db), .s(s), .y(y1));
	initial 
		begin 
			counter = 0;
			$readmemb("mux2.tv",vectors);	//Leitura da entrada do arquivo .tv
			
			$display("Linhas do teste vector");
			$display("%b",vectors[0]);
			$display("%b",vectors[1]);
			$display("%b",vectors[2]);
			$display("%b",vectors[3]);
		end
	always
		begin
			clk = 1;
			#1;
			clk = 0;
			#5;
		end
	always @(posedge clk)
		begin
			da = vectors[counter][12:9];
			db = vectors[counter][8:5];
			s = vectors[counter][4];
		end
	always @(negedge clk)
		begin	
		
			assert(y1 === vectors[counter][3:0]) else $error("y %d",counter);
			counter = counter + 1;
			if(vectors[counter] === 13'bx) 
				begin
					$stop;
				end
		end
		
endmodule
