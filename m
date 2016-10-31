Return-Path: <sgruszka@redhat.com>
From: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: [PATCH 4/4] cputime: simplify task_cputime()
Date: Mon, 31 Oct 2016 13:36:29 +0100
Message-Id: <1477917389-11341-5-git-send-email-sgruszka@redhat.com>
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

Now since fetch_task_cputime() has no other users than task_cputime(),
it's code could be used directly in task_cputime(). Moreover since
only 2 task_cputime() calls of 17 use NULL argument, we can
add dummy variables to those calls and remove NULL checks from
task_cputimes().

Do also remove NULL checks on task_cputimes_scaled().

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 arch/x86/kernel/apm_32.c       |    4 +-
 include/linux/sched.h          |   12 +++-----
 kernel/sched/cputime.c         |   57 ++++++++++-----------------------------
 kernel/time/posix-cpu-timers.c |    4 +-
 4 files changed, 23 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index c7364bd..d90749b 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -906,14 +906,14 @@ static int apm_cpu_idle(struct cpuidle_device *dev,
 	static int use_apm_idle; /* = 0 */
 	static unsigned int last_jiffies; /* = 0 */
 	static unsigned int last_stime; /* = 0 */
-	cputime_t stime;
+	cputime_t stime, utime;
 
 	int apm_idle_done = 0;
 	unsigned int jiffies_since_last_check = jiffies - last_jiffies;
 	unsigned int bucket;
 
 recalc:
-	task_cputime(current, NULL, &stime);
+	task_cputime(current, &utime, &stime);
 	if (jiffies_since_last_check > IDLE_CALC_LIMIT) {
 		use_apm_idle = 0;
 	} else if (jiffies_since_last_check > idle_period) {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 36a2c2e..93fbae0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2228,10 +2228,8 @@ extern void task_cputime(struct task_struct *t,
 static inline void task_cputime(struct task_struct *t,
 				cputime_t *utime, cputime_t *stime)
 {
-	if (utime)
-		*utime = t->utime;
-	if (stime)
-		*stime = t->stime;
+	*utime = t->utime;
+	*stime = t->stime;
 }
 
 static inline cputime_t task_gtime(struct task_struct *t)
@@ -2245,10 +2243,8 @@ static inline void task_cputime_scaled(struct task_struct *t,
 				       cputime_t *utimescaled,
 				       cputime_t *stimescaled)
 {
-	if (utimescaled)
-		*utimescaled = t->utimescaled;
-	if (stimescaled)
-		*stimescaled = t->stimescaled;
+	*utimescaled = t->utimescaled;
+	*stimescaled = t->stimescaled;
 }
 #else
 static inline void task_cputime_scaled(struct task_struct *t,
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index d427def..46a984e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -851,29 +851,25 @@ cputime_t task_gtime(struct task_struct *t)
  * add up the pending nohz execution time since the last
  * cputime snapshot.
  */
-static void
-fetch_task_cputime(struct task_struct *t,
-		   cputime_t *u_dst, cputime_t *s_dst,
-		   cputime_t *u_src, cputime_t *s_src,
-		   cputime_t *udelta, cputime_t *sdelta)
+void task_cputime(struct task_struct *t, cputime_t *utime, cputime_t *stime)
 {
+	cputime_t delta;
 	unsigned int seq;
-	unsigned long long delta;
 
-	do {
-		*udelta = 0;
-		*sdelta = 0;
+	if (!vtime_accounting_enabled()) {
+		*utime = t->utime;
+		*stime = t->stime;
+		return;
+	}
 
+	do {
 		seq = read_seqcount_begin(&t->vtime_seqcount);
 
-		if (u_dst)
-			*u_dst = *u_src;
-		if (s_dst)
-			*s_dst = *s_src;
+		*utime = t->utime;
+		*stime = t->stime;
 
 		/* Task is sleeping, nothing to add */
-		if (t->vtime_snap_whence == VTIME_INACTIVE ||
-		    is_idle_task(t))
+		if (t->vtime_snap_whence == VTIME_INACTIVE || is_idle_task(t))
 			continue;
 
 		delta = vtime_delta(t);
@@ -882,33 +878,10 @@ cputime_t task_gtime(struct task_struct *t)
 		 * Task runs either in user or kernel space, add pending nohz time to
 		 * the right place.
 		 */
-		if (t->vtime_snap_whence == VTIME_USER || t->flags & PF_VCPU) {
-			*udelta = delta;
-		} else {
-			if (t->vtime_snap_whence == VTIME_SYS)
-				*sdelta = delta;
-		}
+		if (t->vtime_snap_whence == VTIME_USER || t->flags & PF_VCPU)
+			*utime += delta;
+		else if (t->vtime_snap_whence == VTIME_SYS)
+			*stime += delta;
 	} while (read_seqcount_retry(&t->vtime_seqcount, seq));
 }
-
-
-void task_cputime(struct task_struct *t, cputime_t *utime, cputime_t *stime)
-{
-	cputime_t udelta, sdelta;
-
-	if (!vtime_accounting_enabled()) {
-		if (utime)
-			*utime = t->utime;
-		if (stime)
-			*stime = t->stime;
-		return;
-	}
-
-	fetch_task_cputime(t, utime, stime, &t->utime,
-			   &t->stime, &udelta, &sdelta);
-	if (utime)
-		*utime += udelta;
-	if (stime)
-		*stime += sdelta;
-}
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 39008d7..e887ffc 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -133,9 +133,9 @@ static inline unsigned long long prof_ticks(struct task_struct *p)
 }
 static inline unsigned long long virt_ticks(struct task_struct *p)
 {
-	cputime_t utime;
+	cputime_t utime, stime;
 
-	task_cputime(p, &utime, NULL);
+	task_cputime(p, &utime, &stime);
 
 	return cputime_to_expires(utime);
 }
-- 
1.7.1
