; Binary Tree Search Through Sorted Array Elements
; Issues: ARM only addresses in 4 byte blocks so array length must satisfy 2^n-1

ENTRY
			
			; using a specific number of indices (33) which allows for binary search tree algorithm to always land on a specific index when divided.
array		DCD		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33
			
PROC
			
_main
_start
			mov		r1,#8		; init search value
			mov		r2,#128		; init array size in r2
			mov		r3, #array	; load start address of array in r3
			mov		r7,#-1      	; while r7 is -1 the number is not found
			cmp		r2,#0        	; ensure the array size is non-zero
			blt		done        	; branch if less than to done
			
			mov		r5,#0       ; init min_index to 0
			
_while
			cmp		r2,r5       ; check for elements left to search
			blt		_done
			
			add		r4,r5,r2    ; determine midpoint index
			lsr		r4,r4,#1    ; logical shift right by 1 index (int div/2)
			
			ldr		r8,[r3,r4]  	; get midpoint index
			cmp		r8,r1       ; test midpoint index
			blt		_adjust_min  ; less than branch (adjust max index)
			bgt		_adjust_max  ; greater than branch (adjust min index)
			
			mov		r7,r4       ; else we have the exact number in the array so we have found the index
			b		_done
			
_adjust_min
			add		r5,r4,#0
			b		_while
			
_adjust_max
			sub		r2,r4,#0
			b		_while
			
_done
ENDP
			
			END
