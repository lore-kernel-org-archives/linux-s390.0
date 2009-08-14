Return-Path: <linux-kernel-owner+w=401wt.eu-S932214AbZHNL0x@vger.kernel.org>
Message-Id: <20090814112616.544352043@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/34] atomic ops: small cleanups
Content-Disposition: inline; filename=116-atomic-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Couple of coding style fixes, replace __inline__ with inline and
remove #ifdef __KERNEL_- since the header file isn't exported.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/atomic.h |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/atomic.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/atomic.h
+++ quilt-2.6/arch/s390/include/asm/atomic.h
@@ -18,8 +18,6 @@
 
 #define ATOMIC_INIT(i)  { (i) }
 
-#ifdef __KERNEL__
-
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 
 #define __CS_LOOP(ptr, op_val, op_string) ({				\
@@ -69,7 +67,7 @@ static inline void atomic_set(atomic_t *
 	barrier();
 }
 
-static __inline__ int atomic_add_return(int i, atomic_t * v)
+static inline int atomic_add_return(int i, atomic_t *v)
 {
 	return __CS_LOOP(v, i, "ar");
 }
@@ -79,7 +77,7 @@ static __inline__ int atomic_add_return(
 #define atomic_inc_return(_v)		atomic_add_return(1, _v)
 #define atomic_inc_and_test(_v)		(atomic_add_return(1, _v) == 0)
 
-static __inline__ int atomic_sub_return(int i, atomic_t * v)
+static inline int atomic_sub_return(int i, atomic_t *v)
 {
 	return __CS_LOOP(v, i, "sr");
 }
@@ -89,19 +87,19 @@ static __inline__ int atomic_sub_return(
 #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
 #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
 
-static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t * v)
+static inline void atomic_clear_mask(unsigned long mask, atomic_t *v)
 {
-	       __CS_LOOP(v, ~mask, "nr");
+	__CS_LOOP(v, ~mask, "nr");
 }
 
-static __inline__ void atomic_set_mask(unsigned long mask, atomic_t * v)
+static inline void atomic_set_mask(unsigned long mask, atomic_t *v)
 {
-	       __CS_LOOP(v, mask, "or");
+	__CS_LOOP(v, mask, "or");
 }
 
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
-static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
 	asm volatile(
@@ -119,7 +117,7 @@ static __inline__ int atomic_cmpxchg(ato
 	return old;
 }
 
-static __inline__ int atomic_add_unless(atomic_t *v, int a, int u)
+static inline int atomic_add_unless(atomic_t *v, int a, int u)
 {
 	int c, old;
 	c = atomic_read(v);
@@ -155,7 +153,7 @@ static __inline__ int atomic_add_unless(
 		: "=&d" (old_val), "=&d" (new_val),			\
 		  "=Q" (((atomic_t *)(ptr))->counter)			\
 		: "d" (op_val),	"Q" (((atomic_t *)(ptr))->counter)	\
-		: "cc", "memory" );					\
+		: "cc", "memory");					\
 	new_val;							\
 })
 
@@ -173,7 +171,7 @@ static __inline__ int atomic_add_unless(
 		  "=m" (((atomic_t *)(ptr))->counter)			\
 		: "a" (ptr), "d" (op_val),				\
 		  "m" (((atomic_t *)(ptr))->counter)			\
-		: "cc", "memory" );					\
+		: "cc", "memory");					\
 	new_val;							\
 })
 
@@ -191,29 +189,29 @@ static inline void atomic64_set(atomic64
 	barrier();
 }
 
-static __inline__ long long atomic64_add_return(long long i, atomic64_t * v)
+static inline long long atomic64_add_return(long long i, atomic64_t *v)
 {
 	return __CSG_LOOP(v, i, "agr");
 }
 
-static __inline__ long long atomic64_sub_return(long long i, atomic64_t * v)
+static inline long long atomic64_sub_return(long long i, atomic64_t *v)
 {
 	return __CSG_LOOP(v, i, "sgr");
 }
 
-static __inline__ void atomic64_clear_mask(unsigned long mask, atomic64_t * v)
+static inline void atomic64_clear_mask(unsigned long mask, atomic64_t *v)
 {
-	       __CSG_LOOP(v, ~mask, "ngr");
+	__CSG_LOOP(v, ~mask, "ngr");
 }
 
-static __inline__ void atomic64_set_mask(unsigned long mask, atomic64_t * v)
+static inline void atomic64_set_mask(unsigned long mask, atomic64_t *v)
 {
-	       __CSG_LOOP(v, mask, "ogr");
+	__CSG_LOOP(v, mask, "ogr");
 }
 
 #define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
 
-static __inline__ long long atomic64_cmpxchg(atomic64_t *v,
+static inline long long atomic64_cmpxchg(atomic64_t *v,
 					     long long old, long long new)
 {
 #if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 2)
@@ -337,8 +335,7 @@ static inline void atomic64_clear_mask(u
 
 #endif /* CONFIG_64BIT */
 
-static __inline__ int atomic64_add_unless(atomic64_t *v,
-					  long long a, long long u)
+static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
 {
 	long long c, old;
 	c = atomic64_read(v);
@@ -371,5 +368,5 @@ static __inline__ int atomic64_add_unles
 #define smp_mb__after_atomic_inc()	smp_mb()
 
 #include <asm-generic/atomic-long.h>
-#endif /* __KERNEL__ */
+
 #endif /* __ARCH_S390_ATOMIC__  */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
