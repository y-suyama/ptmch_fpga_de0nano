	de0_nano_system u0 (
		.clk100m_clk_clk                           (<connected-to-clk100m_clk_clk>),                           //                  clk100m_clk.clk
		.clk_50                                    (<connected-to-clk_50>),                                    //                clk_50_clk_in.clk
		.reset_n                                   (<connected-to-reset_n>),                                   //          clk_50_clk_in_reset.reset_n
		.in_port_to_the_key                        (<connected-to-in_port_to_the_key>),                        //      key_external_connection.export
		.zs_addr_from_the_sdram                    (<connected-to-zs_addr_from_the_sdram>),                    //                   sdram_wire.addr
		.zs_ba_from_the_sdram                      (<connected-to-zs_ba_from_the_sdram>),                      //                             .ba
		.zs_cas_n_from_the_sdram                   (<connected-to-zs_cas_n_from_the_sdram>),                   //                             .cas_n
		.zs_cke_from_the_sdram                     (<connected-to-zs_cke_from_the_sdram>),                     //                             .cke
		.zs_cs_n_from_the_sdram                    (<connected-to-zs_cs_n_from_the_sdram>),                    //                             .cs_n
		.zs_dq_to_and_from_the_sdram               (<connected-to-zs_dq_to_and_from_the_sdram>),               //                             .dq
		.zs_dqm_from_the_sdram                     (<connected-to-zs_dqm_from_the_sdram>),                     //                             .dqm
		.zs_ras_n_from_the_sdram                   (<connected-to-zs_ras_n_from_the_sdram>),                   //                             .ras_n
		.zs_we_n_from_the_sdram                    (<connected-to-zs_we_n_from_the_sdram>),                    //                             .we_n
		.in_port_to_the_sw                         (<connected-to-in_port_to_the_sw>),                         //       sw_external_connection.export
		.trg_pls_component_0_spi_clk_clk           (<connected-to-trg_pls_component_0_spi_clk_clk>),           //  trg_pls_component_0_spi_clk.clk
		.trg_pls_component_0_spi_cs_spi_cs         (<connected-to-trg_pls_component_0_spi_cs_spi_cs>),         //   trg_pls_component_0_spi_cs.spi_cs
		.trg_pls_component_0_spi_mosi_spi_mosi     (<connected-to-trg_pls_component_0_spi_mosi_spi_mosi>),     // trg_pls_component_0_spi_mosi.spi_mosi
		.trg_pls_component_0_trg_pls_monitorsignal (<connected-to-trg_pls_component_0_trg_pls_monitorsignal>)  //  trg_pls_component_0_trg_pls.monitorsignal
	);

