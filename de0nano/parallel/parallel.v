module parallel(
    input CLK_50,
    inout [9:0] RP,
    input KEY,
    output [7:0] LED
);

// data
reg [2:0] dimension;
wire [15:0] data;

parallel_txrx parallel_txrx(.clock(RP[0]), .chip_select(RP[1]), .data(RP[9:2]));

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

endmodule