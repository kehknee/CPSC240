;****************************************************************************************************************************
;Program name: "getradicand".  Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "manager".                                                                   *
;Magnitude is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;Magnitude is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: getradicand
;  Programming languages: One modules in C and two module in X86
;  Date program began: 2023 Apr 06
;  Date of last update: 2023 Apr 12
;
;  Files in this program: main.cc, manager.asm, getradicand.asm
;  Status: Finished.
;
;===== Begin code area ================================================================================================

extern printf
extern scanf

global getradicand

segment .data

float_format db "%lf", 0

prompt1 db "Please enter a floating radicand for square root bench marking:  ", 0

newline db 10, 0

segment .bss

segment .text

getradicand:
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

; =================== GRAB NUMBER FROM USER BLOCK ============================

push qword 0
mov rax, 0
mov rdi, prompt1    ;ask user for radicand input
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]      ;store radicand into xmm14
pop rax

pop rax

movsd xmm0, xmm14       ;return radicand back to xmm0 in manager.asm

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
