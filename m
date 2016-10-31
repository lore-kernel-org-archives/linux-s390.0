Return-Path: <sgruszka@redhat.com>
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 2/4] cputime/powerpc: remove cputime_to_scaled()
Date: Mon, 31 Oct 2016 13:36:27 +0100
Message-Id: <1477917389-11341-3-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
References: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Currently cputime_to_scaled() just return it's argument on
all implementations, we don't need to call this function.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 arch/powerpc/include/asm/cputime.h    |    7 -------
 include/asm-generic/cputime_jiffies.h |    1 -
 include/asm-generic/cputime_nsecs.h   |    1 -
 kernel/sched/cputime.c                |   26 ++++++++++++--------------
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 9f5dcf7..aa2e6a3 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -52,13 +52,6 @@ static inline unsigned long cputime_to_jiffies(const cputime_t ct)
 	return mulhdu((__force u64) ct, __cputime_jiffies_factor);
 }
 
-/* Estimate the scaled cputime by scaling the real cputime based on
- * the last scaled to real ratio */
-static inline cputime_t cputime_to_scaled(const cputime_t ct)
-{
-	return ct;
-}
-
 static inline cputime_t jiffies_to_cputime(const unsigned long jif)
 {
 	u64 ct;
diff --git a/include/asm-generic/cputime_jiffies.h b/include/asm-generic/cputime_jiffies.h
index fe386fc..6bb8cd4 100644
--- a/include/asm-generic/cputime_jiffies.h
+++ b/include/asm-generic/cputime_jiffies.h
@@ -7,7 +7,6 @@
 
 #define cputime_one_jiffy		jiffies_to_cputime(1)
 #define cputime_to_jiffies(__ct)	(__force unsigned long)(__ct)
-#define cputime_to_scaled(__ct)		(__ct)
 #define jiffies_to_cputime(__hz)	(__force cputime_t)(__hz)
 
 typedef u64 __nocast cputime64_t;
diff --git a/include/asm-generic/cputime_nsecs.h b/include/asm-generic/cputime_nsecs.h
index a84e28e..4e3b18e 100644
--- a/include/asm-generic/cputime_nsecs.h
+++ b/include/asm-generic/cputime_nsecs.h
@@ -34,7 +34,6 @@
  */
 #define cputime_to_jiffies(__ct)	\
 	cputime_div(__ct, NSEC_PER_SEC / HZ)
-#define cputime_to_scaled(__ct)		(__ct)
 #define jiffies_to_cputime(__jif)	\
 	(__force cputime_t)((__jif) * (NSEC_PER_SEC / HZ))
 #define cputime64_to_jiffies64(__ct)	\
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 5ebee31..3229c72 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -390,7 +390,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 					 struct rq *rq, int ticks)
 {
 	u64 cputime = (__force u64) cputime_one_jiffy * ticks;
-	cputime_t scaled, other;
+	cputime_t other;
 
 	/*
 	 * When returning from idle, many ticks can get accounted at
@@ -403,7 +403,6 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	if (other >= cputime)
 		return;
 	cputime -= other;
-	scaled = cputime_to_scaled(cputime);
 
 	if (this_cpu_ksoftirqd() == p) {
 		/*
@@ -411,15 +410,15 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		 * So, we have to handle it separately here.
 		 * Also, p->stime needs to be updated for ksoftirqd.
 		 */
-		__account_system_time(p, cputime, scaled, CPUTIME_SOFTIRQ);
+		__account_system_time(p, cputime, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
-		account_user_time(p, cputime, scaled);
+		account_user_time(p, cputime, cputime);
 	} else if (p == rq->idle) {
 		account_idle_time(cputime);
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
-		account_guest_time(p, cputime, scaled);
+		account_guest_time(p, cputime, cputime);
 	} else {
-		__account_system_time(p, cputime, scaled,	CPUTIME_SYSTEM);
+		__account_system_time(p, cputime, cputime, CPUTIME_SYSTEM);
 	}
 }
 
@@ -502,7 +501,7 @@ void thread_group_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime
  */
 void account_process_tick(struct task_struct *p, int user_tick)
 {
-	cputime_t cputime, scaled, steal;
+	cputime_t cputime, steal;
 	struct rq *rq = this_rq();
 
 	if (vtime_accounting_cpu_enabled())
@@ -520,12 +519,11 @@ void account_process_tick(struct task_struct *p, int user_tick)
 		return;
 
 	cputime -= steal;
-	scaled = cputime_to_scaled(cputime);
 
 	if (user_tick)
-		account_user_time(p, cputime, scaled);
+		account_user_time(p, cputime, cputime);
 	else if ((p != rq->idle) || (irq_count() != HARDIRQ_OFFSET))
-		account_system_time(p, HARDIRQ_OFFSET, cputime, scaled);
+		account_system_time(p, HARDIRQ_OFFSET, cputime, cputime);
 	else
 		account_idle_time(cputime);
 }
@@ -746,7 +744,7 @@ static void __vtime_account_system(struct task_struct *tsk)
 {
 	cputime_t delta_cpu = get_vtime_delta(tsk);
 
-	account_system_time(tsk, irq_count(), delta_cpu, cputime_to_scaled(delta_cpu));
+	account_system_time(tsk, irq_count(), delta_cpu, delta_cpu);
 }
 
 void vtime_account_system(struct task_struct *tsk)
@@ -767,7 +765,7 @@ void vtime_account_user(struct task_struct *tsk)
 	tsk->vtime_snap_whence = VTIME_SYS;
 	if (vtime_delta(tsk)) {
 		delta_cpu = get_vtime_delta(tsk);
-		account_user_time(tsk, delta_cpu, cputime_to_scaled(delta_cpu));
+		account_user_time(tsk, delta_cpu, delta_cpu);
 	}
 	write_seqcount_end(&tsk->vtime_seqcount);
 }
@@ -940,8 +938,8 @@ void task_cputime_scaled(struct task_struct *t,
 	fetch_task_cputime(t, utimescaled, stimescaled,
 			   &t->utimescaled, &t->stimescaled, &udelta, &sdelta);
 	if (utimescaled)
-		*utimescaled += cputime_to_scaled(udelta);
+		*utimescaled += udelta;
 	if (stimescaled)
-		*stimescaled += cputime_to_scaled(sdelta);
+		*stimescaled += sdelta;
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
1.7.1
