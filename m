Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC03233F4;
	Fri,  8 May 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246335; cv=none; b=mPkB4sTmy59ZXVn4Vl8STxU3vI+jWsUOKLBqrqk81shaM3PpE7oZNJ6lrpXISRml+2SwykGwxMDHG5vIb8v5q+AAMfmj6v0JO8Z0iakdpWhb/RTWUTftFyZT+vwXkvrIhDZqTur6ESvTiBpgoBJ2FW/dwlPHvF6sFICDgA0trWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246335; c=relaxed/simple;
	bh=hXs18NJo22xkFsprdONWIHdxUtUkDl4cfFzzNgNwNGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnDAxMpzl8zYDq0u0ukdytgi0ywJWkDPbMiK/TTYeaetEX3A2ZuRswwhQYy62q4MEQIn1JEJIxUPGUVdt3igTPeFMSNq09DNCZucOf7Qe81db2xGL0ZU68RuE1+qvw5OTv/D8qyRkw9c4Bi36FsX5+KgISv6Z1D7ucQhIOlKVOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC7lVjxq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC7lVjxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B95C2BCB0;
	Fri,  8 May 2026 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246335;
	bh=hXs18NJo22xkFsprdONWIHdxUtUkDl4cfFzzNgNwNGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pC7lVjxqNLRLdL/yZEx87pMBKsRgg1BBrueRkNfuR1JQWrR1QGTqH193si0q7sge6
	 7dxCbeAvLLLCPvT4DoeWDL6YIhyVrfDbi7foikJJb2MoQ89M9D5v8GSD4Dn/Z5E9GF
	 Fv2mZ61cg7vq01cDiBnqhg9p8eAHv6oG0109Kpdsd0A4pcu+o/v1u/9k7GYrYwpuOT
	 /uM6EY6hzViGh3Nyp6jNlHKUcMlX80UHQ9iu89joguve2slA2YPe9l8VLM14ZuX1MP
	 XwgkBf4Tqjv73yQU1Zn3QtALvZALUFUrizKh9xNxhw8nLbXc8JvDGvMMjItHTfPpIR
	 MHN8es6mrmxTg==
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
Subject: [PATCH 13/15] sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
Date: Fri,  8 May 2026 15:16:45 +0200
Message-ID: <20260508131647.43868-14-frederic@kernel.org>
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

The last reason why get_cpu_idle/iowait_time_us() may return -1 now is
if the config doesn't support nohz.

The ad-hoc replacement solution by cpufreq is to compute jiffies minus
the whole busy cputime. Although the intention should provide a coherent
low resolution estimation of the idle and iowait time, the
implementation is buggy because jiffies don't start at 0.

Just provide instead a real get_cpu_[idle|iowait]_time_us() offcase.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/cpufreq/cpufreq.c   | 29 +----------------------------
 include/linux/kernel_stat.h |  3 +++
 include/linux/tick.h        |  4 ----
 kernel/sched/cputime.c      | 12 +++++++++---
 4 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1..dda0d34d3c02 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -130,38 +130,11 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
-static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
-{
-	struct kernel_cpustat kcpustat;
-	u64 cur_wall_time;
-	u64 idle_time;
-	u64 busy_time;
-
-	cur_wall_time = jiffies64_to_nsecs(get_jiffies_64());
-
-	kcpustat_cpu_fetch(&kcpustat, cpu);
-
-	busy_time = kcpustat.cpustat[CPUTIME_USER];
-	busy_time += kcpustat.cpustat[CPUTIME_SYSTEM];
-	busy_time += kcpustat.cpustat[CPUTIME_IRQ];
-	busy_time += kcpustat.cpustat[CPUTIME_SOFTIRQ];
-	busy_time += kcpustat.cpustat[CPUTIME_STEAL];
-	busy_time += kcpustat.cpustat[CPUTIME_NICE];
-
-	idle_time = cur_wall_time - busy_time;
-	if (wall)
-		*wall = div_u64(cur_wall_time, NSEC_PER_USEC);
-
-	return div_u64(idle_time, NSEC_PER_USEC);
-}
-
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
 {
 	u64 idle_time = get_cpu_idle_time_us(cpu, io_busy ? wall : NULL);
 
-	if (idle_time == -1ULL)
-		return get_cpu_idle_time_jiffy(cpu, wall);
-	else if (!io_busy)
+	if (!io_busy)
 		idle_time += get_cpu_iowait_time_us(cpu, wall);
 
 	return idle_time;
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 3680519d7b2c..512104b0ff49 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -133,6 +133,9 @@ static inline bool kcpustat_idle_dyntick(void)
 }
 #endif /* CONFIG_NO_HZ_COMMON */
 
+extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
+extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
+
 /* Fetch cputime values when vtime is disabled on a CPU */
 static inline u64 kcpustat_field_default(enum cpu_usage_stat usage, int cpu)
 {
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577..1cf4651f09ad 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,8 +139,6 @@ extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
-extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
-extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline bool tick_nohz_is_active(void) { return false; }
@@ -162,8 +160,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 	*delta_next = TICK_NSEC;
 	return *delta_next;
 }
-static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
-static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 /*
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index c91fd67f93ea..335d2c127763 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -522,6 +522,13 @@ u64 kcpustat_field_iowait(int cpu)
 				      nr_iowait_cpu(cpu), ktime_get());
 }
 EXPORT_SYMBOL_GPL(kcpustat_field_iowait);
+#else
+static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
+				  bool compute_delta, ktime_t now)
+{
+	return kcpustat_cpu(cpu).cpustat[idx];
+}
+#endif /* CONFIG_NO_HZ_COMMON */
 
 static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 				 bool compute_delta, u64 *last_update_time)
@@ -557,7 +564,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if generic vtime is enabled, else total idle time of the @cpu
+ * Return: total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -581,7 +588,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * Return: -1 if generic vtime is enabled, else total iowait time of @cpu
+ * Return: total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
@@ -589,7 +596,6 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
-#endif /* CONFIG_NO_HZ_COMMON */
 
 /*
  * Use precise platform statistics if available:
-- 
2.53.0

