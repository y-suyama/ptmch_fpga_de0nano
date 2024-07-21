	component de0_nano_system is
		port (
			clk100m_clk_clk                           : out   std_logic;                                        -- clk
			clk_50                                    : in    std_logic                     := 'X';             -- clk
			reset_n                                   : in    std_logic                     := 'X';             -- reset_n
			in_port_to_the_key                        : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			zs_addr_from_the_sdram                    : out   std_logic_vector(12 downto 0);                    -- addr
			zs_ba_from_the_sdram                      : out   std_logic_vector(1 downto 0);                     -- ba
			zs_cas_n_from_the_sdram                   : out   std_logic;                                        -- cas_n
			zs_cke_from_the_sdram                     : out   std_logic;                                        -- cke
			zs_cs_n_from_the_sdram                    : out   std_logic;                                        -- cs_n
			zs_dq_to_and_from_the_sdram               : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			zs_dqm_from_the_sdram                     : out   std_logic_vector(1 downto 0);                     -- dqm
			zs_ras_n_from_the_sdram                   : out   std_logic;                                        -- ras_n
			zs_we_n_from_the_sdram                    : out   std_logic;                                        -- we_n
			in_port_to_the_sw                         : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			trg_pls_component_0_spi_clk_clk           : in    std_logic                     := 'X';             -- clk
			trg_pls_component_0_spi_cs_spi_cs         : in    std_logic                     := 'X';             -- spi_cs
			trg_pls_component_0_spi_mosi_spi_mosi     : in    std_logic                     := 'X';             -- spi_mosi
			trg_pls_component_0_trg_pls_monitorsignal : out   std_logic_vector(4 downto 0)                      -- monitorsignal
		);
	end component de0_nano_system;

	u0 : component de0_nano_system
		port map (
			clk100m_clk_clk                           => CONNECTED_TO_clk100m_clk_clk,                           --                  clk100m_clk.clk
			clk_50                                    => CONNECTED_TO_clk_50,                                    --                clk_50_clk_in.clk
			reset_n                                   => CONNECTED_TO_reset_n,                                   --          clk_50_clk_in_reset.reset_n
			in_port_to_the_key                        => CONNECTED_TO_in_port_to_the_key,                        --      key_external_connection.export
			zs_addr_from_the_sdram                    => CONNECTED_TO_zs_addr_from_the_sdram,                    --                   sdram_wire.addr
			zs_ba_from_the_sdram                      => CONNECTED_TO_zs_ba_from_the_sdram,                      --                             .ba
			zs_cas_n_from_the_sdram                   => CONNECTED_TO_zs_cas_n_from_the_sdram,                   --                             .cas_n
			zs_cke_from_the_sdram                     => CONNECTED_TO_zs_cke_from_the_sdram,                     --                             .cke
			zs_cs_n_from_the_sdram                    => CONNECTED_TO_zs_cs_n_from_the_sdram,                    --                             .cs_n
			zs_dq_to_and_from_the_sdram               => CONNECTED_TO_zs_dq_to_and_from_the_sdram,               --                             .dq
			zs_dqm_from_the_sdram                     => CONNECTED_TO_zs_dqm_from_the_sdram,                     --                             .dqm
			zs_ras_n_from_the_sdram                   => CONNECTED_TO_zs_ras_n_from_the_sdram,                   --                             .ras_n
			zs_we_n_from_the_sdram                    => CONNECTED_TO_zs_we_n_from_the_sdram,                    --                             .we_n
			in_port_to_the_sw                         => CONNECTED_TO_in_port_to_the_sw,                         --       sw_external_connection.export
			trg_pls_component_0_spi_clk_clk           => CONNECTED_TO_trg_pls_component_0_spi_clk_clk,           --  trg_pls_component_0_spi_clk.clk
			trg_pls_component_0_spi_cs_spi_cs         => CONNECTED_TO_trg_pls_component_0_spi_cs_spi_cs,         --   trg_pls_component_0_spi_cs.spi_cs
			trg_pls_component_0_spi_mosi_spi_mosi     => CONNECTED_TO_trg_pls_component_0_spi_mosi_spi_mosi,     -- trg_pls_component_0_spi_mosi.spi_mosi
			trg_pls_component_0_trg_pls_monitorsignal => CONNECTED_TO_trg_pls_component_0_trg_pls_monitorsignal  --  trg_pls_component_0_trg_pls.monitorsignal
		);

