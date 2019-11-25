TITLE Assignment 7 Question 1 (A7Q1.asm)
COMMENT !
Description: Rhombicosidodecahedron calculations
Name: Adam Fahrer
Date: November 24, 2019
! COMMENT
INCLUDE Irvine32.inc

.data
  e REAL4 ?
  two DWORD 2
  five DWORD 5
  ten DWORD 10
  eleven DWORD 11
  three DWORD 3
  four DWORD 4
  twentyFive DWORD 25
  twentyNine DWORD 29
  thirty DWORD 30
  sixty DWORD 60
  
  msg BYTE "Length of Edge: ",0
  msg1 BYTE "Surface area of the Rhombicosidodecahedron		=	",0
  msg2 BYTE "Volume of the Rhombicosidodecahedron			=	",0
  msg3 BYTE "Circumsphere radius of the Rhombicosidodecahedron	=	",0
  msg4 BYTE "Midsphere radius of the Rhombicosidodecahedron		=	",0
  msg5 BYTE "Volume of the Circumsphere				=	",0
  msg6 BYTE "Volume of the Midsphere					=	",0
  
  area REAL4 ?
  volume REAL4 ?
  volumeMid REAL4 ?
  volumeCir REAL4 ?
  circumsphere REAL4 ?
  midsphere REAL4 ?
.code	

main PROC
  finit
start:
  ffree st(0)
  call CrLf
  mov edx, OFFSET msg
  call WriteString
  call ReadFloat
  call CrLf
  fldz
  fcomip st(0), st(1)
  je done							; if user enters 0 end the program
  ja start							; if user enter negative number reset the stack and prompt for another number
  fstp e							; store value of e
  
  fild five							; sqrt(5)
  fsqrt
  fild ten							; 10 * sqrt(5)
  fmulp st(1), st(0)
  fild twentyFive					; 10 * sqrt(5) + 25
  faddp st(1), st(0)
  fsqrt								; sqrt(10 * sqrt(5) + 25)				
  fild three						; 3 * sqrt(10 * sqrt(5) + 25)
  fmul 
  fild three
  fsqrt
  fild five
  fmul 
  faddp st(1), st(0) 
  fild thirty
  fadd
  fld e
  fmul
  fld e
  fmul
  fstp area

  fild five							; volume of Rhombicosidodecahedron
  fsqrt
  fild twentyNine
  fmul
  fild sixty
  fadd
  fild three
  fdiv
  fld e
  fmul
  fld e
  fmul
  fld e
  fmul
  fstp volume

  fild five							; circumsphere radius
  fsqrt
  fild four
  fmul
  fild eleven
  fadd
  fsqrt
  fld e
  fmul
  fild two
  fdiv
  fstp circumsphere

  fild five							; midsphere radius
  fsqrt
  fild four
  fmul
  fild ten
  fadd
  fsqrt
  fld e
  fmul
  fild two
  fdiv
  fstp midsphere
  
  fild four							; volume of circumsphere
  fild three
  fdiv
  fldpi
  fmul
  fld circumsphere
  fmul
  fld circumsphere
  fmul
  fld circumsphere
  fmul
  fstp volumeCir

  fild four							; volume of midsphere
  fild three
  fdiv
  fldpi
  fmul
  fld midsphere
  fmul
  fld midsphere
  fmul
  fld midsphere
  fmul
  fstp volumeMid

  push area							; print all values
  push OFFSET msg1
  call print

  push volume
  push OFFSET msg2
  call print

  push circumsphere
  push OFFSET msg3
  call print

  push midsphere
  push OFFSET msg4
  call print

  push volumeCir
  push OFFSET msg5
  call print

  push volumeMid
  push OFFSET msg6
  call print

  jmp start
done:
  ffree st(0)
  call ShowFPUStack
  exit
main ENDP

print PROC, offMsg:DWORD, value:REAL4
  mov edx, offMsg
  fld value
  call WriteString
  call WriteFloat
  call CrLf
  ffree st(0)
  ret
print ENDP
END main