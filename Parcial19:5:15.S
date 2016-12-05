# Pasar a MIPS, usando la convencion de llamadas a funciones implementadas en los trabajos practicos
# size_t strlen(const char* s, size_t maxlen) {
# 	size_t len;	
# 	
#	for (len = 0; len < maxlen; len++, s++) {
# 		if (!*s)
# 			break;
# 	}
# 	return len;
# }

# Es una funcion leaf, no guardo ra ni reservo SRA.
# Stack Frame -> 8
# 	_________________
# 4|    	gp		 |
# 0|	    fp		 |
#   -----------------

.begin
.globl strlen
.ent strlen
.align 2
.set noreorder

strlen:	

# Inicializo Stack Frame
.apload t9
.set reorder
							subu sp, sp, 8
.cprestore 4	
							sw	fp, 0(sp)
							move $fp, sp	

# Salvo los valores pasados por parámetro
							sw	a0, 8($fp)		#a0 = s
							sw	a1, 12($fp)		#a1 = maxlen
							
							move t1, zero		#t1 = len = 0

					loop:	subu t2,t1,a1		#t1-a0
							beqz t2, FIN 		#b if len == maxlen
							lb	t0, 0(a0)		#t0 = *s
							addiu t1, t1, 1
							addiu a0,a0,1  		#1 byte por char
							beqz t0, FIN 		#termino de recorrer s
							b loop

					FIN:	move v0, t1
							lw gp, 4($fp)
							lw fp, 0(sp)
							addiu sp, sp, 8
							jr ra
.end							

