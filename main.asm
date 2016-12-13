; ***********************************************************
;   INTESC electronics & embedded
;
;   Curso b�sico de microcontroladores en ensamblador	    
;
;   Pr�ctica 4: Uso del ADC
;   Objetivo: Conocer la inicializaci�n del ADC
;
;   Fecha: 05/Jun/16
;   Creado por: Daniel Hern�ndez Rodr�guez
; ************************************************************

LIST    P = 18F87J50	;PIC a utilizar
INCLUDE <P18F87J50.INC>

;************************************************************
;Configuraci�n de fusibles
CONFIG  FOSC = HS   
CONFIG  DEBUG = OFF
CONFIG  XINST = OFF

;***********************************************************
;C�digo
CBLOCK 0x000
	valor1
	valor2
ENDC
   
ORG 0x00    ;Iniciar el programa en el registro 0x00
    
INICIO
	movlw	0x00
	movwf	TRISF	;Puerto F como salida (Paso de MiuvaPro)
	movlw	0x00
	movwf	TRISJ	;Puerto E como salida
	movlw	0x00
	movwf	PORTJ	;Puerto J como salida
	movlw	0xFF
	movwf	TRISA	;Puerto A como entrada
	movlw	b'11111110'
	movwf	ANCON0	;Configuramos AN0 como anal�gico
	movlw	0xFF
	movwf	ANCON1	;Configuramos puertos digitales
	movlw	b'00000000'
	movwf	ADCON0	;Configuraci�n del ADC
	movlw	b'00001000'
	movwf	ADCON1	;Configuraci�n del ADC
	bsf		ADCON0,ADON	;ADC ENABLED

BUCLE
	bsf		ADCON0,GO_DONE 	;Comienza la conversi�n
ESPERA
	btfsc	ADCON0,GO_DONE	;Esperamos a que est� lista la conversi�n
	goto	ESPERA			;Si no est� lista regresamos a ESPERA
	movff	ADRESL,valor1	;Cargamos valor1 con el valor del ADC LSB
	movff	ADRESH,valor2	;Cargamos valor2 con el valor del ADC MSB
	movff	valor2,PORTJ	;Mostramos la parte m�s significativa en los leds
	goto BUCLE				;Volvemos a empezar la conversi�n

end