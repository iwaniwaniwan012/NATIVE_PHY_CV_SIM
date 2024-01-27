if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/home/dev/intelFPGA_lite/21.1/quartus/"
} 

proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }

ensure_lib ./work/
vmap work ./work/
ensure_lib ./hw_libs/

if ![ string match "*Intel*FPGA*" [ vsim -version ] ] {
  ensure_lib                       ./hw_libs/altera_ver/           
  vmap       altera_ver            ./hw_libs/altera_ver/           
  ensure_lib                       ./hw_libs/lpm_ver/              
  vmap       lpm_ver               ./hw_libs/lpm_ver/              
  ensure_lib                       ./hw_libs/sgate_ver/            
  vmap       sgate_ver             ./hw_libs/sgate_ver/            
  ensure_lib                       ./hw_libs/altera_mf_ver/        
  vmap       altera_mf_ver         ./hw_libs/altera_mf_ver/        
  ensure_lib                       ./hw_libs/altera_lnsim_ver/     
  vmap       altera_lnsim_ver      ./hw_libs/altera_lnsim_ver/     
  ensure_lib                       ./hw_libs/cyclonev_ver/         
  vmap       cyclonev_ver          ./hw_libs/cyclonev_ver/         
  ensure_lib                       ./hw_libs/cyclonev_hssi_ver/    
  vmap       cyclonev_hssi_ver     ./hw_libs/cyclonev_hssi_ver/    
  ensure_lib                       ./hw_libs/cyclonev_pcie_hip_ver/
  vmap       cyclonev_pcie_hip_ver ./hw_libs/cyclonev_pcie_hip_ver/
  ensure_lib                       ./hw_libs/altera/               
  vmap       altera                ./hw_libs/altera/               
  ensure_lib                       ./hw_libs/lpm/                  
  vmap       lpm                   ./hw_libs/lpm/                  
  ensure_lib                       ./hw_libs/sgate/                
  vmap       sgate                 ./hw_libs/sgate/                
  ensure_lib                       ./hw_libs/altera_mf/            
  vmap       altera_mf             ./hw_libs/altera_mf/            
  ensure_lib                       ./hw_libs/altera_lnsim/         
  vmap       altera_lnsim          ./hw_libs/altera_lnsim/         
  ensure_lib                       ./hw_libs/cyclonev/             
  vmap       cyclonev              ./hw_libs/cyclonev/             
  ensure_lib                       ./hw_libs/cyclonev_hssi/        
  vmap       cyclonev_hssi         ./hw_libs/cyclonev_hssi/        
}

