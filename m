Return-Path: <peterz@infradead.org>
Date: Tue, 1 Sep 2015 12:38:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/8] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150901103859.GP19282@twins.programming.kicks-ass.net>
References: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1439534981-7937-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439534981-7937-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 13, 2015 at 11:49:34PM -0700, Sukadev Bhattiprolu wrote:

I'm ever so sorry I keep going on about this, but..

> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index d90893b..b18efe4 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -50,6 +50,7 @@ struct cpu_hw_events {
>  
>  	unsigned int group_flag;
>  	int n_txn_start;
> +	int txn_flags;
>  
>  	/* BHRB bits */
>  	u64				bhrb_filter;	/* BHRB HW branch filter */
> @@ -1586,11 +1587,19 @@ static void power_pmu_stop(struct perf_event *event, int ef_flags)
>   * Start group events scheduling transaction
>   * Set the flag to make pmu::enable() not perform the
>   * schedulability test, it will be performed at commit time
> + *
> + * We only support PERF_PMU_TXN_ADD transactions. Save the
> + * transaction flags but otherwise ignore non-PERF_PMU_TXN_ADD
> + * transactions.
>   */
> -static void power_pmu_start_txn(struct pmu *pmu)
> +static void power_pmu_start_txn(struct pmu *pmu, int txn_flags)
>  {
>  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
>  
> +	cpuhw->txn_flags = txn_flags;
> +	if (txn_flags & ~PERF_PMU_TXN_ADD)
> +		return;
> +
>  	perf_pmu_disable(pmu);
>  	cpuhw->group_flag |= PERF_EVENT_TXN;
>  	cpuhw->n_txn_start = cpuhw->n_events;
> @@ -1604,6 +1613,12 @@ static void power_pmu_start_txn(struct pmu *pmu)
>  static void power_pmu_cancel_txn(struct pmu *pmu)
>  {
>  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
> +	int txn_flags;
> +
> +	txn_flags = cpuhw->txn_flags;
> +	cpuhw->txn_flags = 0;
> +	if (txn_flags & ~PERF_PMU_TXN_ADD)
> +		return;
>  
>  	cpuhw->group_flag &= ~PERF_EVENT_TXN;
>  	perf_pmu_enable(pmu);
> @@ -1618,10 +1633,18 @@ static int power_pmu_commit_txn(struct pmu *pmu)
>  {
>  	struct cpu_hw_events *cpuhw;
>  	long i, n;
> +	int txn_flags;
>  
>  	if (!ppmu)
>  		return -EAGAIN;
> +
>  	cpuhw = this_cpu_ptr(&cpu_hw_events);
> +
> +	txn_flags = cpuhw->txn_flags;
> +	cpuhw->txn_flags = 0;
> +	if (cpuhw->txn_flags & ~PERF_PMU_TXN_ADD)
> +		return 0;
> +
>  	n = cpuhw->n_events;
>  	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
>  		return -EAGAIN;


when looking at this (I almost pressed A for apply) it occurred to me
that we now keep double state, cpuhw->txn_flags and cpuhw->group_flag
are basically the same thing.

Would not something like the below avoid this duplication?

--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -48,9 +48,8 @@ struct cpu_hw_events {
 	unsigned long amasks[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
 	unsigned long avalues[MAX_HWEVENTS][MAX_EVENT_ALTERNATIVES];
 
-	unsigned int group_flag;
+	unsigned int txn_flags;
 	int n_txn_start;
-	int txn_flags;
 
 	/* BHRB bits */
 	u64				bhrb_filter;	/* BHRB HW branch filter */
@@ -1442,7 +1441,7 @@ static int power_pmu_add(struct perf_eve
 	 * skip the schedulability test here, it will be performed
 	 * at commit time(->commit_txn) as a whole
 	 */
-	if (cpuhw->group_flag & PERF_EVENT_TXN)
+	if (cpuhw->txn_flags & PERF_PMU_TXN_ADD)
 		goto nocheck;
 
 	if (check_excludes(cpuhw->event, cpuhw->flags, n0, 1))
@@ -1596,12 +1595,12 @@ static void power_pmu_start_txn(struct p
 {
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 
+	WARN_ON_ONCE(cpuhw->txn_flags); /* already txn in flight */
 	cpuhw->txn_flags = txn_flags;
 	if (txn_flags & ~PERF_PMU_TXN_ADD)
 		return;
 
 	perf_pmu_disable(pmu);
-	cpuhw->group_flag |= PERF_EVENT_TXN;
 	cpuhw->n_txn_start = cpuhw->n_events;
 }
 
@@ -1615,12 +1614,12 @@ static void power_pmu_cancel_txn(struct
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 	int txn_flags;
 
+	WARN_ON_ONCE(!cpuhw->txn_flags); /* no txn in flight */
 	txn_flags = cpuhw->txn_flags;
 	cpuhw->txn_flags = 0;
 	if (txn_flags & ~PERF_PMU_TXN_ADD)
 		return;
 
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
 	perf_pmu_enable(pmu);
 }
 
@@ -1633,17 +1632,17 @@ static int power_pmu_commit_txn(struct p
 {
 	struct cpu_hw_events *cpuhw;
 	long i, n;
-	int txn_flags;
 
 	if (!ppmu)
 		return -EAGAIN;
 
 	cpuhw = this_cpu_ptr(&cpu_hw_events);
 
-	txn_flags = cpuhw->txn_flags;
-	cpuhw->txn_flags = 0;
-	if (cpuhw->txn_flags & ~PERF_PMU_TXN_ADD)
+	WARN_ON_ONCE(!cpuhw->txn_flags); /* no txn in flight */
+	if (cpuhw->txn_flags & ~PERF_PMU_TXN_ADD) {
+		cpuhw->txn_flags = 0;
 		return 0;
+	}
 
 	n = cpuhw->n_events;
 	if (check_excludes(cpuhw->event, cpuhw->flags, 0, n))
@@ -1655,7 +1654,7 @@ static int power_pmu_commit_txn(struct p
 	for (i = cpuhw->n_txn_start; i < n; ++i)
 		cpuhw->event[i]->hw.config = cpuhw->events[i];
 
-	cpuhw->group_flag &= ~PERF_EVENT_TXN;
+	cpuhw->txn_flags = 0;
 	perf_pmu_enable(pmu);
 	return 0;
 }
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -199,9 +199,7 @@ struct perf_event;
 /*
  * Common implementation detail of pmu::{start,commit,cancel}_txn
  */
-#define PERF_EVENT_TXN 0x1
-
-#define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
+#define PERF_PMU_TXN_ADD	0x1	/* txn to add/schedule event on PMU */
 
 /**
  * pmu::capabilities flags
