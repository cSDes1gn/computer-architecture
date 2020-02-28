; Process uses binary search tree algorithm to return the index of a specified input value in a sorted array

ENTRY
			
array		DCD		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24
			
PROC
			
_start
			mov		r1,#17			; init search value in r1
			mov		r2,#24			; init array size in r2
			mov		r3, #array		; load start address of array in r3

_main
			mov		r7,#-1      	; while r7 is -1 the number is not found
			cmp		r2,#0        	; ensure the array size is non-zero
			blt		done        	; branch if less than to done
			
			mov		r5,#0      		; init min_index to 0
			sub		r2,r2,#1    	; init max_index
			
_while
			cmp		r2,r5       	; check for elements left to search
			blt		_done
			
			add		r4,r5,r2    	; determine midpoint index
			lsl		r4,r4,#1    	; logical shift right by 1 index (int r4/2) then conversion off offset from bit to byte increments lsl << 2 (int r4*4)
			ldr		r8,[r3,r4]  	; get midpoint index value
			
			cmp		r8,r1       	; test midpoint index
			blt		_adjust_min  	; less than branch (adjust max index)
			bgt		_adjust_max  	; greater than branch (adjust min index)
			
			mov		r7,r4       	; else we have the exact number in the array so we have found the index
			b		_done
			
_adjust_min
			lsr		r4,r4,#2		; convert word (byte) index to integer index for min increment
			add		r5,r4,#1
			b		_while
			
_adjust_max
			lsr		r4,r4,#2		; convert word (byte) index to integer index for max decrement
			sub		r2,r4,#1
			b		_while
			
_done
ENDP
			END
