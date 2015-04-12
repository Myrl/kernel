; Decimal64 support

;; DPDtoBCD_0
;;  Converts DPD to BCD
;; Inputs:
;;  IX: 10-bit DPD
;;  IY: Destination
;; Outputs:
;;  Nothing

DPDtoBCD:
	push bc
	.s3:
		ld a, (IX)
		bit 3, a ; Checks if S3 or not
		jp 0, .s2l1

	.s3cp:
		push af
		and 0x7f ; The first 7 bits of an S3 DPD is equal to BCD.
		ld (IY), a	
		pop af

		ld b, (IX + 1)
		sla b

		and 0x80
		sla a
		jp 2, .s3n ; If the last bit is not set
		or 1
	.s3n:
		or b
	.s3end:
		and a, 0xf
		ld (IY + 1), a
		pop bc
		ret

	.s2l1:
		bit 2, a
		jp 0, .lss
		bit 1, a
		jp 0, .sls

	.ssl:
		jmp .s3cp ;Conditions are the same with s3.
	
	.sls:
		and 1
		ld b, a
		ld a, (IX)
		and a, 0x60
		srl a \ srl a \ srl a \ srl a
		or b
		
		
