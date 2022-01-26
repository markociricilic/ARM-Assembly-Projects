/* Program that finds the largest number in a list of integers	*/
            
            .text                   // executable code follows
            .global _start                  
_start:                             
            MOV     R4, #RESULT     // R4 points to result location
            LDR     R0, [R4, #4]    // R0 holds the number of elements in the list
            MOV     R1, #NUMBERS    // R1 points to the start of the list
            BL      LARGE           
            STR     R0, [R4]        // R0 holds the subroutine return value

END:        B       END             

/* Subroutine to find the largest integer in a list
 * Parameters: R0 has the number of elements in the list
 *             R1 has the address of the start of the list
 * Returns: R0 returns the largest item in the list */

// Based on LOOP code from part2.s
LARGE:      SUBS    R0, #1        // decrements the loop counter by 1
            BEQ     DONE          // if result is equal to 0, branch
            ADD     R1, #4        
            LDR     R2, [R1]      // value at the address R1 is loaded into register R2 (gets the next number)
            CMP     R3, R2        // check if a larger number is found
            BGE     LARGE
            MOV     R3, R2        // update the largest number
            B       LARGE
            
DONE:       MOV     R0, R3      // stores largest number into result location; R0
            MOV     PC, LR      // PC<-LR (RETURN FROM SUBROUTINE)

RESULT:     .word   0           
N:          .word   7           // number of entries in the list
NUMBERS:    .word   4, 5, 3, 6  // the data
            .word   1, 8, 2                 

            .end