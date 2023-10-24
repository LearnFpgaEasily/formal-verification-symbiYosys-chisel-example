`ifdef FORMAL
initial assume(reset);
// check that the counter does not reach max count
always @(posedge clk) begin
  if(reset==0)
  assert(io_count <=12);
end

always @(posedge clk) begin
  if(reset==0 && $past(io_pulse==1)) assert(io_pulse==0); 
end
`endif