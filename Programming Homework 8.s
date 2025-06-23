	AREA RESET, CODE  
	THUMB  
	ENTRY 
Main  
	ldr r0, =packed			    ; get the address of the packed array
	ldr r1, [r0]			      ; place the packed array into r1
	ldr r2, =unpacked			  ; get the address of the unpacked array
	mov r3, #9				      ; r3 = 0x00000009 as a counter for the Loop
	mov r4, #28				      ; r4 = 0x0000001C the value used to shift the register later
	
Loop
	subs r3, #1				      ; subtracts one from the counter
	beq Done				        ; if equal, the counter = 0, i.e. the number of Loops have been completed
	lsr r5, r1, r4			    ; shift r1 right the amount of r4 into r5
	and r5, #0x0000000F	  	; clears everything but the last bit
	strb r5, [r2]			      ; store r5 into unpacked
	add r2, #1				      ; increment the address that r2 is referencing
	subs r4, #4				      ; subtract 4 from r4 to account for the "loss" of 4 bits
	b Loop				          ; go back to the beginning of the Loop
	
Done
	
  b .  
 
	AREA MyData, DATA
packed dcd 0x5348A201		  ; packed data used in CODE
unpacked space 8			    ; label where unpacked data is stored
	
	END 
