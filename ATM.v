module ATM(
	input clk,
	input incard,
	input language,
	input [3:0] password,
	input [1:0] operation,
	input [5:0] amount,
	input [1:0] confirm,
	input again,
	output reg incorrectpassword,
	output reg nobalance,
	output reg success,
	output reg [5:0] balance);
	
	localparam [3:0]	S0=4'b0000,//idle
						S1=4'b0001,//input language
						S2=4'b0010,//input password
						S3=4'b0011,//chooseop
						S4=4'b0100,//deposit
						S5=4'b0101,//withdraw
						S6=4'b0110,//balance
						S7=4'b0111,//confirm amount
						S8=4'b1000,//another services
						correctpass=4'b0110;
						
	reg [3:0]	currentstate,
				nextstate;
	reg [5:0] bal;
initial 
		begin
		currentstate = S0;
		bal=6'b110000;
		nobalance=0;
        success=0;
        incorrectpassword=0;
		end
always @(posedge clk)
	begin
		currentstate <= nextstate ;
	end
 always @(*)
	begin
	case(currentstate)
	S0	:	begin
			if(!incard)
				nextstate=S0;
			else
				nextstate=S1;
			end
	S1	:	begin
			if(!language)
				nextstate = S1;
			else 
				nextstate = S2;
			end
	S2	:	begin
			if(password == correctpass)
				begin
				nextstate = S3;
				incorrectpassword = 1'b0;
				end
			else
				begin
				nextstate = S0;
				incorrectpassword = 1'b1;
				end	
			end
	S3	:	begin
			case (operation)
			2'b00 :		nextstate =S4;
			2'b10 :		nextstate = S5;
			2'b01 :		nextstate = S6;
			default : nextstate = S3;
			endcase
			end
	
	S4	:	begin
			if(amount)
				nextstate = S7;
			else
				nextstate = S4;
				
			end
	S5	:	begin
			if(amount && amount < balance)	
					nextstate = S7;
			else
					nextstate = S5;
					
			end
	S6	:	begin
			if(confirm == 2'b10)
				nextstate = S8;
			else 
				nextstate = S6;
				
			end
	S7	:	begin
			case (confirm)
			2'b00 : nextstate = S4;
			2'b01 : nextstate = S5;
			2'b11 : nextstate = S8;
			default : nextstate = S7;
			endcase
			end
			
	S8	: 	begin
			if(again)
				nextstate = S3;
			else
				nextstate = S0;
			end				
	endcase
	end
		


always @ (*)
	begin
	case (currentstate)
	S2:	begin
		if(password == correctpass)
			incorrectpassword = 0;
		else	
			incorrectpassword = 1;
		end
	S7 : begin
		if(amount && operation == 2'b00)
			bal = bal + amount;
		else if(amount <= bal && operation == 2'b10)
			begin	
				bal = bal - amount;
				nobalance = 0 ;
			end
		else if(amount > bal && operation == 2'b10)
			nobalance = 1;
		else nobalance = 0;
		 end
	S8 : success = 1;
		
	endcase
	balance = bal;
	end

//psl assert always ((S2 && (password == 4'b0110)) -> next (correctpass)) @(posedge clk);
//psl assert always ((S7 && (confirm)) -> next (success)) @(posedge clk);

endmodule

