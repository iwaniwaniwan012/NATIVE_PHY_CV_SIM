library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--library n_phy_cores;
--use n_phy_cores.all;

entity TB_NATIVE_PHY_SIM is
end entity;

architecture behavioral of TB_NATIVE_PHY_SIM is

constant T 				: time := 8 ns;
constant T_Rcfg		: time := 8 ns;

signal Clk 				: std_logic := '0';
signal Clk_Rcfg		: std_logic := '0';
signal Reset			: std_logic := '1';
signal Rcfg_Reset		: std_logic := '0';

signal wire_phy_pll_powerdown					: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_tx_analogreset				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_tx_digitalreset				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_tx_pll_refclk					: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_tx_serial_data				: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_pll_locked						: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_rx_analogreset				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_rx_digitalreset				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_rx_cdr_refclk					: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_rx_serial_data				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_rx_is_lockedtoref			: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_rx_is_lockedtodata			: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_tx_std_coreclkin				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_rx_std_coreclkin				: std_logic_vector(0 downto 0)   := (others => '0');
signal wire_phy_tx_std_clkout					: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_rx_std_clkout					: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_tx_cal_busy					: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_rx_cal_busy					: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phy_reconfig_to_xcvr				: std_logic_vector(139 downto 0) := (others => '0');
signal wire_phy_reconfig_from_xcvr			: std_logic_vector(91 downto 0)	:= (others => '0');
signal wire_phy_tx_parallel_data				: std_logic_vector(19 downto 0)  := (others => '0');
signal wire_phy_unused_tx_parallel_data	: std_logic_vector(23 downto 0)  := (others => '0');
signal wire_phy_rx_parallel_data				: std_logic_vector(19 downto 0)	:= (others => '0');
signal wire_phy_unused_rx_parallel_data	: std_logic_vector(43 downto 0)	:= (others => '0');

signal wire_phyrcgf_reconfig_busy					: std_logic								:= '0';
signal wire_phyrcgf_mgmt_clk_clk						: std_logic                      := '0';
signal wire_phyrcgf_mgmt_rst_reset					: std_logic                      := '0';
signal wire_phyrcgf_reconfig_mgmt_address			: std_logic_vector(6 downto 0)   := (others => '0');
signal wire_phyrcgf_reconfig_mgmt_read				: std_logic                      := '0';
signal wire_phyrcgf_reconfig_mgmt_readdata		: std_logic_vector(31 downto 0)	:= (others => '0');
signal wire_phyrcgf_reconfig_mgmt_waitrequest	: std_logic								:= '0';
signal wire_phyrcgf_reconfig_mgmt_write			: std_logic                      := '0';
signal wire_phyrcgf_reconfig_mgmt_writedata		: std_logic_vector(31 downto 0)  := (others => '0');
signal wire_phyrcgf_reconfig_mif_address			: std_logic_vector(31 downto 0)	:= (others => '0');
signal wire_phyrcgf_reconfig_mif_read				: std_logic								:= '0';
signal wire_phyrcgf_reconfig_mif_readdata			: std_logic_vector(15 downto 0)  := (others => '0');
signal wire_phyrcgf_reconfig_mif_waitrequest		: std_logic                      := '0';
signal wire_phyrcgf_reconfig_to_xcvr				: std_logic_vector(139 downto 0)	:= (others => '0');
signal wire_phyrcgf_reconfig_from_xcvr				: std_logic_vector(91 downto 0)  := (others => '0');

signal wire_phyrst_clock					: std_logic                    	:= '0';
signal wire_phyrst_reset					: std_logic                    	:= '0';
signal wire_phyrst_pll_powerdown			: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_tx_analogreset		: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_tx_digitalreset		: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_tx_ready				: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_pll_locked				: std_logic_vector(0 downto 0) 	:= (others => '0');
signal wire_phyrst_pll_select				: std_logic_vector(0 downto 0) 	:= (others => '0');
signal wire_phyrst_tx_cal_busy			: std_logic_vector(0 downto 0) 	:= (others => '0');
signal wire_phyrst_rx_analogreset		: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_rx_digitalreset		: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_rx_ready				: std_logic_vector(0 downto 0)	:= (others => '0');
signal wire_phyrst_rx_is_lockedtodata	: std_logic_vector(0 downto 0) 	:= (others => '0');
signal wire_phyrst_rx_cal_busy			: std_logic_vector(0 downto 0) 	:= (others => '0');

