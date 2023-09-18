module ATMTestBench();
reg incard_tb, language_tb, again_tb, clock_tb;
reg [1:0] confirm_tb;
reg [1:0] operations_tb;
reg [3:0] password_tb;
reg [5:0] amount_tb;
wire [5:0] balance_tb;
wire incorrectpswd_tb, nobalance_tb, success_tb;
integer I;
integer seed1 = 1;
integer seed2 = 0;
integer seed3 = 2;
integer seed7 = 7;
initial 
  begin


#10
incard_tb = 1'b0; //Tests incard_tb when 0

#10
incard_tb = 1'b1; //tests incard_tb when 1

#10
language_tb = 1'b0; //tests language_tb when 0

#10
incard_tb = 1'b0;

#10
language_tb = 1'b1; //tests language_tb when 1

#10
password_tb = 4'b0011; //wrong password

#10
incard_tb= 1'b1; //returns to incard state

#10
language_tb=1'b1; //language state

#10
password_tb = 4'b0110; //password correct 

#10
operations_tb = 2'b00; //deposit money

#10
amount_tb= 6'b000000;
#10
amount_tb = 6'b100010; //enters money

#10
confirm_tb = 2'b11; //confirm 1

#10
again_tb= 1'b1; //again 1

#10
operations_tb = 2'b01; //balance check

#10
confirm_tb = 2'b11; //confirm 1

#10
again_tb= 1'b1; //again 1

#10
operations_tb = 2'b10; //withdraw

#10
amount_tb = 6'b110011; //enters amount to withdraw

#10
confirm_tb = 2'b11; //confirm 1

#10
again_tb = 1'b0; //again 0

/*
randomization
*/

//$random(seed);

for(I = 0; I< 1000000; I = I+1)
begin
#10
incard_tb= $random(seed1);
language_tb = $random(seed1);
password_tb = 4'b0110;
operations_tb = $random(seed1);
again_tb = $random(seed1);
confirm_tb = $random(seed1);
amount_tb = $random(seed1);

#10
incard_tb= $random(seed2);
language_tb = $random(seed2);
password_tb = 4'b0110;
operations_tb = $random(seed2);
again_tb = $random(seed2);
confirm_tb = $random(seed2);
amount_tb = $random(seed2);

#10
incard_tb= $random(seed3);
language_tb = $random(seed3);
password_tb = 4'b0110;
operations_tb = $random(seed3);
again_tb = $random(seed3);
confirm_tb = $random(seed3);
amount_tb = $random(seed3);


#10
incard_tb= $random(seed7);
language_tb = $random(seed7);
password_tb = 4'b0110;
operations_tb = $random(seed7);
again_tb = $random(seed7);
confirm_tb = $random(seed7);
amount_tb = $random(seed7);
end

$finish;

end

initial 
begin 

      clock_tb = 0;
      forever
       #5 clock_tb=~clock_tb;

end

ATM DUT(
.clk(clock_tb),
.incard(incard_tb),
.language(language_tb),
.password(password_tb),
.operation(operations_tb),
.amount(amount_tb),
.confirm(confirm_tb),
.again(again_tb),
.incorrectpassword(incorrectpswd_tb),
.nobalance(nobalance_tb),
.success(success_tb),
.balance(balance_tb)
);

endmodule
