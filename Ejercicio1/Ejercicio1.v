module Contador12bits(input wire [11:0] Load, input clk, input enable, input reset, output [11:0] Q);
reg Q;

always @(posedge clk or posedge reset or Load)  
			begin
				if(reset)
					begin
						Q <= 12'b000000000000; 
					end
				else if(Load)
					begin
						Q <= Load; 
					end
				else if(enable == 1)
					begin
						Q <= Q+1;
					end
				else
					begin
						Q <= Q;
					end
						
			end
endmodule 


module ROM4kx8 (input wire [11:0]Address, output wire [7:0]Data);           
	reg [11:0] ROM [0:4095] ;  
    
	assign Data = ROM[Address];

initial begin
  $readmemb("Lista.txt", ROM); 
end

endmodule

module FLipFlopD4bits(input wire [3:0] D,input wire clk,input wire reset, input wire enable,output [3:0] Q);
reg Q;
	always @(posedge clk or posedge reset)  
		begin
			if(reset)
				begin
					Q <= 0; 
				end
			else if(enable==1) 
				begin
					Q <= D;
				end
			else
				begin
					Q <= Q;
		end
	end
endmodule 

module Fetch (input wire [7:0] D, input wire clk, input wire reset, input wire enable, output [3:0] Instr, output [3:0] Oprnd);

FLipFlopD4bits FFD_1(D[7:4], clk, reset, enable, Instr);
FLipFlopD4bits FFD_2(D[3:0], clk, reset, enable, Oprnd);

endmodule

module Ejercicio_1 (input wire [11:0] Load, input wire clk, input wire reset, input wire enablePG, input wire enableFTCH, output [3:0] Instr, output [3:0] Oprnd);

wire [11:0] No_Instruccion;
wire [7:0]  Instruccion;

Contador12bits	ProgramCounter	(Load, clk, enablePG, reset, No_Instruccion);
ROM4kx8 		ProgramROM		(No_Instruccion, Instruccion);
Fetch			Fetch1			(Instruccion, clk, reset, enableFTCH, Instr, Oprnd);

endmodule