[![N|Solid](https://eventos.ifg.edu.br/semanai2c/wp-content/uploads/sites/7/2016/08/marca-ifg-2015-todas-as-verses.png)](https://www.ifg.edu.br/goiania)

# Programa: Blink (PIC)

Esse código é um exemplo de Led Blink (piscar led) desenvolvido por discentes do IFG para o microcontrolador PIC16F84A, este codigo em especifico pisca o led a cada 0.5 segundos se utilizado um cristal de 4 Khz.
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