ensure_lib ./n_phy_cores/
ensure_lib                  			 ./n_phy_cores/Trans_Native_Phy/
vmap       Trans_Native_Phy 			 ./n_phy_cores/Trans_Native_Phy/
ensure_lib                           ./n_phy_cores/Trans_Native_Phy_Reconfig/
vmap       Trans_Native_Phy_Reconfig ./n_phy_cores/Trans_Native_Phy_Reconfig/
ensure_lib                        	 ./n_phy_cores/Trans_Native_Phy_Reset/
vmap       Trans_Native_Phy_Reset 	 ./n_phy_cores/Trans_Native_Phy_Reset/
# ----------------------------------------
# Compile device library files
#alias dev_com {
#  echo "\[exec\] dev_com"
if ![ string match "*Intel*FPGA*" [ vsim -version ] ] {
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                     -work altera_ver           
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                              -work lpm_ver              
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                 -work sgate_ver            
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                             -work altera_mf_ver        
	eval  vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                     -work altera_lnsim_ver     
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                        -work cyclonev_ver         
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                   -work cyclonev_hssi_ver    
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"               -work cyclonev_pcie_hip_ver
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"               -work altera               
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"           -work altera               
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"              -work altera               
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"           -work altera               
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd"        -work altera               
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"                   -work altera               
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                             -work lpm                  
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                            -work lpm                  
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                          -work sgate                
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                               -work sgate                
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"                -work altera_mf            
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                           -work altera_mf            
	eval  vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv"     -work altera_lnsim         
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"             -work altera_lnsim         
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v"          -work cyclonev             
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.vhd"                      -work cyclonev             
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_components.vhd"                 -work cyclonev             
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_components.vhd"            -work cyclonev_hssi        
	eval  vlog "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi        
	eval  vcom "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.vhd"                 -work cyclonev_hssi        
}
#}

  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/altera_xcvr_functions.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/altera_xcvr_functions.sv"                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/sv_reconfig_bundle_to_xcvr.sv"                  -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/sv_reconfig_bundle_to_ip.sv"                    -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/sv_reconfig_bundle_merger.sv"                   -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/sv_reconfig_bundle_to_xcvr.sv"           -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/sv_reconfig_bundle_to_ip.sv"             -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/sv_reconfig_bundle_merger.sv"            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_xcvr_h.sv"                                   -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_xcvr_avmm_csr.sv"                            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_tx_pma_ch.sv"                                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_tx_pma.sv"                                   -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_rx_pma.sv"                                   -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_pma.sv"                                      -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_pcs_ch.sv"                                   -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_pcs.sv"                                      -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_xcvr_avmm.sv"                                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_xcvr_native.sv"                              -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_xcvr_plls.sv"                                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_xcvr_data_adapter.sv"                        -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_reconfig_bundle_to_basic.sv"                 -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_reconfig_bundle_to_xcvr.sv"                  -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_xcvr_h.sv"                            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_xcvr_avmm_csr.sv"                     -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_tx_pma_ch.sv"                         -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_tx_pma.sv"                            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_rx_pma.sv"                            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_pma.sv"                               -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_pcs_ch.sv"                            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_pcs.sv"                               -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_xcvr_avmm.sv"                         -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_xcvr_native.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_xcvr_plls.sv"                         -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_xcvr_data_adapter.sv"                 -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_reconfig_bundle_to_basic.sv"          -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_reconfig_bundle_to_xcvr.sv"           -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_8g_rx_pcs_rbc.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_8g_tx_pcs_rbc.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_common_pcs_pma_interface_rbc.sv"        -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_common_pld_pcs_interface_rbc.sv"        -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_pipe_gen1_2_rbc.sv"                     -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_rx_pcs_pma_interface_rbc.sv"            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_rx_pld_pcs_interface_rbc.sv"            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_tx_pcs_pma_interface_rbc.sv"            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/av_hssi_tx_pld_pcs_interface_rbc.sv"            -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_8g_rx_pcs_rbc.sv"                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_8g_tx_pcs_rbc.sv"                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_common_pcs_pma_interface_rbc.sv" -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_common_pld_pcs_interface_rbc.sv" -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_pipe_gen1_2_rbc.sv"              -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_rx_pcs_pma_interface_rbc.sv"     -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_rx_pld_pcs_interface_rbc.sv"     -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_tx_pcs_pma_interface_rbc.sv"     -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/av_hssi_tx_pld_pcs_interface_rbc.sv"     -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_reset_ctrl_lego.sv"                         -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_reset_ctrl_tgx_cdrauto.sv"                  -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_resync.sv"                             -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_reset_ctrl_lego.sv"                  -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_reset_ctrl_tgx_cdrauto.sv"           -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_resync.sv"                      -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_csr_common_h.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_csr_common.sv"                         -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_csr_pcs8g_h.sv"                        -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_csr_pcs8g.sv"                          -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_csr_selector.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/alt_xcvr_mgmt2dec.sv"                           -work Trans_Native_Phy
  eval  vlog     "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/altera_wait_generate.v"                         -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_csr_common_h.sv"                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_csr_common.sv"                  -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_csr_pcs8g_h.sv"                 -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_csr_pcs8g.sv"                   -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_csr_selector.sv"                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/alt_xcvr_mgmt2dec.sv"                    -work Trans_Native_Phy
  eval  vlog     "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/altera_wait_generate.v"                  -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/altera_xcvr_native_av_functions_h.sv"           -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/altera_xcvr_native_av.sv"                       -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/altera_xcvr_data_adapter_av.sv"                 -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/altera_xcvr_native_av_functions_h.sv"    -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/altera_xcvr_native_av.sv"                -work Trans_Native_Phy
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_sim/altera_xcvr_native_cv/mentor/altera_xcvr_data_adapter_av.sv"          -work Trans_Native_Phy
  eval  vcom 	  "./ip_cores/Trans_Native_Phy_sim/Trans_Native_Phy.vhd"                                                                       

  
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/altera_xcvr_functions.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/altera_xcvr_functions.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_h.sv"                                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_h.sv"                                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_resync.sv"                                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_resync.sv"                          -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_h.sv"                             -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_h.sv"                      -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig.sv"                               -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig.sv"                        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_cal_seq.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_cal_seq.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xreconf_cif.sv"                                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xreconf_cif.sv"                          -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xreconf_uif.sv"                                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xreconf_uif.sv"                          -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xreconf_basic_acq.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xreconf_basic_acq.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_analog.sv"                        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_analog.sv"                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_analog_av.sv"                     -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_analog_av.sv"              -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xreconf_analog_datactrl_av.sv"                  -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xreconf_analog_datactrl_av.sv"           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xreconf_analog_rmw_av.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xreconf_analog_rmw_av.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xreconf_analog_ctrlsm.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xreconf_analog_ctrlsm.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_offset_cancellation.sv"           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_offset_cancellation.sv"    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_offset_cancellation_av.sv"        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_offset_cancellation_av.sv" -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_eyemon.sv"                        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_eyemon.sv"                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_dfe.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_dfe.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_adce.sv"                          -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_adce.sv"                   -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_dcd.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_av.sv"                        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_cal_av.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_dcd_control_av.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_dcd_av.sv"                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_dcd_cal_av.sv"             -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_dcd_control_av.sv"         -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_mif.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_mif.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_reconfig_mif.sv"                            -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_reconfig_mif_ctrl.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_reconfig_mif_avmm.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_reconfig_mif.sv"                     -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_reconfig_mif_ctrl.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_reconfig_mif_avmm.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_pll.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_pll.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_reconfig_pll.sv"                            -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_reconfig_pll_ctrl.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_reconfig_pll.sv"                     -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_reconfig_pll_ctrl.sv"                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_soc.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_cpu_ram.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_direct.sv"                        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_arbiter_acq.sv"                                 -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_reconfig_basic.sv"                         -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_arbiter_acq.sv"                          -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_reconfig_basic.sv"                  -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xrbasic_l2p_addr.sv"                             -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xrbasic_l2p_ch.sv"                               -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xrbasic_l2p_rom.sv"                              -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xrbasic_lif_csr.sv"                              -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xrbasic_lif.sv"                                  -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_xcvr_reconfig_basic.sv"                          -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xrbasic_l2p_addr.sv"                      -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xrbasic_l2p_ch.sv"                        -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xrbasic_l2p_rom.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xrbasic_lif_csr.sv"                       -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xrbasic_lif.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_xcvr_reconfig_basic.sv"                   -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_arbiter.sv"                                -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_m2s.sv"                                    -work Trans_Native_Phy_Reconfig
  eval  vlog     "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/altera_wait_generate.v"                             -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/alt_xcvr_csr_selector.sv"                           -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_arbiter.sv"                         -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_m2s.sv"                             -work Trans_Native_Phy_Reconfig
  eval  vlog     "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/altera_wait_generate.v"                      -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/alt_xcvr_csr_selector.sv"                    -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/sv_reconfig_bundle_to_basic.sv"                     -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/sv_reconfig_bundle_to_basic.sv"              -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_reconfig_bundle_to_basic.sv"                     -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/av_reconfig_bundle_to_xcvr.sv"                      -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_reconfig_bundle_to_basic.sv"              -work Trans_Native_Phy_Reconfig
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reconfig_sim/alt_xcvr_reconfig/mentor/av_reconfig_bundle_to_xcvr.sv"               -work Trans_Native_Phy_Reconfig
  eval  vcom 	  "./ip_cores/Trans_Native_Phy_Reconfig_sim/Trans_Native_Phy_Reconfig.vhd"                                                                       
 
 
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/altera_xcvr_functions.sv"            -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/mentor/altera_xcvr_functions.sv"     -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/alt_xcvr_resync.sv"                  -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/mentor/alt_xcvr_resync.sv"           -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/altera_xcvr_reset_control.sv"        -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/alt_xcvr_reset_counter.sv"           -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/mentor/altera_xcvr_reset_control.sv" -work Trans_Native_Phy_Reset
  eval  vlog -sv "./ip_cores/Trans_Native_Phy_Reset_sim/altera_xcvr_reset_control/mentor/alt_xcvr_reset_counter.sv"    -work Trans_Native_Phy_Reset
  eval  vcom "./ip_cores/Trans_Native_Phy_Reset_sim/Trans_Native_Phy_Reset.vhd"                                                                

