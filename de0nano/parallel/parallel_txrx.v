module parallel_txrx(
    input clock,
    input chip_select,
    inout [7:0] data_pins,
    output reg [7:0] data_in,
    input [7:0] data_out
);

reg [7:0] data_out_internal;

assign data_pins = chip_select ? 8'bZ : data_out_internal;

always @(negedge clock)
    // if chip select is high, the fpga is reading in data
    if(chip_select)
        data_in <= data_pins;
    else
        data_out_internal <= data_out;


endmodule