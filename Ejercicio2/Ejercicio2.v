module BufferTriEstado4bits (input wire enable, input wire [3:0 ] IN, output [3:0] OUT); 

assign OUT = enable ? IN : 4'bz;

endmodule

module ALU (input wire [3:0]A, input wire [3:0]B, input wire [2:0]Sel, input wire reset, output reg [3:0]Y, output reg Z, output reg C); 
reg [4:0] P;

	always @ (A or B or Sel) 
		case (Sel) 
			0 : begin
					Y = A;
					P = 5'b00000;
					begin
						C <= P[4];
					end
				end
			1 :  begin
					P = A - B; 
					Y[0] = P[0];
					Y[1] = P[1];
					Y[2] = P[2];
					Y[3] = P[3];
					begin
						C <= P[4];
					end
				end
			2 : begin
					Y = B;
					P = 5'b00000;
					begin
						C <= P[4];
					end
				end
			3 : begin
					P = A + B; 
					Y[0] = P[0];
					Y[1] = P[1];
					Y[2] = P[2];
					Y[3] = P[3];
					begin
						C <= P[4];
					end
				end
			4 :begin
					Y = ~(A & B);
					P = 5'b00000;
					begin
						C <= P[4];
					end
				end
			
			default : $display("Error in Sel"); 
		endcase 
	
	
	always @(Y or posedge reset)  
		begin
			if(Y == 4'b0000 )
				begin
					Z <= 1; 
				end
			else if (reset)
				begin
					P <= 5'b00000;
				end
			else 
				begin
					Z <= 0;
				end
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

module Ejercicio_2(input wire[3:0]IN, input wire[2:0]Sel, input wire clk, input wire reset, input wire enableACCU, input wire enableBTE1, input wire enableBTE2, output[3:0]Y, output Z, output C);

wire [3:0] OUT_BTE1;
wire [3:0] OUT_ACCU;
wire [3:0] OUT_ALU;

BufferTriEstado4bits	BTE1 (enableBTE1, IN, OUT_BTE1);
ALU						ALU1 (OUT_ACCU, OUT_BTE1, Sel, reset, OUT_ALU, Z, C);
FLipFlopD4bits			ACCU (OUT_ALU, clk, reset, enableACCU, OUT_ACCU);
BufferTriEstado4bits	BTE2 (enableBTE2, OUT_ALU, Y);

endmodule