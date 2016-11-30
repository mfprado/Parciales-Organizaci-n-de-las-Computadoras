#EJERCICIO 1 - PARCIAL 12/11/2013

#codigo en C:
int my_strlen_utf8_c(char *s) {
	int i=0, j=0;
	while(s[i]) {
		if ( (s[i] & 0xc0) != 0x80) j++;
		i++;
	}
	return j;
}

# Es hoja, no llama a ninguna funcion, por lo tanto no es necesario salvar el registro ra
# ni tampoco reservar espacio para ABA (argument building area).
# Solo voy a salvar el $fp y el gp, Stack Frame de 8.
#     ________________
#  4 |       fp       |
#     ----------------
#  0 |       gp       |
#     ----------------

#include <mips/regdef.h>
.begin
.align 2
.globl my_strlen_utf8_c
.ent my_strlen_utf8_c

my_strlen_utf8_c:
.set noreorder
.cpload t9
				subu sp, sp, 8
.cprestore 0
				sw $fp, 4(sp)
				move $fp, sp

				sw a0, 8($fp)
				li r1, 0
				li r2, 0
		loop:	addu r3, a0, r1
				lb r4, 0(r3)
				beqz r4, FIN
				addiu r1,r1,1
				andi r5, r4, 0xc0
				li r6, 0x80
				addiu r1,r1,1
				beq r5, r6, loop
				addiu r2, r2, 1
				ba loop

		FIN:	lw gp, 0($fp)
				lw $fp, 4($fp)
				move v0, r2
				jr ra
.end