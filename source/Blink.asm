list		p=16f84A								; Indica o microcontrolador que sera utilizado

#INCLUDE <P16F84A.INC> 								; Adiciona biblioteca de mapeamento de mem?ria

__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF	;Realiza as configuraçoes iniciais


org b'0'            ;Indica onde o vetor da pilha vai ser iniciado.

goto CONFIGURANDO	;vai para o bloco "configurarando".

;---------------REGISTRADORES DE USO GERAL---------------

cblock 0x0c			;Configura aux1 e aux2 como registradores de uso geral
aux					;0Ch é o endereços de aux
endc


;---------------------BLOCO CONFIG----------------------;
CONFIGURANDO:

	BSF STATUS, RP0     ;Seleciona o banco 1.
	
	movLW	b'11111110' ;Move um literal para o registrador w.
	movWF	TRISB       ;Move do registrador w para o registrador trisb.
					    ;Torna todos os ports B em input menos o PB0.
						;O pino PB0 sera ligado ao led.
						
	BCF STATUS,	RP0		;escolhe o banco 0 onde está localizado o PortB.

;---------------------BLOCO LOOP----------------------

LOOP:

	BSF PORTB, 0		;Set no primeiro pino do port b(desliga LED).
	
	call DELAY			;Chama subrotina delay.
	
	BCF PORTB, 0		;Clear no primeiro pino do port b(liga LED).
	
	call DELAY			;Chama subrotina delay.
	
	goto LOOP			;Retorna pro LOOP

;---------------------BLOCO DELAY----------------------
DELAY:

	MOVLW	d'167'		;Manda 167 decimal para o registrador w.
	MOVWF	aux		;Manda o literal que est? em w para aux.

;---------------------BLOCO DELAYAUX----------------------
DELAYAUX:

	DECFSZ	aux,1		;Aguarda na linha, decrementando aux1 em 1 até que seja zero.(1 ciclos de maquina = 1us)
	
	GOTO DELAYAUX		;Retorna para DELAYAUX. (2 ciclos de maquina = 2us)
				

	RETURN 

END