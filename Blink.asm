list		p=16f84A  		;Indica o microcontrolador a ser utilizado

#INCLUDE <P16F84A.INC> 		; Adiciona biblioteca de mapeamento de memуria


__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF ; Realiza as configuraçoes iniciais


org b'0'            		;Indica onde o vetor da pilha vai ser iniciado.

goto config					;Pula para o bloco "config".


cblock 0x0c			;Configura aux1 e aux2 como registradores de uso geral
aux1				;0Ch e 0Dh sao, respecitvamente, os endereзos de aux1 e aux 2
endc



config:

BSF STATUS, RP0     ;escolhe o banco 1.

movLW	b'11111110' ;Move um literal para o registrador w.
movWF	TRISB       ;Move do registrador w para o registrador trisb.
				    ;Torna todos os ports B em input menos o PB0.
					;O pino PB0 serб ligado ao led.
					
BCF STATUS,	RP0		;escolhe o banco 0 onde está localizado o PortB.


LOOP:

BSF PORTB, 0		;Set no primeiro pino do port b(desliga LED).

call DELAY			;Chama subrotina delay.

BCF PORTB, 0		;Clear no primeiro pino do port b(liga LED).

call DELAY			;Chama subrotina delay.

goto LOOP			;Retorna pro LOOP

DELAY:

MOVLW	d'167'		;Manda 167 decimal para o registrador w.
MOVWF	aux1		;Manda o literal que estб em w para aux1.
		            ;Manda o literal que estб em w para aux2.
DELAYAUX1:

DECFSZ	aux1,1		;Aguarda na linha, decrementando aux1 em 1 atй que seja zero.(1 ciclos de mбquina = 1us)

GOTO DELAYAUX1		;Retorna para DELAYAUX1. (2 ciclos de mбquina = 2us)
			
			        ;Ou seja : 167 x 3 = 501 us
			        ;f = 4mhz ===> 1/4000 s por ciclo de maquina
					;Cada instruçao precisa de 4 ciclos de maquina, ou seja, (1/4000)x4 = 0,0001 s = 1us


RETURN 

END