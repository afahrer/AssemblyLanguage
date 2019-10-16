TITLE Assignment 1 Question C (A1QC.asm)

INCLUDE Irvine32.inc

.data
  ; strings to be printed
  promptP BYTE "Enter an unsigned value for P: ",0			
  promptR BYTE "Enter an unsigned value for R: ",0			
  promptT BYTE "Enter an unsigned value for T: ",0

  promptQ BYTE "Enter a signed value for Q: ",0	
  promptS BYTE "Enter a signed value for S: ",0	

  func BYTE "4T + (P - 3Q) - (S + 2R) = ",0
  ; variables for p,q,r,s and t
  p DWORD ?
  q SDWORD ?
  r DWORD ?
  s SDWORD ?
  t DWORD ?
.code	
main PROC
  ; get p
  mov edx, OFFSET promptP		
  call WriteString			    
  call ReadDec			        
  mov p, eax					
  ; get r
  mov edx, OFFSET promptR		
  call WriteString			    
  call ReadDec			        
  mov r, eax					
  ; get t
  mov edx, OFFSET promptT		
  call WriteString			    
  call ReadDec			        
  mov t, eax					
  ; get q
  mov edx, OFFSET promptQ		
  call WriteString			    
  call ReadInt			        
  mov q, eax					
  ; get s
  mov edx, OFFSET promptS		
  call WriteString			    
  call ReadInt			        
  mov s, eax
  ; perform math operations using eax and ebx
  ; (p - 3q)
  mov eax, p
  sub eax, q
  sub eax, q
  sub eax, q
  ; add 4t
  add eax, t
  add eax, t
  add eax, t
  add eax, t
  ; (s + 2r)
  mov ebx, s
  add ebx, r
  add ebx, r
  ; 4T + (P - 3Q) - (S + 2R)
  sub eax, ebx
  ; print the results
  mov edx, OFFSET func
  call WriteString
  call WriteInt
  exit
main ENDP

END main