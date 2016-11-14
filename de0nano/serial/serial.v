module serial(
    input CLK_50,
    input RxD,
    input KEY,
    output TxD,
    output [7:0] LED,
    output ACC_CLK,
	inout ACC_DATA,
    output ACC_SELECT,
    input ACC_INTERRUPT
);
`include "parameters.h"
parameter VALUE = 42435;
wire RxD_data_ready;
reg TxD_data_ready;
wire [7:0] RxD_data;
reg [7:0] TxD_data;
wire TxD_busy;
reg [2:0] TxD_state;
assign LED = {RxD_data, dimension, RxD_data_ready, TxD_busy};

// data
reg [2:0] dimension;
wire [15:0] data;


always @(posedge (TxD_busy | RxD_data_ready))
    if(TxD_state == 0)
        begin
            TxD_state = 1;
            if(RxD_data == 120)
                dimension = 0;
            else if(RxD_data == 121)
                dimension = 1;
            else if(RxD_data == 122)
                dimension = 2;
        end
    else if(TxD_state == 4)
        TxD_state = 0;
    else
        TxD_state = TxD_state + 1;

always @(TxD_state)
    if (~TxD_busy)
        if(TxD_state == 1)
            begin
                TxD_data_ready = 1'b1;
                TxD_data <= 0;//data[7:0];
            end

        else if(TxD_state == 2)
            begin
                TxD_data_ready = 1'b1;
                TxD_data <= data[7:0];
            end
        else if(TxD_state == 3)
            begin
                TxD_data_ready = 1'b1;
                TxD_data <= data[15:8];
            end
        else if(TxD_state == 4)
            begin
                TxD_data_ready = 1'b0;
            end
    else if(TxD_busy)
        begin
            TxD_data_ready = 1'b0;
        end

async_receiver RX(.clk(CLK_50), .RxD(RxD), .RxD_data_ready(RxD_data_ready),
                  .RxD_data(RxD_data));

async_transmitter TX(.clk(CLK_50), .TxD(TxD), .TxD_start(TxD_data_ready),
                     .TxD_data(TxD_data), .TxD_busy(TxD_busy));


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

