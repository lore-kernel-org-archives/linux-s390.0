Return-Path: <linux-kernel-owner+w=401wt.eu-S1755919AbZHNL1i@vger.kernel.org>
Message-Id: <20090814112616.312607017@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/34] atomic ops: add effecient atomic64 support for 31 bit
Content-Disposition: inline; filename=115-atomic64-31bit-fast.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use compare double and swap to implement efficient atomic64 ops for 31 bit.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig              |    1 
 arch/s390/include/asm/atomic.h |  164 +++++++++++++++++++++++++++++++----------
 2 files changed, 127 insertions(+), 38 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/atomic.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/atomic.h
+++ quilt-2.6/arch/s390/include/asm/atomic.h
@@ -1,28 +1,20 @@
 #ifndef __ARCH_S390_ATOMIC__
 #define __ARCH_S390_ATOMIC__
 
-#include <linux/compiler.h>
-#include <linux/types.h>
-
 /*
- *  include/asm-s390/atomic.h
+ * Copyright 1999,2009 IBM Corp.
+ * Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *	      Denis Joseph Barrow,
+ *	      Arnd Bergmann <arndb@de.ibm.com>,
  *
- *  S390 version
- *    Copyright (C) 1999-2005 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Denis Joseph Barrow,
- *		 Arnd Bergmann (arndb@de.ibm.com)
- *
- *  Derived from "include/asm-i386/bitops.h"
- *    Copyright (C) 1992, Linus Torvalds
+ * Atomic operations that C can't guarantee us.
+ * Useful for resource counting etc.
+ * s390 uses 'Compare And Swap' for atomicity in SMP enviroment.
  *
  */
 
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- * S390 uses 'Compare And Swap' for atomicity in SMP enviroment
- */
+#include <linux/compiler.h>
+#include <linux/types.h>
 
 #define ATOMIC_INIT(i)  { (i) }
 
