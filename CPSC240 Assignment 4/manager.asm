;****************************************************************************************************************************
;Program name: "manager".  Copyright (C) 2022 Kenneth Tran.                                                                           *
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
;  Program name: manager
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

extern getradicand

global manager

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

inputPrompt1 db "Welcome to Square Root Benchmarks by Kenneth Tran ", 10, 0
inputPrompt2 db "For customer service contact me at kqmtran@csu.fullerton.edu", 10, 0

cpuPrompt db "Your CPU is %s", 10, 0
clockAskPrompt db "Please enter your CPU frequency in GHz: ", 0

clicksPrompt1 db "The time on the clock is %llu tics.", 10, 0
clicksPrompt2 db "The time of the clock is %llu tics and the benchmark is completed.", 10, 0
benchmarkStartPrompt db "The bench mark of the sqrtsd instruction is in progress.", 10, 0
elapsedTimePrompt db "The elapsed time was %llu tics.", 10, 0

nanosecondsPrompt db "The time for one square root computation is %.5lf tics which equals %.5lf ns.", 10, 0
sqrtPrompt db "The square root of %.10lf is %.11lf", 10, 0

loopAmountPrompt db "Next enter the number of times iteration should be performed:  ",0


loopCount db "%d", 0
single_float_format db "%lf", 0

newline db 10, 0

segment .bss

cpu_name resb 100

segment .text

manager:
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

; =================== GET CPU NAME ============================

MOV r15, 0x80000002
MOV rax, r15
cpuid

mov [cpu_name], rax
mov [cpu_name +4], rbx
mov [cpu_name +8], rcx
mov [cpu_name +12], rdx

mov r15, 0x80000003
mov rax, r15
cpuid

mov [cpu_name +16], rax
mov [cpu_name +20], rbx
mov [cpu_name +24], rcx
mov [cpu_name +28], rdx

mov r15, 0x80000004
mov rax, r15
cpuid

mov [cpu_name +32], rax
mov [cpu_name +36], rbx
mov [cpu_name +40], rcx
mov [cpu_name +44], rdx

push qword 0
mov rax, 0
mov rdi, cpuPrompt
mov rsi, cpu_name
call printf
pop rax

; =================== GET CLOCK SPEED ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, clockAskPrompt ;ask user for cpu freq in ghz
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, single_float_format
mov rsi, rsp
call scanf
movsd xmm11, [rsp]    ;store in xmm11
pop rax

; =================== GET SQUARE ROOT ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
call getradicand    ;calls getradicand function
movsd xmm13, xmm0   ;takes returned number in xmm0, puts it in xmm13
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

sqrtsd xmm12, xmm13     ;get sqrt of number user inputted and display it

push qword 0
mov rax, 2
mov rdi, sqrtPrompt
movsd xmm0, xmm13
movsd xmm1, xmm12
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== ENTER AMOUNT OF TIMES LOOP SHOULD BE RUN ============================

push qword 0
mov rax, 0
mov rdi, loopAmountPrompt     ;ask user to input amount of times they want loop to be ran
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, loopCount
mov rsi, rsp
call scanf
mov r12, [rsp]
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

; =================== PRINT PROMPTS AND DISPLAY TICS ============================

push qword 0
mov rax, 0
mov rdi, clicksPrompt1    ;displays start tics
mov rsi, r14
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, benchmarkStartPrompt   ;"The bench mark of the sqrtsd instruction is in progress."
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

;=================== LOOP TO RUN SQUARE ROOT FUNCTION ============================

mov r11, 0
loopBegin:
  cmp r11, r12   ;r12 is amount of times loop needs to be ran
  je loopEnd

  sqrtsd xmm12, xmm13     ;square root number from earlier

  inc r11     ;r11 is the increment
  jmp loopBegin
loopEnd:

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

; =================== PRINT PROMPTS AND DISPLAY TICS ============================

push qword 0
mov rax, 0
mov rdi, clicksPrompt2      ;display end tics
mov rsi, r13
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== CALCULATE ELAPSED TIME IN BETWEEN TICS ============================

sub r13, r14      ;end tics - start tics = elapsed tics

push qword 0
mov rax, 0
mov rdi, elapsedTimePrompt      ;display elapsed tics
mov rsi, r13
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== CALCULATE SECONDS PER SQUARE ROOT COMPUTATION AND NANOSECONDS ============================

mov rax, r13
cvtsi2sd xmm14, r13   ;convert elapsed into xmm register

mov rax, r12
cvtsi2sd xmm15, r12   ;convert iterations into xmm register

divsd xmm14, xmm15  ;tics per sqrt computation = elapsed / iterations
movsd xmm15, xmm14  ;move into xmm register to calculate with

mov r15, 1000000000   ;1x10^9 nanoseconds
mov rax, r15
cvtsi2sd xmm12, r15

mulsd xmm11, xmm12
divsd xmm15, xmm11 ;divide seconds / ghz per second
mulsd xmm15, xmm12  ;divide seconds / ghz per sec by 1xx10^9 nanoseconds to get nanoseconds per tic

push qword 0
mov rax, 2
mov rdi, nanosecondsPrompt
movsd xmm0, xmm14 ;seconds per tic
movsd xmm1, xmm15 ;nanoseconds per tic
call printf
pop rax

; ===========================================================================


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
