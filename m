Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v5 1/8] perf: Add a flags parameter to pmu txn interfaces
Date: Thu, 13 Aug 2015 23:49:34 -0700
Message-Id: <1439534981-7937-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Currently, the PMU interface allows reading only one counter at a time.
But some PMUs like the 24x7 counters in Power, support reading several
counters at once. To leveage this functionality, extend the transaction
interface to support a "transaction type".

The first type, PERF_PMU_TXN_ADD, refers to the existing transactions,
i.e. used to _schedule_ all the events on the PMU as a group. A second
transaction type, PERF_PMU_TXN_READ, will be used in a follow-on patch,
by the 24x7 counters to read several counters at once.

Extend the transaction interfaces to the PMU to accept a 'txn_flags'
parameter and use this parameter to ignore any transactions that are
not of type PERF_PMU_TXN_ADD.

Thanks to Peter Zijlstra for his input.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

---
Changelog[v4]
	- [Peter Zijlstra] Fix an copy-paste error in power_pmu_cancel_txn().
	- [Peter Zijlstra] Use __this_cpu_read() and __this_cpu_write().

Changelog[v3]
	- [Peter Zijlstra] Ensure the nop_txn interfaces disable/enable
	  PMU only for TXN_ADD transactions.
	- [Peter Zijlstra] Cache the flags parameter in ->start_txn() and
	  drop the flags parameter from ->commit_txn() and ->cancel_txn().
