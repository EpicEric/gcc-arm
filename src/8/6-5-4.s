    .text
    .globl main
main:
    CMP r0, #1
    BLEQ    push_byte
    CMP r0, #2
    BLEQ    push_half_word
    CMP r0, #4
    BLEQ    push_word 
    B main
push_byte:

push_half_word:

push_word:
