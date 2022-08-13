#start=stepper_motor.exe#
name "stepper"
#make_bin#
steps_before_direction_change = 10h ; 32 (decimal)
jmp start
; ========= data ===============
; bin data for clock-wise
; half-step rotation:
datcw db 0000_0110b
db 0000_0100b
db 0000_0011b
db 0000_0010b
; bin data for counter-clock-wise
; half-step rotation:
datccw db 0000_0011b
db 0000_0001b
db 0000_0110b
db 0000_0010b
start:
mov bx, offset datcw ; start from clock-wise
mov si, 0
mov cx, 0 ; step counter
next_step:
; motor sets top bit when it's ready to accept new command
wait: in al, 7
test al, 10000000b
jz wait
mov al, [bx][si]
out 7, al
inc si
cmp si, 4
jb next_step
mov si, 0
inc cx
cmp cx, steps_before_direction_change
jb next_step
;Anti-Clockwise
mov bx, offset datccw ;Anti-clock-wise
mov cx, 0 ; step counter
next_step1:
; motor sets top bit when it's ready to accept new command
wait1: in al, 7
test al, 10000000b
jz wait1
mov al, [bx][si]
out 7, al
inc si
cmp si, 4
jb next_step1
mov si, 0
inc cx
cmp cx, steps_before_direction_change
jb next_step1
hlt