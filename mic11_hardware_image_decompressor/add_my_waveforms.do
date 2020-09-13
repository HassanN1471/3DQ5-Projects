

# add waves to waveform
add wave Clock_50
add wave -divider {top level signals}
add wave -unsigned uut/top_state
add wave -unsigned uut/SRAM_address
add wave -hex uut/SRAM_read_data
add wave -hex uut/SRAM_write_data
add wave uut/SRAM_we_n

add wave -divider {M1 signals}

add wave -decimal uut/M1_unit/Vert_count 
add wave -decimal uut/M1_unit/Hori_count 
add wave -decimal uut/M1_unit/data_counter
add wave -decimal uut/M1_unit/Y_counter
add wave -decimal uut/M1_unit/U_counter 
add wave -unsigned uut/M1_unit/state
add wave -unsigned uut/M1_unit/SRAM_address
add wave -hex uut/M1_unit/SRAM_read_data
add wave -hex uut/M1_unit/SRAM_write_data
add wave uut/M1_unit/SRAM_we_n



add wave -hex uut/M1_unit/Y
add wave -hex uut/M1_unit/Ytest
add wave -hex uut/M1_unit/U
add wave -hex uut/M1_unit/V
add wave -hex uut/M1_unit/Utest
add wave -hex uut/M1_unit/Vtest
add wave -hex uut/M1_unit/UPrime
add wave -hex uut/M1_unit/VPrime

add wave -decimal uut/M1_unit/ans1
add wave -decimal uut/M1_unit/ans2

add wave -decimal uut/M1_unit/Mult_op_1
add wave -decimal uut/M1_unit/Mult_op_2
add wave -decimal uut/M1_unit/Mult_op_3
add wave -decimal uut/M1_unit/Mult_op_4
add wave -decimal uut/M1_unit/Mult_op_5
add wave -decimal uut/M1_unit/Mult_op_6
add wave -decimal uut/M1_unit/Mult_op_7
add wave -decimal uut/M1_unit/Mult_op_8

add wave -decimal uut/M1_unit/Mult_result1
add wave -decimal uut/M1_unit/Mult_result2
add wave -decimal uut/M1_unit/Mult_result3
add wave -decimal uut/M1_unit/Mult_result4


add wave -decimal uut/M1_unit/R0
add wave -decimal uut/M1_unit/G0
add wave -decimal uut/M1_unit/B0

add wave -decimal uut/M1_unit/R1
add wave -decimal uut/M1_unit/G1
add wave -decimal uut/M1_unit/B1

add wave -hex uut/M1_unit/R
add wave -hex uut/M1_unit/G
add wave -hex uut/M1_unit/B

