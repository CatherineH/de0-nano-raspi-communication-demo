module parallel(
    input CLK_50,
    input RP_clock,
    input RP_CS,
    inout [7:0] RP_data,
    input KEY,
    output [7:0] LED,
    output ACC_CLK,
	inout ACC_DATA,
    output ACC_SELECT,
    input ACC_INTERRUPT
);

// data
reg [2:0] dimension;
wire [15:0] data;
wire [7:0] data_in;
reg [7:0] data_out;
reg [1:0] write_state;

assign LED = {RP_data, RP_CS, RP_clock};
/*
always @(posedge RP_clock)
    if (write_state == 0)
        begin
            if(data_in == 120)
                dimension = 0;
            else if(data_in == 121)
                dimension = 1;
            else if(data_in == 122)
                dimension = 2;
            write_state = 1;
        end
    else if (write_state == 1)
        begin
            data_out <= data[7:0];
            write_state = 2;
        end
    else if (write_state == 2)
        begin
            data_out <= data[15:8];
            write_state = 0;
        end

parallel_txrx parallel_txrx(.clock(RP_clock), .chip_select(RP_CS),
                            .data_pins(RP_data), .data_in(data_in),
                            .data_out(data_out));

//  PLL
spipll spipll(
            .areset(dly_rst),
            .inclk0(CLK_50),
            .c0(spi_clk),      // 2MHz
            .c1(spi_clk_out)); // 2MHz phase shift

//  Initial Setting and Data Read Back
spi_ee_config spi_ee_config (
						.iRSTN(!dly_rst),
						.iSPI_CLK(spi_clk),
						.iSPI_CLK_OUT(spi_clk_out),
						.iG_INT2(ACC_INTERRUPT),
						.dimension(dimension),
						.oDATA_L(data[7:0]),
						.oDATA_H(data[15:8]),
						.SPI_SDIO(ACC_DATA),
						.oSPI_CSN(ACC_SELECT),
						.oSPI_CLK(ACC_CLK));
*/
endmodule