Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084448.363663882@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/32] [PATCH] use inline assembly contraints available with gcc 3.3.3
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=106-q-constraint.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Drop support to compile the kernel with gcc versions older than 3.3.3.
This allows us to use the "Q" inline assembly contraint on some more
inline assemblies without duplicating a lot of complex code (e.g. __xchg
and __cmpxchg). The distinction for older gcc versions can be removed
which saves a few lines and simplifies the code.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/atomic.h    |   86 ++-----------------
 arch/s390/include/asm/bitops.h    |   83 ++++--------------
 arch/s390/include/asm/etr.h       |   12 +-
 arch/s390/include/asm/irqflags.h  |   36 --------
 arch/s390/include/asm/processor.h |   18 ++--
 arch/s390/include/asm/rwsem.h     |  147 ++++++++++++++++-----------------
 arch/s390/include/asm/spinlock.h  |   18 ----
 arch/s390/include/asm/swab.h      |   16 +--
 arch/s390/include/asm/system.h    |  168 +++++++++++++++++++-------------------
 arch/s390/include/asm/timex.h     |   22 +---
 arch/s390/kernel/asm-offsets.c    |    8 +
 11 files changed, 226 insertions(+), 388 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/atomic.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/atomic.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/atomic.h	2010-02-24 09:44:24.000000000 +0100
@@ -18,8 +18,6 @@
 
 #define ATOMIC_INIT(i)  { (i) }
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 #define __CS_LOOP(ptr, op_val, op_string) ({				\
 	int old_val, new_val;						\
 	asm volatile(							\
@@ -35,26 +33,6 @@
 	new_val;							\
 })
 
-#else /* __GNUC__ */
-
-#define __CS_LOOP(ptr, op_val, op_string) ({				\
-	int old_val, new_val;						\
-	asm volatile(							\
-		"	l	%0,0(%3)\n"				\
-		"0:	lr	%1,%0\n"				\
-		op_string "	%1,%4\n"				\
-		"	cs	%0,%1,0(%3)\n"				\
-		"	jl	0b"					\
-		: "=&d" (old_val), "=&d" (new_val),			\
-		  "=m" (((atomic_t *)(ptr))->counter)			\
-		: "a" (ptr), "d" (op_val),				\
-		  "m" (((atomic_t *)(ptr))->counter)			\
-		: "cc", "memory");					\
-	new_val;							\
-})
-
-#endif /* __GNUC__ */
-
 static inline int atomic_read(const atomic_t *v)
 {
 	barrier();
@@ -101,19 +79,11 @@
 
 static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 	asm volatile(
 		"	cs	%0,%2,%1"
 		: "+d" (old), "=Q" (v->counter)
 		: "d" (new), "Q" (v->counter)
 		: "cc", "memory");
-#else /* __GNUC__ */
-	asm volatile(
-		"	cs	%0,%3,0(%2)"
-		: "+d" (old), "=m" (v->counter)
-		: "a" (v), "d" (new), "m" (v->counter)
-		: "cc", "memory");
-#endif /* __GNUC__ */
 	return old;
 }
 
@@ -140,8 +110,6 @@
 
 #ifdef CONFIG_64BIT
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 #define __CSG_LOOP(ptr, op_val, op_string) ({				\
 	long long old_val, new_val;					\
 	asm volatile(							\
@@ -157,26 +125,6 @@
 	new_val;							\
 })
 
-#else /* __GNUC__ */
-
-#define __CSG_LOOP(ptr, op_val, op_string) ({				\
-	long long old_val, new_val;					\
-	asm volatile(							\
-		"	lg	%0,0(%3)\n"				\
-		"0:	lgr	%1,%0\n"				\
-		op_string "	%1,%4\n"				\
-		"	csg	%0,%1,0(%3)\n"				\
-		"	jl	0b"					\
-		: "=&d" (old_val), "=&d" (new_val),			\
-		  "=m" (((atomic_t *)(ptr))->counter)			\
-		: "a" (ptr), "d" (op_val),				\
-		  "m" (((atomic_t *)(ptr))->counter)			\
-		: "cc", "memory");					\
-	new_val;							\
-})
-
-#endif /* __GNUC__ */
-
 static inline long long atomic64_read(const atomic64_t *v)
 {
 	barrier();
@@ -214,19 +162,11 @@
 static inline long long atomic64_cmpxchg(atomic64_t *v,
 					     long long old, long long new)
 {
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 	asm volatile(
 		"	csg	%0,%2,%1"
 		: "+d" (old), "=Q" (v->counter)
 		: "d" (new), "Q" (v->counter)
 		: "cc", "memory");
-#else /* __GNUC__ */
-	asm volatile(
-		"	csg	%0,%3,0(%2)"
-		: "+d" (old), "=m" (v->counter)
-		: "a" (v), "d" (new), "m" (v->counter)
-		: "cc", "memory");
-#endif /* __GNUC__ */
 	return old;
 }
 
@@ -243,10 +183,8 @@
 	register_pair rp;
 
 	asm volatile(
-		"	lm	%0,%N0,0(%1)"
-		: "=&d" (rp)
-		: "a" (&v->counter), "m" (v->counter)
-		);
+		"	lm	%0,%N0,%1"
+		: "=&d" (rp) : "Q" (v->counter)	);
 	return rp.pair;
 }
 