@@ -146,9 +138,10 @@ static __inline__ int atomic_add_unless(
 
 #undef __CS_LOOP
 
-#ifdef __s390x__
 #define ATOMIC64_INIT(i)  { (i) }
 
+#ifdef CONFIG_64BIT
+
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 
 #define __CSG_LOOP(ptr, op_val, op_string) ({				\
@@ -202,21 +195,11 @@ static __inline__ long long atomic64_add
 {
 	return __CSG_LOOP(v, i, "agr");
 }
-#define atomic64_add(_i, _v)		atomic64_add_return(_i, _v)
-#define atomic64_add_negative(_i, _v)	(atomic64_add_return(_i, _v) < 0)
-#define atomic64_inc(_v)		atomic64_add_return(1, _v)
-#define atomic64_inc_return(_v)		atomic64_add_return(1, _v)
-#define atomic64_inc_and_test(_v)	(atomic64_add_return(1, _v) == 0)
 
 static __inline__ long long atomic64_sub_return(long long i, atomic64_t * v)
 {
 	return __CSG_LOOP(v, i, "sgr");
 }
-#define atomic64_sub(_i, _v)		atomic64_sub_return(_i, _v)
-#define atomic64_sub_and_test(_i, _v)	(atomic64_sub_return(_i, _v) == 0)
-#define atomic64_dec(_v)		atomic64_sub_return(1, _v)
-#define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
-#define atomic64_dec_and_test(_v)	(atomic64_sub_return(1, _v) == 0)
 
 static __inline__ void atomic64_clear_mask(unsigned long mask, atomic64_t * v)
 {
@@ -249,6 +232,111 @@ static __inline__ long long atomic64_cmp
 	return old;
 }
 
+#undef __CSG_LOOP
+
+#else /* CONFIG_64BIT */
+
+typedef struct {
+	long long counter;
+} atomic64_t;
+
+static inline long long atomic64_read(const atomic64_t *v)
+{
+	register_pair rp;
+
+	asm volatile(
+		"	lm	%0,%N0,0(%1)"
+		: "=&d" (rp)
+		: "a" (&v->counter), "m" (v->counter)
+		);
+	return rp.pair;
+}
+
+static inline void atomic64_set(atomic64_t *v, long long i)
+{
+	register_pair rp = {.pair = i};
+
+	asm volatile(
+		"	stm	%1,%N1,0(%2)"
+		: "=m" (v->counter)
+		: "d" (rp), "a" (&v->counter)
+		);
+}
+
+static inline long long atomic64_xchg(atomic64_t *v, long long new)
+{
+	register_pair rp_new = {.pair = new};
+	register_pair rp_old;
+
+	asm volatile(
+		"	lm	%0,%N0,0(%2)\n"
+		"0:	cds	%0,%3,0(%2)\n"
+		"	jl	0b\n"
+		: "=&d" (rp_old), "+m" (v->counter)
+		: "a" (&v->counter), "d" (rp_new)
+		: "cc");
+	return rp_old.pair;
+}
+
+static inline long long atomic64_cmpxchg(atomic64_t *v,
+					 long long old, long long new)
+{
+	register_pair rp_old = {.pair = old};
+	register_pair rp_new = {.pair = new};
+
+	asm volatile(
+		"	cds	%0,%3,0(%2)"
+		: "+&d" (rp_old), "+m" (v->counter)
+		: "a" (&v->counter), "d" (rp_new)
+		: "cc");
+	return rp_old.pair;
+}
+
+
+static inline long long atomic64_add_return(long long i, atomic64_t *v)
+{
+	long long old, new;
+
+	do {
+		old = atomic64_read(v);
+		new = old + i;
+	} while (atomic64_cmpxchg(v, old, new) != old);
+	return new;
+}
+
+static inline long long atomic64_sub_return(long long i, atomic64_t *v)
+{
+	long long old, new;
+
+	do {
+		old = atomic64_read(v);
+		new = old - i;
+	} while (atomic64_cmpxchg(v, old, new) != old);
+	return new;
+}
+
+static inline void atomic64_set_mask(unsigned long long mask, atomic64_t *v)
+{
+	long long old, new;
+
+	do {
+		old = atomic64_read(v);
+		new = old | mask;
+	} while (atomic64_cmpxchg(v, old, new) != old);
+}
+
+static inline void atomic64_clear_mask(unsigned long long mask, atomic64_t *v)
+{
+	long long old, new;
+
+	do {
+		old = atomic64_read(v);
+		new = old & mask;
+	} while (atomic64_cmpxchg(v, old, new) != old);
+}
+
+#endif /* CONFIG_64BIT */
+
 static __inline__ int atomic64_add_unless(atomic64_t *v,
 					  long long a, long long u)
 {
@@ -265,15 +353,17 @@ static __inline__ int atomic64_add_unles
 	return c != u;
 }
 
-#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
-
-#undef __CSG_LOOP
-
-#else /* __s390x__ */
-
-#include <asm-generic/atomic64.h>
-
-#endif /* __s390x__ */
+#define atomic64_add(_i, _v)		atomic64_add_return(_i, _v)
+#define atomic64_add_negative(_i, _v)	(atomic64_add_return(_i, _v) < 0)
+#define atomic64_inc(_v)		atomic64_add_return(1, _v)
+#define atomic64_inc_return(_v)		atomic64_add_return(1, _v)
+#define atomic64_inc_and_test(_v)	(atomic64_add_return(1, _v) == 0)
+#define atomic64_sub(_i, _v)		atomic64_sub_return(_i, _v)
+#define atomic64_sub_and_test(_i, _v)	(atomic64_sub_return(_i, _v) == 0)
+#define atomic64_dec(_v)		atomic64_sub_return(1, _v)
+#define atomic64_dec_return(_v)		atomic64_sub_return(1, _v)
+#define atomic64_dec_and_test(_v)	(atomic64_sub_return(1, _v) == 0)
+#define atomic64_inc_not_zero(v)	atomic64_add_unless((v), 1, 0)
 
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -95,7 +95,6 @@ config S390
 	select HAVE_ARCH_TRACEHOOK
 	select INIT_ALL_POSSIBLE
 	select HAVE_PERF_COUNTERS
-	select GENERIC_ATOMIC64 if !64BIT
 
 config SCHED_OMIT_FRAME_POINTER
 	bool

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
