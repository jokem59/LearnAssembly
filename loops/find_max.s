#PURPOSE: This program finds the maximum number of a
# set of data items.
#
#VARIABLES: The registers have the following uses:
#
# %edi - Holds the index of the data item being examined
# %ebx - Largest data item found
# %eax - Current data item
#
# The following memory locations are used:
#
# data_items - contains the item data. A 0 is used
# to terminate the data
#

    .section .data
data_items:
    .long 3,67,34,222,45,75,54,66,0

    .section .text
    .globl _start
_start:
    movl $0, %edi                  # immediate mode          - move 0 into register edi
    movl data_items(,%edi,4), %eax # indexed addressing mode - access data_items, index 0 that's 4 bytes wide, and place in register eax
    movl %eax, %ebx                # direct addressing mode  - first number, we we store our max in register ebx


start_loop:
    cmpl $0, %eax                  # immediate/direct mode   - check to see if we're at the end of our array
    je loop_exit                   # If 0 equals to value in eax, exit loop
    incl %edi                      # direct addressing mode  - increment our index counter
    movl data_items(,%edi,4), %eax # same as previous
    cmpl %ebx, %eax                # Compare indexed value with current max
    jle start_loop                 # jle works from right to left -> %eax <= %ebx, jump to start_loop

    movl %eax, %ebx                # move eax into ebx, the new largest value
    jmp start_loop

loop_exit:
    # %ebx is the status code for the exit system call
	# and it already has the maximum number
	movl $1, %eax                  # eax holds the value of the system call to execute (1 = exit)
    int $0x80                      # Linux magic number to signal interrupt handler and handle system call
