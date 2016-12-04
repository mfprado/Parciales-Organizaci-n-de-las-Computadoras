# Pasar a MIPS, usando la convencion de llamadas a funciones implementadas en los trabajos practicos
# char* strrev (char*p) {
# 	char *s = p;
# 	char *e = p + strlen(p) - 1;
# 	while (s < e) {
# 		char a = s*;
# 		*s = *e;
# 		*e = a;
# 		s++ = e--;
# 	}
# }

# Es una funcion non leaf, llama a strlen() por lo que tendra que 
# salvar el registro ra y reservar ABA (argument building area)
# Stack Frame -> 48

# 44  //////////////
# 40		gp
# 36		fp
# 32 		ra
#    ________________
# 28   ///////////// 
# 24		a
# 20		*e
# 16		*s
#    ________________
# 12|       a3       |
# 8 |       a2       |    ABA
# 4 |    	a1		 |
# 0 |	    a0		 |
#    -----------------

.begin
.globl strrev
.ent strrev
.align 2
.set noreorder

strrev:	

# Inicializo Stack Frame
.apload t9
.set reorder
							subu sp, sp, 48
.cprestore 40	
							sw	fp, 36(sp)
							move $fp, sp	
							sw	ra, 32($fp)
# Salvo los valores pasados por parámetro
							sw	a0, 48($fp)		#a0 = *p

							sw	a0, 16($fp)		#char *s = p

							jal strlen			#al volver, en v0 tengo strlen(p)
							subu v0, v0, 1      # strlen(p) - 1
							addu t0, v0, a0		# p + strlen(p) - 1 = t0
							sw	t0, 20($fp)		# char *e = p + strlen(p) - 1
							lw 	t1, 16($fp)		# t1 = s = p

					LOOP: 	subu t2, t0, t1     # e-s
							beqz	t2, FIN
							lb	t3, 0(t1)  		# char a = *s
							sb  t3, 0(t0)       # *s = *e
							addiu t1,t1,1 		# s++
							subu t0,t0,1 		# e--

					FIN:	lw v0, 48($fp) 		#v0 = p
							lw gp, 40($fp)
							lw fp, 36(sp)
							lw ra, 32(sp)
							addiu sp, sp, 48
							jr ra
.end							

