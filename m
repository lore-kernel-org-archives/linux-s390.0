Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800732AAD6;
	Fri,  8 May 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246302; cv=none; b=HlKa+yZw6xT6zUkHysYyp8/aXl5SkiXLxckQmMJJbYHzE4Cv9S2LHaigJUFW6m+TYAViq8DVuwZ0972qkXaSG2ygz4kJVzPW8nVgd5AwdbLqpI4r//H2sGLsxG9YM9mliUmI0r2e2Koi5Liqy007OA+aD5ex7aLXIBt1hTz0jFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246302; c=relaxed/simple;
	bh=u0vNvN9NtF+AsX8/Y+QNB08Illj907nXS1MtqiyyDWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3XigOyJMgEJpLL2/Tu1GrubNIP2FiWnQ9/YWLDo6kn0LLw4OCfdnYA8WuaWIFbBJjFjXTk7iP6ZOXXe5zyE8I8JD7mSFUs9UR9VI99ulfHh9gpsrl7up8C66i5AedcO+HD/5vLHn8IvfsuemAD5PFNkOpFPogn5vvUMcE3tJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b03JG/0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b03JG/0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2984EC2BCB0;
	Fri,  8 May 2026 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246302;
	bh=u0vNvN9NtF+AsX8/Y+QNB08Illj907nXS1MtqiyyDWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b03JG/0Cc9XSCeKKg8g3/tA2h1fJv9Ek3cPqLiDrg84ZStWD53YYSIONP4WAuh4/u
	 bEk0gSg8yi3OBVOWzfvklBu9UpcBDKqSbqXCqts34xdSwrRGa9jF+O6LAvsd20z/yY
	 rxYBif/Lr3jIguxvb7EVOeQz+eIDp/N8l95vRURu2ql3kJNPMN8yiFlb0kvo/wKTVM
	 emHntXqYwlcU9g1/enzjSxEPFRE5sFk4Vb3f5ZWAaRbu4dKnOqhvfbRn96/4circ0q
	 8XlQcefuVU2/TCQjJXK9OlqPrvh/m3dH3KUJsfSHCy4Rsi1eSlMzO3q4CNnkkcpo5m
	 usDk3aIQHSXgg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sashiko,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/15] tick/sched: Move dyntick-idle cputime accounting to cputime code
Date: Fri,  8 May 2026 15:16:41 +0200
Message-ID: <20260508131647.43868-10-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508131647.43868-1-frederic@kernel.org>
References: <20260508131647.43868-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although the dynticks-idle cputime accounting is necessarily tied to
the tick subsystem, the actual related accounting code has no business
residing there and should be part of the scheduler cputime code.

