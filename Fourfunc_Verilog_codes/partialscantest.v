module partialscantestbench ();
  fourFunc MUT ( .clk(clk), .rst(rst), .start(start), .func(func), .x(x), .busy(busy), .addr(addr), .tableData(tableData), .resultIPart(resultIPart), .resultFPart(resultFPart) );
  /*reg NbarT;
  reg rst;
  reg start;
  reg func;
  reg [7:0] x;
  reg [7:0] adderinput1;
  reg [7:0] adderinput2;
  reg [7:0] mulinput1;
  reg [7:0] mulinput2;*/
  initial repeat (20) #50 clk = ~clk;
  /* initial repeat (8) begin
    adderinput1 = $random();
    adderinput2 = $random();
    mulinput1 = $random();
    mulinput2 = $random();
    #100;
  end*/
  initial repeat (10) begin 
    //NbarT = 1'b1;
    rst = 0;
    start = 1;
    func = 00;
    x = $random();
    #100;
  end
  initial begin
    #300;
    repeat (10) begin
      //check
      #100;
    end
  end
  /*always @(negedge clk) begin
    if (adderout != adderinput1 + adderinput2)  
      $display ("Adder is faulty");
    if (mulout != mulinput1 * mulinput2) 
      $display ("Multiplier is faulty");
  end*/
endmodule


