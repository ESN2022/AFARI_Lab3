	component Lab3_sys is
		port (
			clk_clk                             : in    std_logic := 'X'; -- clk
			opencores_i2c_0_export_0_scl_pad_io : inout std_logic := 'X'; -- scl_pad_io
			opencores_i2c_0_export_0_sda_pad_io : inout std_logic := 'X'; -- sda_pad_io
			reset_reset_n                       : in    std_logic := 'X'  -- reset_n
		);
	end component Lab3_sys;

	u0 : component Lab3_sys
		port map (
			clk_clk                             => CONNECTED_TO_clk_clk,                             --                      clk.clk
			opencores_i2c_0_export_0_scl_pad_io => CONNECTED_TO_opencores_i2c_0_export_0_scl_pad_io, -- opencores_i2c_0_export_0.scl_pad_io
			opencores_i2c_0_export_0_sda_pad_io => CONNECTED_TO_opencores_i2c_0_export_0_sda_pad_io, --                         .sda_pad_io
			reset_reset_n                       => CONNECTED_TO_reset_reset_n                        --                    reset.reset_n
		);

