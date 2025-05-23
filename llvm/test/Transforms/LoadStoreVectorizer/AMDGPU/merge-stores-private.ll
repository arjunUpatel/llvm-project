; RUN: opt -mtriple=amdgcn-amd-amdhsa -mattr=+max-private-element-size-4,-unaligned-scratch-access -passes=load-store-vectorizer -S -o - %s | FileCheck -check-prefixes=ELT4,ELT4-ALIGNED,ALIGNED,ALL %s
; RUN: opt -mtriple=amdgcn-amd-amdhsa -mattr=+max-private-element-size-8,-unaligned-scratch-access -passes=load-store-vectorizer -S -o - %s | FileCheck -check-prefixes=ELT8,ALIGNED,ALL %s
; RUN: opt -mtriple=amdgcn-amd-amdhsa -mattr=+max-private-element-size-16,-unaligned-scratch-access -passes=load-store-vectorizer -S -o - %s | FileCheck -check-prefixes=ELT16,ALIGNED,ALL %s
; RUN: opt -mtriple=amdgcn-amd-amdhsa -mattr=+max-private-element-size-4,+unaligned-scratch-access -passes=load-store-vectorizer -S -o - %s | FileCheck -check-prefixes=ELT4,ELT4-UNALIGNED,UNALIGNED,ALL %s
; RUN: opt -mtriple=amdgcn-amd-amdhsa -mattr=+max-private-element-size-8,+unaligned-scratch-access -passes=load-store-vectorizer -S -o - %s | FileCheck -check-prefixes=ELT8,ELT8-UNALIGNED,UNALIGNED,ALL %s
; RUN: opt -mtriple=amdgcn-amd-amdhsa -mattr=+max-private-element-size-16,+unaligned-scratch-access -passes=load-store-vectorizer -S -o - %s | FileCheck -check-prefixes=ELT16,ELT16-UNALIGNED,UNALIGNED,ALL %s

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v4i32
; ELT4-ALIGNED: store i32
; ELT4-ALIGNED: store i32
; ELT4-ALIGNED: store i32
; ELT4-ALIGNED: store i32

; ELT8: store <2 x i32>
; ELT8: store <2 x i32>

