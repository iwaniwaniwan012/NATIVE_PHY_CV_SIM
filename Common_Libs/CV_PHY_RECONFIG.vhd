library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

entity CV_PHY_RECONFIG is
	port (
		Clk					: in std_logic;
		Reset					: in std_logic;
		
		Speed_Req			: in std_logic;
		Speed					: in std_logic;
		Rcfg_Done			: out std_logic;
		
		avmm_address		: out std_logic_vector(7 downto 0);
		avmm_write			: out std_logic;
		avmm_writedata		: out std_logic_vector(31 downto 0);
		avmm_read			: out std_logic;
		avmm_readdata		: in std_logic_vector(31 downto 0);
		avmm_busy			: in std_logic;
		
		mif_address      	: in std_logic_vector(7 downto 0);
		mif_read        	: in std_logic;
		mif_readdata		: out std_logic_vector(15 downto 0);
		mif_waitrequest	: out std_logic
	);
end entity;

architecture behavioral of CV_PHY_RECONFIG is

signal wire_n_phy_rcfg_1250mbps_address		: std_logic_vector(7 downto 0) := (others => '0');
signal wire_n_phy_rcfg_1250mbps_clock			: std_logic	:= '0';
signal wire_n_phy_rcfg_1250mbps_rden			: std_logic := '0';
signal wire_n_phy_rcfg_1250mbps_dataout		: std_logic_vector(15 downto 0) := (others => '0');
signal wire_n_phy_rcfg_2500mbps_address		: std_logic_vector(7 downto 0) := (others => '0');
signal wire_n_phy_rcfg_2500mbps_clock			: std_logic	:= '0';
signal wire_n_phy_rcfg_2500mbps_rden			: std_logic := '0';
signal wire_n_phy_rcfg_2500mbps_dataout		: std_logic_vector(15 downto 0) := (others => '0');
signal wire_n_phy_pll_rcfg_1250mbps_address	: std_logic_vector(3 downto 0) := (others => '0');
signal wire_n_phy_pll_rcfg_1250mbps_clock		: std_logic := '0';
signal wire_n_phy_pll_rcfg_1250mbps_rden		: std_logic := '0';
signal wire_n_phy_pll_rcfg_1250mbps_dataout	: std_logic_vector(15 downto 0) := (others => '0');
signal wire_n_phy_pll_rcfg_2500mbps_address	: std_logic_vector(3 downto 0) := (others => '0');
signal wire_n_phy_pll_rcfg_2500mbps_clock		: std_logic := '0';
signal wire_n_phy_pll_rcfg_2500mbps_rden		: std_logic := '0';
signal wire_n_phy_pll_rcfg_2500mbps_dataout	: std_logic_vector(15 downto 0) := (others => '0');

signal dmif_read 	: std_logic := '0';
signal davmm_busy	: std_logic := '0';

signal Counter		: std_logic_vector(2 downto 0) := (others => '0');
type States	is (IDLE, PREPARE_PHY_RECONFIG, WAIT_PHY_MIF_STEAMING, PREPARE_PLL_RECONFIG, WAIT_PLL_MIF_STREAMING);
signal State : States := IDLE;
signal Speed_Loc	: std_logic := '0';
signal Rcfg_Type	: std_logic := '0';

signal Read_Data_Valid	: std_logic := '0';