@@ -255,10 +193,8 @@
 	register_pair rp = {.pair = i};
 
 	asm volatile(
-		"	stm	%1,%N1,0(%2)"
-		: "=m" (v->counter)
-		: "d" (rp), "a" (&v->counter)
-		);
+		"	stm	%1,%N1,%0"
+		: "=Q" (v->counter) : "d" (rp) );
 }
 
 static inline long long atomic64_xchg(atomic64_t *v, long long new)
@@ -267,11 +203,11 @@
 	register_pair rp_old;
 
 	asm volatile(
-		"	lm	%0,%N0,0(%2)\n"
-		"0:	cds	%0,%3,0(%2)\n"
+		"	lm	%0,%N0,%1\n"
+		"0:	cds	%0,%2,%1\n"
 		"	jl	0b\n"
-		: "=&d" (rp_old), "+m" (v->counter)
-		: "a" (&v->counter), "d" (rp_new)
+		: "=&d" (rp_old), "=Q" (v->counter)
+		: "d" (rp_new), "Q" (v->counter)
 		: "cc");
 	return rp_old.pair;
 }
@@ -283,9 +219,9 @@
 	register_pair rp_new = {.pair = new};
 
 	asm volatile(
-		"	cds	%0,%3,0(%2)"
-		: "+&d" (rp_old), "+m" (v->counter)
-		: "a" (&v->counter), "d" (rp_new)
+		"	cds	%0,%2,%1"
+		: "+&d" (rp_old), "=Q" (v->counter)
+		: "d" (rp_new), "Q" (v->counter)
 		: "cc");
 	return rp_old.pair;
 }
Index: quilt-2.6/arch/s390/include/asm/bitops.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/bitops.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/bitops.h	2010-02-24 09:44:24.000000000 +0100
@@ -71,8 +71,6 @@
 #define __BITOPS_AND		"nr"
 #define __BITOPS_XOR		"xr"
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 #define __BITOPS_LOOP(__old, __new, __addr, __val, __op_string)	\
 	asm volatile(						\
 		"	l	%0,%2\n"			\
@@ -85,22 +83,6 @@
 		: "d" (__val), "Q" (*(unsigned long *) __addr)	\
 		: "cc");
 
-#else /* __GNUC__ */
-
-#define __BITOPS_LOOP(__old, __new, __addr, __val, __op_string)	\
-	asm volatile(						\
-		"	l	%0,0(%4)\n"			\
-		"0:	lr	%1,%0\n"			\
-		__op_string "	%1,%3\n"			\
-		"	cs	%0,%1,0(%4)\n"			\
-		"	jl	0b"				\
-		: "=&d" (__old), "=&d" (__new),			\
-		  "=m" (*(unsigned long *) __addr)		\
-		: "d" (__val), "a" (__addr),			\
-		  "m" (*(unsigned long *) __addr) : "cc");
-
-#endif /* __GNUC__ */
-
 #else /* __s390x__ */
 
 #define __BITOPS_ALIGN		7
@@ -109,8 +91,6 @@
 #define __BITOPS_AND		"ngr"
 #define __BITOPS_XOR		"xgr"
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 #define __BITOPS_LOOP(__old, __new, __addr, __val, __op_string)	\
 	asm volatile(						\
 		"	lg	%0,%2\n"			\
@@ -123,23 +103,6 @@
 		: "d" (__val), "Q" (*(unsigned long *) __addr)	\
 		: "cc");
 
-#else /* __GNUC__ */
-
-#define __BITOPS_LOOP(__old, __new, __addr, __val, __op_string)	\
-	asm volatile(						\
-		"	lg	%0,0(%4)\n"			\
-		"0:	lgr	%1,%0\n"			\
-		__op_string "	%1,%3\n"			\
-		"	csg	%0,%1,0(%4)\n"			\
-		"	jl	0b"				\
-		: "=&d" (__old), "=&d" (__new),			\
-		  "=m" (*(unsigned long *) __addr)		\
-		: "d" (__val), "a" (__addr),			\
-		  "m" (*(unsigned long *) __addr) : "cc");
-
-
-#endif /* __GNUC__ */
-
 #endif /* __s390x__ */
 
 #define __BITOPS_WORDS(bits) (((bits)+__BITOPS_WORDSIZE-1)/__BITOPS_WORDSIZE)
@@ -261,9 +224,8 @@
 
 	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	asm volatile(
-		"	oc	0(1,%1),0(%2)"
-		: "=m" (*(char *) addr) : "a" (addr),
-		  "a" (_oi_bitmap + (nr & 7)), "m" (*(char *) addr) : "cc" );
+		"	oc	%O0(1,%R0),%1"
+		: "=Q" (*(char *) addr) : "Q" (_oi_bitmap[nr & 7]) : "cc" );
 }
 
 static inline void 
@@ -290,9 +252,8 @@
 
 	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	asm volatile(
-		"	nc	0(1,%1),0(%2)"
-		: "=m" (*(char *) addr)	: "a" (addr),
-		  "a" (_ni_bitmap + (nr & 7)), "m" (*(char *) addr) : "cc");
+		"	nc	%O0(1,%R0),%1"
+		: "=Q" (*(char *) addr) : "Q" (_ni_bitmap[nr & 7]) : "cc" );
 }
 
 static inline void 
