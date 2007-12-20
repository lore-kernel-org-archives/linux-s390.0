Return-Path: <linux-kernel-owner+w=401wt.eu-S965285AbXLTP1R@vger.kernel.org>
Message-Id: <20071220152108.530593357@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 25/47] Remove owner_pc member from raw_spinlock_t.
Content-Disposition: inline; filename=124-spinlock-owner.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Used to contain the address of the holder of the lock. But since the
spinlock code is not inlined anymore all locks contain the same address
anyway. And since in addtition nobody complained about that for ages
its obviously unused. So remove it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/spinlock.c          |   12 ++++--------
 include/asm-s390/spinlock.h       |   19 ++++++-------------
 include/asm-s390/spinlock_types.h |    1 -
 3 files changed, 10 insertions(+), 22 deletions(-)

Index: quilt-2.6/arch/s390/lib/spinlock.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/spinlock.c
+++ quilt-2.6/arch/s390/lib/spinlock.c
@@ -39,7 +39,7 @@ static inline void _raw_yield_cpu(int cp
 		_raw_yield();
 }
 
-void _raw_spin_lock_wait(raw_spinlock_t *lp, unsigned int pc)
+void _raw_spin_lock_wait(raw_spinlock_t *lp)
 {
 	int count = spin_retry;
 	unsigned int cpu = ~smp_processor_id();
@@ -53,15 +53,13 @@ void _raw_spin_lock_wait(raw_spinlock_t 
 		}
 		if (__raw_spin_is_locked(lp))
 			continue;
-		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0) {
-			lp->owner_pc = pc;
+		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0)
 			return;
-		}
 	}
 }
 EXPORT_SYMBOL(_raw_spin_lock_wait);
 
-int _raw_spin_trylock_retry(raw_spinlock_t *lp, unsigned int pc)
+int _raw_spin_trylock_retry(raw_spinlock_t *lp)
 {
 	unsigned int cpu = ~smp_processor_id();
 	int count;
@@ -69,10 +67,8 @@ int _raw_spin_trylock_retry(raw_spinlock
 	for (count = spin_retry; count > 0; count--) {
 		if (__raw_spin_is_locked(lp))
 			continue;
-		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0) {
-			lp->owner_pc = pc;
+		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0)
 			return 1;
-		}
 	}
 	return 0;
 }
Index: quilt-2.6/include/asm-s390/spinlock.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/spinlock.h
+++ quilt-2.6/include/asm-s390/spinlock.h
@@ -58,39 +58,32 @@ _raw_compare_and_swap(volatile unsigned 
 	do { while (__raw_spin_is_locked(lock)) \
 		 _raw_spin_relax(lock); } while (0)
 
-extern void _raw_spin_lock_wait(raw_spinlock_t *, unsigned int pc);
-extern int _raw_spin_trylock_retry(raw_spinlock_t *, unsigned int pc);
+extern void _raw_spin_lock_wait(raw_spinlock_t *);
+extern int _raw_spin_trylock_retry(raw_spinlock_t *);
 extern void _raw_spin_relax(raw_spinlock_t *lock);
 
 static inline void __raw_spin_lock(raw_spinlock_t *lp)
 {
-	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
 	int old;
 
 	old = _raw_compare_and_swap(&lp->owner_cpu, 0, ~smp_processor_id());
-	if (likely(old == 0)) {
-		lp->owner_pc = pc;
+	if (likely(old == 0))
 		return;
-	}
-	_raw_spin_lock_wait(lp, pc);
+	_raw_spin_lock_wait(lp);
 }
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lp)
 {
-	unsigned long pc = 1 | (unsigned long) __builtin_return_address(0);
 	int old;
 
 	old = _raw_compare_and_swap(&lp->owner_cpu, 0, ~smp_processor_id());
-	if (likely(old == 0)) {
-		lp->owner_pc = pc;
+	if (likely(old == 0))
 		return 1;
-	}
-	return _raw_spin_trylock_retry(lp, pc);
+	return _raw_spin_trylock_retry(lp);
 }
 
 static inline void __raw_spin_unlock(raw_spinlock_t *lp)
 {
-	lp->owner_pc = 0;
 	_raw_compare_and_swap(&lp->owner_cpu, lp->owner_cpu, 0);
 }
 		
Index: quilt-2.6/include/asm-s390/spinlock_types.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/spinlock_types.h
+++ quilt-2.6/include/asm-s390/spinlock_types.h
@@ -7,7 +7,6 @@
 
 typedef struct {
 	volatile unsigned int owner_cpu;
-	volatile unsigned int owner_pc;
 } __attribute__ ((aligned (4))) raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
