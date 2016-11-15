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
    input ACC_INTERRUPT,
    output [2:0] OUT
);

// data
reg [1:0] dimension;
reg part;
//reg [15:0] data;
wire [15:0] data;
wire [7:0] data_in;
reg [7:0] data_out;
reg [1:0] write_state;
wire	        dly_rst;
wire	        spi_clk, spi_clk_out;

assign LED = {data};

assign OUT[0] = RP_clock;
assign OUT[1] = RP_CS;
assign OUT[2] = RP_data[0];

always @(posedge RP_clock)
    if (write_state == 0)
        begin
            if(data_in == 120)
                begin
                    write_state = 1;
                    part = 0;
                    dimension = 0;
                end
            else if(data_in == 121)
                begin
                    write_state = 1;
                    part = 0;
                    dimension = 1;
                end
            else if(data_in == 122)
                begin
                    write_state = 1;
                    part = 0;
                    dimension = 2;
                end
            else if(data_in == 88)
                begin
                    write_state = 1;
                    part = 1;
                    dimension = 0;
                end
            else if(data_in == 89)
                begin
                    write_state = 1;
                    part = 1;
                    dimension = 1;
                end
            else if(data_in == 90)
                begin
                    write_state = 1;
                    part = 1;
                    dimension = 2;
                end
        end
    else if (write_state == 1)
        begin
            //data_out <= part ? data[7:0] : data[15:8];
            data_out <= 100;//data[7:0];
            write_state = 2;
        end
    else if (write_state == 2)
        begin
            data_out <= 200;//data[15:8];
            write_state = 0;
        end

parallel_txrx parallel_txrx(.clock(RP_clock), .chip_select(RP_CS),
                            .data_pins(RP_data), .data_in(data_in),
                            .data_out(data_out));


reset_delay	reset_delay	(
            .iRSTN(KEY),
            .iCLK(CLK_50),
            .oRST(dly_rst));
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