@@ -318,9 +279,8 @@
 
 	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	asm volatile(
-		"	xc	0(1,%1),0(%2)"
-		:  "=m" (*(char *) addr) : "a" (addr),
-		   "a" (_oi_bitmap + (nr & 7)), "m" (*(char *) addr) : "cc" );
+		"	xc	%O0(1,%R0),%1"
+		: "=Q" (*(char *) addr) : "Q" (_oi_bitmap[nr & 7]) : "cc" );
 }
 
 static inline void 
@@ -349,10 +309,9 @@
 	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
 	asm volatile(
-		"	oc	0(1,%1),0(%2)"
-		: "=m" (*(char *) addr)
-		: "a" (addr), "a" (_oi_bitmap + (nr & 7)),
-		  "m" (*(char *) addr) : "cc", "memory");
+		"	oc	%O0(1,%R0),%1"
+		: "=Q" (*(char *) addr)	: "Q" (_oi_bitmap[nr & 7])
+		: "cc", "memory");
 	return (ch >> (nr & 7)) & 1;
 }
 #define __test_and_set_bit(X,Y)		test_and_set_bit_simple(X,Y)
@@ -369,10 +328,9 @@
 	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
 	asm volatile(
-		"	nc	0(1,%1),0(%2)"
-		: "=m" (*(char *) addr)
-		: "a" (addr), "a" (_ni_bitmap + (nr & 7)),
-		  "m" (*(char *) addr) : "cc", "memory");
+		"	nc	%O0(1,%R0),%1"
+		: "=Q" (*(char *) addr)	: "Q" (_ni_bitmap[nr & 7])
+		: "cc", "memory");
 	return (ch >> (nr & 7)) & 1;
 }
 #define __test_and_clear_bit(X,Y)	test_and_clear_bit_simple(X,Y)
@@ -389,10 +347,9 @@
 	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
 	asm volatile(
-		"	xc	0(1,%1),0(%2)"
-		: "=m" (*(char *) addr)
-		: "a" (addr), "a" (_oi_bitmap + (nr & 7)),
-		  "m" (*(char *) addr) : "cc", "memory");
+		"	xc	%O0(1,%R0),%1"
+		: "=Q" (*(char *) addr)	: "Q" (_oi_bitmap[nr & 7])
+		: "cc", "memory");
 	return (ch >> (nr & 7)) & 1;
 }
 #define __test_and_change_bit(X,Y)	test_and_change_bit_simple(X,Y)
@@ -591,11 +548,11 @@
 	p = (unsigned long *)((unsigned long) p + offset);
 #ifndef __s390x__
 	asm volatile(
-		"	ic	%0,0(%1)\n"
-		"	icm	%0,2,1(%1)\n"
-		"	icm	%0,4,2(%1)\n"
-		"	icm	%0,8,3(%1)"
-		: "=&d" (word) : "a" (p), "m" (*p) : "cc");
+		"	ic	%0,%O1(%R1)\n"
+		"	icm	%0,2,%O1+1(%R1)\n"
+		"	icm	%0,4,%O1+2(%R1)\n"
+		"	icm	%0,8,%O1+3(%R1)"
+		: "=&d" (word) : "Q" (*p) : "cc");
 #else
 	asm volatile(
 		"	lrvg	%0,%1"
Index: quilt-2.6/arch/s390/include/asm/etr.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/etr.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/etr.h	2010-02-24 09:44:24.000000000 +0100
@@ -145,11 +145,11 @@
 	int rc = -ENOSYS;
 
 	asm volatile(
-		"	.insn	s,0xb2160000,0(%2)\n"
+		"	.insn	s,0xb2160000,%1\n"
 		"0:	la	%0,0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (rc) : "m" (*ctrl), "a" (ctrl));
+		: "+d" (rc) : "Q" (*ctrl));
 	return rc;
 }
 
@@ -159,11 +159,11 @@
 	int rc = -ENOSYS;
 
 	asm volatile(
-		"	.insn	s,0xb2170000,0(%2)\n"
+		"	.insn	s,0xb2170000,%1\n"
 		"0:	la	%0,0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (rc) : "m" (*aib), "a" (aib));
+		: "+d" (rc) : "Q" (*aib));
 	return rc;
 }
 
@@ -174,11 +174,11 @@
 	int rc = -ENOSYS;
 
 	asm volatile(
-		"	.insn	s,0xb2b30000,0(%2)\n"
+		"	.insn	s,0xb2b30000,%1\n"
 		"0:	la	%0,0\n"
 		"1:\n"
 		EX_TABLE(0b,1b)
-		: "+d" (rc) : "m" (*aib), "a" (aib), "d" (reg0));
+		: "+d" (rc) : "Q" (*aib), "d" (reg0));
 	return rc;
 }
 
Index: quilt-2.6/arch/s390/include/asm/irqflags.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/irqflags.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/irqflags.h	2010-02-24 09:44:24.000000000 +0100
@@ -8,8 +8,6 @@
 
 #include <linux/types.h>
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 /* store then or system mask. */
 #define __raw_local_irq_stosm(__or)					\
 ({									\
@@ -36,40 +34,6 @@
 	asm volatile("ssm   %0" : : "Q" (__mask) : "memory");		\
 })
 
