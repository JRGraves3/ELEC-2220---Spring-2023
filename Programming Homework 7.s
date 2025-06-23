	AREA RESET, CODE
	THUMB
	ENTRY
Main
	mov r0, #0			      ;start with all zeroes in a register of my choosing.
	ldr r2, =Control	    ;read in Control
	ldrb r1, [r2]		      ;read in value of Control
	tst r1,	#2_10000000  	;see of C7 is set
	bne setB2			        ;if C7 set, set bit 2
	beq next1
setB2
	orr r0, #2_100		    ;set bit 2
next1
	tst r1, #2_100000    	;see if C5 is set
	bne isC4clear
	beq next2
isC4clear
	tst r1, #2_10000    	;see if C4 is set
	beq setB5B3B1		      ;if C4 is clear, set bits 5, 3, 1
	bne next2
setB5B3B1
	orr r0, #2_101010	    ;set bits 5, 3, 1

next2
	tst r1, #2_1000		    ;see if C3 is set
	beq toggleB1		      ;if C3 is clear, toggle B1
	bne next3
toggleB1
	eor r0, #2_10		      ;toggle bit 1
next3
	tst r1, #2_100		    ;see if C2 is set
	beq setB6			        ;if C2 is set, set bit 6
	bne next4
setB6
	orr r0, #2_1000000	  ;set bit 6
next4
	tst r1, #2_1		      ;see if C0 is set
	beq setB7B4			      ;if C0 is clear, set bits 7 and 4
	bne next5
setB7B4
	orr r0, #2_10010000   ;set bits 7 and 4
next5
	and r1, #2_10		      ;clear all but bit 1
	ldrb r3, [r0]			    ;load r0 into r3
	and r3, #2_10		      ;clear all but bit 1
	cmp r3, r1			      ;compares r3 and r1 (C1 and bit 1 of r0)
	bne setB0			        ;if r3 and r1 are equal, branch
	b next6
setB0
	orr r0, #2_1		      ;set bit 0
next6
	ldr r4, =Status
	str r0, [r4]	      	;stores r0 into Status
Control dcb 0x28        ; you’ll need to change this to other values to test your code
	b .
	AREA HW7, DATA
Status space 1          ;could do Status dcb 0x00, either is fine
	END