Move away the relevant pieces and state machine to where they belong.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/kernel_stat.h |  14 +++-
 kernel/sched/core.c         |   6 +-
 kernel/sched/cputime.c      | 148 ++++++++++++++++++++++++++++++--
 kernel/time/tick-sched.c    | 163 +++++++-----------------------------
 4 files changed, 188 insertions(+), 143 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index ba65aad308a1..9343353ac7a3 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -35,9 +35,12 @@ enum cpu_usage_stat {
 
 struct kernel_cpustat {
 #ifdef CONFIG_NO_HZ_COMMON
-	int idle_dyntick;
+	bool		idle_dyntick;
+	bool		idle_elapse;
+	seqcount_t	idle_sleeptime_seq;
+	u64		idle_entrytime;
 #endif
-	u64 cpustat[NR_STATS];
+	u64		cpustat[NR_STATS];
 };
 
 struct kernel_stat {
@@ -103,8 +106,11 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-extern void kcpustat_dyntick_start(void);
-extern void kcpustat_dyntick_stop(void);
+extern void kcpustat_dyntick_start(u64 now);
+extern void kcpustat_dyntick_stop(u64 now);
+extern void kcpustat_irq_enter(u64 now);
+extern void kcpustat_irq_exit(u64 now);
+
 static inline bool kcpustat_idle_dyntick(void)
 {
 	return __this_cpu_read(kernel_cpustat.idle_dyntick);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da20fb6ea25a..0cfc027a955d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5517,7 +5517,11 @@ void sched_exec(void)
 }
 
 DEFINE_PER_CPU(struct kernel_stat, kstat);
-DEFINE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
+DEFINE_PER_CPU(struct kernel_cpustat, kernel_cpustat) = {
+#ifdef CONFIG_NO_HZ_COMMON
+	.idle_sleeptime_seq = SEQCNT_ZERO(kernel_cpustat.idle_sleeptime_seq)
+#endif
+};
 
 EXPORT_PER_CPU_SYMBOL(kstat);
 EXPORT_PER_CPU_SYMBOL(kernel_cpustat);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a5733789e0bd..4c00163b74b9 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -2,6 +2,7 @@
 /*
  * Simple CPU accounting cgroup controller
  */
+#include <linux/sched/clock.h>
 #include <linux/sched/cputime.h>
 #include <linux/tsacct_kern.h>
 #include "sched.h"
@@ -420,22 +421,155 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_NO_HZ_COMMON
-void kcpustat_dyntick_start(void)
+static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
-	if (!vtime_generic_enabled_this_cpu()) {
-		vtime_dyntick_start();
-		__this_cpu_write(kernel_cpustat.idle_dyntick, 1);
-	}
+	u64 *cpustat = kc->cpustat;
+	u64 delta;
+
+	if (!kc->idle_elapse)
+		return;
+
+	delta = now - kc->idle_entrytime;
+
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
+		cpustat[CPUTIME_IOWAIT] += delta;
+	else
+		cpustat[CPUTIME_IDLE] += delta;
+
+	kc->idle_entrytime = now;
+	kc->idle_elapse = false;
+	write_seqcount_end(&kc->idle_sleeptime_seq);
 }
 
-void kcpustat_dyntick_stop(void)
+static void kcpustat_idle_start(struct kernel_cpustat *kc, u64 now)
 {
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	kc->idle_entrytime = now;
+	kc->idle_elapse = true;
+	write_seqcount_end(&kc->idle_sleeptime_seq);
+}
+
+void kcpustat_dyntick_stop(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
 	if (!vtime_generic_enabled_this_cpu()) {
-		__this_cpu_write(kernel_cpustat.idle_dyntick, 0);
+		WARN_ON_ONCE(!kc->idle_dyntick);
+		kcpustat_idle_stop(kc, now);
+		kc->idle_dyntick = false;
 		vtime_dyntick_stop();
 		steal_account_process_time(ULONG_MAX);
 	}
 }
+
+void kcpustat_dyntick_start(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu()) {
+		vtime_dyntick_start();
+		kc->idle_dyntick = true;
+		kcpustat_idle_start(kc, now);
+	}
+}
+
+void kcpustat_irq_enter(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu())
+		kcpustat_idle_stop(kc, now);
+}
+
+void kcpustat_irq_exit(u64 now)
+{
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	if (!vtime_generic_enabled_this_cpu())
+		kcpustat_idle_start(kc, now);
+}
+
+static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
+				 bool compute_delta, u64 *last_update_time)
+{
+	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
+	u64 *cpustat = kc->cpustat;
+	unsigned int seq;
+	ktime_t now;
+	u64 idle;
+
+	now = ktime_get();
+	if (last_update_time)
+		*last_update_time = ktime_to_us(now);
+
+	if (vtime_generic_enabled_cpu(cpu)) {
+		idle = kcpustat_field(idx, cpu);
+		goto to_us;
+	}
+
+	do {
+		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
+
+		idle = cpustat[idx];
+		if (kc->idle_elapse && compute_delta && now > kc->idle_entrytime)
+			idle += (now - kc->idle_entrytime);
+	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
+
+to_us:
+	do_div(idle, NSEC_PER_USEC);
+
+	return idle;
+}
+
+/**
+ * get_cpu_idle_time_us - get the total idle time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative idle time (since boot) for a given
+ * CPU, in microseconds. Note that this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
+ */
+u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
+{
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
+				     !nr_iowait_cpu(cpu), last_update_time);
+}
+EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
+
+/**
+ * get_cpu_iowait_time_us - get the total iowait time of a CPU
+ * @cpu: CPU number to query
+ * @last_update_time: variable to store update time in. Do not update
+ * counters if NULL.
+ *
+ * Return the cumulative iowait time (since boot) for a given
+ * CPU, in microseconds. Note this is partially broken due to
+ * the counter of iowait tasks that can be remotely updated without
+ * any synchronization. Therefore it is possible to observe backward
+ * values within two consecutive reads.
+ *
+ * This time is measured via accounting rather than sampling,
+ * and is as accurate as ktime_get() is.
+ *
+ * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
+ */
+u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
+{
+	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
+				     nr_iowait_cpu(cpu), last_update_time);
+}
+EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
+
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cb235ec7d2d6..fa03cf7b3cec 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -749,126 +749,6 @@ static void tick_nohz_update_jiffies(ktime_t now)
 	touch_softlockup_watchdog_sched();
 }
 