signal wire_rcfg_clk						: std_logic := '0';
signal wire_rcfg_Reset					: std_logic := '0';
signal wire_rcfg_Speed_Req				: std_logic := '0';
signal wire_rcfg_Speed					: std_logic := '0';
signal wire_rcfg_Rcfg_Done				: std_logic := '0';
signal wire_rcfg_avmm_address			: std_logic_vector(7 downto 0) := (others => '0');
signal wire_rcfg_avmm_write			: std_logic := '0';
signal wire_rcfg_avmm_writedata		: std_logic_vector(31 downto 0) := (others => '0');
signal wire_rcfg_avmm_read				: std_logic := '0';
signal wire_rcfg_avmm_readdata		: std_logic_vector(31 downto 0) := (others => '0');
signal wire_rcfg_avmm_busy				: std_logic := '0';
signal wire_rcfg_mif_address			: std_logic_vector(7 downto 0) := (others => '0');
signal wire_rcfg_mif_read				: std_logic := '0';
signal wire_rcfg_mif_readdata			: std_logic_vector(15 downto 0) := (others => '0');
signal wire_rcfg_mif_waitrequest		: std_logic := '0';

signal wire_prbs_gen_clk				: std_logic := '0';
signal wire_prbs_gen_reset				: std_logic	:= '0';
signal wire_prbs_gen_data_out			: std_logic_vector(19 downto 0) := (others => '0');

signal wire_prbs_check_clk				: std_logic := '0';
signal wire_prbs_check_reset			: std_logic := '0';
signal wire_prbs_check_data_in		: std_logic_vector(19 downto 0) := (others => '0');
signal wire_prbs_check_data_err 		: std_logic := '0';

signal Counter_Rcfg		: std_logic_vector(15 downto 0) := (others => '0');
signal Wait_4_Reconfig	: std_logic := '0';

begin