-#else /* __GNUC__ */
-
-/* store then or system mask. */
-#define __raw_local_irq_stosm(__or)					\
-({									\
-	unsigned long __mask;						\
-	asm volatile(							\
-		"	stosm	0(%1),%2"				\
-		: "=m" (__mask)						\
-		: "a" (&__mask), "i" (__or) : "memory");		\
-	__mask;								\
-})
-
-/* store then and system mask. */
-#define __raw_local_irq_stnsm(__and)					\
-({									\
-	unsigned long __mask;						\
-	asm volatile(							\
-		"	stnsm	0(%1),%2"				\
-		: "=m" (__mask)						\
-		: "a" (&__mask), "i" (__and) : "memory");		\
-	__mask;								\
-})
-
-/* set system mask. */
-#define __raw_local_irq_ssm(__mask)					\
-({									\
-	asm volatile(							\
-		"	ssm	0(%0)"					\
-		: : "a" (&__mask), "m" (__mask) : "memory");		\
-})
-
-#endif /* __GNUC__ */
-
 /* interrupt control.. */
 static inline unsigned long raw_local_irq_enable(void)
 {
Index: quilt-2.6/arch/s390/include/asm/processor.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/processor.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/processor.h	2010-02-24 09:44:24.000000000 +0100
@@ -28,7 +28,7 @@
 
 static inline void get_cpu_id(struct cpuid *ptr)
 {
-	asm volatile("stidp 0(%1)" : "=m" (*ptr) : "a" (ptr));
+	asm volatile("stidp %0" : "=Q" (*ptr));
 }
 
 extern void s390_adjust_jiffies(void);
@@ -184,9 +184,9 @@
 static inline void __load_psw(psw_t psw)
 {
 #ifndef __s390x__
-	asm volatile("lpsw  0(%0)" : : "a" (&psw), "m" (psw) : "cc");
+	asm volatile("lpsw  %0" : : "Q" (psw) : "cc");
 #else
-	asm volatile("lpswe 0(%0)" : : "a" (&psw), "m" (psw) : "cc");
+	asm volatile("lpswe %0" : : "Q" (psw) : "cc");
 #endif
 }
 
@@ -206,17 +206,17 @@
 	asm volatile(
 		"	basr	%0,0\n"
 		"0:	ahi	%0,1f-0b\n"
-		"	st	%0,4(%1)\n"
-		"	lpsw	0(%1)\n"
+		"	st	%0,%O1+4(%R1)\n"
+		"	lpsw	%1\n"
 		"1:"
-		: "=&d" (addr) : "a" (&psw), "m" (psw) : "memory", "cc");
+		: "=&d" (addr), "=Q" (psw) : "Q" (psw) : "memory", "cc");
 #else /* __s390x__ */
 	asm volatile(
 		"	larl	%0,1f\n"
-		"	stg	%0,8(%1)\n"
-		"	lpswe	0(%1)\n"
+		"	stg	%0,%O1+8(%R1)\n"
+		"	lpswe	%1\n"
 		"1:"
-		: "=&d" (addr) : "a" (&psw), "m" (psw) : "memory", "cc");
+		: "=&d" (addr), "=Q" (psw) : "Q" (psw) : "memory", "cc");
 #endif /* __s390x__ */
 }
  
Index: quilt-2.6/arch/s390/include/asm/rwsem.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/rwsem.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/rwsem.h	2010-02-24 09:44:24.000000000 +0100
@@ -124,21 +124,21 @@
 
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	ahi	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	ahi	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	aghi	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	aghi	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "i" (RWSEM_ACTIVE_READ_BIAS) : "cc", "memory");
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "i" (RWSEM_ACTIVE_READ_BIAS)
+		: "cc", "memory");
 	if (old < 0)
 		rwsem_down_read_failed(sem);
 }
@@ -152,25 +152,25 @@
 
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	ltr	%1,%0\n"
 		"	jm	1f\n"
-		"	ahi	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	ahi	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b\n"
 		"1:"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	ltgr	%1,%0\n"
 		"	jm	1f\n"
-		"	aghi	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	aghi	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b\n"
 		"1:"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "i" (RWSEM_ACTIVE_READ_BIAS) : "cc", "memory");
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "i" (RWSEM_ACTIVE_READ_BIAS)
+		: "cc", "memory");
 	return old >= 0 ? 1 : 0;
 }
 
@@ -184,20 +184,20 @@
 	tmp = RWSEM_ACTIVE_WRITE_BIAS;
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	a	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	a	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	ag	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	ag	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "m" (tmp)
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "m" (tmp)
 		: "cc", "memory");
 	if (old != 0)
 		rwsem_down_write_failed(sem);
@@ -217,22 +217,22 @@
 
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%2)\n"
+		"	l	%0,%1\n"
 		"0:	ltr	%0,%0\n"
 		"	jnz	1f\n"
-		"	cs	%0,%4,0(%2)\n"
+		"	cs	%0,%3,%1\n"
 		"	jl	0b\n"
 #else /* __s390x__ */
-		"	lg	%0,0(%2)\n"
+		"	lg	%0,%1\n"
 		"0:	ltgr	%0,%0\n"
 		"	jnz	1f\n"
-		"	csg	%0,%4,0(%2)\n"
+		"	csg	%0,%3,%1\n"
 		"	jl	0b\n"
 #endif /* __s390x__ */
 		"1:"
