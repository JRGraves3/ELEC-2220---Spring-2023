    AREA RESET, CODE
    THUMB
    ENTRY
Main
    ldr r0, =Starter       ; load the address of Starter into r0
    ldr r1, =Finished      ; load the address of Finished into r1
    ldr r2, =Counter       ; load the address of Counter into r2
Starter dcb 0x05, 0x52, 0x73, 0x7B
Loop
    ldrb r3, [r0], #1      ; loads the first/next byte of Starter
    cmp r3, #0x00          ; compares it to 0
    beq Exit               ; if equal, then go to Exit/Loop ends
    cmp r3, #0x61          ; compares it to the first lowercase letter in the ASCII table
    blo Accepted           ; if less than, sends to Accepted
    cmp r3, #0x7A          ; compares to the last lowercase letter in the ASCII table
    bhi Accepted           ; if greater than, sends to Accepted
    sub r3, #0x20          ; subtracts 0x20 from the value making it uppercase
                           ; this works since 0x61 to 0x7A is 26 values apart
                           ; and 0x20 is 32 in base 10, therefore subtracting 0x20 is the same as subtracting 32
    strb r3, [r2]          ; stores the byte in Finished
    ldr r3, [r2]           ; since r3 is not needed, load counter value into r3
                           ; trying to stay withing r0-r3 to get the bonus points :)
    add r3, #1             ; increment to count lowercase instances
    str r3, [r2]           ; stores the count back into Counter
    b Loop                 ; this repeats the loop
Accepted                   ; any non-lowercase values are sent here
    strb r3, [r1], #1      ; stores the value in Finished
    b Loop                 ; again restarts the loop
Exit                       ; when the value us 0x00, the loop exits to here
  b .
    AREA TheDATA, DATA     ; start of the data section
Counter dcd 0x00000000     ; creates a word used to count the amount of lowercase letters in Started
Finished space 32          ; 32 bytes of space for stored values
    END