begin

	wire_n_phy_rcfg_1250mbps_clock		<= Clk;
	wire_n_phy_rcfg_2500mbps_clock		<= Clk;
	wire_n_phy_pll_rcfg_1250mbps_clock	<= Clk;
	wire_n_phy_pll_rcfg_2500mbps_clock	<= Clk;
	
	wire_n_phy_rcfg_1250mbps_address			<= mif_address;
	wire_n_phy_rcfg_2500mbps_address			<= mif_address;
	wire_n_phy_pll_rcfg_1250mbps_address	<= mif_address(3 downto 0);
	wire_n_phy_pll_rcfg_2500mbps_address	<= mif_address(3 downto 0);
	
	wire_n_phy_rcfg_1250mbps_rden			<= '1' when mif_read = '1' and Speed_Loc = '0' and Rcfg_Type = '0' else '0';
	wire_n_phy_rcfg_2500mbps_rden			<= '1' when mif_read = '1' and Speed_Loc = '1' and Rcfg_Type = '0' else '0';
	wire_n_phy_pll_rcfg_1250mbps_rden	<= '1' when mif_read = '1' and Speed_Loc = '0' and Rcfg_Type = '1' else '0';
	wire_n_phy_pll_rcfg_2500mbps_rden	<= '1' when mif_read = '1' and Speed_Loc = '1' and Rcfg_Type = '1' else '0';
	
	mif_readdata <= 	wire_n_phy_rcfg_1250mbps_dataout when Speed_Loc = '0' and Rcfg_Type = '0' else
							wire_n_phy_rcfg_2500mbps_dataout when Speed_Loc = '1' and Rcfg_Type = '0' else
							wire_n_phy_pll_rcfg_1250mbps_dataout when Speed_Loc = '0' and Rcfg_Type = '1' else
							wire_n_phy_pll_rcfg_2500mbps_dataout when Speed_Loc = '1' and Rcfg_Type = '1';
	
	mif_waitrequest 	<=	'0' when dmif_read = '1' else
								'1' when mif_read = '1';
	
	Speed_Loc <= Speed when Rising_Edge(Clk) and Speed_Req = '1';
	
	Read_Data_Valid <= '1' when avmm_busy = '0' and davmm_busy = '1' else '0';
	
	process(Clk) begin
		if Rising_Edge(Clk) then
			davmm_busy <= avmm_busy;
			dmif_read <= mif_read;
			if Reset = '1' then
				State 		<= IDLE;
				avmm_write	<= '0';
				avmm_read	<= '0';
			else
				case State is
					when IDLE =>
						Rcfg_Type <= '0';
						if Speed_Req = '1' then
							State <= PREPARE_PHY_RECONFIG;
						end if;
						Rcfg_Done	<= '0';
						Counter 		<= (others => '0');
						avmm_write	<= '0';
						avmm_read	<= '0';
					when PREPARE_PHY_RECONFIG =>
						case Counter is
							when "000" =>
								avmm_address 	<= x"38";
								avmm_writedata	<= x"00000000";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter <= Counter + '1';
							when "001" =>
								avmm_address 	<= x"3A";
								avmm_writedata	<= x"00000000";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "010" =>
								avmm_address 	<= x"3B";
								avmm_writedata	<= x"00000000";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "011" =>
								avmm_address 	<= x"3C";
								avmm_writedata	<= x"00000100";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "100" =>
								avmm_address 	<= x"3A";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "101" =>
								avmm_address 	<= x"3B";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "110" =>
								avmm_address 	<= x"3C";
								avmm_writedata	<= x"00000003";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "111" =>
								avmm_address 	<= x"3A";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
								State <= WAIT_PHY_MIF_STEAMING;
							when others =>
						end case;
					when WAIT_PHY_MIF_STEAMING =>
						avmm_write <= '0';
						if Read_Data_Valid = '1' then
							if avmm_readdata(8) = '0' then
								State <= PREPARE_PLL_RECONFIG;
							end if;
						else
							avmm_read 		<= '1';
							avmm_address 	<= x"3A";
						end if;
					when PREPARE_PLL_RECONFIG =>
						Rcfg_Type <= '1';
						avmm_read <= '0';
						case Counter is
							when "000" =>
								avmm_address 	<= x"38";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter <= Counter + '1';
							when "001" =>
								avmm_address 	<= x"3A";
								avmm_writedata	<= x"00000000";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "010" =>
								avmm_address 	<= x"3B";
								avmm_writedata	<= x"00000000";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "011" =>
								avmm_address 	<= x"3C";
								avmm_writedata	<= x"00000100";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "100" =>
								avmm_address 	<= x"3A";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "101" =>
								avmm_address 	<= x"3B";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "110" =>
								avmm_address 	<= x"3C";
								avmm_writedata	<= x"00000003";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
							when "111" =>
								avmm_address 	<= x"3A";
								avmm_writedata	<= x"00000001";
								avmm_write		<= '1';
								avmm_read		<= '0';
								Counter	<= Counter + '1';
								State <= WAIT_PLL_MIF_STREAMING;
							when others =>
						end case;
					when WAIT_PLL_MIF_STREAMING =>
						avmm_write <= '0';
						if Read_Data_Valid = '1' then
							if avmm_readdata(8) = '0' then
								Rcfg_Done 	<= '1';
								State 		<= IDLE;
							end if;
						else
							avmm_read 		<= '1';
							avmm_address 	<= x"3A";
						end if;
					when others =>
						NULL;
				end case;
			end if;
		end if;
	end process;

	m_n_phy_rcfg_rom_1250mbps : altsyncram
		GENERIC MAP (
			address_aclr_a 			=> "NONE",
			clock_enable_input_a 	=> "BYPASS",
			clock_enable_output_a 	=> "BYPASS",
			init_file 					=> "MIF/trans_native_phy_1250mbps.mif",
			intended_device_family 	=> "Cyclone V",
			lpm_hint 					=> "ENABLE_RUNTIME_MOD=NO",
			lpm_type 					=> "altsyncram",
			numwords_a 					=> 81,
			operation_mode 			=> "ROM",
			outdata_aclr_a 			=> "NONE",
			outdata_reg_a 				=> "UNREGISTERED",
			widthad_a 					=> 8,
			width_a 						=> 16,
			width_byteena_a 			=> 1
		)
		PORT MAP (
			address_a 	=> wire_n_phy_rcfg_1250mbps_address,
			clock0 		=> wire_n_phy_rcfg_1250mbps_clock,
			rden_a 		=> wire_n_phy_rcfg_1250mbps_rden,
			q_a 			=> wire_n_phy_rcfg_1250mbps_dataout
		);
		
	m_n_phy_rcfg_rom_2500mbps : altsyncram
		GENERIC MAP (
			address_aclr_a 			=> "NONE",
			clock_enable_input_a 	=> "BYPASS",
			clock_enable_output_a 	=> "BYPASS",
			init_file 					=> "MIF/trans_native_phy_2500mbps.mif",
			intended_device_family 	=> "Cyclone V",
			lpm_hint 					=> "ENABLE_RUNTIME_MOD=NO",
			lpm_type 					=> "altsyncram",
			numwords_a 					=> 81,
			operation_mode 			=> "ROM",
			outdata_aclr_a 			=> "NONE",
			outdata_reg_a 				=> "UNREGISTERED",
			widthad_a 					=> 8,
			width_a 						=> 16,
			width_byteena_a 			=> 1
		)
		PORT MAP (
			address_a 	=> wire_n_phy_rcfg_2500mbps_address,
			clock0 		=> wire_n_phy_rcfg_2500mbps_clock,
			rden_a 		=> wire_n_phy_rcfg_2500mbps_rden,
			q_a 			=> wire_n_phy_rcfg_2500mbps_dataout
		);
	
	m_n_phy_pll_rcfg_rom_1250mbps : altsyncram
		GENERIC MAP (
			address_aclr_a 			=> "NONE",
			clock_enable_input_a 	=> "BYPASS",
			clock_enable_output_a 	=> "BYPASS",
			init_file 					=> "MIF/trans_native_phy_pll_1250mbps.mif",
			intended_device_family 	=> "Cyclone V",
			lpm_hint 					=> "ENABLE_RUNTIME_MOD=NO",
			lpm_type 					=> "altsyncram",
			numwords_a 					=> 12,
			operation_mode 			=> "ROM",
			outdata_aclr_a 			=> "NONE",
			outdata_reg_a 				=> "UNREGISTERED",
			widthad_a 					=> 4,
			width_a 						=> 16,
			width_byteena_a 			=> 1
		)
		PORT MAP (
			address_a 	=> wire_n_phy_pll_rcfg_1250mbps_address,
			clock0 		=> wire_n_phy_pll_rcfg_1250mbps_clock,
			rden_a 		=> wire_n_phy_pll_rcfg_1250mbps_rden,
			q_a 			=> wire_n_phy_pll_rcfg_1250mbps_dataout
		);
	
	m_n_phy_pll_rcfg_rom_2500mbps : altsyncram
		GENERIC MAP (
			address_aclr_a 			=> "NONE",
			clock_enable_input_a 	=> "BYPASS",
			clock_enable_output_a 	=> "BYPASS",
			init_file 					=> "MIF/trans_native_phy_pll_2500mbps.mif",
			intended_device_family 	=> "Cyclone V",
			lpm_hint 					=> "ENABLE_RUNTIME_MOD=NO",
			lpm_type 					=> "altsyncram",
			numwords_a 					=> 12,
			operation_mode 			=> "ROM",
			outdata_aclr_a 			=> "NONE",
			outdata_reg_a 				=> "UNREGISTERED",
			widthad_a 					=> 4,
			width_a 						=> 16,
			width_byteena_a 			=> 1
		)
		PORT MAP (
			address_a 	=> wire_n_phy_pll_rcfg_2500mbps_address,
			clock0 		=> wire_n_phy_pll_rcfg_2500mbps_clock,
			rden_a 		=> wire_n_phy_pll_rcfg_2500mbps_rden,
			q_a 			=> wire_n_phy_pll_rcfg_2500mbps_dataout
		);
		
end architecture;
