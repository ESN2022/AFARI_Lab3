library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Lab3 is
	port (
		clk : in    std_logic; --                       clk.clk
		reset : in std_logic;
		i2c_scl : inout std_logic                     := '0'; --  opencores_i2c_0_export_0.scl_pad_io
		i2c_sda : inout std_logic                     := '0'; --                          .sda_pad_io
		cs_n: out std_logic ;
		ALT_ADRESS: out std_logic
	);
	end entity;

architecture arch of Lab3 is

component Lab3_sys is
		port (
			clk_clk                             : in    std_logic := 'X'; -- clk
			reset_reset_n                       : in    std_logic := 'X'; -- reset_n
			opencores_i2c_0_export_0_scl_pad_io : inout std_logic := 'X'; -- scl_pad_io
			opencores_i2c_0_export_0_sda_pad_io : inout std_logic := 'X'  -- sda_pad_io
		);
end component Lab3_sys;
	
begin
cs_n <= '1';
ALT_ADRESS <='1';

u0 : component Lab3_sys
		port map (
			clk_clk                             => clk,     --                      clk.clk
			reset_reset_n                       => reset,   --                    reset.reset_n
			opencores_i2c_0_export_0_scl_pad_io => i2c_scl, -- opencores_i2c_0_export_0.scl_pad_io
			opencores_i2c_0_export_0_sda_pad_io => i2c_sda  --                         .sda_pad_io
		);
end architecture;