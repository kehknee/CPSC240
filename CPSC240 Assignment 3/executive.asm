;****************************************************************************************************************************
;Program name: "executive".  Copyright (C) 2022 Kenneth Tran.                                                                           *
;                                                                                                                           *
;This file is part of the software program "executive".                                                                   *
;executive is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
;version 3 as published by the Free Software Foundation.                                                                    *
;executive is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
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
;  Program name: executive
;  Programming languages: Three modules in X86, two modules in C
;  Date program began: 2023 Mar 5
;  Date of last update: 2023 Mar 9
;
;  Files in this program: executive.asm, fill_random_array.asm, show_array.asm, main.cc, quick_sort.cc
;  Status: Finished.
;
;===== Begin code area ================================================================================================

extern printf
extern scanf
extern qsort
extern quick_sort

extern fgets
extern stdin
extern strlen

extern fill_random_array
extern show_array

INPUT_LEN equ 256

global executive

segment .data

;===== Declare some messages, new lines, and value input variables ==============================================================================================================================================

format: db "%s", 0

name_input db "Please enter your name: ", 0
title_input db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ", 0
welcome db "Nice to meet you ", 0
goodbye db "Good bye ", 0
goodbye2 db ". You are welcome anytime.", 10, 0


prompt1 db "This program will generate 64-bit IEEE float numbers.", 10, 0
prompt2 db "How many numbers do you want?  Today's limit is 100 per customer. ", 0
prompt3 db "Your numbers have been stored in an array.  Here is that array.", 10, 0

prompt4 db "The array is now being sorted.", 10, 0
prompt5 db "Here is the updated array.", 10, 0

normalize_prompt db "The random numbers will be normalized. Here is the normalized array", 10, 0

newline db 10, 0
spc: db " ", 0

array_size db "%d", 0

segment .bss

title: resb INPUT_LEN
name: resb INPUT_LEN

myArray: resq 100

segment .text

executive:
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

; =================== PROMPT + FGETS TITLE ============================

push qword 0
mov rax, 0
mov rdi, title_input ;Please enter your title
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, title
mov rsi, INPUT_LEN
mov rdx, [stdin]
call fgets
pop rax

push qword 0
mov rax, 0
mov rdi, title
call strlen
sub rax, 1
mov byte [title + rax], 0
pop rax

; =================== WELCOME PROMPTS ============================

push qword 0
mov rax, 0
mov rdi, format
mov rsi, welcome
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, format
mov rsi, title      ;Welcome prompt + title + space + name
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, format
mov rsi, spc
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
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== PROMPTS FOR ARRAY SIZE ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, prompt1      ;This program will generate 64-bit IEEE float numbers.
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, prompt2      ;How many numbers do you want. Today’s limit is 100 per customer.
call printf
pop rax

; =================== SCAN INPUT FROM USER ============================

push qword 0
mov rax, 0
mov rdi, array_size       ;gets input from user as a %d, stores it into r9
mov rsi, rsp
call scanf
mov r9, [rsp]
pop rax

push qword 0
mov rax, 0
mov rdi, prompt3        ;Your numbers have been stored in an array. Here is that array.
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== CALL FILL ARRAY FUNCTION ============================

push qword 0
mov rax, 0
mov rdi, myArray        ;parameter 1 = array
mov rsi, r9             ;parameter 2 = size of array
call fill_random_array
mov r14, rax
pop rax

; =================== CALL SHOW ARRAY FUNCTION ============================

push qword 0
mov rax, 0
mov rdi, myArray      ;parameter 1 = array
mov rsi, r14          ;parameter 2 = size of array
call show_array
pop rax

; =================== PROMPTS BETWEEN UNSORTED AND SORTED ARRAY ============================

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, prompt4 ;The array is now being sorted
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, prompt5 ;Here is the updated array
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== CALL QUICK SORT FUNCTION ============================

push qword 0
mov rax, 0
mov rdi, myArray       ;parameter 1 = array
mov rsi, r14           ;parameter 2 = size of array
mov rdx, 8             ;parameter 3 = size of bytes in each element in the array
mov rcx, quick_sort    ;uses loop and algorithm in quick_sort.cc function
call qsort
pop rax

; =================== CALL SHOW ARRAY FUNCTION (again) ============================

push qword 0
mov rax, 0
mov rdi, myArray      ;parameter 1 = array
mov rsi, r14          ;parameter 2 = size of array
call show_array
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== NORMALIZE PROMPTS  ============================

push qword 0
mov rax, 0
mov rdi, normalize_prompt   ;The random numbers will be normalized. Here is the normalized array
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== CALL NORMALIZE FUNCTION + QSORT ============================

push qword 0
mov rax, 0
mov r13, 0      ;index
mov r12, r14    ;move array size into r12 to use to compare with index
loopStart:
  cmp r13, r12 ;check if index is equal / if yes, jump to end of loop, if not continue
  jge loopEnd

  mov rdx, [myArray+8*r13]      ;move number in array[index]
  shl rdx, 12                 ;shift number left 12
  shr rdx, 12                 ;shift number right 12
  mov rcx, 1023
  shl rcx, 52
  or rdx, rcx                 ;normalizes number to only 0x3FF

  mov[myArray + 8*r13], rdx   ;moves number back into array
  inc r13
  jmp loopStart

loopEnd:

pop rax

;sort array one more time
push qword 0
mov rax, 0
mov rdi, myArray       ;parameter 1 = array
mov rsi, r14           ;parameter 2 = size of array
mov rdx, 8             ;parameter 3 = size of bytes in each element in the array
mov rcx, quick_sort    ;uses loop and algorithm in quick_sort.cc function
call qsort
pop rax

; =================== CALL SHOW ARRAY FUNCTION ============================

push qword 0
mov rax, 0
mov rdi, myArray      ;parameter 1 = array
mov rsi, r14          ;parameter 2 = size of array
call show_array
pop rax

push qword 0
mov rax, 0
mov rdi, newline  ;enters new line into terminal
call printf
pop rax

; =================== GOODBYE MESSAGES ============================

push qword 0
mov rax, 0
mov rdi, format
mov rsi, goodbye        ;Good bye <title>
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, format
mov rsi, title
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, goodbye2       ;You are welcome any time.
call printf
pop rax

pop rax
mov rax, name           ;moves name into rax to be used in main function

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
