/* Program that converts a binary number to decimal */

/* Algorithm to implement:
MAX decimal value = 9999
divide by 1000 result is 9, remainder 999 save the 9
divide by 100 result is 9, remainder 99 save the 9
divide by 10 result is 9, remainder 9 save the 9 and 9
*/
           .text               // executable code follows
           .global _start
_start:
            MOV    R4, #N
            MOV    R5, #Digits  // R5 points to the decimal digits storage location
            LDR    R4, [R4]     // R4 holds N
            MOV    R0, R4       // parameter for DIVIDE goes in R0
            BL     DIVIDE
            STRB   R9, [R5, #3] // Thousands digit is now in R9
            STRB   R8, [R5, #2] // Hundreds digit is now in R8
            STRB   R1, [R5, #1] // Tens digit is now in R1
            STRB   R0, [R5]     // Ones digit is in R0
END:        B      END

/* Subroutine to perform the integer division R0 / x.
 * Returns: quotient in R1, and remainder in R0 */

// BLT: Branch if less than; compares 2 registers, takes a branch if one register is less than another
// Cannot use registers R0-R5 for thousands and hundreds division

DIVIDE:     MOV    R6, #0 // For thousands division
            MOV    R7, #0 // For hundreds division
            MOV    R2, #0 // For tens division
CONT_T:     CMP    R0, #1000     
            BLT    DIV_END_T
            SUB    R0, #1000    
            ADD    R6, #1
            B      CONT_T
DIV_END_T:  MOV    R9, R6     // quotient in R9 (remainder in R0)

CONT_H:     CMP    R0, #100     
            BLT    DIV_END_H
            SUB    R0, #100     
            ADD    R7, #1
            B      CONT_H
DIV_END_H:  MOV    R8, R7     // quotient in R8 (remainder in R0)

CONT:       CMP    R0, #10     
            BLT    DIV_END
            SUB    R0, #10      
            ADD    R2, #1
            B      CONT
DIV_END:    MOV    R1, R2     // quotient in R1 (remainder in R0)
            MOV    PC, LR

N:          .word  9876       // the decimal number to be converted
Digits:     .space 4          // storage space for the decimal digits

            .end