---
 arch/powerpc/perf/core-book3s.c  |   25 ++++++++++++++++++++++++-
 arch/s390/kernel/perf_cpum_cf.c  |   24 +++++++++++++++++++++++-
 arch/sparc/kernel/perf_event.c   |   19 ++++++++++++++++++-
 arch/x86/kernel/cpu/perf_event.c |   27 +++++++++++++++++++++++++--
 arch/x86/kernel/cpu/perf_event.h |    1 +
 include/linux/perf_event.h       |   14 +++++++++++---
 kernel/events/core.c             |   31 ++++++++++++++++++++++++++++---
 7 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index d90893b..b18efe4 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -50,6 +50,7 @@ struct cpu_hw_events {
 
 	unsigned int group_flag;
 	int n_txn_start;
+	int txn_flags;
 
 	/* BHRB bits */
 	u64				bhrb_filter;	/* BHRB HW branch filter */
@@ -1586,11 +1587,19 @@ static void power_pmu_stop(struct perf_event *event, int ef_flags)
  * Start group events scheduling transaction
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
+ *
+ * We only support PERF_PMU_TXN_ADD transactions. Save the
+ * transaction flags but otherwise ignore non-PERF_PMU_TXN_ADD
+ * transactions.
  */
-static void power_pmu_start_txn(struct pmu *pmu)
+static void power_pmu_start_txn(struct pmu *pmu, int txn_flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	cpuhw->txn_flags = txn_flags;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	cpuhw->group_flag |= PERF_EVENT_TXN;
 	cpuhw->n_txn_start = cpuhw->n_events;
@@ -1604,6 +1613,12 @@ static void power_pmu_start_txn(struct pmu *pmu)
 static void power_pmu_cancel_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
+	int txn_flags;
+
+	txn_flags = cpuhw->txn_flags;
+	cpuhw->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
 
 	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
@@ -1618,10 +1633,18 @@ static int power_pmu_commit_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw;
 	long i, n;
+	int txn_flags;
 
 	if (!ppmu)
 		return -EAGAIN;
+
 	cpuhw = this_cpu_ptr(&cpu_hw_events);
+
+	txn_flags = cpuhw->txn_flags;
+	cpuhw->txn_flags = 0;
+	if (cpuhw->txn_flags & ~PERF_PMU_TXN_ADD)
+		return 0;
+
 	n = cpuhw->n_events;
 	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
 		return -EAGAIN;
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 56fdad4..a6f9e7b 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -72,6 +72,7 @@ struct cpu_hw_events {
 	atomic_t		ctr_set[CPUMF_CTR_SET_MAX];
 	u64			state, tx_state;
 	unsigned int		flags;
+	int			txn_flags;
 };
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.ctr_set = {
@@ -82,6 +83,7 @@ static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	},
 	.state = 0,
 	.flags = 0,
+	.txn_flags = 0,
 };
 
 static int get_counter_set(u64 event)
@@ -572,11 +574,19 @@ static void cpumf_pmu_del(struct perf_event *event, int flags)
 /*
  * Start group events scheduling transaction.
  * Set flags to perform a single test at commit time.
+ *
+ * We only support PERF_PMU_TXN_ADD transactions. Save the
+ * transaction flags but otherwise ignore non-PERF_PMU_TXN_ADD
+ * transactions.
  */
-static void cpumf_pmu_start_txn(struct pmu *pmu)
+static void cpumf_pmu_start_txn(struct pmu *pmu, int txn_flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	cpuhw->txn_flags = txn_flags;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	cpuhw->flags |= PERF_EVENT_TXN;
 	cpuhw->tx_state = cpuhw->state;
@@ -589,8 +599,14 @@ static void cpumf_pmu_start_txn(struct pmu *pmu)
  */
 static void cpumf_pmu_cancel_txn(struct pmu *pmu)
 {
+	int txn_flags;
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	txn_flags = cphw->txn_flags;
+	cpuhw->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	WARN_ON(cpuhw->tx_state != cpuhw->state);
 
 	cpuhw->flags &= ~PERF_EVENT_TXN;
@@ -604,9 +620,15 @@ static void cpumf_pmu_cancel_txn(struct pmu *pmu)
  */
 static int cpumf_pmu_commit_txn(struct pmu *pmu)
 {
+	int txn_flags;
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 	u64 state;
 
+	txn_flags = cpuhw->txn_flags;
+	cpuhw->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return 0;
+
 	/* check if the updated state can be scheduled */
 	state = cpuhw->state & ~((1 << CPUMF_LCCTL_ENABLE_SHIFT) - 1);
 	state >>= CPUMF_LCCTL_ENABLE_SHIFT;
diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 689db65..b5fcbce 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -109,6 +109,7 @@ struct cpu_hw_events {
 	int			enabled;
 
 	unsigned int		group_flag;
+	int			txn_flags;
 };
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = { .enabled = 1, };
 
@@ -1494,10 +1495,14 @@ static int sparc_pmu_event_init(struct perf_event *event)
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
  */
-static void sparc_pmu_start_txn(struct pmu *pmu)
+static void sparc_pmu_start_txn(struct pmu *pmu, int txn_flags)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	cpuhw->txn_flags = txn_flags;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	cpuhw->group_flag |= PERF_EVENT_TXN;
 }
@@ -1510,6 +1515,12 @@ static void sparc_pmu_start_txn(struct pmu *pmu)
 static void sparc_pmu_cancel_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
+	int txn_flags;
+
+	txn_flags = cpuhw->txn_flags;
+	cpuhw->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
 
 	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
@@ -1524,11 +1535,17 @@ static int sparc_pmu_commit_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int n;
+	int txn_flags;
 
 	if (!sparc_pmu)
 		return -EINVAL;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
+	txn_flags = cpuc->txn_flags;
+	cpuc->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return 0;
+
 	n = cpuc->n_events;
 	if (check_excludes(cpuc->event, 0, n))
 		return -EINVAL;
diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 9469dfa..6736997 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1748,9 +1748,19 @@ static inline void x86_pmu_read(struct perf_event *event)
  * Start group events scheduling transaction
  * Set the flag to make pmu::enable() not perform the
  * schedulability test, it will be performed at commit time
+ *
+ * We only support PERF_PMU_TXN_ADD transactions. Save the
+ * transaction flags but otherwise ignore non-PERF_PMU_TXN_ADD
+ * transactions.
  */
-static void x86_pmu_start_txn(struct pmu *pmu)
+static void x86_pmu_start_txn(struct pmu *pmu, int txn_flags)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->txn_flags = txn_flags;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 	__this_cpu_or(cpu_hw_events.group_flag, PERF_EVENT_TXN);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
@@ -1763,6 +1773,14 @@ static void x86_pmu_start_txn(struct pmu *pmu)
  */
 static void x86_pmu_cancel_txn(struct pmu *pmu)
 {
+	int txn_flags;
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	txn_flags = cpuc->txn_flags;
+	cpuc->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	__this_cpu_and(cpu_hw_events.group_flag, ~PERF_EVENT_TXN);
 	/*
 	 * Truncate collected array by the number of events added in this
@@ -1784,7 +1802,12 @@ static int x86_pmu_commit_txn(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int assign[X86_PMC_IDX_MAX];
-	int n, ret;
+	int n, ret, txn_flags;
+
+	txn_flags = cpuc->txn_flags;
+	cpuc->txn_flags = 0;
+	if (txn_flags & ~PERF_PMU_TXN_ADD)
+		return 0;
 
 	n = cpuc->n_events;
 
diff --git a/arch/x86/kernel/cpu/perf_event.h b/arch/x86/kernel/cpu/perf_event.h
index 3e7fd27..87b6bb7 100644
--- a/arch/x86/kernel/cpu/perf_event.h
+++ b/arch/x86/kernel/cpu/perf_event.h
@@ -197,6 +197,7 @@ struct cpu_hw_events {
 
 	unsigned int		group_flag;
 	int			is_fake;
+	int			txn_flags;
 
 	/*
 	 * Intel DebugStore bits
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2027809..44bf05f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -168,6 +168,8 @@ struct perf_event;
  */
 #define PERF_EVENT_TXN 0x1
 
+#define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
+
 /**
  * pmu::capabilities flags
  */
@@ -252,20 +254,26 @@ struct pmu {
 	 *
 	 * Start the transaction, after this ->add() doesn't need to
 	 * do schedulability tests.
+	 *
+	 * Optional.
 	 */
-	void (*start_txn)		(struct pmu *pmu); /* optional */
+	void (*start_txn)		(struct pmu *pmu, int txn_flags);
 	/*
 	 * If ->start_txn() disabled the ->add() schedulability test
 	 * then ->commit_txn() is required to perform one. On success
 	 * the transaction is closed. On error the transaction is kept
 	 * open until ->cancel_txn() is called.
+	 *
+	 * Optional.
 	 */
-	int  (*commit_txn)		(struct pmu *pmu); /* optional */
+	int  (*commit_txn)		(struct pmu *pmu);
 	/*
 	 * Will cancel the transaction, assumes ->del() is called
 	 * for each successful ->add() during the transaction.
+	 *
+	 * Optional.
 	 */
-	void (*cancel_txn)		(struct pmu *pmu); /* optional */
+	void (*cancel_txn)		(struct pmu *pmu);
 
 	/*
 	 * Will return the value for perf_event_mmap_page::index for this event,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d3dae34..4435bf5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1913,7 +1913,7 @@ group_sched_in(struct perf_event *group_event,
 	if (group_event->state == PERF_EVENT_STATE_OFF)
 		return 0;
 
-	pmu->start_txn(pmu);
+	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
 	if (event_sched_in(group_event, cpuctx, ctx)) {
 		pmu->cancel_txn(pmu);
@@ -7074,24 +7074,49 @@ static void perf_pmu_nop_void(struct pmu *pmu)
 {
 }
 
+static void perf_pmu_nop_txn(struct pmu *pmu, int flags)
+{
+}
+
 static int perf_pmu_nop_int(struct pmu *pmu)
 {
 	return 0;
 }
 
-static void perf_pmu_start_txn(struct pmu *pmu)
+DEFINE_PER_CPU(int, nop_txn_flags);
+
+static void perf_pmu_start_txn(struct pmu *pmu, int flags)
 {
+	__this_cpu_write(nop_txn_flags, flags);
+
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_disable(pmu);
 }
 
 static int perf_pmu_commit_txn(struct pmu *pmu)
 {
+	int flags = __this_cpu_read(nop_txn_flags);
+
+	__this_cpu_write(nop_txn_flags, 0);
+
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return 0;
+
 	perf_pmu_enable(pmu);
 	return 0;
 }
 
 static void perf_pmu_cancel_txn(struct pmu *pmu)
 {
+	int flags =  __this_cpu_read(nop_txn_flags);
+
+	__this_cpu_write(nop_txn_flags, 0);
+
+	if (flags & ~PERF_PMU_TXN_ADD)
+		return;
+
 	perf_pmu_enable(pmu);
 }
 
@@ -7330,7 +7355,7 @@ got_cpu_context:
 			pmu->commit_txn = perf_pmu_commit_txn;
 			pmu->cancel_txn = perf_pmu_cancel_txn;
 		} else {
-			pmu->start_txn  = perf_pmu_nop_void;
+			pmu->start_txn  = perf_pmu_nop_txn;
 			pmu->commit_txn = perf_pmu_nop_int;
 			pmu->cancel_txn = perf_pmu_nop_void;
 		}
-- 
1.7.9.5
