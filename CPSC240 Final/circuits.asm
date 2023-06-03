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

extern getfrequency

global circuits

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

input_current db "Please enter the current:  ", 0
input_res1 db "Please enter the resistance on circuit 1:  ", 0
input_res2 db "Please enter the resistance on circuit 2:  ", 0
input_res3 db "Please enter the resistance on circuit 3:  ", 0

total_res db "The total resistance is R = %.8lf ", 10, 0
voltage db "The voltage is V = %.8lf ", 10, 0

frequencyPrompt db "The frequency of this processor is %d tics/second", 10, 0
computation db "The computations were performed in %llu tics, which equals %.10lf .", 10, 0

one_float_format db "%lf", 0

newline db 10, 0

segment .bss

segment .text

circuits:
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

; =================== CURRENT INPUT ============================
push qword 0
mov rax, 0
mov rdi, input_current ;"Please enter the current:"
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm15, [rsp] ;Dereference data at the top of the stack, store it in xmm15
pop rax

; =================== FIRST RESISTANCE INPUT ============================
push qword 0
mov rax, 0
mov rdi, input_res1 ;"Please enter the resistance on circuit 1:"
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp] ;Dereference data at the top of the stack, store it in xmm14
pop rax

; =================== SECOND RESISTANCE INPUT ============================
push qword 0
mov rax, 0
mov rdi, input_res2 ;"Please enter the resistance on circuit 2:"
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm13, [rsp] ;Dereference data at the top of the stack, store it in xmm13
pop rax

; =================== THIRD RESISTANCE INPUT ============================
push qword 0
mov rax, 0
mov rdi, input_res3 ;"Please enter the resistance on circuit 3:"
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp] ;Dereference data at the top of the stack, store it in xmm12
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== GET START TICS ============================

push qword 0
xor rax, rax
xor rdx, rdx
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r14, rdx
pop rax

;start tics held in r14

; =================== CALCULATE TOTAL RESISTANCE ============================

;xmm14-12 holds resistances 1, 2, 3
;total resistance is 1/r1 + 1/r2 + 1/r3
mov r15, 1
cvtsi2sd xmm11, r15

divsd xmm11, xmm14  ;divide 1/r1 , result is in xmm11
movsd xmm14, xmm11  ;move result into xmm14

cvtsi2sd xmm11, r15 ;move 1 back into xmm11

divsd xmm11, xmm13  ;divide 1/r2 , result is in xmm11
movsd xmm13, xmm11  ;move result into xmm13

cvtsi2sd xmm11, r15 ;move 1 back into xmm11

divsd xmm11, xmm12  ;divide 1/r3 , result is in xmm11
movsd xmm12, xmm11  ;move result into xmm12

cvtsi2sd xmm11, r15 ;move 1 back into xmm11

addsd xmm14, xmm13
addsd xmm14, xmm12

push qword 0
mov rax, 1
mov rdi, total_res
movsd xmm0, xmm14
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

;total resistance is in xmm14 now

; =================== CALCULATE VOLTAGE ============================

mulsd xmm15, xmm14  ;voltage = current * total resistance

push qword 0
mov rax, 1
mov rdi, voltage
movsd xmm0, xmm15
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== GET END TICS ============================

push qword 0
xor rax, rax
xor rdx, rdx
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r13, rdx
pop rax

;end tics in r13

; =================== CALL GET FREQUENCY ============================

push qword 0
mov rax, 0
call getfrequency
movsd xmm13, xmm0
pop rax

push qword 0
mov rax, 1
mov rdi, frequencyPrompt
movsd xmm0, xmm13
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== CALCULATE TICS AND SECONDS ============================

sub r13, r14    ;elapsed tics in r13
cvtsi2sd xmm12, r13     ;put it into xmm12

divsd xmm12, xmm13

push qword 0
mov rax, 1
mov rdi, computation
mov rsi, r13
movsd xmm0, xmm12
call printf
pop rax

pop rax

movsd xmm0, xmm15

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