-		: "=&d" (old), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "d" (RWSEM_ACTIVE_WRITE_BIAS) : "cc", "memory");
+		: "=&d" (old), "=Q" (sem->count)
+		: "Q" (sem->count), "d" (RWSEM_ACTIVE_WRITE_BIAS)
+		: "cc", "memory");
 	return (old == RWSEM_UNLOCKED_VALUE) ? 1 : 0;
 }
 
@@ -245,21 +245,20 @@
 
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	ahi	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	ahi	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	aghi	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	aghi	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count),
-		  "i" (-RWSEM_ACTIVE_READ_BIAS)
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "i" (-RWSEM_ACTIVE_READ_BIAS)
 		: "cc", "memory");
 	if (new < 0)
 		if ((new & RWSEM_ACTIVE_MASK) == 0)
@@ -276,20 +275,20 @@
 	tmp = -RWSEM_ACTIVE_WRITE_BIAS;
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	a	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	a	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	ag	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	ag	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "m" (tmp)
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "m" (tmp)
 		: "cc", "memory");
 	if (new < 0)
 		if ((new & RWSEM_ACTIVE_MASK) == 0)
@@ -306,20 +305,20 @@
 	tmp = -RWSEM_WAITING_BIAS;
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	a	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	a	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	ag	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	ag	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "m" (tmp)
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "m" (tmp)
 		: "cc", "memory");
 	if (new > 1)
 		rwsem_downgrade_wake(sem);
@@ -334,20 +333,20 @@
 
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	ar	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	ar	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	agr	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	agr	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "d" (delta)
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "d" (delta)
 		: "cc", "memory");
 }
 
@@ -360,20 +359,20 @@
 
 	asm volatile(
 #ifndef __s390x__
-		"	l	%0,0(%3)\n"
+		"	l	%0,%2\n"
 		"0:	lr	%1,%0\n"
-		"	ar	%1,%5\n"
-		"	cs	%0,%1,0(%3)\n"
+		"	ar	%1,%4\n"
+		"	cs	%0,%1,%2\n"
 		"	jl	0b"
 #else /* __s390x__ */
-		"	lg	%0,0(%3)\n"
+		"	lg	%0,%2\n"
 		"0:	lgr	%1,%0\n"
-		"	agr	%1,%5\n"
-		"	csg	%0,%1,0(%3)\n"
+		"	agr	%1,%4\n"
+		"	csg	%0,%1,%2\n"
 		"	jl	0b"
 #endif /* __s390x__ */
-		: "=&d" (old), "=&d" (new), "=m" (sem->count)
-		: "a" (&sem->count), "m" (sem->count), "d" (delta)
+		: "=&d" (old), "=&d" (new), "=Q" (sem->count)
+		: "Q" (sem->count), "d" (delta)
 		: "cc", "memory");
 	return new;
 }
Index: quilt-2.6/arch/s390/include/asm/spinlock.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/spinlock.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/spinlock.h	2010-02-24 09:44:24.000000000 +0100
@@ -13,8 +13,6 @@
 
 #include <linux/smp.h>
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
-
 static inline int
 _raw_compare_and_swap(volatile unsigned int *lock,
 		      unsigned int old, unsigned int new)
@@ -27,22 +25,6 @@
 	return old;
 }
 
-#else /* __GNUC__ */
-
-static inline int
-_raw_compare_and_swap(volatile unsigned int *lock,
-		      unsigned int old, unsigned int new)
-{
-	asm volatile(
-		"	cs	%0,%3,0(%4)"
-		: "=d" (old), "=m" (*lock)
-		: "0" (old), "d" (new), "a" (lock), "m" (*lock)
-		: "cc", "memory" );
-	return old;
-}
-
-#endif /* __GNUC__ */
-
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
Index: quilt-2.6/arch/s390/include/asm/swab.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/swab.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/swab.h	2010-02-24 09:44:24.000000000 +0100
@@ -47,11 +47,11 @@
 	
 	asm volatile(
 #ifndef __s390x__
-		"	icm	%0,8,3(%1)\n"
-		"	icm	%0,4,2(%1)\n"
-		"	icm	%0,2,1(%1)\n"
-		"	ic	%0,0(%1)"
-		: "=&d" (result) : "a" (x), "m" (*x) : "cc");
+		"	icm	%0,8,%O1+3(%R1)\n"
+		"	icm	%0,4,%O1+2(%R1)\n"
+		"	icm	%0,2,%O1+1(%R1)\n"
+		"	ic	%0,%1"
+		: "=&d" (result) : "Q" (*x) : "cc");
 #else /* __s390x__ */
 		"	lrv	%0,%1"
 		: "=d" (result) : "m" (*x));
@@ -77,9 +77,9 @@
 	
 	asm volatile(
 #ifndef __s390x__
-		"	icm	%0,2,1(%1)\n"
-		"	ic	%0,0(%1)\n"
-		: "=&d" (result) : "a" (x), "m" (*x) : "cc");
+		"	icm	%0,2,%O+1(%R1)\n"
+		"	ic	%0,%1\n"
+		: "=&d" (result) : "Q" (*x) : "cc");
 #else /* __s390x__ */
 		"	lrvh	%0,%1"
 		: "=d" (result) : "m" (*x));
