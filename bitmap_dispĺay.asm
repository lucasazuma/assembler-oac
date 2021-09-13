.data
color: .word 0xFFFF # azul turquesa
dx: .word 64 # linha com 64 pixels
dy: .word 64 # 64 linhas
org: .word 0x10040000 # endereço da origem da imagem (heap)
input_x0: .string "digite X0\n"
input_y0: .string "digite Y0\n"
input_x1: .string "digite X1\n"
input_y1: .string "digite Y1\n"
testif: .string "\nIIFFF\n"
else: .string "\nELSE\n"
testloop: .string "LOOP\n"
testalgoritimo: .string "ALGORITIMO\n"
testa5: .string "\nD==\n"
testx0: .string "\nx0 ==\n"
testx1: .string "\nx1 ==\n"

.text 
    #s0 = x0
    #s1 = y0
    #s2 = x1
    #s3 = y1
    #s4 = origem
    #s5 = dx
    #s6 = dy
    #a1 = parameter x
    #a2 = parameter y
    #a3 = 4
    #a4 = return from get address
    
    #definindo a origem
    lw s4, org
    lw s5, dx
    lw s6, dy
    
    # input X0
    la a2, input_x0
    mv a0, a2
    li a7,4
    ecall
	
    li a7, 5
    ecall
    addi s0, a0, 0
   
    #input Y0 
    la a2, input_y0
    mv a0, a2
    li a7,4
    ecall
   
    li a7, 5
    ecall
    addi s1, a0, 0
    
     # input X1
    la a2, input_x1
    mv a0, a2
    li a7,4
    ecall
    
    li a7, 5
    ecall
    addi s2, a0, 0
    
    #input Y1
    la a2, input_y1
    mv a0, a2
    li a7,4
    ecall
   
    li a7, 5
    ecall
    addi s3, a0, 0
    j algoritimo
    
    
algoritimo:
####################
la a2, testalgoritimo
    mv a0, a2
    li a7,4
    ecall
#####################
sub a6 , s2, s0 #dx = x1 - x0
sub a7 , s3, s1 #dy = y1 - y0
addi t2, zero, 2
mul t3, t2, a7 #2*dy
sub a5, t3, a6 #D = 2*dy - dx

#colorindo o primeiro ponto
add a1, zero, s0
add a2, zero, s1
jal x1, ponto

add a3, zero, s1 # y = y0
addi a6, s0, 1 #saving x0 + 1
j loop

loop:
###### DEBUG #################
la t0, testloop
mv a0, t0
li a7,4
ecall
##########################

###### DEBUG #################
la t0, testa5
mv a0, t0
li a7,4
ecall
add a0, zero, a5
li a7,1
ecall
##########################

###### DEBUG #################
la t0, testa5
mv a0, t0
li a7,4
ecall
add a0, zero, a5
li a7,1
ecall
##########################

###### DEBUG #################
la t0, testx0
mv a0, t0
li a7,4
ecall
add a0, zero, a6
li a7,1
ecall
##########################

###### DEBUG #################
la t0, testx1
mv a0, t0
li a7,4
ecall
add a0, zero, s4
li a7,1
ecall
##########################

	
	bge a6, s2, end #terminar se x0+1 == x1
	bne a5, zero, if #goes to if
	
	#else
	jal x1, ponto
	addi t0, zero, 2
	mul t1, a7, t0
	add a5, a5, t1
	addi a6, a6, 1
#######DEBUG##########
la t0, else
mv a0, t0
li a7,4
ecall
##################
	j loop
	

#função que calcula o enderço de memória e colore o ponto
ponto:
 #jal x1,getaddres
 addi a3, zero, 4
 mul t1, a1, a3 #4*x
 mul t2, a2, s5 #Y*dx
 mul t3, a3, t2 #4*(y*dx)
 add t4, t1, t3 #4*x + 4*(y*dx)
 add a4, t4, s4 #4*x + 4*(y*dx) + offset
 lw a4, color
 jalr x0, 0(x1)

#getaddres:
 #addi a3, zero, 4
 #mul t1, a1, a3 #4*x
 #mul t2, a2, s5 #Y*dx
 #mul t3, a3, t2 #4*(y*dx)
 #add t4, t1, t3 #4*x + 4*(y*dx)
 #add a4, t4, s4 #4*x + 4*(y*dx) + offset
 #jalr x0, 0(x1)
 
if:
#########DEBUG#########
la t0, testif
mv a0, t0
li a7,4
ecall
#################
addi a3, a3, 1 #y = y+1
jal x1, ponto
add a2,zero, a3 #passing parameters y
addi t0, zero, 2
mul t1, a6, t0 #2*dx
mul t2, a7, t0
sub t3, t2, t1
add a5, a5, t3
addi a6, a6, 1
j loop

end:
	mv a0, x9
    	li a7, 1
    	ecall
	li a7, 10
	ecall
 
 
 
 





