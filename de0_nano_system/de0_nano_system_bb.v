
module de0_nano_system (
	clk100m_clk_clk,
	clk_50,
	reset_n,
	in_port_to_the_key,
	zs_addr_from_the_sdram,
	zs_ba_from_the_sdram,
	zs_cas_n_from_the_sdram,
	zs_cke_from_the_sdram,
	zs_cs_n_from_the_sdram,
	zs_dq_to_and_from_the_sdram,
	zs_dqm_from_the_sdram,
	zs_ras_n_from_the_sdram,
	zs_we_n_from_the_sdram,
	in_port_to_the_sw,
	trg_pls_component_0_spi_clk_clk,
	trg_pls_component_0_spi_cs_spi,
	trg_pls_component_0_spi_mosi_spi,
	trg_pls_component_0_trg_pls_triggersignal);	

	output		clk100m_clk_clk;
	input		clk_50;
	input		reset_n;
	input	[1:0]	in_port_to_the_key;
	output	[12:0]	zs_addr_from_the_sdram;
	output	[1:0]	zs_ba_from_the_sdram;
	output		zs_cas_n_from_the_sdram;
	output		zs_cke_from_the_sdram;
	output		zs_cs_n_from_the_sdram;
	inout	[15:0]	zs_dq_to_and_from_the_sdram;
	output	[1:0]	zs_dqm_from_the_sdram;
	output		zs_ras_n_from_the_sdram;
	output		zs_we_n_from_the_sdram;
	input	[3:0]	in_port_to_the_sw;
	input		trg_pls_component_0_spi_clk_clk;
	input		trg_pls_component_0_spi_cs_spi;
	input		trg_pls_component_0_spi_mosi_spi;
	output	[4:0]	trg_pls_component_0_trg_pls_triggersignal;
endmodule
