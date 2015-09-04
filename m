Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [[PATCH v6 10/10] perf: Drop PERF_EVENT_TXN
Date: Thu,  3 Sep 2015 20:07:53 -0700
Message-Id: <1441336073-22750-11-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We currently use PERF_EVENT_TXN flag to determine if we are in the middle
of a transaction. If in a transaction, we defer the schedulability checks
from pmu->add() operation to the pmu->commit() operation.

Now that we have "transaction types" (PERF_PMU_TXN_ADD, PERF_PMU_TXN_READ)
we can use the type to determine if we are in a transaction and drop the
PERF_EVENT_TXN flag.

When PERF_EVENT_TXN is dropped, the cpuhw->group_flag on some architectures
becomes unused, so drop that field as well.

This is an extension of the Powerpc patch from Peter Zijlstra to s390,
Sparc and x86 architectures.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c  |    6 +-----
 arch/s390/kernel/perf_cpum_cf.c  |    5 +----
 arch/sparc/kernel/perf_event.c   |    6 +-----
 arch/x86/kernel/cpu/perf_event.c |    7 ++-----
 arch/x86/kernel/cpu/perf_event.h |    1 -
 include/linux/perf_event.h       |    2 --
 6 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a9e9a39..b699d19 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -48,7 +48,6 @@ struct cpu_hw_events {
 	unsigned long amasks[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
 	unsigned long avalues[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
 
-	unsigned int group_flag;
 	unsigned int txn_flags;
 	int n_txn_start;
 
@@ -1442,7 +1441,7 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 	 * skip the schedulability test here, it will be performed
 	 * at commit time(->commit_txn) as a whole
 	 */
-	if (cpuhw->group_flag & PERF_EVENT_TXN)
+	if (cpuhw->txn_flags & PERF_PMU_TXN_ADD)
 		goto nocheck;
 
 	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
@@ -1603,7 +1602,6 @@ static void power_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 		return;
 
 	perf_pmu_disable(pmu);
-	cpuhw->group_flag |= PERF_EVENT_TXN;
 	cpuhw->n_txn_start = cpuhw->n_events;
 }
 
@@ -1624,7 +1622,6 @@ static void power_pmu_cancel_txn(struct pmu *pmu)
 	if (txn_flags & ~PERF_PMU_TXN_ADD)
 		return;
 
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
 
@@ -1659,7 +1656,6 @@ static int power_pmu_commit_txn(struct pmu *pmu)
 	for (i = cpuhw->n_txn_start; i < n; ++i)
 		cpuhw->event[i]->hw.config = cpuhw->events[i];
 
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	cpuhw->txn_flags = 0;
 	perf_pmu_enable(pmu);
 	return 0;
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index dbcfd29..f50ef65 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -536,7 +536,7 @@ static int cpumf_pmu_add(struct perf_event *event, int flags)
 	 * For group events transaction, the authorization check is
 	 * done in cpumf_pmu_commit_txn().
 	 */
-	if (!(cpuhw->flags & PERF_EVENT_TXN))
+	if (!(cpuhw->txn_flags & PERF_PMU_TXN_ADD))
 		if (validate_ctr_auth(&event->hw))
 			return -EPERM;
 
@@ -590,7 +590,6 @@ static void cpumf_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 		return;
 
 	perf_pmu_disable(pmu);
-	cpuhw->flags |= PERF_EVENT_TXN;
 	cpuhw->tx_state = cpuhw->state;
 }
 
@@ -613,7 +612,6 @@ static void cpumf_pmu_cancel_txn(struct pmu *pmu)
 
 	WARN_ON(cpuhw->tx_state != cpuhw->state);
 
-	cpuhw->flags &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
 
@@ -640,7 +638,6 @@ static int cpumf_pmu_commit_txn(struct pmu *pmu)
 	if ((state & cpuhw->info.auth_ctl) != state)
 		return -EPERM;
 
-	cpuhw->flags &= ~PERF_EVENT_TXN;
 	cpuhw->txn_flags = 0;
 	perf_pmu_enable(pmu);
 	return 0;
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 2c0984d..b0da5ae 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -108,7 +108,6 @@ struct cpu_hw_events {
 	/* Enabled/disable state.  */
 	int			enabled;
 
-	unsigned int		group_flag;
 	unsigned int		txn_flags;
 };
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = { .enabled = 1, };
@@ -1380,7 +1379,7 @@ static int sparc_pmu_add(struct perf_event *event, int ef_flags)
 	 * skip the schedulability test here, it will be performed
 	 * at commit time(->commit_txn) as a whole
 	 */
-	if (cpuc->group_flag & PERF_EVENT_TXN)
+	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto nocheck;
 
 	if (check_excludes(cpuc->event, n0, 1))
@@ -1506,7 +1505,6 @@ static void sparc_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 		return;
 
 	perf_pmu_disable(pmu);
-	cpuhw->group_flag |= PERF_EVENT_TXN;
 }
 
 /*
@@ -1526,7 +1524,6 @@ static void sparc_pmu_cancel_txn(struct pmu *pmu)
 	if (txn_flags & ~PERF_PMU_TXN_ADD)
 		return;
 
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
 
@@ -1556,7 +1553,6 @@ static int sparc_pmu_commit_txn(struct pmu *pmu)
 	if (sparc_check_constraints(cpuc->event, cpuc->events, n))
 		return -EAGAIN;
 
-	cpuc->group_flag &= ~PERF_EVENT_TXN;
 	cpuc->txn_flags = 0;
 	perf_pmu_enable(pmu);
 	return 0;
diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index dc77ef4..4562cf0 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1175,7 +1175,7 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	 * skip the schedulability test here, it will be performed
 	 * at commit time (->commit_txn) as a whole.
 	 */
-	if (cpuc->group_flag & PERF_EVENT_TXN)
+	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto done_collect;
 
 	ret = x86_pmu.schedule_events(cpuc, n, assign);
@@ -1326,7 +1326,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	 * XXX assumes any ->del() called during a TXN will only be on
 	 * an event added during that same TXN.
 	 */
-	if (cpuc->group_flag & PERF_EVENT_TXN)
+	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		return;
 
 	/*
@@ -1764,7 +1764,6 @@ static void x86_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 		return;
 
 	perf_pmu_disable(pmu);
-	__this_cpu_or(cpu_hw_events.group_flag, PERF_EVENT_TXN);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
 }
 
@@ -1785,7 +1784,6 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 	if (txn_flags & ~PERF_PMU_TXN_ADD)
 		return;
 
-	__this_cpu_and(cpu_hw_events.group_flag, ~PERF_EVENT_TXN);
 	/*
 	 * Truncate collected array by the number of events added in this
 	 * transaction. See x86_pmu_add() and x86_pmu_*_txn().
@@ -1830,7 +1828,6 @@ static int x86_pmu_commit_txn(struct pmu *pmu)
 	 */
 	memcpy(cpuc->assign, assign, n*sizeof(int));
 
-	cpuc->group_flag &= ~PERF_EVENT_TXN;
 	cpuc->txn_flags = 0;
 	perf_pmu_enable(pmu);
 	return 0;
diff --git a/arch/x86/kernel/cpu/perf_event.h b/arch/x86/kernel/cpu/perf_event.h
index c99c93b..953a0e4 100644
--- a/arch/x86/kernel/cpu/perf_event.h
+++ b/arch/x86/kernel/cpu/perf_event.h
@@ -195,7 +195,6 @@ struct cpu_hw_events {
 
 	int			n_excl; /* the number of exclusive events */
 
-	unsigned int		group_flag;
 	unsigned int		txn_flags;
 	int			is_fake;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b3435e7..8d204d3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -166,8 +166,6 @@ struct perf_event;
 /*
  * Common implementation detail of pmu::{start,commit,cancel}_txn
  */
-#define PERF_EVENT_TXN 0x1
-
 #define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
 #define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
 
-- 
1.7.9.5
