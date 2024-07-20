	component de0_nano_system is
		port (
			altpll_0_c1_clk             : out   std_logic;                                        -- clk
			clk_50                      : in    std_logic                     := 'X';             -- clk
			reset_n                     : in    std_logic                     := 'X';             -- reset_n
			in_port_to_the_key          : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			zs_addr_from_the_sdram      : out   std_logic_vector(12 downto 0);                    -- addr
			zs_ba_from_the_sdram        : out   std_logic_vector(1 downto 0);                     -- ba
			zs_cas_n_from_the_sdram     : out   std_logic;                                        -- cas_n
			zs_cke_from_the_sdram       : out   std_logic;                                        -- cke
			zs_cs_n_from_the_sdram      : out   std_logic;                                        -- cs_n
			zs_dq_to_and_from_the_sdram : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			zs_dqm_from_the_sdram       : out   std_logic_vector(1 downto 0);                     -- dqm
			zs_ras_n_from_the_sdram     : out   std_logic;                                        -- ras_n
			zs_we_n_from_the_sdram      : out   std_logic;                                        -- we_n
			in_port_to_the_sw           : in    std_logic_vector(3 downto 0)  := (others => 'X')  -- export
		);
	end component de0_nano_system;

	u0 : component de0_nano_system
		port map (
			altpll_0_c1_clk             => CONNECTED_TO_altpll_0_c1_clk,             --             altpll_0_c1.clk
			clk_50                      => CONNECTED_TO_clk_50,                      --           clk_50_clk_in.clk
			reset_n                     => CONNECTED_TO_reset_n,                     --     clk_50_clk_in_reset.reset_n
			in_port_to_the_key          => CONNECTED_TO_in_port_to_the_key,          -- key_external_connection.export
			zs_addr_from_the_sdram      => CONNECTED_TO_zs_addr_from_the_sdram,      --              sdram_wire.addr
			zs_ba_from_the_sdram        => CONNECTED_TO_zs_ba_from_the_sdram,        --                        .ba
			zs_cas_n_from_the_sdram     => CONNECTED_TO_zs_cas_n_from_the_sdram,     --                        .cas_n
			zs_cke_from_the_sdram       => CONNECTED_TO_zs_cke_from_the_sdram,       --                        .cke
			zs_cs_n_from_the_sdram      => CONNECTED_TO_zs_cs_n_from_the_sdram,      --                        .cs_n
			zs_dq_to_and_from_the_sdram => CONNECTED_TO_zs_dq_to_and_from_the_sdram, --                        .dq
			zs_dqm_from_the_sdram       => CONNECTED_TO_zs_dqm_from_the_sdram,       --                        .dqm
			zs_ras_n_from_the_sdram     => CONNECTED_TO_zs_ras_n_from_the_sdram,     --                        .ras_n
			zs_we_n_from_the_sdram      => CONNECTED_TO_zs_we_n_from_the_sdram,      --                        .we_n
			in_port_to_the_sw           => CONNECTED_TO_in_port_to_the_sw            --  sw_external_connection.export
		);