vcom -2008 ./Common_Libs/CV_PHY_RECONFIG.vhd
vcom -2008 ./Common_Libs/PRBS9_Generator.vhd
vcom -2008 ./Common_Libs/PRBS9_Checker.vhd

vcom -2008 ./TB_NATIVE_PHY_SIM.vhd

eval vsim -voptargs=+acc -t ps -L work -L Trans_Native_Phy -L Trans_Native_Phy_Reconfig -L Trans_Native_Phy_Reset -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L cyclonev_hssi TB_NATIVE_PHY_SIM

add wave -position insertpoint  \
sim:/tb_native_phy_sim/Clk \
sim:/tb_native_phy_sim/Clk_Rcfg \
sim:/tb_native_phy_sim/Reset \
sim:/tb_native_phy_sim/Rcfg_Reset \
sim:/tb_native_phy_sim/wire_phy_pll_powerdown \
sim:/tb_native_phy_sim/wire_phy_tx_analogreset \
sim:/tb_native_phy_sim/wire_phy_tx_digitalreset \
sim:/tb_native_phy_sim/wire_phy_tx_pll_refclk \
sim:/tb_native_phy_sim/wire_phy_tx_serial_data \
sim:/tb_native_phy_sim/wire_phy_pll_locked \
sim:/tb_native_phy_sim/wire_phy_rx_analogreset \
sim:/tb_native_phy_sim/wire_phy_rx_digitalreset \
sim:/tb_native_phy_sim/wire_phy_rx_cdr_refclk \
sim:/tb_native_phy_sim/wire_phy_rx_serial_data \
sim:/tb_native_phy_sim/wire_phy_rx_is_lockedtoref \
sim:/tb_native_phy_sim/wire_phy_rx_is_lockedtodata \
sim:/tb_native_phy_sim/wire_phy_tx_std_coreclkin \
sim:/tb_native_phy_sim/wire_phy_rx_std_coreclkin \
sim:/tb_native_phy_sim/wire_phy_tx_std_clkout \
sim:/tb_native_phy_sim/wire_phy_rx_std_clkout \
sim:/tb_native_phy_sim/wire_phy_tx_cal_busy \
sim:/tb_native_phy_sim/wire_phy_rx_cal_busy \
sim:/tb_native_phy_sim/wire_phy_reconfig_to_xcvr \
sim:/tb_native_phy_sim/wire_phy_reconfig_from_xcvr \
sim:/tb_native_phy_sim/wire_phy_tx_parallel_data \
sim:/tb_native_phy_sim/wire_phy_unused_tx_parallel_data \
sim:/tb_native_phy_sim/wire_phy_rx_parallel_data \
sim:/tb_native_phy_sim/wire_phy_unused_rx_parallel_data \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_busy \
sim:/tb_native_phy_sim/wire_phyrcgf_mgmt_clk_clk \
sim:/tb_native_phy_sim/wire_phyrcgf_mgmt_rst_reset \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mgmt_address \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mgmt_read \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mgmt_readdata \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mgmt_waitrequest \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mgmt_write \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mgmt_writedata \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mif_address \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mif_read \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mif_readdata \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_mif_waitrequest \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_to_xcvr \
sim:/tb_native_phy_sim/wire_phyrcgf_reconfig_from_xcvr \
sim:/tb_native_phy_sim/wire_phyrst_clock \
sim:/tb_native_phy_sim/wire_phyrst_reset \
sim:/tb_native_phy_sim/wire_phyrst_pll_powerdown \
sim:/tb_native_phy_sim/wire_phyrst_tx_analogreset \
sim:/tb_native_phy_sim/wire_phyrst_tx_digitalreset \
sim:/tb_native_phy_sim/wire_phyrst_tx_ready \
sim:/tb_native_phy_sim/wire_phyrst_pll_locked \
sim:/tb_native_phy_sim/wire_phyrst_pll_select \
sim:/tb_native_phy_sim/wire_phyrst_tx_cal_busy \
sim:/tb_native_phy_sim/wire_phyrst_rx_analogreset \
sim:/tb_native_phy_sim/wire_phyrst_rx_digitalreset \
sim:/tb_native_phy_sim/wire_phyrst_rx_ready \
sim:/tb_native_phy_sim/wire_phyrst_rx_is_lockedtodata \
sim:/tb_native_phy_sim/wire_phyrst_rx_cal_busy \
sim:/tb_native_phy_sim/wire_rcfg_clk \
sim:/tb_native_phy_sim/wire_rcfg_Reset \
sim:/tb_native_phy_sim/wire_rcfg_Speed_Req \
sim:/tb_native_phy_sim/wire_rcfg_Speed \
sim:/tb_native_phy_sim/wire_rcfg_Rcfg_Done \
sim:/tb_native_phy_sim/wire_rcfg_avmm_address \
sim:/tb_native_phy_sim/wire_rcfg_avmm_write \
sim:/tb_native_phy_sim/wire_rcfg_avmm_writedata \
sim:/tb_native_phy_sim/wire_rcfg_avmm_read \
sim:/tb_native_phy_sim/wire_rcfg_avmm_readdata \
sim:/tb_native_phy_sim/wire_rcfg_avmm_busy \
sim:/tb_native_phy_sim/wire_rcfg_mif_address \
sim:/tb_native_phy_sim/wire_rcfg_mif_read \
sim:/tb_native_phy_sim/wire_rcfg_mif_readdata \
sim:/tb_native_phy_sim/wire_rcfg_mif_waitrequest \
sim:/tb_native_phy_sim/wire_prbs_gen_clk \
sim:/tb_native_phy_sim/wire_prbs_gen_reset \
sim:/tb_native_phy_sim/wire_prbs_gen_data_out \
sim:/tb_native_phy_sim/wire_prbs_check_clk \
sim:/tb_native_phy_sim/wire_prbs_check_reset \
sim:/tb_native_phy_sim/wire_prbs_check_data_in \
sim:/tb_native_phy_sim/wire_prbs_check_data_err \
sim:/tb_native_phy_sim/Counter_Rcfg \
sim:/tb_native_phy_sim/Wait_4_Reconfig \
sim:/tb_native_phy_sim/T \
sim:/tb_native_phy_sim/T_Rcfg

run -all
