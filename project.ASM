.model small
.stack 100h
.data 
.code

main proc

;Setting Text Mode by using Funtion 0h
	mov ah,0h
	mov al,3
	int 10h
;clear screen to Black By using Scroll Up Function 6h 
	mov ah,6h
	mov al,0
	mov cx,0
	mov dx,184Fh
	mov bh,7
	int 10h
;setting Graphic mode by using 0hsssssssss
	mov ah,0h
	mov al,13h
	int 10h
	
;using bl As A FLAG Variable to repeat Graphical Lines 4 times
	mov bl,0

;Strting Loop 4 Times By Adding 1 To Bl Each Time
rl:

	
;Setting Rows And Columns For Writinh Pixel using OCH Function
	mov ah, 0Ch
	mov cx,20 
	mov dx,19
	mov al,0
	mov bh,0
	int 10h
	
;writing Square by Calling Procedure "write_row" to write rows
	
;start of write_square
write_square:
	mov cx,20			;Setting Column Value to 20
	inc dx				;incrementing rows each time by adding 1 in DX
	inc al				;incrementing al TO Change Color Each time Until DX is Not > 170
	call	write_row	;calling Procedure write_row
	mov cx,20			; againg setting column position that was changed By Procedure	
; start delay
	mov bp,60000
	delay:
	dec bp
	nop
	jnz delay
; end delay
	cmp dx,170
	JLE write_square
;End Of write_square

	
	mov al,0			;setting color Value TO Black by Moving 0 In AL to Remove Written pixels By write_square
	mov dx,171			;setting row to Last Number of row to which write_square have left to
	

;start of remove_square	
	remove_square:		
	mov cx,20			;Setting Column Value to 20
	call remove_row		;caling procedure to write BLACK Pixel From Boottom Of Line
	dec dx				;Decrementing Row Each Time So To Remove Each Pixel Written by write_square
	mov cx,20			;Setting Column Value to 20
;start delay
	mov bp,60000
	delay2:
	dec bp		
	nop
	Jnz delay2
;end Delay
	cmp dx,20
	JGE remove_square
;end of remove_square
	
	call write_name ;Calling Procedure to Write Alphabets After Removing All Rows 
 
 
	INC bl 		;incrementing value of BL so to Loop Only 4 times		
	cmp bl,4	;Checking COndition By COmparing With Bl
	JLE rl		;jump if BL have LEss Or Equal value of 4
	
;Back To Console
	mov ah,4ch
	int 21h

main endp

write_name PROC
	
	;Clearing Screen To Yellosish Color by Using Function 6h
	mov ah,6	
	mov cx,0303h	;starting from upper right row and Column ch=row cl=column
	mov dx,1424h	;Ending to bottom left row and column
	mov bh,03h		;Indicating background Color
	mov al,0		;Indicating Color Of Pixel		
	int 10h

					;comparing and Executing suitable Alphabets 
	cmp bl,1		;according to Value Of BL Incremented In Main Procudure each Time
	JL w_s			
	JE w_h
	JG decision
		
decision:
	cmp bl,2
	JE w_a
	JG w_z
	
w_s:
call write_s
jmp exit
w_h:
call write_h
jmp exit
w_a:
call write_a
jmp exit
w_z:
	cmp bl,4
	JE w_all
	call write_z	
	jmp exit	

w_all:
	call write_s
	call write_h
	call write_a
	call write_z


	exit:
RET
write_name ENDP


write_z PROC
;Z Top Line
	mov ah,0CH
	mov cx,185
	mov dx,60
	z1:inc cx
	Int 10h
	cmp cx,233
	JLE z1

;Z Center Line
	mov cx,235
	mov dx,60
	z2:dec cx
	inc dx
	Int 10h
	cmp dx,108
	JLE z2

;Z Top Line
	mov cx,185
	mov dx,110
	z3:inc cx
	Int 10h
	cmp cx,233
	JLE z3

	
RET
write_z ENDP


write_a PROC
;A Left Line
	mov ah,0CH
	mov cx,130
	mov dx,60
	a1:inc dx
	int 10h
	cmp dx,111
	JLE a1
;A Right Line	
	mov cx,165
	mov dx,60
	a2:inc dx
	int 10h
	cmp dx,111
	JLE a2
;A Center Line
	mov cx,130
	mov dx,86
	a3:inc cx
	Int 10h
	cmp cx,164
	JLE a3
;A Top Line
	mov cx,129
	mov dx,60
	a4:inc cx
	Int 10h
	cmp cx,164
	JLE a4
	
	
RET
write_a ENDP



write_h PROC

;H Left Line
	mov ah,0CH
	mov cx,70
	mov dx,60
	h1:inc dx
	int 10h
	cmp dx,111
	JLE h1
;H Right Line	
	mov cx,105
	mov dx,60
	h2:inc dx
	int 10h
	cmp dx,111
	JLE h2
;H Center Line
	mov cx,70
	mov dx,86
	h3:inc cx
	Int 10h
	cmp cx,104
	JLE h3
RET
write_h ENDP




write_s PROC
	
;S Top Line
	mov ah,0CH
	mov cx,25
	mov dx,60
	s1:inc cx
	Int 10h
	cmp cx,50
	JLE s1
;S Left Line	
	mov cx,25
	mov dx,59
	s2:inc dx
	Int 10h
	cmp dx,85
	JLE s2
;S Center Line
	mov cx,25
	mov dx,86
	s3:inc cx
	Int 10h
	cmp cx,50
	JLE s3
;S Right Line
	mov cx,51
	mov dx,86
	s4:inc dx
	Int 10h
	cmp dx,110
	JLE s4
;S Bottom Line
	mov cx,25
	mov dx,111
	s5:inc cx
	Int 10h
	cmp cx,50
	JLE s5

	RET
write_s ENDP



remove_row PROC
	coulumn:
	inc cx
	int 10h
	cmp cx,300
	JLE coulumn
ret
remove_row endp



write_row PROC
	coulumn2:
	inc cx
	int 10h
	cmp cx,300
	JLE coulumn2	
RET
write_row ENDP


	end main
	