.dseg
T0_Count:		.byte 1

.cseg

Stable:			; ????? ?????? - ?????? ?????? ? ???????? "? ?????? ?????? ???? ?????? ???????? - ?????? ?????????"
;ldi K0, DefPowerDC(50%)	;????? ?????? ??????????? ???????? ?????????? ??? ????????? ??????
ldi r17, high(DefPowerDC)
ldi r16, low (DefPowerDC)
ldi ZH, high(K0)
ldi ZL, low (K0)
st Z+, r16
st Z, r17
;ldi K1, 0			; ?????? ???? (roll, pitch, yaw) ? 0 degree - ?? ?????????
clr r16
ldi ZH, high(K1)
ldi ZL, low (K1)
st Z+, r16
st Z, r16
;ldi K2, 0
ldi ZH, high(K2)
ldi ZL, low (K2)
st Z+, r16
st Z, r16
;ldi K3, 0
ldi ZH, high(K3)
ldi ZL, low (K3)
st Z+, r16
st Z, r16

call EulerAngles	;????????? ??????????? ? ???? ??????(???????)
call Inter	
jmp Outer

ISR0:
push r17
push r30
push r31

	ldi ZH, high(T0_Count)
	ldi ZL, low (T0_Count)
	ld r17, Z
	inc r17
	cpi r17, 122
	brne ISR_OUT
	clr r17
	st Z, r17
	jmp Stable
ISR_OUT:
	st Z, r17
	ldi r17, 0b00000001		; 1 << OCIE0
	sts TIMSK0, r16
	ldi r16, 0b00000101		;(1 << CS02)|(1 << CS00)=> presc == 1024
	sts TCCR0B, r17
	clr r17
	out TCNT0, r17
	
pop r31
pop r30
pop r17
reti