Clk 			<= not Clk after T/2;
Clk_Rcfg 	<= not Clk_Rcfg after T_Rcfg/2;
Reset 		<= '1', '0' after T*10;

	m_Trans_Native_Phy: entity work.Trans_Native_Phy
		port map (
			pll_powerdown           => wire_phy_pll_powerdown,					--: in  std_logic_vector(0 downto 0);
			tx_analogreset          => wire_phy_tx_analogreset,				--: in  std_logic_vector(0 downto 0);
			tx_digitalreset         => wire_phy_tx_digitalreset,				--: in  std_logic_vector(0 downto 0);
			tx_pll_refclk           => wire_phy_tx_pll_refclk,					--: in  std_logic_vector(0 downto 0);
			tx_serial_data          => wire_phy_tx_serial_data,				--: out std_logic_vector(0 downto 0);
			pll_locked              => wire_phy_pll_locked,						--: out std_logic_vector(0 downto 0);
			rx_analogreset          => wire_phy_rx_analogreset,				--: in  std_logic_vector(0 downto 0);
			rx_digitalreset         => wire_phy_rx_digitalreset,				--: in  std_logic_vector(0 downto 0);
			rx_cdr_refclk           => wire_phy_rx_cdr_refclk,					--: in  std_logic_vector(0 downto 0);
			rx_serial_data          => wire_phy_rx_serial_data,				--: in  std_logic_vector(0 downto 0);
			rx_is_lockedtoref       => wire_phy_rx_is_lockedtoref,			--: out std_logic_vector(0 downto 0);
			rx_is_lockedtodata      => wire_phy_rx_is_lockedtodata,			--: out std_logic_vector(0 downto 0);
			tx_std_coreclkin        => wire_phy_tx_std_coreclkin,				--: in  std_logic_vector(0 downto 0);
			rx_std_coreclkin        => wire_phy_rx_std_coreclkin,				--: in  std_logic_vector(0 downto 0);
			tx_std_clkout           => wire_phy_tx_std_clkout,					--: out std_logic_vector(0 downto 0);
			rx_std_clkout           => wire_phy_rx_std_clkout,					--: out std_logic_vector(0 downto 0);
			tx_cal_busy             => wire_phy_tx_cal_busy,					--: out std_logic_vector(0 downto 0);
			rx_cal_busy             => wire_phy_rx_cal_busy,					--: out std_logic_vector(0 downto 0);
			reconfig_to_xcvr        => wire_phy_reconfig_to_xcvr,				--: in  std_logic_vector(139 downto 0);
			reconfig_from_xcvr      => wire_phy_reconfig_from_xcvr,			--: out std_logic_vector(91 downto 0);
			tx_parallel_data        => wire_phy_tx_parallel_data,				--: in  std_logic_vector(19 downto 0);
			unused_tx_parallel_data => wire_phy_unused_tx_parallel_data,	--: in  std_logic_vector(23 downto 0);
			rx_parallel_data        => wire_phy_rx_parallel_data,				--: out std_logic_vector(19 downto 0);
			unused_rx_parallel_data => wire_phy_unused_rx_parallel_data		--: out std_logic_vector(43 downto 0);
		);
	
	wire_phy_pll_powerdown			<= wire_phyrst_pll_powerdown;
	wire_phy_tx_analogreset			<= wire_phyrst_tx_analogreset;
	wire_phy_tx_digitalreset		<= wire_phyrst_tx_digitalreset;
	wire_phy_tx_pll_refclk(0)		<= Clk;
	wire_phy_rx_serial_data			<= wire_phy_tx_serial_data;
	--wire_phy_pll_locked
	wire_phy_rx_analogreset			<= wire_phyrst_rx_analogreset;
	wire_phy_rx_digitalreset		<= wire_phyrst_rx_digitalreset;
	wire_phy_rx_cdr_refclk(0)		<= Clk;
	--wire_phy_rx_is_lockedtoref
	--wire_phy_rx_is_lockedtodata
	wire_phy_tx_std_coreclkin		<= wire_phy_tx_std_clkout;
	wire_phy_rx_std_coreclkin		<= wire_phy_rx_std_clkout;
	wire_phy_reconfig_to_xcvr		<= wire_phyrcgf_reconfig_to_xcvr;
	--wire_phy_tx_parallel_data		<= ;
	--wire_phy_rx_parallel_data		<= ;
	
	m_Trans_Native_Phy_Reconfig: entity work.Trans_Native_Phy_Reconfig
		port map (
			reconfig_busy             => wire_phyrcgf_reconfig_busy,					--: out std_logic;
			mgmt_clk_clk              => wire_phyrcgf_mgmt_clk_clk,					--: in  std_logic;
			mgmt_rst_reset            => wire_phyrcgf_mgmt_rst_reset,				--: in  std_logic;
			reconfig_mgmt_address     => wire_phyrcgf_reconfig_mgmt_address,		--: in  std_logic_vector(6 downto 0);
			reconfig_mgmt_read        => wire_phyrcgf_reconfig_mgmt_read,			--: in  std_logic;
			reconfig_mgmt_readdata    => wire_phyrcgf_reconfig_mgmt_readdata,		--: out std_logic_vector(31 downto 0);
			reconfig_mgmt_waitrequest => wire_phyrcgf_reconfig_mgmt_waitrequest,	--: out std_logic;
			reconfig_mgmt_write       => wire_phyrcgf_reconfig_mgmt_write,			--: in  std_logic;
			reconfig_mgmt_writedata   => wire_phyrcgf_reconfig_mgmt_writedata,	--: in  std_logic_vector(31 downto 0);
			reconfig_mif_address      => wire_phyrcgf_reconfig_mif_address,		--: out std_logic_vector(31 downto 0);
			reconfig_mif_read         => wire_phyrcgf_reconfig_mif_read,			--: out std_logic;
			reconfig_mif_readdata     => wire_phyrcgf_reconfig_mif_readdata,		--: in  std_logic_vector(15 downto 0);
			reconfig_mif_waitrequest  => wire_phyrcgf_reconfig_mif_waitrequest,	--: in  std_logic;
			reconfig_to_xcvr          => wire_phyrcgf_reconfig_to_xcvr,				--: out std_logic_vector(139 downto 0);
			reconfig_from_xcvr        => wire_phyrcgf_reconfig_from_xcvr			--: in  std_logic_vector(91 downto 0);
		);

	wire_phyrcgf_mgmt_clk_clk 								<= Clk_Rcfg;
	wire_phyrcgf_mgmt_rst_reset							<= Reset;
	wire_phyrcgf_reconfig_mgmt_address				 	<= wire_rcfg_avmm_address(6 downto 0);
	wire_phyrcgf_reconfig_mgmt_read 						<= wire_rcfg_avmm_read;
	wire_phyrcgf_reconfig_mgmt_write						<= wire_rcfg_avmm_write;
	wire_phyrcgf_reconfig_mgmt_writedata				<= wire_rcfg_avmm_writedata;
	wire_phyrcgf_reconfig_mif_readdata					<= wire_rcfg_mif_readdata;
	wire_phyrcgf_reconfig_mif_waitrequest				<= wire_rcfg_mif_waitrequest;
	wire_phyrcgf_reconfig_from_xcvr						<= wire_phy_reconfig_from_xcvr;
	
	m_Trans_Native_Phy_Reset: entity work.Trans_Native_Phy_Reset
		port map (
			clock              => wire_phyrst_clock,					--: in  std_logic;
			reset              => wire_phyrst_reset,					--: in  std_logic;
			pll_powerdown      => wire_phyrst_pll_powerdown,		--: out std_logic_vector(0 downto 0);
			tx_analogreset     => wire_phyrst_tx_analogreset,		--: out std_logic_vector(0 downto 0);
			tx_digitalreset    => wire_phyrst_tx_digitalreset,		--: out std_logic_vector(0 downto 0);
			tx_ready           => wire_phyrst_tx_ready,				--: out std_logic_vector(0 downto 0);
			pll_locked         => wire_phyrst_pll_locked,			--: in  std_logic_vector(0 downto 0);
			pll_select         => wire_phyrst_pll_select,			--: in  std_logic_vector(0 downto 0);
			tx_cal_busy        => wire_phyrst_tx_cal_busy,			--: in  std_logic_vector(0 downto 0);
			rx_analogreset     => wire_phyrst_rx_analogreset,		--: out std_logic_vector(0 downto 0);
			rx_digitalreset    => wire_phyrst_rx_digitalreset,		--: out std_logic_vector(0 downto 0);
			rx_ready           => wire_phyrst_rx_ready,				--: out std_logic_vector(0 downto 0);
			rx_is_lockedtodata => wire_phyrst_rx_is_lockedtodata,	--: in  std_logic_vector(0 downto 0);
			rx_cal_busy        => wire_phyrst_rx_cal_busy			--: in  std_logic_vector(0 downto 0);
		);
	
	wire_phyrst_clock 					<= Clk_Rcfg;
	wire_phyrst_reset						<= Reset or Rcfg_Reset;
	--wire_phyrst_pll_select(0)		<= '0';
	wire_phyrst_pll_locked				<= wire_phy_pll_locked;
	wire_phyrst_tx_cal_busy				<= wire_phy_tx_cal_busy;
	wire_phyrst_rx_is_lockedtodata	<= wire_phy_rx_is_lockedtodata;
	wire_phyrst_rx_cal_busy				<= wire_phy_rx_cal_busy;
	
	m_CV_PHY_RECONFIG: entity work.CV_PHY_RECONFIG
		port map (
			Clk					=> wire_rcfg_clk,					--: in std_logic;
			Reset					=> wire_rcfg_Reset,				--: in std_logic;
			Speed_Req			=> wire_rcfg_Speed_Req,			--: in std_logic;
			Speed					=> wire_rcfg_Speed,				--: in std_logic;
			Rcfg_Done			=> wire_rcfg_Rcfg_Done,			--: out std_logic;
			avmm_address		=> wire_rcfg_avmm_address,		--: out std_logic(6 downto 0);
			avmm_write			=> wire_rcfg_avmm_write,		--: out std_logic;
			avmm_writedata		=> wire_rcfg_avmm_writedata,	--: out std_logic_vector(31 downto 0);
			avmm_read			=> wire_rcfg_avmm_read,			--: out std_logic;
			avmm_readdata		=> wire_rcfg_avmm_readdata,	--: in std_logic_vector(31 downto 0);
			avmm_busy			=> wire_rcfg_avmm_busy,			--: in std_logic;
			mif_address      	=> wire_rcfg_mif_address,		--: in std_logic_vector(7 downto 0);
			mif_read        	=> wire_rcfg_mif_read,			--: in std_logic;
			mif_readdata		=> wire_rcfg_mif_readdata,		--: out std_logic_vector(15 downto 0);
			mif_waitrequest	=> wire_rcfg_mif_waitrequest	--: out std_logic
		);	
		
	wire_rcfg_clk 				<= Clk_Rcfg;
	wire_rcfg_Reset			<= Reset;
	wire_rcfg_avmm_readdata	<= wire_phyrcgf_reconfig_mgmt_readdata;
	wire_rcfg_avmm_busy		<= wire_phyrcgf_reconfig_busy;
	wire_rcfg_mif_address 	<= wire_phyrcgf_reconfig_mif_address(7 downto 0);
	wire_rcfg_mif_read 		<= wire_phyrcgf_reconfig_mif_read;
	
	m_PRBS9_Generator: entity work.PRBS9_Generator
		port map (
			Clk			=> wire_prbs_gen_clk,		--: in std_logic;
			Reset			=> wire_prbs_gen_reset,		--: in std_logic;
			DataOut		=> wire_prbs_gen_data_out	--: out std_logic_vector(19 downto 0)
		);
		
	wire_prbs_gen_clk 			<= wire_phy_tx_std_clkout(0);
	wire_prbs_gen_reset			<= Reset or Rcfg_Reset or (not wire_phy_pll_locked(0));-- or Wait_4_Rcfg;
	wire_phy_tx_parallel_data	<= wire_prbs_gen_data_out;
		
	m_PRBS9_Checker: entity work.PRBS9_Checker
		port map (
			Clk			=> wire_prbs_check_clk, 		--: in std_logic;
			Reset			=> wire_prbs_check_reset, 		--: in std_logic;
			DataIn		=> wire_prbs_check_data_in, 	--: in std_logic_vector(19 downto 0);
			DataError	=> wire_prbs_check_data_err 	--: out std_logic
		);
	wire_prbs_check_clk 		<= wire_phy_rx_std_clkout(0);
	wire_prbs_check_reset	<= Reset or Rcfg_Reset or (not wire_phy_rx_is_lockedtodata(0));
	wire_prbs_check_data_in	<= wire_phy_rx_parallel_data;
	
	process(Clk_Rcfg) begin
		if Rising_Edge(Clk_Rcfg) then
			if Reset = '1' then
				Counter_Rcfg 			<= (others => '0');
				Rcfg_Reset 				<= '0';
				Wait_4_Reconfig		<= '0';
				wire_rcfg_Speed_Req 	<= '0';
			else
				if Wait_4_Reconfig = '0' then
					if Counter_Rcfg = x"1FFF" then
						Wait_4_Reconfig 		<= '1';
						wire_rcfg_Speed_Req 	<= '1';
						wire_rcfg_Speed 		<= not wire_rcfg_Speed;
						Rcfg_Reset				<= '1';
					else
						Counter_Rcfg <= Counter_Rcfg + '1';
					end if;
				else
					wire_rcfg_Speed_Req 	<= '0';
					if wire_rcfg_Rcfg_Done = '1' then
						Rcfg_Reset 			<= '0';
						Wait_4_Reconfig 	<= '0';
						Counter_Rcfg		<= (others => '0');
					end if;
				end if;
			end if;
		end if;
	end process;
	
end architecture; 