-static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
-{
-	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	ktime_t delta;
-
-	if (vtime_generic_enabled_this_cpu())
-		return;
-
-	if (WARN_ON_ONCE(!tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)))
-		return;
-
-	delta = ktime_sub(now, ts->idle_entrytime);
-
-	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
-		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
-	else
-		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
-
-	ts->idle_entrytime = now;
-	tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
-	write_seqcount_end(&ts->idle_sleeptime_seq);
-
-	sched_clock_idle_wakeup_event();
-}
-
-static void tick_nohz_start_idle(struct tick_sched *ts)
-{
-	if (vtime_generic_enabled_this_cpu())
-		return;
-
-	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	ts->idle_entrytime = ktime_get();
-	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
-	write_seqcount_end(&ts->idle_sleeptime_seq);
-	sched_clock_idle_sleep_event();
-}
-
-static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
-				 bool compute_delta, u64 *last_update_time)
-{
-	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
-	ktime_t now, idle;
-	unsigned int seq;
-
-	now = ktime_get();
-	if (last_update_time)
-		*last_update_time = ktime_to_us(now);
-
-	if (vtime_generic_enabled_cpu(cpu)) {
-		idle = kcpustat_field(idx, cpu);
-		return ktime_to_us(idle);
-	}
-
-	do {
-		ktime_t delta = 0;
-
-		seq = read_seqcount_begin(&ts->idle_sleeptime_seq);
-
-		if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE) && compute_delta) {
-			if (now > ts->idle_entrytime)
-				delta = ktime_sub(now, ts->idle_entrytime);
-		}
-
-		idle = ktime_add(cpustat[idx], delta);
-	} while (read_seqcount_retry(&ts->idle_sleeptime_seq, seq));
-
-	return ktime_to_us(idle);
-
-}
-
-/**
- * get_cpu_idle_time_us - get the total idle time of a CPU
- * @cpu: CPU number to query
- * @last_update_time: variable to store update time in. Do not update
- * counters if NULL.
- *
- * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds. Note that this is partially broken due to
- * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
- *
- * This time is measured via accounting rather than sampling,
- * and is as accurate as ktime_get() is.
- *
- * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
- */
-u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
-{
-	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
-				     !nr_iowait_cpu(cpu), last_update_time);
-}
-EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
-
-/**
- * get_cpu_iowait_time_us - get the total iowait time of a CPU
- * @cpu: CPU number to query
- * @last_update_time: variable to store update time in. Do not update
- * counters if NULL.
- *
- * Return the cumulative iowait time (since boot) for a given
- * CPU, in microseconds. Note this is partially broken due to
- * the counter of iowait tasks that can be remotely updated without
- * any synchronization. Therefore it is possible to observe backward
- * values within two consecutive reads.
- *
- * This time is measured via accounting rather than sampling,
- * and is as accurate as ktime_get() is.
- *
- * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
- */
-u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
-{
-	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
-				     nr_iowait_cpu(cpu), last_update_time);
-}
-EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-
 /* Simplified variant of hrtimer_forward_now() */
 static ktime_t tick_forward_now(ktime_t expires, ktime_t now)
 {
@@ -1289,6 +1169,20 @@ void tick_nohz_idle_retain_tick(void)
 	tick_nohz_retain_tick(this_cpu_ptr(&tick_cpu_sched));
 }
 
+static void tick_nohz_clock_sleep(struct tick_sched *ts)
+{
+	tick_sched_flag_set(ts, TS_FLAG_IDLE_ACTIVE);
+	sched_clock_idle_sleep_event();
+}
+
+static void tick_nohz_clock_wakeup(struct tick_sched *ts)
+{
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
+		tick_sched_flag_clear(ts, TS_FLAG_IDLE_ACTIVE);
+		sched_clock_idle_wakeup_event();
+	}
+}
+
 /**
  * tick_nohz_idle_enter - prepare for entering idle on the current CPU
  *
@@ -1303,12 +1197,11 @@ void tick_nohz_idle_enter(void)
 	local_irq_disable();
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
-
 	WARN_ON_ONCE(ts->timer_expires_base);
-
 	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
-	kcpustat_dyntick_start();
-	tick_nohz_start_idle(ts);
+	ts->idle_entrytime = ktime_get();
+	kcpustat_dyntick_start(ts->idle_entrytime);
+	tick_nohz_clock_sleep(ts);
 
 	local_irq_enable();
 }
@@ -1336,10 +1229,13 @@ void tick_nohz_irq_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE))
-		tick_nohz_start_idle(ts);
-	else
+	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
+		ts->idle_entrytime = ktime_get();
+		kcpustat_irq_exit(ts->idle_entrytime);
+		tick_nohz_clock_sleep(ts);
+	} else {
 		tick_nohz_full_update_tick(ts);
+	}
 }
 
 /**
@@ -1484,11 +1380,11 @@ void tick_nohz_idle_exit(void)
 		now = ktime_get();
 
 	if (idle_active)
-		tick_nohz_stop_idle(ts, now);
+		tick_nohz_clock_wakeup(ts);
 
 	if (tick_stopped)
 		tick_nohz_idle_update_tick(ts, now);
-	kcpustat_dyntick_stop();
+	kcpustat_dyntick_stop(now);
 
 	local_irq_enable();
 }
@@ -1545,9 +1441,14 @@ static inline void tick_nohz_irq_enter(void)
 
 	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
 		return;
+
 	now = ktime_get();
-	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE))
-		tick_nohz_stop_idle(ts, now);
+
+	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
+		tick_nohz_clock_wakeup(ts);
+		kcpustat_irq_enter(now);
+	}
+
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
 	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
-- 
2.53.0

