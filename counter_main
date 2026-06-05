module updown_counter(
    input logic clk,       // Clock input
    input logic rst_n,     // Active-low reset
    input logic load,      // Load enable
    input logic up_down,   // Direction control (1 = up, 0 = down)
    input logic enable,    // Counter enable
    input logic [3:0] d_in,// Input data for loading
    output logic [3:0] count // Counter output
);
  always_ff @(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
    begin
       count<=4'b0000;
    end
    else if(load)
    begin
      count<=d_in;
    end
    else if(enable)
    begin
      if(up_down)
        count<=count+1'b1;
      else
        count<=count-1'b1;
    end
  end


endmodule
