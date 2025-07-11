; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=x86_64 -mattr=+avx512fp16 | FileCheck %s

define <2 x half> @vector_sint64ToHalf(<2 x i64> %int64) {
; CHECK-LABEL: vector_sint64ToHalf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; CHECK-NEXT:    vcvtqq2ph %zmm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %fp16 = sitofp <2 x i64> %int64 to <2 x half>
  ret <2 x half> %fp16
}

define <4 x half> @vector_sint32ToHalf(<4 x i32> %int32) {
; CHECK-LABEL: vector_sint32ToHalf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vextractps $3, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm1, %xmm1
; CHECK-NEXT:    vextractps $2, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm2, %xmm2
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; CHECK-NEXT:    vextractps $1, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm3, %xmm2
; CHECK-NEXT:    vmovd %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm3, %xmm0
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1],xmm0[2],xmm2[2],xmm0[3],xmm2[3]
; CHECK-NEXT:    vinsertps {{.*#+}} xmm0 = xmm0[0],xmm1[0],zero,zero
; CHECK-NEXT:    retq
  %fp16 = sitofp <4 x i32> %int32 to <4 x half>
  ret <4 x half> %fp16
}

define <8 x half> @vector_sint16ToHalf(<8 x i16> %int16) {
; CHECK-LABEL: vector_sint16ToHalf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpextrw $7, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm1, %xmm1
; CHECK-NEXT:    vpextrw $6, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm2, %xmm2
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; CHECK-NEXT:    vpextrw $5, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm3, %xmm2
; CHECK-NEXT:    vpextrw $4, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm3, %xmm3
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
; CHECK-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; CHECK-NEXT:    vpextrw $3, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm2
; CHECK-NEXT:    vpextrw $2, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm3
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
; CHECK-NEXT:    vpextrw $1, %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm3
; CHECK-NEXT:    vmovw %xmm0, %eax
; CHECK-NEXT:    cwtl
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm0
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
; CHECK-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; CHECK-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; CHECK-NEXT:    retq
  %fp16 = sitofp <8 x i16> %int16 to <8 x half>
  ret <8 x half> %fp16
}

define <2 x half> @vector_uint64ToHalf(<2 x i64> %int64) {
; CHECK-LABEL: vector_uint64ToHalf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; CHECK-NEXT:    vcvtuqq2ph %zmm0, %xmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %fp16 = uitofp <2 x i64> %int64 to <2 x half>
  ret <2 x half> %fp16
}

define <4 x half> @vector_uint32ToHalf(<4 x i32> %int32) {
; CHECK-LABEL: vector_uint32ToHalf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; CHECK-NEXT:    vcvtudq2ph %zmm0, %ymm0
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $ymm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %fp16 = uitofp <4 x i32> %int32 to <4 x half>
  ret <4 x half> %fp16
}

define <8 x half> @vector_uint16ToHalf(<8 x i16> %int16) {
; CHECK-LABEL: vector_uint16ToHalf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpextrw $7, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm1, %xmm1
; CHECK-NEXT:    vpextrw $6, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm2, %xmm2
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1],xmm2[2],xmm1[2],xmm2[3],xmm1[3]
; CHECK-NEXT:    vpextrw $5, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm3, %xmm2
; CHECK-NEXT:    vpextrw $4, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm3, %xmm3
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
; CHECK-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; CHECK-NEXT:    vpextrw $3, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm2
; CHECK-NEXT:    vpextrw $2, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm3
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm2 = xmm3[0],xmm2[0],xmm3[1],xmm2[1],xmm3[2],xmm2[2],xmm3[3],xmm2[3]
; CHECK-NEXT:    vpextrw $1, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm3
; CHECK-NEXT:    vpextrw $0, %xmm0, %eax
; CHECK-NEXT:    vcvtsi2sh %eax, %xmm4, %xmm0
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1],xmm0[2],xmm3[2],xmm0[3],xmm3[3]
; CHECK-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
; CHECK-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; CHECK-NEXT:    retq
  %fp16 = uitofp <8 x i16> %int16 to <8 x half>
  ret <8 x half> %fp16
}

define <8 x half> @select(<8 x half> %x) {
; CHECK-LABEL: select:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 def $zmm0
; CHECK-NEXT:    vmovsh {{.*#+}} xmm1 = [1.0E+0,0.0E+0,0.0E+0,0.0E+0,0.0E+0,0.0E+0,0.0E+0,0.0E+0]
; CHECK-NEXT:    vucomish %xmm1, %xmm0
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    andl $1, %eax
; CHECK-NEXT:    kmovw %eax, %k0
; CHECK-NEXT:    vpsrld $16, %xmm0, %xmm2
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $14, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-5, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vmovshdup {{.*#+}} xmm2 = xmm0[1,1,3,3]
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $13, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-9, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpsrlq $48, %xmm0, %xmm2
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $12, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-17, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vshufpd {{.*#+}} xmm2 = xmm0[1,0]
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $11, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-33, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm2 = xmm0[10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $10, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-65, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vshufps {{.*#+}} xmm2 = xmm0[3,3,3,3]
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $6, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    kshiftlw $9, %k0, %k0
; CHECK-NEXT:    kshiftrw $9, %k0, %k0
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm2 = xmm0[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vucomish %xmm1, %xmm2
; CHECK-NEXT:    seta %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $7, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k1
; CHECK-NEXT:    vpbroadcastw {{.*#+}} xmm1 = [1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0,1.0E+0]
; CHECK-NEXT:    vmovdqu16 %zmm1, %zmm0 {%k1}
; CHECK-NEXT:    # kill: def $xmm0 killed $xmm0 killed $zmm0
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %c = fcmp ogt <8 x half> %x, splat (half 0xH3C00)
  %s = select <8 x i1> %c, <8 x half> splat (half 0xH3C00), <8 x half> %x
  ret <8 x half> %s
}

define <4 x half> @select2(<4 x i32> %0, <4 x half> %1) {
; CHECK-LABEL: select2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    vpcmpeqd %xmm2, %xmm0, %xmm0
; CHECK-NEXT:    vpackssdw %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    vmovq {{.*#+}} xmm2 = [9.6E+1,9.7E+1,9.8E+1,9.9E+1,0.0E+0,0.0E+0,0.0E+0,0.0E+0]
; CHECK-NEXT:    vpblendvb %xmm0, %xmm1, %xmm2, %xmm0
; CHECK-NEXT:    retq
entry:
  %2 = icmp eq <4 x i32> %0, zeroinitializer
  %3 = select <4 x i1> %2, <4 x half> %1, <4 x half> <half 0xH5600, half 0xH5610, half 0xH5620, half 0xH5630>
  ret <4 x half> %3
}
