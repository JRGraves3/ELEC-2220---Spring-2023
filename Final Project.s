	AREA RESET, CODE  
	THUMB  
	ENTRY
Main
	ldr r0, =homescores		;get the address of homescores and assign to r0
	ldr r1, =awayscores		;get address of awayscores and assign to r1
	ldr r2, [r0]			;place homescores in r2
	ldr r3, [r1]			;place awayscores in r3
	ldr r4, =winning		;get address of winning and assign to r4
	mov r6, #28
	;ldr r7, #0				;initial value of bonus tracker
HomeScoreGetter
	ldr r5, =scoreboard		;get address of scoreboard and assign to r5
	lsr r9, r2, r6			;shift to compare the last bit if homescores
	and r9, #0x0000000F		;clear all but the last bit of homescores
	cmp r9, #0x00000000		;see if score is 0
	beq Zero1				;branch to Zero1
	cmp r9, #0x00000001		;see if score is 0
	beq One1				;branch to One1
	cmp r9, #0x00000002		;see if score is 0
	beq Two1				;branch to Two1
	cmp r9, #0x00000003		;see if score is 0
	beq Three1				;branch to Three1
	cmp r9, #0x00000004		;see if score is 0
	beq Four1				;branch to Four1
	cmp r9, #0x00000005		;see if score is 0
	beq Five1				;branch to Five1
	cmp r9, #0x00000006		;see if score is 0
	beq Six1				;branch to Six1
	cmp r9, #0x00000007		;see if score is 0
	beq Seven1				;branch to Seven1
	cmp r9, #0x00000008		;see if score is 0
	beq Eight1				;branch to Eight1
	b Nine1					;branch to Nine1
HomeScoreSetter
	strb r0, [r5], #1		;store in the first slot for the scoreboard then increment for away score
AwayScoreGetter
	lsr r10, r3, r6			;shift to compare the last bit of awayscores
	and r10, #0x0000000F	;clear all but the last bit of awayscores
	cmp r10, #0x00000000	;see if score is 0
	beq Zero2				;branch to Zero2
	cmp r10, #0x00000001	;see if score is 0
	beq One2				;branch to One2
	cmp r10, #0x00000002	;see if score is 0
	beq Two2				;branch to Two2
	cmp r10, #0x00000003	;see if score is 0
	beq Three2				;branch to Three2
	cmp r10, #0x00000004	;see if score is 0
	beq Four2				;branch to Four2
	cmp r10, #0x00000005	;see if score is 0
	beq Five2				;branch to Five2
	cmp r10, #0x00000006	;see if score is 0
	beq Six2				;branch to Six2
	cmp r10, #0x00000007	;see if score is 0
	beq Seven2				;branch to Seven2
	cmp r10, #0x00000008	;see if score is 0
	beq Eight2				;branch to Eight2
	b Nine2					;branch to Nine2
AwayScoreSetter
	strb r0, [r5]			;store in the second slot for the scoreboard
	
ScoreComparison
	SUBS r9, r10			;subtract away from home
	beq Tie					;if 0, they tied
	blt AwayWin				;if less than 0, Away won
	bgt HomeWin				;if higher than 0, Home won
	
Tie
	mov r11, #0xFF			;assign -1 to r11
	strb r11, [r4]			;store in winning
	;add r7, #1				;increment the bonus tracker
	subs r6, #4				;decrement by a bit
	cmp r6, #0x00			;check if 0
	beq Exit
	b HomeScoreGetter		;branch to get the next scores
HomeWin
	mov r11, #0x00			;assign 0 to r11
	strb r11, [r4]			;store in winning
	;add r7, #1				;increment the bonus tracker
	subs r6, #4				;decrement by a bit
	cmp r6, #0x00			;check if 0
	beq Exit
	b HomeScoreGetter		;branch to get the next scores
AwayWin
	mov r11, #0x01			;assign 1 to r11
	strb r11, [r4]			;store in winning
	;add r7, #1				;increment the bonus tracker
	subs r6, #4				;decrement by a bit
	cmp r6, #0x00			;check if 0
	beq Exit
	b HomeScoreGetter		;branch to get the next scores
	
Zero1
	mov r0, #0x3F			;the 7 segment byte for 0
	b HomeScoreSetter		;return to set scoreboard
One1
	mov r0, #0x03			;the 7 segment byte for 1
	b HomeScoreSetter		;return to set scoreboard
Two1
	mov r0, #0x5B			;the 7 segment byte for 2
	b HomeScoreSetter		;return to set scoreboard
Three1
	mov r0, #0x4F			;the 7 segment byte for 3
	b HomeScoreSetter		;return to set scoreboard
Four1
	mov r0, #0x66			;the 7 segment byte for 4
	b HomeScoreSetter		;return to set scoreboard
Five1
	mov r0, #0x6D			;the 7 segment byte for 5
	b HomeScoreSetter		;return to set scoreboard
Six1
	mov r0, #0x7D			;the 7 segment byte for 6
	b HomeScoreSetter		;return to set scoreboard
Seven1
	mov r0, #0x07			;the 7 segment byte for 7
	b HomeScoreSetter		;return to set scoreboard
Eight1
	mov r0, #0x7F			;the 7 segment byte for 8
	b HomeScoreSetter		;return to set scoreboard
Nine1
	mov r0, #0x77			;the 7 segment byte for 9
	b HomeScoreSetter		;return to set scoreboard
	
Zero2
	mov r0, #0x3F			;the 7 segment byte for 0
	b AwayScoreSetter		;return to set scoreboard
One2
	mov r0, #0x03			;the 7 segment byte for 1
	b AwayScoreSetter		;return to set scoreboard
Two2
	mov r0, #0x5B			;the 7 segment byte for 2
	b AwayScoreSetter		;return to set scoreboard
Three2
	mov r0, #0x4F			;the 7 segment byte for 3
	b AwayScoreSetter		;return to set scoreboard
Four2
	mov r0, #0x66			;the 7 segment byte for 4
	b AwayScoreSetter		;return to set scoreboard
Five2
	mov r0, #0x6D			;the 7 segment byte for 5
	b AwayScoreSetter		;return to set scoreboard
Six2
	mov r0, #0x7D			;the 7 segment byte for 6
	b AwayScoreSetter		;return to set scoreboard
Seven2
	mov r0, #0x07			;the 7 segment byte for 7
	b AwayScoreSetter		;return to set scoreboard
Eight2
	mov r0, #0x7F			;the 7 segment byte for 8
	b AwayScoreSetter		;return to set scoreboard
Nine2
	mov r0, #0x77			;the 7 segment byte for 9
	b AwayScoreSetter		;return to set scoreboard
	
ReturningBonus
	;str r7, [r5]			;store r7 back into bonus at address stored in r5
Exit
	b .
  AREA MyData, DATA  
homescores dcd 0x12345678
awayscores dcd 0x90382736
scoreboard dcd 0, 0
winning dcd 0
bonus dcd 0
	END 
 
