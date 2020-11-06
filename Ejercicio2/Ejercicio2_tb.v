module Ejercicio2_tb();

reg clk, enableACCU, enableBTE1, enableBTE2, reset; 
reg  [2:0] Sel;
reg [3:0] IN;
wire Z, C; 
wire [3:0] Y; 

Ejercicio_2 E2 (IN, Sel, clk, reset, enableACCU, enableBTE1, enableBTE2, Y, Z, C);

initial begin
	clk=1;
	forever #5 clk = ~clk;  
end 

initial begin

	#1 $display("");
	$display("Ejercicio 2");
    $display("RESET ENABLE_ACCU ENABLE_BTE1 ENABLE_BTE2 SELECT ENTRADA | CARRY_FLAG ZERO_FLAG SALIDA");
    $display("---------------------------------------------------------|----------------------------");
    $monitor("%d           %d           %d           %d        %d     %d    |      %d         %d       %d ", reset, enableACCU, enableBTE1, enableBTE2, Sel, IN, C, Z, Y);
	   
	#2 reset = 1; enableACCU = 0; enableBTE1 = 0; enableBTE2 = 0; Sel = 3'b000; IN = 2'b00;
	#5 reset = 0;
	//SE INGRESA EL VALOR DE ENTRADA "5"
	#10 IN = 5;
	//SE HABILITA EL PASO DEL VALOR POR EL BUFFER 1 Y POR LA ALU
	#10 enableBTE1 = 1; Sel = 2;
	//SE HABILITA EL PASO POR EL ACUMULADOR
	#10 enableACCU = 1; 
	//SE CIERRA EL PASO AL ACUMULADOR, SE CIEERA EL PASO POR EL BUFFER 1, SE INGRESA EL VALOR DE ENTRADA "0" 
	#10 enableACCU = 0; enableBTE1 = 0; IN = 0; 
	//SE VA A DEJAR FIJO EL VALOR EN EL ACUMULADOR, SE SELECCIONA EL MODO DE SUMA DE LA ALU Y SE VA A SUMAR CON LOS NUMEROS DEL 0 AL 15
	#10 enableBTE1 = 1; enableBTE2 = 1; Sel = 3;
	#10 IN = 1;
	#10 IN = 2;
	#10 IN = 3;
	#10 IN = 4;
	#10 IN = 5;
	#10 IN = 6;
	#10 IN = 7;
	#10 IN = 8;
	#10 IN = 9;
	#10 IN = 10;
	#10 IN = 11;
	#10 IN = 12;
	#10 IN = 13;
	#10 IN = 14;
	#10 IN = 15;
	//SE INGRESA EL VALOR DE ENTRADA "12" Y SE LE PERMITE EL PASO HASTA EL ACUMULADOR
	#10 IN = 12; enableBTE1 = 1; Sel = 2; enableACCU = 1; enableBTE2 = 0;
	//SE ABRE EL PASO DEL ACUMULADOR A LA SALIDA, SE CIERRA EL PASO AL ACUMULADOR, SE CIEERA EL PASO POR EL BUFFER 1, SE INGRESA EL VALOR DE ENTRADA "0" 
	#10 enableACCU = 0; enableBTE1 = 0; IN = 0; Sel = 0; enableBTE2 = 1;
	//SE PERMITE EL PASO POR EL BUFFER 1, SE SELECCIONA EL MODO DE RESTA DE LA ALU Y SE RESTARÁN LOS VALORES DEL 0 AL 15
	#10 enableBTE1 = 1; Sel = 1;
	#10 IN = 1;
	#10 IN = 2;
	#10 IN = 3;
	#10 IN = 4;
	#10 IN = 5;
	#10 IN = 6;
	#10 IN = 7;
	#10 IN = 8;
	#10 IN = 9;
	#10 IN = 10;
	#10 IN = 11;
	#10 IN = 12;
	#10 IN = 13;
	#10 IN = 14;
	#10 IN = 15;
	//SE INGRESA EL VALOR DE ENTRADA "8" Y SE LE PERMITE EL PASO HASTA EL ACUMULADOR
	#10 IN = 8; enableBTE1 = 1; Sel = 2; enableACCU = 1; enableBTE2 = 0;
	//SE ABRE EL PASO DEL ACUMULADOR A LA SALIDA, SE CIERRA EL PASO AL ACUMULADOR, SE CIEERA EL PASO POR EL BUFFER 1, SE INGRESA EL VALOR DE ENTRADA "0" 
	#10 enableACCU = 0; enableBTE1 = 0; IN = 0; Sel = 0; enableBTE2 = 1;
	//SE PERMITE EL PASO POR EL BUFFER 1, SE SELECCIONA EL MODO DE NAND DE LA ALU Y SE COMPARA EL ACUMULADOR CON LOS VALORES DEL 0 AL 15
	#10 enableBTE1 = 1; Sel = 4;
	#10 IN = 1;
	#10 IN = 2;
	#10 IN = 3;
	#10 IN = 4;
	#10 IN = 5;
	#10 IN = 6;
	#10 IN = 7;
	#10 IN = 8;
	#10 IN = 9;
	#10 IN = 10;
	#10 IN = 11;
	#10 IN = 12;
	#10 IN = 13;
	#10 IN = 14;
	#10 IN = 15;
	
	#10 $display("");
 end
 
initial
#580 $finish; 

initial begin
    $dumpfile("Ejercicio2_tb.vcd");
    $dumpvars(0, Ejercicio2_tb);
end

endmodule 