; ELT16-UNALIGNED: store <4 x i32>
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v4i32(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i32, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i32, ptr addrspace(5) %out, i32 2
  %out.gep.3 = getelementptr i32, ptr addrspace(5) %out, i32 3

  store i32 9, ptr addrspace(5) %out
  store i32 1, ptr addrspace(5) %out.gep.1
  store i32 23, ptr addrspace(5) %out.gep.2
  store i32 19, ptr addrspace(5) %out.gep.3
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v4i32_align1(
; ALIGNED: store i32 9, ptr addrspace(5) %out, align 1
; ALIGNED: store i32 1, ptr addrspace(5) %out.gep.1, align 1
; ALIGNED: store i32 23, ptr addrspace(5) %out.gep.2, align 1
; ALIGNED: store i32 19, ptr addrspace(5) %out.gep.3, align 1

; ELT16-UNALIGNED: store <4 x i32> <i32 9, i32 1, i32 23, i32 19>, ptr addrspace(5) %out, align 1

; ELT8-UNALIGNED: store <2 x i32> <i32 9, i32 1>, ptr addrspace(5) %out, align 1
; ELT8-UNALIGNED: store <2 x i32> <i32 23, i32 19>, ptr addrspace(5) %out.gep.2, align 1

; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v4i32_align1(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i32, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i32, ptr addrspace(5) %out, i32 2
  %out.gep.3 = getelementptr i32, ptr addrspace(5) %out, i32 3

  store i32 9, ptr addrspace(5) %out, align 1
  store i32 1, ptr addrspace(5) %out.gep.1, align 1
  store i32 23, ptr addrspace(5) %out.gep.2, align 1
  store i32 19, ptr addrspace(5) %out.gep.3, align 1
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v4i32_align2(
; ALIGNED: store i32
; ALIGNED: store i32
; ALIGNED: store i32
; ALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT8-UNALIGNED: store <2 x i32>
; ELT8-UNALIGNED: store <2 x i32>
; ELT16-UNALIGNED: store <4 x i32>
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v4i32_align2(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i32, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i32, ptr addrspace(5) %out, i32 2
  %out.gep.3 = getelementptr i32, ptr addrspace(5) %out, i32 3

  store i32 9, ptr addrspace(5) %out, align 2
  store i32 1, ptr addrspace(5) %out.gep.1, align 2
  store i32 23, ptr addrspace(5) %out.gep.2, align 2
  store i32 19, ptr addrspace(5) %out.gep.3, align 2
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v4i8(
; ALL: store <4 x i8>
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v4i8(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i8, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i8, ptr addrspace(5) %out, i32 2
  %out.gep.3 = getelementptr i8, ptr addrspace(5) %out, i32 3

  store i8 9, ptr addrspace(5) %out, align 4
  store i8 1, ptr addrspace(5) %out.gep.1
  store i8 23, ptr addrspace(5) %out.gep.2
  store i8 19, ptr addrspace(5) %out.gep.3
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v4i8_align1(
; ALIGNED: store i8
; ALIGNED: store i8
; ALIGNED: store i8
; ALIGNED: store i8

; UNALIGNED: store <4 x i8> <i8 9, i8 1, i8 23, i8 19>, ptr addrspace(5) %out, align 1
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v4i8_align1(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i8, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i8, ptr addrspace(5) %out, i32 2
  %out.gep.3 = getelementptr i8, ptr addrspace(5) %out, i32 3

  store i8 9, ptr addrspace(5) %out, align 1
  store i8 1, ptr addrspace(5) %out.gep.1, align 1
  store i8 23, ptr addrspace(5) %out.gep.2, align 1
  store i8 19, ptr addrspace(5) %out.gep.3, align 1
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v2i16(
; ALL: store <2 x i16>
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v2i16(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i16, ptr addrspace(5) %out, i32 1

  store i16 9, ptr addrspace(5) %out, align 4
  store i16 12, ptr addrspace(5) %out.gep.1
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v2i16_align2(
; ALIGNED: store i16
; ALIGNED: store i16
; UNALIGNED: store <2 x i16>
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v2i16_align2(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i16, ptr addrspace(5) %out, i32 1

  store i16 9, ptr addrspace(5) %out, align 2
  store i16 12, ptr addrspace(5) %out.gep.1, align 2
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v2i16_align1(
; ALIGNED: store i16
; ALIGNED: store i16

; UNALIGNED: store <2 x i16> <i16 9, i16 12>, ptr addrspace(5) %out, align 1
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v2i16_align1(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i16, ptr addrspace(5) %out, i32 1

  store i16 9, ptr addrspace(5) %out, align 1
  store i16 12, ptr addrspace(5) %out.gep.1, align 1
  ret void
}

; ALL-LABEL: @merge_private_store_4_vector_elts_loads_v2i16_align8(
; ALL: store <2 x i16> <i16 9, i16 12>, ptr addrspace(5) %out, align 8
define amdgpu_kernel void @merge_private_store_4_vector_elts_loads_v2i16_align8(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i16, ptr addrspace(5) %out, i32 1

  store i16 9, ptr addrspace(5) %out, align 8
  store i16 12, ptr addrspace(5) %out.gep.1, align 2
  ret void
}

; ALL-LABEL: @merge_private_store_3_vector_elts_loads_v4i32
; ELT4: store i32
; ELT4: store i32
; ELT4: store i32

; ELT8: store <2 x i32>
; ELT8: store i32

; ELT16: store <3 x i32>
define amdgpu_kernel void @merge_private_store_3_vector_elts_loads_v4i32(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i32, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i32, ptr addrspace(5) %out, i32 2

  store i32 9, ptr addrspace(5) %out
  store i32 1, ptr addrspace(5) %out.gep.1
  store i32 23, ptr addrspace(5) %out.gep.2
  ret void
}

; ALL-LABEL: @merge_private_store_3_vector_elts_loads_v4i32_align1(
; ALIGNED: store i32
; ALIGNED: store i32
; ALIGNED: store i32

; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32
; ELT4-UNALIGNED: store i32

; ELT8-UNALIGNED: store <2 x i32>
; ELT8-UNALIGNED: store i32

; ELT16-UNALIGNED: store <3 x i32>
define amdgpu_kernel void @merge_private_store_3_vector_elts_loads_v4i32_align1(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i32, ptr addrspace(5) %out, i32 1
  %out.gep.2 = getelementptr i32, ptr addrspace(5) %out, i32 2

  store i32 9, ptr addrspace(5) %out, align 1
  store i32 1, ptr addrspace(5) %out.gep.1, align 1
  store i32 23, ptr addrspace(5) %out.gep.2, align 1
  ret void
}

; ALL-LABEL: @merge_private_store_3_vector_elts_loads_v4i8_align1(
; ALIGNED: store i8
; ALIGNED: store i8
; ALIGNED: store i8

; UNALIGNED: store <3 x i8>
define amdgpu_kernel void @merge_private_store_3_vector_elts_loads_v4i8_align1(ptr addrspace(5) %out) #0 {
  %out.gep.1 = getelementptr i8, ptr addrspace(5) %out, i8 1
  %out.gep.2 = getelementptr i8, ptr addrspace(5) %out, i8 2

  store i8 9, ptr addrspace(5) %out, align 1
  store i8 1, ptr addrspace(5) %out.gep.1, align 1
  store i8 23, ptr addrspace(5) %out.gep.2, align 1
  ret void
}

attributes #0 = { nounwind }
