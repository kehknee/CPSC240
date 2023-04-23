;****************************************************************************************************************************
;Program name: "manager".  Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "driver".                                                                   *
;driver is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;driver is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Programming languages: Two modules in X86, one modules in C
;  Date program began: 2023 Apr 17
;  Date of last update: 2023 Apr 22
;
;  Files in this program: manager.asm, driver.cc, r.sh, isfloat.asm
;  Status: Finished.
;
;===== Begin code area ================================================================================================

extern printf
extern scanf

;includes for checking if string inputted number can be converted to float // also include for sin library
extern isfloat
extern atof
extern sin

;includes for getting user's name
extern fgets
extern stdin
extern strlen




INPUT_LEN equ 256

global manager

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

format: db "%s", 0

name_input db "Please enter your name: ", 0
welcome db "Nice to meet you ", 0
welcome2 db " Please enter an angle number in degrees: ", 0
term_input_prompt db "Thank you. Please enter the number of terms in a Taylor series to be computed: ", 0

computationPrompt db "Thank you. The Taylor series will be used to compute the sine of your angle.", 10, 0
finishedPrompt db "The computation completed in %d tics and the computed value is %.9lf", 10, 0
secondComputation db "Next the sine of %.9lf will be computed by the function sin in the library <math.h>.", 10, 0
secondFinish db "The computation completed in %d tics and gave the value %.9lf", 10, 0

invalid_input_msg db "Invalid. Please try again: ", 0

newline db 10, 0
spc: db " ", 0
period: db ".", 0

angle_input_format db "%s", 0
single_digit_format db "%d", 0

radian_constant dq 0.017453292519943295

segment .bss

name: resb INPUT_LEN

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

; =================== PROMPT + FGETS NAME ============================

push qword 0
mov rax, 0
mov rdi, name_input ;Please enter your name:
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, name
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets        ;gets name from user that includes white space
pop rax

push qword 0
mov rax, 0
mov rdi, name
call strlen
sub rax, 1
mov byte [name + rax], 0
pop rax

; =================== WELCOME PROMPTS ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, format
mov rsi, welcome    ;It's nice to meet you ...
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, format
mov rsi, name
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, format
mov rsi, period     ;Welcome + name + period.
call printf
pop rax

; =================== PROMPTS FOR ANGLE IN DEGREES INPUT ============================

push qword 0
mov rax, 0
mov rdi, welcome2      ;Please enter an angle number in degrees:
call printf
pop rax

; =================== SCAN INPUT FROM USER ============================

beginLoop:
  push qword 0
  mov rax, 0
  mov rdi, angle_input_format   ;%s with isfloat
  mov rsi, rsp
  call scanf

; =================== CHECK IF USER INPUT IS VALID ============================

  mov rax, 0
  mov rdi, rsp
  call isfloat      ;call isfloat to check if user inputted number as type string can be converted to float
  cmp rax, 0
  je invalidInput

  mov rax, 0
  mov rdi, rsp
  call atof         ;if valid, turn string into a useable float and store in xmm15
  movsd xmm15, xmm0
  pop rax

  jmp endLoop

  invalidInput:

    mov rax, 0
    mov rdi, invalid_input_msg      ;if invalid then display msg
    call printf
    pop rax

    jmp beginLoop

endLoop:

; =================== CONVERT TO RADIANS ============================

movsd xmm14, xmm15
mulsd xmm14, [radian_constant]

; =================== PROMPTS FOR TERMS INPUT ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, term_input_prompt      ;Thank you. Please enter the number of terms in a Taylor series to be computed:
call printf
pop rax

; =================== SCAN AMOUNT OF COMPUTATIONS ============================

push qword 0
mov rax, 0
mov rdi, single_digit_format    ;%d
mov rsi, rsp
call scanf
mov r10, [rsp]      ;store radicand into xmm14
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, computationPrompt      ;Thank you.  The Taylor series will be used to compute the sine of your angle.
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

;=================== LOOP TO RUN TAYLOR SERIES SINE FUNCTION ============================


; -1 * x^2
; --------- (divded by)
; (2k+3)(2k+2)

;xmm14 = x, the number the user inputted
;these are for the 3, 2 and -1 in the equation

mov rax, 3
cvtsi2sd xmm13, rax
mov rax, 2
cvtsi2sd xmm12, rax
mov rax, -1
cvtsi2sd xmm5, rax

mov r15, 0      ;the "k" in the equation, always starting at 0 (our increment)
cvtsi2sd xmm11, r15

movsd xmm10, xmm14  ;count = current term

loopBegin:
  cmp r15, r10   ;r10 is amount of times loop needs to be ran or our "max" term
  je loopEnd

  ; ======= 2k+3 =======
  movsd xmm9, xmm12 ;move 2 (xmm12) into xmm9
  mulsd xmm9, xmm11 ;multiply 2 (xmm9) by k (xmm11)
  addsd xmm9, xmm13 ;add 3 (xmm13) to xmm9
  ;2k+3 is now stored in xmm9

  ; ======= 2k+2 =======
  movsd xmm8, xmm12 ;move 2 (xmm12) into xmm8
  mulsd xmm8, xmm11 ;multiply 2 (xmm8) by k (xmm11)
  addsd xmm8, xmm12 ;add 2 (xmm13) to xmm8
  ;2k+2 is now stored in xmm8

  ;multiply (2k+3)(2k+2)
  mulsd xmm9, xmm8

  ;calculate the x^2
  movsd xmm7, xmm14
  mulsd xmm7, xmm7

  ;divide x^2 by (2k+3)(2k+2), then multiply by -1
  divsd xmm7, xmm9
  mulsd xmm7, xmm5

  ;factor is in xmm7
  ;current term is in xmm14

  ;next term = current term * factor
  mulsd xmm7, xmm14
  addsd xmm10, xmm7  ;add current term of the sequence if index is not capped
  movsd xmm14, xmm7

  inc r15
  cvtsi2sd xmm11, r15
  jmp loopBegin

loopEnd:

;final result is stored in xmm10

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

; =================== FIND TICS TAKEN TO FINISH LOOP ============================

sub r13, r14      ;end tics - start tics = elapsed tics

; =================== FINISHED PROMPTS  ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, finishedPrompt   ;The computation completed in x tics and computed value is y.
mov rsi, r13
movsd xmm0, xmm10
call printf
pop rax

; =================== SECOND RUN PROMPTS ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, secondComputation   ;Next the sine of x will be computed by the function "sin" in the library <math.h>.
movsd xmm0, xmm15
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
mov r12, rdx
pop rax

; =================== COMPUTE SINE USING LIBRARY ============================

push qword 0
mov rax, 0
mulsd xmm15, [radian_constant]    ;xmm15 = user inputted degrees, radian constant = pi/180
movsd xmm0, xmm15                 ;multiply xmm15 with pi/180 then move into xmm0
call sin                          ;call sine function then move from xmm0 into xmm8 for printing
movsd xmm8, xmm0
pop rax

; =================== GET END TICS ============================

push qword 0
xor rax, rax
xor rdx, rdx
cpuid
rdtsc
shl rdx, 32
add rdx, rax
mov r11, rdx
pop rax

; =================== FIND TICS TAKEN TO FINISH LOOP ============================

sub r11, r12      ;end tics - start tics = elapsed tics

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 2
mov rdi, secondFinish
mov rsi, r11
movsd xmm0, xmm8
call printf
pop rax

cvtsi2sd xmm14, r13

pop rax

movsd xmm0, xmm14

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
