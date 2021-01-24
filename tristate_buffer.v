
module tristate_buffer(input_x, enable, output_x);

input [3:0]input_x;

input enable;

output tri [3:0]output_x;

assign output_x = enable? input_x : 'bz;

endmodule
