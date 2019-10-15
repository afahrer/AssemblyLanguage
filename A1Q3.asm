TITLE Assignment 1 Question 2 (A1Q2.asm)

INCLUDE Irvine32.inc

.data
  promptP BYTE "Enter an unsigned value for P: ",0			
  promptR BYTE "Enter an unsigned value for R: ",0			
  promptT BYTE "Enter an unsigned value for T: ",0

  promptQ BYTE "Enter a signed value for Q: ",0	
  promptS BYTE "Enter a signed value for S: ",0	

  p DWORD ?
  q SDWORD ?
  r DWORD ?
  s SDWORD ?
  t DWORD ?
.code	
main PROC
  
  mov edx, OFFSET promptP		
  call WriteString			    
  call ReadDec			        
  mov p, eax					
  
  mov edx, OFFSET promptR		
  call WriteString			    
  call ReadDec			        
  mov r, eax					
  
  mov edx, OFFSET promptT		
  call WriteString			    
  call ReadDec			        
  mov r, eax					
  
  mov edx, OFFSET promptQ		
  call WriteString			    
  call ReadInt			        
  mov q, eax					
  
  mov edx, OFFSET promptS		
  call WriteString			    
  call ReadInt			        
  mov s, eax					


  exit
main ENDP

END main