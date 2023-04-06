;****************************************************************************************************************************
;Program name: "Hypotenuse".  This program takes in the user input of two side lengths of a right triangle and calculates the hypotenuse. Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Hypotenuse".                                                                   *
;Hypotenuse is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Hypotenuse is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Kenneth Tran
;  Author email: kqmtran@csu.fullerton.edu
;
;Program information
;  Program name: Hypotenuse
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2023 Jan 25
;  Date of last update: 2023 Jan 31
;
;  Files in this program: triangle.cc, hypotenuse.asm
;  Status: Finished.
;
;This file
;   File name: pythagoras.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l hypotenuse.lis -o hypotenuse.o hypotenuse.asm

;===== Begin code area ================================================================================================

extern printf

extern scanf

global hypotenuse

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

inputPrompt1 db "Enter the length of the first side of the triangle: ", 0
inputPrompt2 db "Enter the length of the second side of the triangle: ", 0

negativeInputPrompt db "Negative values not allowed. Try again: ", 0

one_float_format db "%lf", 0
two_float_format db "%lf %lf", 0

confirm db "Thank you. You entered two sides: %.6lf and %.6lf", 10, 0
output_hypotenuse_float db "The length of the hypotenuse is %.6lf", 10, 0

newline db 10, 0

zeroCheck dq 0.0

segment .bss

segment .text

hypotenuse:
;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp, rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword 0

;Registers rax, rip, and rsp are usually not backed up.

push qword 0

mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf

pop rax

; =================== FIRST SIDE INPUT ============================

;Display prompt for first side input
push qword 0

mov rax, 0
mov rdi, inputPrompt1 ;"Enter the first side length: "
call printf

pop rax

back:
;scanf block
push qword 0

mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm10, [rsp] ;Dereference data at the top of the stack, store it in xmm10

pop rax

movsd xmm4, qword [zeroCheck]   ;moves 0 into register to compare
ucomisd xmm10, xmm4     ;compares number inputted with 0 to see if it is negative or not

jb negativeConfirmed    ;if it's negative, go to negativeConfirmed

jmp continue        ;go to continue: if it is not negative

negativeConfirmed:    ;if number is negative, prompt the negative number detected and go back to the block to scan user input

  push qword 0

  mov rax, 0
  mov rdi, negativeInputPrompt    ;"Negative values not allowed. Try again: "
  call printf

  pop rax

  jmp back    ;jumps back to scanf block

continue:
; =================== SECOND SIDE INPUT ============================

;Display prompt for second side input
push qword 0

mov rax, 0
mov rdi, inputPrompt2 ;"Enter the second side length: "
call printf

pop rax

back2:
;scanf block
push qword 0

mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm11, [rsp]  ;Dereference second side and store it in xmm11

pop rax

movsd xmm4, qword [zeroCheck]
ucomisd xmm11, xmm4

jb negativeTrue   ;check if negative is true but for second input

jmp continue2   ;if not negative continue after SECOND input, not go back to first one

negativeTrue:

  push qword 0

  mov rax, 0
  mov rdi, negativeInputPrompt    ;"Negative values not allowed. Try again: "
  call printf

  pop rax

  jmp back2   ;if negative then go back to second scanf block, not first one

continue2:      ;continue2 is to continue after second side input

push qword 0

mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf

pop rax

; =================== CONFIRM AND DISPLAY ============================

push qword 0

mov rax, 2
mov rdi, confirm  ;"You entered %.6lf and %.6lf."
movsd xmm0, xmm10   ;moves data of sides into xmm0 and xmm1 for storing
movsd xmm1, xmm11

call printf

pop rax

; =================== CALCULATIONS ============================
movsd xmm13, xmm10
movsd xmm14, xmm11

mulsd xmm13, xmm10    ;multiplies both numbers together, effectively squaring the numbers
mulsd xmm14, xmm11

addsd xmm13, xmm14    ;adds the results of both squares together, since a^2 + b^2 = c^2

sqrtsd xmm15, xmm13   ;square roots the result, as we want to find the hypotenuse C, not C^2

push qword 0

mov rax, 1
movsd xmm0, xmm15   ;moves the answer found into xmm0 so we can display it
mov rdi, output_hypotenuse_float    ;"The hypotenuse is %.6lf."
call printf

movsd xmm0, xmm15

pop rax

pop rax

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret
