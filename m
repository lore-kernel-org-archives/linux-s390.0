Return-Path: <sgruszka@redhat.com>
Date: Mon, 31 Oct 2016 14:13:18 +0100
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH v2 3/4] cputime/powerpc/s390: make scaled cputime arch specific
Message-ID: <20161031131317.GA18969@redhat.com>
References: <1477917389-11341-1-git-send-email-sgruszka@redhat.com>
 <1477917389-11341-4-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477917389-11341-4-git-send-email-sgruszka@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Only s390 and powerpc have hardware facilities allowing to measure
cputimes scaled by frequency. On all other architectures
utimescaled/stimescaled are equal to utime/stime (however they are
accounted separately).

Patch remove {u,s}timescaled accounting on all architectures except
powerpc and s390, where those values are explicitly accounted on proper
places.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
v1 -> v2 : fix compilation (missed comma)

 arch/ia64/kernel/time.c     |    4 +-
 arch/powerpc/Kconfig        |    1 +
 arch/powerpc/kernel/time.c  |    6 +++-
 arch/s390/Kconfig           |    1 +
 arch/s390/kernel/vtime.c    |    9 ++++--
 include/linux/kernel_stat.h |    4 +-
 include/linux/sched.h       |   23 ++++++++++++----
 kernel/fork.c               |    2 +
 kernel/sched/cputime.c      |   61 ++++++++++--------------------------------
 9 files changed, 50 insertions(+), 61 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 6f892b9..021f44a 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -68,7 +68,7 @@ void vtime_account_user(struct task_struct *tsk)
 
 	if (ti->ac_utime) {
 		delta_utime = cycle_to_cputime(ti->ac_utime);
-		account_user_time(tsk, delta_utime, delta_utime);
+		account_user_time(tsk, delta_utime);
 		ti->ac_utime = 0;
 	}
 }
@@ -112,7 +112,7 @@ void vtime_account_system(struct task_struct *tsk)
 {
 	cputime_t delta = vtime_delta(tsk);
 
-	account_system_time(tsk, 0, delta, delta);
+	account_system_time(tsk, 0, delta);
 }
 EXPORT_SYMBOL_GPL(vtime_account_system);
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c..c7f120a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC
 	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select GENERIC_CPU_AUTOPROBE
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select ARCH_HAS_SCALED_CPUTIME if VIRT_CPU_ACCOUNTING_NATIVE
 	select HAVE_ARCH_HARDENED_USERCOPY
 	select HAVE_KERNEL_GZIP
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8105198..be9751f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -358,7 +358,8 @@ void vtime_account_system(struct task_struct *tsk)
 	unsigned long delta, sys_scaled, stolen;
 
 	delta = vtime_delta(tsk, &sys_scaled, &stolen);
-	account_system_time(tsk, 0, delta, sys_scaled);
+	account_system_time(tsk, 0, delta);
+	tsk->stimescaled += sys_scaled;
 	if (stolen)
 		account_steal_time(stolen);
 }
@@ -391,7 +392,8 @@ void vtime_account_user(struct task_struct *tsk)
 	acct->user_time = 0;
 	acct->user_time_scaled = 0;
 	acct->utime_sspurr = 0;
-	account_user_time(tsk, utime, utimescaled);
+	account_user_time(tsk, utime);
+	tsk->utimescaled += utimescaled;
 }
 
 #ifdef CONFIG_PPC32
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 426481d..028f97b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -171,6 +171,7 @@ config S390
 	select SYSCTL_EXCEPTION_TRACE
 	select TTY
 	select VIRT_CPU_ACCOUNTING
+	select ARCH_HAS_SCALED_CPUTIME
 	select VIRT_TO_BUS
 	select HAVE_NMI
 
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 856e30d..90eeb7c 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -137,8 +137,10 @@ static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 		user_scaled = (user_scaled * mult) / div;
 		system_scaled = (system_scaled * mult) / div;
 	}
-	account_user_time(tsk, user, user_scaled);
-	account_system_time(tsk, hardirq_offset, system, system_scaled);
+	account_user_time(tsk, user);
+	tsk->utimescaled += user_scaled;
+	account_system_time(tsk, hardirq_offset, system)
+	tsk->stimescaled += system_scaled;
 
 	steal = S390_lowcore.steal_timer;
 	if ((s64) steal > 0) {
@@ -202,7 +204,8 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 
 		system_scaled = (system_scaled * mult) / div;
 	}
-	account_system_time(tsk, 0, system, system_scaled);
+	account_system_time(tsk, 0, system);
+	tsk->stimescaled += system_scaled;
 
 	virt_timer_forward(system);
 }
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 44fda64..00f7768 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -78,8 +78,8 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 	return kstat_cpu(cpu).irqs_sum;
 }
 
-extern void account_user_time(struct task_struct *, cputime_t, cputime_t);
-extern void account_system_time(struct task_struct *, int, cputime_t, cputime_t);
+extern void account_user_time(struct task_struct *, cputime_t);
+extern void account_system_time(struct task_struct *, int, cputime_t);
 extern void account_steal_time(cputime_t);
 extern void account_idle_time(cputime_t);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 348f51b..36a2c2e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1627,7 +1627,10 @@ struct task_struct {
 	int __user *set_child_tid;		/* CLONE_CHILD_SETTID */
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
-	cputime_t utime, stime, utimescaled, stimescaled;
+	cputime_t utime, stime;
+#ifdef ARCH_HAS_SCALED_CPUTIME
+	cputime_t utimescaled, stimescaled;
+#endif
 	cputime_t gtime;
 	struct prev_cputime prev_cputime;
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
@@ -2220,8 +2223,6 @@ static inline void put_task_struct(struct task_struct *t)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern void task_cputime(struct task_struct *t,
 			 cputime_t *utime, cputime_t *stime);
-extern void task_cputime_scaled(struct task_struct *t,
-				cputime_t *utimescaled, cputime_t *stimescaled);
 extern cputime_t task_gtime(struct task_struct *t);
 #else
 static inline void task_cputime(struct task_struct *t,
@@ -2233,6 +2234,13 @@ static inline void task_cputime(struct task_struct *t,
 		*stime = t->stime;
 }
 
+static inline cputime_t task_gtime(struct task_struct *t)
+{
+	return t->gtime;
+}
+#endif
+
+#ifdef ARCH_HAS_SCALED_CPUTIME
 static inline void task_cputime_scaled(struct task_struct *t,
 				       cputime_t *utimescaled,
 				       cputime_t *stimescaled)
@@ -2242,12 +2250,15 @@ static inline void task_cputime_scaled(struct task_struct *t,
 	if (stimescaled)
 		*stimescaled = t->stimescaled;
 }
-
-static inline cputime_t task_gtime(struct task_struct *t)
+#else
+static inline void task_cputime_scaled(struct task_struct *t,
+				       cputime_t *utimescaled,
+				       cputime_t *stimescaled)
 {
-	return t->gtime;
+	task_cputime(t, utimescaled, stimescaled);
 }
 #endif
+
 extern void task_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime_t *st);
 extern void thread_group_cputime_adjusted(struct task_struct *p, cputime_t *ut, cputime_t *st);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 623259f..dbc9f60 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1548,7 +1548,9 @@ static void posix_cpu_timers_init(struct task_struct *tsk)
 	init_sigpending(&p->pending);
 
 	p->utime = p->stime = p->gtime = 0;
+#ifdef ARCH_HAS_SCALED_CPUTIME
 	p->utimescaled = p->stimescaled = 0;
+#endif
 	prev_cputime_init(&p->prev_cputime);
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 3229c72..d427def 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -128,16 +128,13 @@ static inline void task_group_account_field(struct task_struct *p, int index,
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in user space since the last update
- * @cputime_scaled: cputime scaled by cpu frequency
  */
-void account_user_time(struct task_struct *p, cputime_t cputime,
-		       cputime_t cputime_scaled)
+void account_user_time(struct task_struct *p, cputime_t cputime)
 {
 	int index;
 
 	/* Add user time to process. */
 	p->utime += cputime;
-	p->utimescaled += cputime_scaled;
 	account_group_user_time(p, cputime);
 
 	index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
@@ -153,16 +150,13 @@ void account_user_time(struct task_struct *p, cputime_t cputime,
  * Account guest cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in virtual machine since the last update
- * @cputime_scaled: cputime scaled by cpu frequency
  */
-static void account_guest_time(struct task_struct *p, cputime_t cputime,
-			       cputime_t cputime_scaled)
+static void account_guest_time(struct task_struct *p, cputime_t cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
 
 	/* Add guest time to process. */
 	p->utime += cputime;
-	p->utimescaled += cputime_scaled;
 	account_group_user_time(p, cputime);
 	p->gtime += cputime;
 
@@ -180,16 +174,13 @@ static void account_guest_time(struct task_struct *p, cputime_t cputime,
  * Account system cpu time to a process and desired cpustat field
  * @p: the process that the cpu time gets accounted to
  * @cputime: the cpu time spent in kernel space since the last update
- * @cputime_scaled: cputime scaled by cpu frequency
- * @target_cputime64: pointer to cpustat field that has to be updated
+ * @index: pointer to cpustat field that has to be updated
  */
 static inline
-void __account_system_time(struct task_struct *p, cputime_t cputime,
-			cputime_t cputime_scaled, int index)
+void __account_system_time(struct task_struct *p, cputime_t cputime, int index)
 {
 	/* Add system time to process. */
 	p->stime += cputime;
-	p->stimescaled += cputime_scaled;
 	account_group_system_time(p, cputime);
 
 	/* Add system time to cpustat. */
@@ -204,15 +195,14 @@ void __account_system_time(struct task_struct *p, cputime_t cputime,
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the cpu time spent in kernel space since the last update
- * @cputime_scaled: cputime scaled by cpu frequency
  */
 void account_system_time(struct task_struct *p, int hardirq_offset,
-			 cputime_t cputime, cputime_t cputime_scaled)
+			 cputime_t cputime)
 {
 	int index;
 
 	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
-		account_guest_time(p, cputime, cputime_scaled);
+		account_guest_time(p, cputime);
 		return;
 	}
 
@@ -223,7 +213,7 @@ void account_system_time(struct task_struct *p, int hardirq_offset,
 	else
 		index = CPUTIME_SYSTEM;
 
-	__account_system_time(p, cputime, cputime_scaled, index);
+	__account_system_time(p, cputime, index);
 }
 
 /*
@@ -410,15 +400,15 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		 * So, we have to handle it separately here.
 		 * Also, p->stime needs to be updated for ksoftirqd.
 		 */
-		__account_system_time(p, cputime, cputime, CPUTIME_SOFTIRQ);
+		__account_system_time(p, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
-		account_user_time(p, cputime, cputime);
+		account_user_time(p, cputime);
 	} else if (p == rq->idle) {
 		account_idle_time(cputime);
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
-		account_guest_time(p, cputime, cputime);
+		account_guest_time(p, cputime);
 	} else {
-		__account_system_time(p, cputime, cputime, CPUTIME_SYSTEM);
+		__account_system_time(p, cputime, CPUTIME_SYSTEM);
 	}
 }
 
@@ -521,9 +511,9 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	cputime -= steal;
 
 	if (user_tick)
-		account_user_time(p, cputime, cputime);
+		account_user_time(p, cputime);
 	else if ((p != rq->idle) || (irq_count() != HARDIRQ_OFFSET))
-		account_system_time(p, HARDIRQ_OFFSET, cputime, cputime);
+		account_system_time(p, HARDIRQ_OFFSET, cputime);
 	else
 		account_idle_time(cputime);
 }
@@ -744,7 +734,7 @@ static void __vtime_account_system(struct task_struct *tsk)
 {
 	cputime_t delta_cpu = get_vtime_delta(tsk);
 
-	account_system_time(tsk, irq_count(), delta_cpu, delta_cpu);
+	account_system_time(tsk, irq_count(), delta_cpu);
 }
 
 void vtime_account_system(struct task_struct *tsk)
@@ -765,7 +755,7 @@ void vtime_account_user(struct task_struct *tsk)
 	tsk->vtime_snap_whence = VTIME_SYS;
 	if (vtime_delta(tsk)) {
 		delta_cpu = get_vtime_delta(tsk);
-		account_user_time(tsk, delta_cpu, delta_cpu);
+		account_user_time(tsk, delta_cpu);
 	}
 	write_seqcount_end(&tsk->vtime_seqcount);
 }
@@ -921,25 +911,4 @@ void task_cputime(struct task_struct *t, cputime_t *utime, cputime_t *stime)
 	if (stime)
 		*stime += sdelta;
 }
-
-void task_cputime_scaled(struct task_struct *t,
-			 cputime_t *utimescaled, cputime_t *stimescaled)
-{
-	cputime_t udelta, sdelta;
-
-	if (!vtime_accounting_enabled()) {
-		if (utimescaled)
-			*utimescaled = t->utimescaled;
-		if (stimescaled)
-			*stimescaled = t->stimescaled;
-		return;
-	}
-
-	fetch_task_cputime(t, utimescaled, stimescaled,
-			   &t->utimescaled, &t->stimescaled, &udelta, &sdelta);
-	if (utimescaled)
-		*utimescaled += udelta;
-	if (stimescaled)
-		*stimescaled += sdelta;
-}
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
1.7.1
