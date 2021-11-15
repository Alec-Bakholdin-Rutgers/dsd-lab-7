transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/sign_extend.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/MUX_RegDst.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/MUX_MemtoReg.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/MUX_ALUSrc.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/data_memory.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/register_file.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/alu.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/instruction_memory.sv}
vlog -sv -work work +incdir+C:/College/2021\ Fall/DSD/Lab\ 7 {C:/College/2021 Fall/DSD/Lab 7/PC.sv}

