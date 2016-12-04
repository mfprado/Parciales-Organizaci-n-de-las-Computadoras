# Pasar a MIPS, usando la convencion de llamadas a funciones implementadas en los trabajos practicos
# static int pg_ascii2wchar_with_len(const unsigned char* from, pg_wchar *to, int len) {
# 	int cnt = 0;
# 	while ( len > 0 && *from) {
# 		*to++ = *from++;
# 		len-;
# 		cnt++;
# 	}
# 	*to = 0;
# 	return cnt;
# }

# Es una funcion hoja, no guardo ra ni reservo SRA.
# Stack Frame -> 8
# 	_________________
# 4|    	gp		 |
# 0|	    fp		 |
#   -----------------

.begin
.globl pg_ascii2wchar_with_len
.ent pg_ascii2wchar_with_len
.align 2
.set noreorder

pg_ascii2wchar_with_len:	

# Inicializo Stack Frame
.apload t9
.set reorder
							subu sp, sp, 8
.cprestore 4	
							sw	fp, 0(sp)
							move $fp, sp	

# Salvo los valores pasados por parámetro
							sw	a0, 8($fp)		#a0 = *from
							sw	a1, 12($fp)		#a1 = *to
							sw	a2, 16($fp)		#a2 = len
							move t1, zero		#t1 = cnt = 0

					loop:	blez a2, FIN
							lb	t0, 0(a0)		#t0 = *from
							beqz t0, FIN
							sb t0, 0(a1)		#*to = *from
							addiu a0, a0, 1 	#*from++
							addiu a1, a1, 1 	#*to++
							subu a2, a2, 1 		#len--
							addiu t1, t1, 1 	#cnt++
							b loop

					FIN:	move v0, t1
							lw gp, 4($fp)
							lw fp, 0(sp)
							addiu sp, sp, 8
							jr ra
.end							

