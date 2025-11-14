// Code your design here
// Code your design here
// Code your design here


////   0101 and 0110 detector //////



module pattern_0110_detector(
  input clk,
  input reset,
  input in,
  output out
);
  
  // pattern detector for 0110 using mealy;
  
  
  reg [2-1:0] state;
  reg [2-1:0] nextstate;
  
  localparam A=0;
  localparam B=1;
  localparam C=2;
  localparam D=3;
  
  always @(posedge clk) begin
    if(reset) begin
      state <= A;
    end 
    else 
      state <= nextstate;
  end 
  
  always @(*) begin
    case(state)
      A: nextstate = in ? A : B;
      B: nextstate = in ? C : B;
      C: nextstate = in ? D : B;
      D: nextstate = in ? A : B;
    endcase
  end 
  
  assign out = ((state==D)&& in==0) ? 1:0;

  property FSM_Assertion_0110(logic present_state, logic inp, logic nxtstate);
    @(posedge clk)
      disable iff(reset)
      (state == present_state && inp) |=> (state == nxtstate) ; 
  endproperty: FSM_Assertion_0110

  stateA_in1: assert property(FSM_Assertion_0110(A,in,A));
  stateA_in0: assert property(FSM_Assertion_0110(A,~in,B));
  stateB_in0: assert property(FSM_Assertion_0110(B,~in,B));
  stateB_in1: assert property(FSM_Assertion_0110(B,in,C));
  stateC_in1: assert property(FSM_Assertion_0110(C,in,D));
  stateC_in0: assert property(FSM_Assertion_0110(C,~in,B));
  stateD_in0: assert property(FSM_Assertion_0110(D,~in,B));
  stateD_in1: assert property(FSM_Assertion_0110(D,in,A));
  
  
endmodule


///  for 0101 detector

// Code your design here
// Code your design here

// pattern detector "0101".

module pattern_0101_detector(
        input clk,
        input in,
        input reset,
        output out
);
  
  /* since pattern "0101" is of four bits so each state will be of two bits like */
  
  reg [2-1:0] state;      //present state
  reg [2-1:0] nextstate;  // next state
  
  // input may be either zero or one;
  
  localparam A=0;
  localparam B=1;
  localparam C=2; 
  localparam D=3;

  // Instantiation
 
  always @(posedge clk) begin
    if(reset) begin
      state<= A;

    end 
    else
      state <=nextstate;
  end 
  
  always @(*) begin   
    case(state)
      A: nextstate = in ? A:B;
      B: nextstate = in ? C:B;
      C: nextstate = in ? A:D;
      D: nextstate = in ? C:B;
    endcase
  end
  
  assign out = ((state==D)&&(in==1))?1:0;

  // check when the system is in reset state then 
  // it should be on state "A"

  property if_reset;
    @(posedge clk)
      reset |-> (state == A);
  endproperty: if_reset

  property_if_reset: assert property(if_reset);

  /*

  // This will check that if the present state is A
  // and input is 0 then the state after one clock cycle should be B.

  property state_A_to_B;
    @(posedge clk)
      disable iff(reset)
      (state == A && in == 0) |=> state == B;
  endproperty: state_A_to_B

  property_state_A_to_B: assert property(state_A_to_B);

  // This will check that if the present state is A
  // and input is 1 then the state after one clock cycle should be A.

  property state_A_if_in1;
    @(posedge clk)
      disable iff(reset)
      (state == A && in) |=> state == A;
  endproperty: state_A_if_in1

  property_state_A_if_in1: assert property(state_A_if_in1);

  // This will check that if the present state is B
  // and input is 1 then the state after one clock cycle should be C.

  property state_B_in1;
    @(posedge clk)
      disable iff(reset)
      (state == B && in) |=> state == C ;
  endproperty: state_B_in1

  property_state_B_if_in1: assert property (state_B_in1);

  // This will check that if the present state is B
  // and input is 0 then the state after one clock cycle should be B.

  property state_B_in0;
    @(posedge clk)
      disable iff(reset)
      (state == B && !in) |=> state == B ;
  endproperty: state_B_in0

  property_state_B_if_in0: assert property (state_B_in0);

  // This will check that if the present state is C
  // and input is 0 then the state after one clock cycle should be D.

  property state_C_if_in0;
    @(posedge clk)
    disable iff(reset)
    state == C && !in |=> state == D;
  endproperty:state_C_if_in0

  property_state_C_if_in0: assert property(state_C_if_in0);

  // This will check that if the present state is C
  // and input is 1 then the state after one clock cycle should be A.

  property state_C_if_in1;
    @(posedge clk)
    disable iff(reset)
    state == C && in |=> state == A;
  endproperty:state_C_if_in1

  property_state_C_if_in1: assert property(state_C_if_in1);

  // This will check that if the present state is A
  // and input is 0 then the state after one clock cycle should be B.

  property state_D_if_in1;
    @(posedge clk)
    disable iff(reset)
    state == D && in |-> out ##1 (state == C);
  endproperty:state_D_if_in1

  property_state_D_if_in1: assert property(state_D_if_in1);

  // This will check that if the present state is A
  // and input is 0 then the state after one clock cycle should be B.


  property state_D_if_in0;
    @(posedge clk)
    disable iff(reset)
    state == D && !in |=> state == B;
  endproperty: state_D_if_in0

  property_state_D_if_in0: assert property(state_D_if_in0);

  // This will check that if the present state is D
  // and input is 0 then the state after one clock cycle should be B.
  */

  property FSM_Assertion(logic present_state,logic inp, logic nxtstate);
    @(posedge clk)
      disable iff(reset)
      (state == present_state && inp) |=> (state == nxtstate);
  endproperty:FSM_Assertion

  // This will check that if the present state is A
  // and input is 1 then the state after one clock cycle should be A.

  stateA_in1: assert property(FSM_Assertion(A,in,A));

  // This will check that if the present state is A
  // and input is 0 then the state after one clock cycle should be B.

  stateA_in0: assert property(FSM_Assertion(A,~in,B));

  // This will check that if the present state is B
  // and input is 1 then the state after one clock cycle should be C.
  stateB_in1: assert property(FSM_Assertion(B,in,C));

  // This will check that if the present state is B
  // and input is 0 then the state after one clock cycle should be B.
  stateB_in0: assert property(FSM_Assertion(B,~in,B));

  // This will check that if the present state is C
  // and input is 0 then the state after one clock cycle should be D.
  stateC_in0: assert property(FSM_Assertion(C,~in,D));

  // This will check that if the present state is C
  // and input is 1 then the state after one clock cycle should be A.
  stateC_in1: assert property(FSM_Assertion(C,in,A));

  // This will check that if the present state is D
  // and input is 1 then the state after one clock cycle should be C.
  stateD_in1: assert property(FSM_Assertion(D,in,C));

  // This will check that if the present state is D
  // and input is 0 then the state after one clock cycle should be B.
  stateD_in0: assert property(FSM_Assertion(D,~in,B));

endmodule

module pattern_0110_or_0101_detector(
  input clk,
  input reset,
  input in,
  output reg out
);
  
  
  wire out1;
  wire out2;
  
  // Instantitaion
  
  
  pattern_0101_detector inst1(.clk(clk) , .reset(reset), .in(in), .out(out1));
  pattern_0110_detector inst(.clk(clk), .reset(reset), .in(in), .out(out2)); 
  
  always @(posedge clk) begin
    if(reset) begin
      out <=0;
    end 
  end 
  always @(*) begin
        out = out1 | out2;
  end 
endmodule
