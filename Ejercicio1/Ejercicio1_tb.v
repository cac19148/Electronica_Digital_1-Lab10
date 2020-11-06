module Ejercicio1_tb();

reg clk, enablePG, enableFTCH, reset; 
reg [11:0] Load;
wire [3:0] Instr; 
wire [3:0] Oprnd; 

Ejercicio_1 E1 (Load, clk, reset, enablePG, enableFTCH, Instr, Oprnd);

initial begin
	clk=1;
	forever #5 clk = ~clk;  
end 

initial begin

	#1 $display("");
	$display("Ejercicio 1");
    $display("RESET ENABLE_PG ENABLE_FTCH LOAD | INTRUCCION OPERANDO ");
    $display("---------------------------------|---------------------");
    $monitor("%d         %d          %d     %d  |    %d       %d   ", reset, enablePG, enableFTCH, Load, Instr, Oprnd);
	   
	#2 reset = 1; enablePG = 0; enableFTCH = 0; Load = 12'b000000000000;
	#5 reset = 0;
	
	#10  enablePG = 1; enableFTCH = 0;
	#10  enablePG = 1; enableFTCH = 1;
	#90  Load     = 12'b000000010000;
	#40  Load     = 12'b000000000101;
	#50  enablePG = 0;
	
	#10 $display("");
 end
 
initial
#240 $finish; 

initial begin
    $dumpfile("Ejercicio1_tb.vcd");
    $dumpvars(0, Ejercicio1_tb);
end

endmodule 
	