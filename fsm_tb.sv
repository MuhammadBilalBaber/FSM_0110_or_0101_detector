module tb_seq_detector();


  //Ports

  reg clk  ;
  reg reset;
  reg in   ;
  wire out  ;


  //Instantiation
  pattern_0110_or_0101_detector dut(.clk(clk),
                                    .reset(reset),
                                    .in(in),
                                    .out(out)
                                    );
 
 
// clock
  always #5 clk=~clk;



//Initial Block
  initial begin
   clk=1;
   reset=1;
   in=1;
   @(posedge clk);
   @(posedge clk);
    reset=0;
    @(posedge clk)  in=1;
    @(posedge clk)  in=0;
    @(posedge clk) in=1;
    @(posedge clk) in=0;
    @(posedge clk) in=1;
    @(posedge clk) in=0;
    @(posedge clk) in=1;
    @(posedge clk) in=1;

    @(posedge clk) in=0;
    @(posedge clk) in=1;
    @(posedge clk) in=1;
    @(posedge clk) in=0;
    @(posedge clk) in=0;
    @(posedge clk) in=1;
    @(posedge clk) in=1;
    @(posedge clk) in=0;

       #100;
       $finish;
  end
  initial begin
    $monitor(" reset=%b in=%b out=%b" ,reset,in,out);   
  end 

  initial begin
    $fsdbDumpfile("fsm_tb.fsdb");
    $fsdbDumpvars(0,tb_seq_detector);
  end
 

endmodule




