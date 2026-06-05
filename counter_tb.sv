`timescale 1ns / 1ps
module counter_tb();
    logic clk;
    logic rst_n;
    logic load;
    logic up_down;
    logic enable;
    logic [3:0] d_in;
    logic [3:0] count;
    logic test_passed;

    // Clock generation
    initial begin
        // Fill in code here
      clk=0;
      forever #5 clk=~clk;
      
    end

    // Instance of student's module
  updown_counter dut(.clk(clk),
                     .rst_n(rst_n),
                     .load(load),
                     .up_down(up_down),
                     .enable(enable),
                     .d_in(d_in),
                     .count(count)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,counter_tb);
       
        test_passed = 1'b1;
        
        // Reset
        rst_n = 0;
        load = 0;
        up_down = 1;
        enable = 0;
        d_in = 4'h0;
        #20;
        rst_n = 1;

        // Test Case 1: Load value
        d_in = 4'h7;
        load = 1;
        #10;
        load = 0;
        if (count !== 4'h7) begin
            $display("Test 1 Failed: Load operation");
            test_passed = 1'b0;
        end

        // Test Case 2: Count up
        enable = 1;
        up_down = 1;
        #40;  // 4 clock cycles
        if (count !== 4'hB) begin
            $display("Test 2 Failed: Count up operation");
            test_passed = 1'b0;
        end

        // Test Case 3: Count down
        up_down = 0;
        #30;  // 3 clock cycles
        if (count !== 4'h8) begin
            $display("Test 3 Failed: Count down operation");
            test_passed = 1'b0;
        end

        // Test Case 4: Disabled counter should not change
        enable = 0;
        #20;
        if (count !== 4'h8) begin
            $display("Test 4 Failed: Disabled counter changed");
            test_passed = 1'b0;
        end

        // Test Case 5: Reset during operation
      enable=1;
      up_down=1;
      #10;
      rst_n=0;
      #10;
      if(count!==4'h0)begin
        $display("Test 5 failed: Reset during operation");
        test_passed=1'b0;
      end
      rst_n = 0;
      #10;
      rst_n = 1;   // Missing

        // Test Case 6: Load while counting
      d_in=4'h5;
      load=1;
      #10;
      load=0;
      if(count!==4'h5)begin
        $display("Test 6 failed:Load while counting");
        test_passed=1'b0;
      end

        // Test Case 7: Disable while counting
       enable=1;
       up_down=1;
       #20;
       enable=0;
       #20;
       if(count!==4'h7)begin
         $display("Test 7 failed:Disable while counting");
         test_passed=1'b0;
       end
                   

        // Final check
        if (test_passed) begin
            $display("All tests passed!");
        end else begin
            $display("Some tests failed.");
        end

        $finish(0);
    end
endmodule
