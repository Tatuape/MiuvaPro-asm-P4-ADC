; ***********************************************************
;   INTESC electronics & embedded
;
;   Curso básico de microcontroladores en ensamblador	    
;
;   Práctica 4: Uso del ADC
;   Objetivo: Conocer la inicialización del ADC
;
;   Fecha: 05/Jun/16
;   Creado por: Daniel Hernández Rodríguez
; ************************************************************

LIST    P = 18F87J50	;PIC a utilizar
INCLUDE <P18F87J50.INC>

;************************************************************
;Configuración de fusibles
CONFIG  FOSC = HS   
CONFIG  DEBUG = OFF
CONFIG  XINST = OFF

;***********************************************************
;Código
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
	movwf	ANCON0	;Configuramos AN0 como analógico
	movlw	0xFF
	movwf	ANCON1	;Configuramos puertos digitales
	movlw	b'00000000'
	movwf	ADCON0	;Configuración del ADC
	movlw	b'00001000'
	movwf	ADCON1	;Configuración del ADC
	bsf		ADCON0,ADON	;ADC ENABLED

BUCLE
	bsf		ADCON0,GO_DONE 	;Comienza la conversión
ESPERA
	btfsc	ADCON0,GO_DONE	;Esperamos a que esté lista la conversión
	goto	ESPERA			;Si no está lista regresamos a ESPERA
	movff	ADRESL,valor1	;Cargamos valor1 con el valor del ADC LSB
	movff	ADRESH,valor2	;Cargamos valor2 con el valor del ADC MSB
	movff	valor2,PORTJ	;Mostramos la parte más significativa en los leds
	goto BUCLE				;Volvemos a empezar la conversión

end