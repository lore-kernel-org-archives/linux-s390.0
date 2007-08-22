Return-Path: <linux-kernel-owner+w=401wt.eu-S1763053AbXHVMfz@vger.kernel.org>
Message-Id: <20070822123644.236127458@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/10] Change atomic_read/set to inline functions with barrier semantics.
Content-Disposition: inline; filename=010-atomic_t.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

After doing some tests this seems to be the best variant for s390 and
should be correct as well. With gcc 4.2.1 we get the following kernel
image sizes using the default configuration:

atomic_t type volatile, atomic_read/set defines   5311824 bytes
atomic_t type int, atomic_read/set defines        5270864 bytes
atomic_t type int, atomic_read/set inline asm     5279056 bytes
atomic_t type int, atomic_read/set inline barrier 5270864 bytes

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/atomic.h |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

Index: quilt-2.6/include/asm-s390/atomic.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/atomic.h
+++ quilt-2.6/include/asm-s390/atomic.h
@@ -67,8 +67,17 @@ typedef struct {
 
 #endif /* __GNUC__ */
 
-#define atomic_read(v)          ((v)->counter)
-#define atomic_set(v,i)         (((v)->counter) = (i))
+static inline int atomic_read(const atomic_t *v)
+{
+	barrier();
+	return v->counter;
+}
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	v->counter = i;
+	barrier();
+}
 
 static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
@@ -182,8 +191,17 @@ typedef struct {
 
 #endif /* __GNUC__ */
 
-#define atomic64_read(v)          ((v)->counter)
-#define atomic64_set(v,i)         (((v)->counter) = (i))
+static inline long long atomic64_read(const atomic64_t *v)
+{
+	barrier();
+	return v->counter;
+}
+
+static inline void atomic64_set(atomic64_t *v, long long i)
+{
+	v->counter = i;
+	barrier();
+}
 
 static __inline__ long long atomic64_add_return(long long i, atomic64_t * v)
 {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
