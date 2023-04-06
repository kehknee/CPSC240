;****************************************************************************************************************************
;Program name: "manager.asm". This program is the menu and control for finding the magnitude of 2 arrays and append them together. Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "manager.asm".                                                                   *
;manager.asm is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;manager.asm is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Programming languages: Two modules in C and three module in X86
;  Date program began: 2023 Feb 10
;  Date of last update: 2023 Feb 19
;
;  Files in this program: manager.asm, append.asm, magnitude.asm, input_array.asm, display.cc, main.cc
;  Status: Finished.
;
;This file
;   File name: manager.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l manager.lis -o manager.o manager.asm

;===== Begin code area ================================================================================================

extern printf
extern scanf

extern input_array
extern display_array
extern magnitude
extern append

global manager

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

inputPrompt1 db "This program will manage your arrays of 64-bit floats", 10, 0
inputPrompt2 db "For array A enter a sequence of 64-bit floats (up to 7 numbers) separated by white space.", 10, 0
inputPrompt3 db "After the last input press enter followed by Control+D:", 10, 0

inputPrompt4 db "For array B enter a sequence of 64-bit floats (up to 7 numbers) separated by white space.", 10, 0
inputPrompt5 db "After the last input press enter followed by Control+D: ", 10, 0

displayNumbers db "These numbers were received and placed into array A:", 10, 0
displayNumbers_B db "These number were received and placed into array B:", 10, 0
displayMagni db "The magnitude of array A is %.6lf", 10, 0
displayMagni_B db "The magnitude of this array B is %.8lf", 10, 0

appendedArrays db "Arrays A and B have been appended and given the name A⊕ B.", 10, 0
appendedPrompt2 db "A⊕ B contains ", 10, 0
appendedMagnitude db "The magnitude of  A⊕ B is %.5lf  ", 10, 0

newline db 10, 0


segment .bss

myArray resq 7
myArrayB resq 7
resultArray resq 12

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

; =================== INPUT FOR ARRAY A ============================


push qword 0
mov rax, 0
mov rdi, inputPrompt1
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, inputPrompt2
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, inputPrompt3
call printf
pop rax

; =================== CALL INPUT_ARRAY FUNCTION ============================

push qword 0
mov rax, 0
mov rdi, myArray    ;array name
mov rsi, 7         ;array size
call input_array
mov r15, rax        ;moves total size based on number of inputs from user back into register
pop rax

; =================== DISPLAY RECEIVED NUMBERS ============================

push qword 0
mov rax, 0
mov rdi, displayNumbers
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, myArray      ;parameter 1 = array
mov rsi, r15          ;parameter 2 = size of array
call display_array
pop rax

; =================== COMPUTE THE MAGNITUDE ============================

push qword 0
mov rax, 0
mov rdi, myArray      ;calls magnitude function with array and max size
mov rsi, r15
call magnitude
movsd xmm15, xmm0         ;moves answer from xmm0 into xmm15 register
pop rax

; =================== DISPLAY MAGNITUTDE ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, displayMagni
movsd xmm0, xmm15         ;moves number in xmm15 into xmm0 to display
call printf
pop rax

; =================== INPUT FOR ARRAY B ============================

push qword 0
mov rax, 0
mov rdi, inputPrompt4
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, inputPrompt5
call printf
pop rax

; =================== CALL INPUT ARRAY FUNCTION (AGAIN) ============================

push qword 0
mov rax, 0
mov rdi, myArrayB       ;array name
mov rsi, 7             ;array size
call input_array
mov r14, rax
pop rax

; =================== DISPLAY RECEIVED NUMBERS FOR ARRAY B ============================

push qword 0
mov rax, 0
mov rdi, displayNumbers_B
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, myArrayB
mov rsi, r14
call display_array
pop rax

; =================== COMPUTE THE MAGNITUDE (AGAIN) ============================

push qword 0
mov rax, 0
mov rdi, myArrayB       ;computes magnitude using array name and size as parameters
mov rsi, r14
call magnitude
movsd xmm14, xmm0
pop rax

; =================== DISPLAY MAGNITUDE FOR ARRAY B ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 1
mov rdi, displayMagni_B
movsd xmm0, xmm14
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== APPEND ARRAYS ============================

push qword 0
mov rax, 0
mov rdi, myArray          ;calls append array function using 5 parameters
mov rsi, r15              ;arrayA and arrayB names and sizes
mov rdx, myArrayB         ;as well as an arrayC
mov rcx, r14
mov r8, resultArray
call append
mov r13, rax
pop rax

; =================== DISPLAY APPENDED ARRAYS ============================

push qword 0
mov rax, 0
mov rdi, appendedArrays
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, appendedPrompt2
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, resultArray
mov rsi, r13
call display_array
pop rax

; =================== CALCULATE MAGNITUDE OF APPENDED ARRAY ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, resultArray          ;calculates magnitude of appended array
mov rsi, 14
call magnitude
movsd xmm13, xmm0
pop rax

; =================== DISPLAY MAGNITUDE FOR ARRAY B ============================

push qword 0
mov rax, 1
mov rdi, appendedMagnitude
movsd xmm0, xmm13
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

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
