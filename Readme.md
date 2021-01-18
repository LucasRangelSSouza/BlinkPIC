[![N|Solid](https://eventos.ifg.edu.br/semanai2c/wp-content/uploads/sites/7/2016/08/marca-ifg-2015-todas-as-verses.png)](https://www.ifg.edu.br/goiania)

# Programa: Blink (PIC)

Esse código é um exemplo de Led Blink (piscar led) desenvolvido por discentes do IFG para o microcontrolador PIC16F84A, este codigo em especifico pisca o led a cada 0.5 segundos se utilizado um cristal de 4 Khz.

## Execução:
O programa pode ser executado em um simuldor ou no gravado em um microcontroldador PIC16f84A, é aconselhavel para fins de depuraçao utilizar o simulador uma vez que as ferramentas de debug do simulador são mais intuitivas que realizar a analise na pratica.

### Simulador:
###### 2º Baixe e instale o gerenciador de pacotes rar Winrrar
 * Click [aqui ](https://www.rarlab.com/download.htm) para realizar o download do Winrrar
 * Aquarde o download finalizar
 * Execute o arquivo .exe baixado
 * Aguarde a instalação finalizar
###### 1º Baixe e instale o MPLAB IDE v8.92 (Iremos utilizar uma versão mais antiga porem mais estavek do MPLAB, no entanto sinta-se a vontade para utilizar o MPLAB X)
 * Click [aqui ](https://drive.google.com/file/d/0B53XJ7dLLG26bm9UQnF2RTc3OVk/view) para realizar o download do MPLAB
 * Aquarde o download finalizar
 * Descompacte o arquivo zip em um diretorio de sua escolha como mostra o gif abaixo
    * ![](https://github.com/LucasRangelSSouza/BlinkPIC/blob/main/gifs/descompactando.gif)
 * Realize a instalação do MPLAB executando o executavel setup.exe
 * Avance as etapas e aguarde a instalação concluir
###### 2º Baixe e instale o gerenciador git
 * Click [aqui ](https://git-scm.com/) para realizar o download do gerenciador git
 * Aquarde o download finalizar
 * Execute o arquivo .exe baixado
 * Aguarde a instalação finalizar
###### 3º Clone o repositorio BlinkPIC
* Abra o o terminal de comandos do windows
* Navegue até um diretorio pre-existente de sua escolha:
    ```
    C:\> chdir C:\MeuDiretorio\
    ```
* Clone o repositorio BlinkPIC
    ```
    C:\> git clone https://github.com/LucasRangelSSouza/BlinkPIC.git
    ```
* Aguarde até que o download dos arquivos finalize
###### 4º Execute o projeto e carregue o arquivo
* Execute o arquivo BlinkPIC.mcw, o MPLAB ira iniciar automaticamente
* Carregue o arquivo blink.asm (source code em assembly, é legivel e debugavel)
    * Carregar blink.asm debugavel
    
    * ![](https://github.com/LucasRangelSSouza/BlinkPIC/blob/main/gifs/CarregandoASM.gif)

* Ajuste as configuraçoes como mostrado abaixo para que o MPLAB gere o arquivo .hex, e ajuste a frequencia do simulador para a frequencia desejada (para este experimento foi utilizado 4Khz)
    
    ![](https://github.com/LucasRangelSSouza/BlinkPIC/blob/main/gifs/AjustandoConfig.gif)

* Realize a simulação como mostrado abaixo
    ![](https://github.com/LucasRangelSSouza/BlinkPIC/blob/main/gifs/ExecutandoCodigo.gif)

### Microcontrolador:
Não sera apresentado aqui um passo a passo da gravação do programa em um microcontrolador, pois deve-se levar em conta diversos detalhes que não faze parte do escopo da analise atual como modelo e tecnologia utilizada no gravador, emulador serial, modelo do microcontrolador entre outros. No esntanto o arquivo compilado no padrao intel (blink.hex) pode ser gravado em qualquer microcontrolador PIC16F84A.

## Codigo:
```
list p=16f84A             ; Indica o microcontrolador que sera utilizado

#INCLUDE <P16F84A.INC>    ; Adiciona biblioteca de mapeamento de mem?ria

__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF    ;Realiza as configuraçoes iniciais


org b'0'             ;Indica onde o vetor da pilha vai ser iniciado.

goto CONFIGURANDO    ;vai para o bloco "configurarando".

;---------------REGISTRADORES DE USO GERAL---------------

cblock 0x0c            ;Configura aux1 e aux2 como registradores de uso geral
aux                    ;0Ch é o endereços de aux
endc


;---------------------BLOCO CONFIG----------------------;
CONFIGURANDO:

	BSF STATUS, RP0        ;Seleciona o banco 1.
	
	movLW	b'11111110'    ;Move um literal para o registrador w.
	movWF	TRISB          ;Move do registrador w para o registrador trisb.
                           ;Torna todos os ports B em input menos o PB0.
                           ;O pino PB0 sera ligado ao led.
						
	BCF STATUS,	RP0        ;escolhe o banco 0 onde está localizado o PortB.

;---------------------BLOCO LOOP----------------------

LOOP:

	BSF PORTB, 0        ;Set no primeiro pino do port b(desliga LED).
	
	call DELAY          ;Chama subrotina delay.
	
	BCF PORTB, 0        ;Clear no primeiro pino do port b(liga LED).
	
	call DELAY          ;Chama subrotina delay.
	
	goto LOOP           ;Retorna pro LOOP

;---------------------BLOCO DELAY----------------------
DELAY:

	MOVLW	d'167'    ;Manda 167 decimal para o registrador w.
	MOVWF	aux       ;Manda o literal que est? em w para aux.

;---------------------BLOCO DELAYAUX----------------------
DELAYAUX:

	DECFSZ	aux,1        ;Aguarda na linha, decrementando aux1 em 1 até que seja zero.
                         ;(1 ciclos de maquina = 1us)
	
	GOTO DELAYAUX        ;Retorna para DELAYAUX. (2 ciclos de maquina = 2us)
				

	RETURN 

END
```
## Operação do codigo:

### Contagem:
O delay é realizado utilizando por base o cristal de 4Khz, um cristal de 4Khz gera uma onda de 1/400 segundos por ciclo de maquina, como cada instrução necessita de 4 ciclos de maquina para executar tem-se que (1/400)x4 = 0,001 segundos = 1 milissegundo

### Delay:
O delay é realizado executando 3 vezes um decremento de 167 até 0, como cada decremento demora exatamente 1 milissegundo, temos que 167*3 = 501 ms = 0.5 segundos, que é o tempo do delay para ligar e desligar o led.


## Tempo de execução:
De acordo com o simulador MPLAB v8.92, se utilizado um cristal de 4Khz temos os seguintes resultados de execuçao:
| Loop | S|Ms|Us |Instruções executadas|
| ------ | ------ | ------ | ------ | ------ |
| 1 | 000  |513 | 000 | 513 instruções|
| 2 |  001  |022 | 000 | 1 022 instruções|
| 3 |  001  |529 | 000 | 1 529 instruções|
| 4 |  002  |038 | 000 | 2 038 instruções|
| 5 |  002  |545 | 000 | 2 545 instruções|
| 6|  003  |054 | 000 | 3 054 instruções|
| 7 |  003  |561 | 00 | 3 561 instruções|
| 8 |  004  |074 | 000 | 4 070 instruções|
|9 |  004  |577 | 000 | 4 577 instruções|
| 10 |  005  |086 | 000 | 5 086 instruções|


Os dados da tabela acima podem ser conferidos na simulação apresentada no gif abaixo
[](https://github.com/LucasRangelSSouza/BlinkPIC/blob/main/gifs/testPic.gif)
 
 
 No geral sao executadas 5086 instruções em 5 segundos e 86 milissegundo em 10 loops do programa, o que nos da uma media de 508 milisegundos e 600 microssegundos por loop e 1 milisegundo por instrução.
 Observe que estes resultados sao obtidos utilizando um cristal oscilador de 4Khz.




----
### Licença
MIT
**Free Software, Hell Yeah!**