Index: quilt-2.6/arch/s390/include/asm/system.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/system.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/system.h	2010-02-24 09:44:24.000000000 +0100
@@ -24,65 +24,65 @@
 static inline void save_fp_regs(s390_fp_regs *fpregs)
 {
 	asm volatile(
-		"	std	0,8(%1)\n"
-		"	std	2,24(%1)\n"
-		"	std	4,40(%1)\n"
-		"	std	6,56(%1)"
-		: "=m" (*fpregs) : "a" (fpregs), "m" (*fpregs) : "memory");
+		"	std	0,%O0+8(%R0)\n"
+		"	std	2,%O0+24(%R0)\n"
+		"	std	4,%O0+40(%R0)\n"
+		"	std	6,%O0+56(%R0)"
+		: "=Q" (*fpregs) : "Q" (*fpregs));
 	if (!MACHINE_HAS_IEEE)
 		return;
 	asm volatile(
-		"	stfpc	0(%1)\n"
-		"	std	1,16(%1)\n"
-		"	std	3,32(%1)\n"
-		"	std	5,48(%1)\n"
-		"	std	7,64(%1)\n"
-		"	std	8,72(%1)\n"
-		"	std	9,80(%1)\n"
-		"	std	10,88(%1)\n"
-		"	std	11,96(%1)\n"
-		"	std	12,104(%1)\n"
-		"	std	13,112(%1)\n"
-		"	std	14,120(%1)\n"
-		"	std	15,128(%1)\n"
-		: "=m" (*fpregs) : "a" (fpregs), "m" (*fpregs) : "memory");
+		"	stfpc	%0\n"
+		"	std	1,%O0+16(%R0)\n"
+		"	std	3,%O0+32(%R0)\n"
+		"	std	5,%O0+48(%R0)\n"
+		"	std	7,%O0+64(%R0)\n"
+		"	std	8,%O0+72(%R0)\n"
+		"	std	9,%O0+80(%R0)\n"
+		"	std	10,%O0+88(%R0)\n"
+		"	std	11,%O0+96(%R0)\n"
+		"	std	12,%O0+104(%R0)\n"
+		"	std	13,%O0+112(%R0)\n"
+		"	std	14,%O0+120(%R0)\n"
+		"	std	15,%O0+128(%R0)\n"
+		: "=Q" (*fpregs) : "Q" (*fpregs));
 }
 
 static inline void restore_fp_regs(s390_fp_regs *fpregs)
 {
 	asm volatile(
-		"	ld	0,8(%0)\n"
-		"	ld	2,24(%0)\n"
-		"	ld	4,40(%0)\n"
-		"	ld	6,56(%0)"
-		: : "a" (fpregs), "m" (*fpregs));
+		"	ld	0,%O0+8(%R0)\n"
+		"	ld	2,%O0+24(%R0)\n"
+		"	ld	4,%O0+40(%R0)\n"
+		"	ld	6,%O0+56(%R0)"
+		: : "Q" (*fpregs));
 	if (!MACHINE_HAS_IEEE)
 		return;
 	asm volatile(
-		"	lfpc	0(%0)\n"
-		"	ld	1,16(%0)\n"
-		"	ld	3,32(%0)\n"
-		"	ld	5,48(%0)\n"
-		"	ld	7,64(%0)\n"
-		"	ld	8,72(%0)\n"
-		"	ld	9,80(%0)\n"
-		"	ld	10,88(%0)\n"
-		"	ld	11,96(%0)\n"
-		"	ld	12,104(%0)\n"
-		"	ld	13,112(%0)\n"
-		"	ld	14,120(%0)\n"
-		"	ld	15,128(%0)\n"
-		: : "a" (fpregs), "m" (*fpregs));
+		"	lfpc	%0\n"
+		"	ld	1,%O0+16(%R0)\n"
+		"	ld	3,%O0+32(%R0)\n"
+		"	ld	5,%O0+48(%R0)\n"
+		"	ld	7,%O0+64(%R0)\n"
+		"	ld	8,%O0+72(%R0)\n"
+		"	ld	9,%O0+80(%R0)\n"
+		"	ld	10,%O0+88(%R0)\n"
+		"	ld	11,%O0+96(%R0)\n"
+		"	ld	12,%O0+104(%R0)\n"
+		"	ld	13,%O0+112(%R0)\n"
+		"	ld	14,%O0+120(%R0)\n"
+		"	ld	15,%O0+128(%R0)\n"
+		: : "Q" (*fpregs));
 }
 
 static inline void save_access_regs(unsigned int *acrs)
 {
-	asm volatile("stam 0,15,0(%0)" : : "a" (acrs) : "memory");
+	asm volatile("stam 0,15,%0" : "=Q" (*acrs));
 }
 
 static inline void restore_access_regs(unsigned int *acrs)
 {
-	asm volatile("lam 0,15,0(%0)" : : "a" (acrs));
+	asm volatile("lam 0,15,%0" : : "Q" (*acrs));
 }
 
 #define switch_to(prev,next,last) do {					     \
