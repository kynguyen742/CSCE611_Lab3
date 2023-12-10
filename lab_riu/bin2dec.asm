.text
	#create a 2^32 bit value and store it in x3, which i will do it later once i figure it out
	
	# Begin Check: limit? 2^32
	# 1: take in a value
	# 2: mod by 10
	# 3: get fraction from mod result (temp)
	# 4: get whole number from mod result (next value to mod)
	# 5: get digit by multipying temp by 10 (num)
	# End Check: is the temp (next value to mod) equal to zero
	
	#shift for the first num
	csrrw x1,0xf00,x0
	li x3, 429496730 
	li x4, 10
	li x8, 0
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,4
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,8
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,12
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,16
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,20
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,24
	or x8,x8,x7
	
	mv x9,x1
	mulhu x7,x9,x3
	mv x1,x7
	mul x7,x7,x4
	sub x7,x9,x7
	slli x7,x7,28
	or x8,x8,x7
	
	csrrw x0,0xf02,x8

