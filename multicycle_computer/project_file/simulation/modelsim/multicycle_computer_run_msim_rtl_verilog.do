transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_datapath_verilog.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_controller_condition_check.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/w_bit_two_to_one_mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/w_bit_four_to_one_mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/registers_two.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/immediate_extender.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/constant_value_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/barrel_shifter.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/alu_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_all.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_controller_state_machine.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_controller_ALU_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_controller_all.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_controller_instruction_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_controller_state_dependent_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file {C:/Users/hemre/OneDrive/Belgeler/multicycle_computer/project_file/multicycle_computer_controller_xPSR_write.v}

