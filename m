Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
Subject: [PATCH 1/3] sched: Support for CPU runtime and SMT based adaption
Date: Fri, 30 Jan 2015 15:02:40 +0100
Message-Id: <1422626562-6966-2-git-send-email-phacht@linux.vnet.ibm.com>
In-Reply-To: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
References: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Philipp Hachtmann <phacht@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On virtualized systems like s390 the CPU runtimes used for the
scheduler's calculations must be adapted to correctly represent real cpu
working time instead of slices of wall time.
Furthermore this real cpu runtime may have to be further adapted on SMT
CPUs depending on the number of threads (Linux: CPUs) being active in
the same core.

This patch changes some calls to sched_clock_cpu into calls to cpu_exec_time.
cpu_exec_time is defined as sched_clock_cpu by default but can be overridden
by architecture code to provide precise CPU runtime timestamps.

One might think that it would be better to override the weak symbol sched_clock
instead of adding something new. This seems to be impossible because
sched_clock is used by other facilities (like printk timestamping) which assume
it to deliver wall time instead of some pure virtual time stamp which differs
from CPU to CPU.

The second hook is a call to an architecture function scale_rq_clock_delta
which additionally scales the calculated delta by an SMT based factor.

Signed-off-by: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
---
 kernel/sched/core.c  | 4 +++-
 kernel/sched/fair.c  | 8 ++++----
 kernel/sched/sched.h | 8 ++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 89e7283..c611055 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -122,9 +122,11 @@ void update_rq_clock(struct rq *rq)
 	if (rq->skip_clock_update > 0)
 		return;
 
-	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
+	delta = cpu_exec_time(cpu_of(rq)) - rq->clock;
 	if (delta < 0)
 		return;
+
+	scale_rq_clock_delta(&delta);
 	rq->clock += delta;
 	update_rq_clock_task(rq, delta);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef2b104..4921d1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3180,7 +3180,7 @@ static inline u64 sched_cfs_bandwidth_slice(void)
 
 /*
  * Replenish runtime according to assigned quota and update expiration time.
- * We use sched_clock_cpu directly instead of rq->clock to avoid adding
+ * We use cpu_exec_time directly instead of rq->clock to avoid adding
  * additional synchronization around rq->lock.
  *
  * requires cfs_b->lock
@@ -3192,7 +3192,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	if (cfs_b->quota == RUNTIME_INF)
 		return;
 
-	now = sched_clock_cpu(smp_processor_id());
+	now = cpu_exec_time(smp_processor_id());
 	cfs_b->runtime = cfs_b->quota;
 	cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
 }
@@ -6969,13 +6969,13 @@ static int idle_balance(struct rq *this_rq)
 		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			t0 = sched_clock_cpu(this_cpu);
+			t0 = cpu_exec_time(this_cpu);
 
 			pulled_task = load_balance(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
 
-			domain_cost = sched_clock_cpu(this_cpu) - t0;
+			domain_cost = cpu_exec_time(this_cpu) - t0;
 			if (domain_cost > sd->max_newidle_lb_cost)
 				sd->max_newidle_lb_cost = domain_cost;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2df8ef0..720664f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1569,3 +1569,11 @@ static inline u64 irq_time_read(int cpu)
 }
 #endif /* CONFIG_64BIT */
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
+
+#ifndef cpu_exec_time
+#define cpu_exec_time sched_clock_cpu
+#endif
+
+#ifndef scale_rq_clock_delta
+#define scale_rq_clock_delta(arg)
+#endif
-- 
2.1.4
