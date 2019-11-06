TITLE Assignment 4 Question C (A4QC.asm)
COMMENT !
Description: gets a character value from the user, then prints the 
             character every 1/5 seconds using random colors and cursor locations.
			 The character is printed 500 times
Name: Adam Fahrer
Date: October 24, 2019
! COMMENT

INCLUDE Irvine32.inc

.data
  charPrompt BYTE "Enter a char to print: ",0
  textPrompt BYTE "Set text color(Number from 0-15): ",0
  backgroundPrompt BYTE "Set background color(Number from 0-15): ",0

.code	
main PROC
  call Randomize
  ; get character value and store in esi
  mov edx, OFFSET charPrompt
  call WriteString
  call ReadChar
  call CrLf
  mov esi, eax
  ; get inital text color
  mov edx, OFFSET textPrompt
  call WriteString
  call ReadDec
  mov bl, al
  ; get inital background color
  mov edx, OFFSET backgroundPrompt
  call WriteString
  call ReadDec
  call CrLf
  ; set inital colors
  call setColors
  ; set loop counter and zero out ebx
  mov ecx, 500
  mov ebx, 0
  l1:
   call printRandom
   ; move max value of colors to eax, all 8 bits on
   mov eax, 11111111b
   call BetterRandomRange
   call setColors
   ; 200ms = 1/5 seconds
   mov eax, 200
   call delay
  loop l1
  ; reset console colors
  mov al, 0h
  mov bl, 0Fh
  call SetColors
  ; reset cursor
  call GetMaxXY
  mov dh, ah
  mov dl, al
  call GoToXY
  call CrLf
  exit
main ENDP

BetterRandomRange PROC
  ; subtract lower from upper and add 1 making randomRange inclusive 
  sub eax, ebx
  add eax, 1
  call RandomRange
  ; add lower back in so that the random number cannot be too low
  add eax, ebx
  ret
BetterRandomRange ENDP

; al = background color, bl = text color
setColors PROC 
  ; shift left 4 bits sets the background color
  shl al, 4
  ; combine bits from al and bl 
  or al, bl
  call SetTextColor
  ret
setColors ENDP

; move character to esi before using this procedure
printRandom PROC 
  ; get window size
  call GetMaxXY
  ; ensure lower bound is 0
  mov ebx, 0
  call BetterRandomRange
  ; GoToXY uses edx so move the random number into it
  mov edx, eax
  call GoToXY 
  ; get the char value and print
  mov eax, esi
  call Writechar
  ret
printRandom ENDP

END main