@@ -139,48 +139,48 @@
 		shift = (3 ^ (addr & 3)) << 3;
 		addr ^= addr & 3;
 		asm volatile(
-			"	l	%0,0(%4)\n"
+			"	l	%0,%4\n"
 			"0:	lr	0,%0\n"
 			"	nr	0,%3\n"
 			"	or	0,%2\n"
-			"	cs	%0,0,0(%4)\n"
+			"	cs	%0,0,%4\n"
 			"	jl	0b\n"
-			: "=&d" (old), "=m" (*(int *) addr)
-			: "d" (x << shift), "d" (~(255 << shift)), "a" (addr),
-			  "m" (*(int *) addr) : "memory", "cc", "0");
+			: "=&d" (old), "=Q" (*(int *) addr)
+			: "d" (x << shift), "d" (~(255 << shift)),
+			  "Q" (*(int *) addr) : "memory", "cc", "0");
 		return old >> shift;
 	case 2:
 		addr = (unsigned long) ptr;
 		shift = (2 ^ (addr & 2)) << 3;
 		addr ^= addr & 2;
 		asm volatile(
-			"	l	%0,0(%4)\n"
+			"	l	%0,%4\n"
 			"0:	lr	0,%0\n"
 			"	nr	0,%3\n"
 			"	or	0,%2\n"
-			"	cs	%0,0,0(%4)\n"
+			"	cs	%0,0,%4\n"
 			"	jl	0b\n"
-			: "=&d" (old), "=m" (*(int *) addr)
-			: "d" (x << shift), "d" (~(65535 << shift)), "a" (addr),
-			  "m" (*(int *) addr) : "memory", "cc", "0");
+			: "=&d" (old), "=Q" (*(int *) addr)
+			: "d" (x << shift), "d" (~(65535 << shift)),
+			  "Q" (*(int *) addr) : "memory", "cc", "0");
 		return old >> shift;
 	case 4:
 		asm volatile(
-			"	l	%0,0(%3)\n"
-			"0:	cs	%0,%2,0(%3)\n"
+			"	l	%0,%3\n"
+			"0:	cs	%0,%2,%3\n"
 			"	jl	0b\n"
-			: "=&d" (old), "=m" (*(int *) ptr)
-			: "d" (x), "a" (ptr), "m" (*(int *) ptr)
+			: "=&d" (old), "=Q" (*(int *) ptr)
+			: "d" (x), "Q" (*(int *) ptr)
 			: "memory", "cc");
 		return old;
 #ifdef __s390x__
 	case 8:
 		asm volatile(
-			"	lg	%0,0(%3)\n"
-			"0:	csg	%0,%2,0(%3)\n"
+			"	lg	%0,%3\n"
+			"0:	csg	%0,%2,%3\n"
 			"	jl	0b\n"
 			: "=&d" (old), "=m" (*(long *) ptr)
-			: "d" (x), "a" (ptr), "m" (*(long *) ptr)
+			: "d" (x), "Q" (*(long *) ptr)
 			: "memory", "cc");
 		return old;
 #endif /* __s390x__ */
@@ -215,20 +215,20 @@
 		shift = (3 ^ (addr & 3)) << 3;
 		addr ^= addr & 3;
 		asm volatile(
-			"	l	%0,0(%4)\n"
+			"	l	%0,%2\n"
 			"0:	nr	%0,%5\n"
 			"	lr	%1,%0\n"
 			"	or	%0,%2\n"
 			"	or	%1,%3\n"
-			"	cs	%0,%1,0(%4)\n"
+			"	cs	%0,%1,%2\n"
 			"	jnl	1f\n"
 			"	xr	%1,%0\n"
 			"	nr	%1,%5\n"
 			"	jnz	0b\n"
 			"1:"
-			: "=&d" (prev), "=&d" (tmp)
-			: "d" (old << shift), "d" (new << shift), "a" (ptr),
-			  "d" (~(255 << shift))
+			: "=&d" (prev), "=&d" (tmp), "=Q" (*(int *) ptr)
+			: "d" (old << shift), "d" (new << shift),
+			  "d" (~(255 << shift)), "Q" (*(int *) ptr)
 			: "memory", "cc");
 		return prev >> shift;
 	case 2:
@@ -236,33 +236,35 @@
 		shift = (2 ^ (addr & 2)) << 3;
 		addr ^= addr & 2;
 		asm volatile(
-			"	l	%0,0(%4)\n"
+			"	l	%0,%2\n"
 			"0:	nr	%0,%5\n"
 			"	lr	%1,%0\n"
 			"	or	%0,%2\n"
 			"	or	%1,%3\n"
-			"	cs	%0,%1,0(%4)\n"
+			"	cs	%0,%1,%2\n"
 			"	jnl	1f\n"
 			"	xr	%1,%0\n"
 			"	nr	%1,%5\n"
 			"	jnz	0b\n"
 			"1:"
-			: "=&d" (prev), "=&d" (tmp)
-			: "d" (old << shift), "d" (new << shift), "a" (ptr),
-			  "d" (~(65535 << shift))
+			: "=&d" (prev), "=&d" (tmp), "=Q" (*(int *) ptr)
+			: "d" (old << shift), "d" (new << shift),
+			  "d" (~(65535 << shift)), "Q" (*(int *) ptr)
 			: "memory", "cc");
 		return prev >> shift;
 	case 4:
 		asm volatile(
-			"	cs	%0,%2,0(%3)\n"
-			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
+			"	cs	%0,%3,%1\n"
+			: "=&d" (prev), "=Q" (*(int *) ptr)
+			: "0" (old), "d" (new), "Q" (*(int *) ptr)
 			: "memory", "cc");
 		return prev;
 #ifdef __s390x__
 	case 8:
 		asm volatile(
-			"	csg	%0,%2,0(%3)\n"
-			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
+			"	csg	%0,%3,%1\n"
+			: "=&d" (prev), "=Q" (*(long *) ptr)
+			: "0" (old), "d" (new), "Q" (*(long *) ptr)
 			: "memory", "cc");
 		return prev;
 #endif /* __s390x__ */
