;****************************************************************************************************************************
;Program name: "Magnitude".  Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "Magnitude".                                                                   *
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
;  Program name: Magnitude
;  Programming languages: Two modules in C and three module in X86
;  Date program began: 2023 Feb 10
;  Date of last update: 2023 Feb 19
;
;  Files in this program: manager.asm, append.asm, magnitude.asm, input_array.asm, display.cc, main.cc
;  Status: Finished.
;
;===== Begin code area ================================================================================================

global magnitude

segment .data

segment .bss

segment .text

magnitude:
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

; =================== REGISTER ARRAY ============================

mov r15, rdi  ;array name
mov r14, rsi  ;array size

; =================== CALCULATE MAGNITUDE ============================

mov rax, 2  ;we use 4 xmm registers
mov rdx, 0
mov rcx, 0
cvtsi2sd xmm15, rdx ; convert the 0 in rdx and rcx to something xmm can read
cvtsi2sd xmm13, rcx
mov r13, 0  ;index

loopStart:
  cmp r13, r14
  je loopEnd

  movsd xmm15, [r15 + 8*r13]    ;calculate magnitude sqrt(x^2 + y^2 + ... z^2)
  mulsd xmm15, xmm15
  addsd xmm13, xmm15

  inc r13
  jmp loopStart
loopEnd:

sqrtsd xmm13, xmm13

pop rax
movsd xmm0, xmm13

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
