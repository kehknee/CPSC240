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

global append

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

float_format db "%lf", 0

segment .bss

segment .text

append:
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

; =================== REGISTER ARRAYS ============================

mov r15, rdi  ;myArray
mov r14, rsi  ;elements in array A
mov r13, rdx  ;myArrayB
mov r12, rcx  ;elements in array A
mov r11, r8   ;resultArray

; =================== LOOP TO ENTER NUMBERS IN ARRAY ============================

mov r10, 0      ;index for 0-5
loopStart:
  cmp r14, r10 ;check if index is equal / if yes, jump to end of loop, if not continue
  je loopEnd
  mov rax, 0

  mov r9, [r15 + 8*r10]
  mov [r11 + 8*r10], r9 ;move number in xmm15 into result[0-5]

  inc r10     ;increment index
  jmp loopStart
loopEnd:

mov rbx, 0
loopStart2:
  cmp r12, rbx  ;check if index is equal / if yes, jump to end of loop, if not continue
  je loopEnd2
  mov rax, 0

  mov r9, [r13 + 8*rbx]
  mov [r11 + 8*r10], r9 ;move number in xmm14 into result[6-11]

  inc r10 ;increment index | r12 starts at 6 goes to 12
  inc rbx
  jmp loopStart2
loopEnd2:

pop rax
mov rax, r10

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