@@ -302,17 +304,17 @@
 #define __ctl_load(array, low, high) ({				\
 	typedef struct { char _[sizeof(array)]; } addrtype;	\
 	asm volatile(						\
-		"	lctlg	%1,%2,0(%0)\n"			\
-		: : "a" (&array), "i" (low), "i" (high),	\
-		    "m" (*(addrtype *)(&array)));		\
+		"	lctlg	%1,%2,%0\n"			\
+		: : "Q" (*(addrtype *)(&array)),		\
+		    "i" (low), "i" (high));			\
 	})
 
 #define __ctl_store(array, low, high) ({			\
 	typedef struct { char _[sizeof(array)]; } addrtype;	\
 	asm volatile(						\
-		"	stctg	%2,%3,0(%1)\n"			\
-		: "=m" (*(addrtype *)(&array))			\
-		: "a" (&array), "i" (low), "i" (high));		\
+		"	stctg	%1,%2,%0\n"			\
+		: "=Q" (*(addrtype *)(&array))			\
+		: "i" (low), "i" (high));			\
 	})
 
 #else /* __s390x__ */
@@ -320,17 +322,17 @@
 #define __ctl_load(array, low, high) ({				\
 	typedef struct { char _[sizeof(array)]; } addrtype;	\
 	asm volatile(						\
-		"	lctl	%1,%2,0(%0)\n"			\
-		: : "a" (&array), "i" (low), "i" (high),	\
-		    "m" (*(addrtype *)(&array)));		\
+		"	lctl	%1,%2,%0\n"			\
+		: : "Q" (*(addrtype *)(&array)),		\
+		    "i" (low), "i" (high));			\
 })
 
 #define __ctl_store(array, low, high) ({			\
 	typedef struct { char _[sizeof(array)]; } addrtype;	\
 	asm volatile(						\
-		"	stctl	%2,%3,0(%1)\n"			\
-		: "=m" (*(addrtype *)(&array))			\
-		: "a" (&array), "i" (low), "i" (high));		\
+		"	stctl	%1,%2,%0\n"			\
+		: "=Q" (*(addrtype *)(&array))			\
+		: "i" (low), "i" (high));			\
 	})
 
 #endif /* __s390x__ */
Index: quilt-2.6/arch/s390/include/asm/timex.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/timex.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/timex.h	2010-02-24 09:44:24.000000000 +0100
@@ -20,10 +20,10 @@
 	int cc;
 
 	asm volatile(
-		"   sck   0(%2)\n"
+		"   sck   %1\n"
 		"   ipm   %0\n"
 		"   srl   %0,28\n"
-		: "=d" (cc) : "m" (time), "a" (&time) : "cc");
+		: "=d" (cc) : "Q" (time) : "cc");
 	return cc;
 }
 
@@ -32,21 +32,21 @@
 	int cc;
 
 	asm volatile(
-		"   stck  0(%2)\n"
+		"   stck  %1\n"
 		"   ipm   %0\n"
 		"   srl   %0,28\n"
-		: "=d" (cc), "=m" (*time) : "a" (time) : "cc");
+		: "=d" (cc), "=Q" (*time) : : "cc");
 	return cc;
 }
 
 static inline void set_clock_comparator(__u64 time)
 {
-	asm volatile("sckc 0(%1)" : : "m" (time), "a" (&time));
+	asm volatile("sckc %0" : : "Q" (time));
 }
 
 static inline void store_clock_comparator(__u64 *time)
 {
-	asm volatile("stckc 0(%1)" : "=m" (*time) : "a" (time));
+	asm volatile("stckc %0" : "=Q" (*time));
 }
 
 #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
@@ -57,11 +57,7 @@
 {
 	unsigned long long clk;
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 	asm volatile("stck %0" : "=Q" (clk) : : "cc");
-#else /* __GNUC__ */
-	asm volatile("stck 0(%1)" : "=m" (clk) : "a" (&clk) : "cc");
-#endif /* __GNUC__ */
 	return clk;
 }
 
@@ -69,13 +65,7 @@
 {
 	unsigned char clk[16];
 
-#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 	asm volatile("stcke %0" : "=Q" (clk) : : "cc");
-#else /* __GNUC__ */
-	asm volatile("stcke 0(%1)" : "=m" (clk)
-				   : "a" (clk) : "cc");
-#endif /* __GNUC__ */
-
 	return *((unsigned long long *)&clk[1]);
 }
 
Index: quilt-2.6/arch/s390/kernel/asm-offsets.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/asm-offsets.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/asm-offsets.c	2010-02-24 09:44:24.000000000 +0100
@@ -9,6 +9,14 @@
 #include <asm/vdso.h>
 #include <asm/sigp.h>
 
+/*
+ * Make sure that the compiler is new enough. We want a compiler that
+ * is known to work with the "Q" assembler constraint.
+ */
+#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 3)
+#error Your compiler is too old; please use version 3.3.3 or newer
+#endif
+
 int main(void)
 {
 	DEFINE(__THREAD_info, offsetof(struct task_struct, stack));
