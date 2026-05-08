Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FA3E274C;
	Fri,  8 May 2026 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246252; cv=none; b=KUDObska/Eo8NS+tYJEHkejxAbrAfTofOWf8/SnMadW+UDAlCYbbpdjKqdOqOlco1e1v8XSnUwR+15pIlGOo1mQeKxLI+rM9WVeI2eJRLoe3UAOfrghSqEXMX5Wzw5ySfQAP5NHb7G8zI3a/sBtty3zdlcnTy+QfJD/OSfVSu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246252; c=relaxed/simple;
	bh=DuIrzTdqfwYdjGcSnL/bgQqtrGTM3ykPIwoij6LiEs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc221+L+5dKg938X15XWJ9LkIlyjOpBoF7FJ3s7+D9A5m7nJLAtgfEBsraRvD7ikOqQ9KRxf9NCON7H1qqlJjiU76dglA5v5OrzaEZTjJk50B3EXFIBHGmzf1CGRQOWQfP39GQKFuJo+qtqVqEogncRQBSeSBquQTmuK+L9309g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1Xg8Xas; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1Xg8Xas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCCBC2BCB8;
	Fri,  8 May 2026 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246251;
	bh=DuIrzTdqfwYdjGcSnL/bgQqtrGTM3ykPIwoij6LiEs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1Xg8Xas7U7pZjqTsNluqtgPnrIyqHsgTonVSRQ8o3HYmfxVWjIIVIfNTL1SaQrUD
	 BgsappcmDyrHUhD2uaYYzpPqBxqXmpXEeV94p6jykhuk1r6TDaeFB4aZKwrumeu0ac
	 vDAiO6epvEoStnyXEEBCAeWvV+UIBWtGoMIJbsj6JK/v9mEHp23VTDpIZxSNzXsXsw
	 nF0xoa/I/hOHytyFrsDRrJ5qpTHJT5uGJvLwNkhSJCy+wJuwG8NkApACLs+l1kRDat
	 0pObi9UjDA+xOSOH4SxmzFH2s0zccm7PB7Mf5ckfaorFAujB9wbNxSLGaG4BPhDZQ7
	 3+ReX095trunA==
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
Subject: [PATCH 03/15] sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
Date: Fri,  8 May 2026 15:16:35 +0200
Message-ID: <20260508131647.43868-4-frederic@kernel.org>
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

The first parameter to kcpustat_field() is a pointer to the cpu kcpustat
to be fetched from. This parameter is error prone because a copy to a
kcpustat could be passed by accident instead of the original one. Also
the kcpustat structure can already be retrieved with the help of the
mandatory CPU argument.

Remove the needless parameter.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 6 +++---
 drivers/macintosh/rack-meter.c     | 2 +-
 include/linux/kernel_stat.h        | 8 +++-----
 kernel/rcu/tree.c                  | 9 +++------
 kernel/rcu/tree_stall.h            | 7 +++----
 kernel/sched/cputime.c             | 5 ++---
 6 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 86f35e451914..3c4a1f9af3ae 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -105,7 +105,7 @@ void gov_update_cpu_data(struct dbs_data *dbs_data)
 			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j, &j_cdbs->prev_update_time,
 								  dbs_data->io_is_busy);
 			if (dbs_data->ignore_nice_load)
-				j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+				j_cdbs->prev_cpu_nice = kcpustat_field(CPUTIME_NICE, j);
 		}
 	}
 }
@@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 		j_cdbs->prev_cpu_idle = cur_idle_time;
 
 		if (ignore_nice) {
-			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			u64 cur_nice = kcpustat_field(CPUTIME_NICE, j);
 
 			idle_time += div_u64(cur_nice - j_cdbs->prev_cpu_nice, NSEC_PER_USEC);
 			j_cdbs->prev_cpu_nice = cur_nice;
@@ -539,7 +539,7 @@ int cpufreq_dbs_governor_start(struct cpufreq_policy *policy)
 		j_cdbs->prev_load = 0;
 
 		if (ignore_nice)
-			j_cdbs->prev_cpu_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
+			j_cdbs->prev_cpu_nice = kcpustat_field(CPUTIME_NICE, j);
 	}
 
 	gov->start(policy);
diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index 8a1e2c08b096..26cb93191ede 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -87,7 +87,7 @@ static inline u64 get_cpu_idle_time(unsigned int cpu)
 		 kcpustat->cpustat[CPUTIME_IOWAIT];
 
 	if (rackmeter_ignore_nice)
-		retval += kcpustat_field(kcpustat, CPUTIME_NICE, cpu);
+		retval += kcpustat_field(CPUTIME_NICE, cpu);
 
 	return retval;
 }
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index b97ce2df376f..dd020ecaf67b 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -100,14 +100,12 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-			  enum cpu_usage_stat usage, int cpu);
+extern u64 kcpustat_field(enum cpu_usage_stat usage, int cpu);
 extern void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu);
 #else
-static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-				 enum cpu_usage_stat usage, int cpu)
+static inline u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	return kcpustat->cpustat[usage];
+	return kcpustat_cpu(cpu).cpustat[usage];
 }
 
 static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 55df6d37145e..3cbf79bee976 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -969,14 +969,11 @@ static int rcu_watching_snap_recheck(struct rcu_data *rdp)
 		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
 			int cpu = rdp->cpu;
 			struct rcu_snap_record *rsrp;
-			struct kernel_cpustat *kcsp;
-
-			kcsp = &kcpustat_cpu(cpu);
 
 			rsrp = &rdp->snap_record;
-			rsrp->cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
-			rsrp->cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
-			rsrp->cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+			rsrp->cputime_irq     = kcpustat_field(CPUTIME_IRQ, cpu);
+			rsrp->cputime_softirq = kcpustat_field(CPUTIME_SOFTIRQ, cpu);
+			rsrp->cputime_system  = kcpustat_field(CPUTIME_SYSTEM, cpu);
 			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(cpu) + arch_irq_stat_cpu(cpu);
 			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(cpu);
 			rsrp->nr_csw = nr_context_switches_cpu(cpu);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..cf7ae51cba40 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -479,7 +479,6 @@ static void print_cpu_stat_info(int cpu)
 {
 	struct rcu_snap_record rsr, *rsrp;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
 
 	if (!rcu_cpu_stall_cputime)
 		return;
@@ -488,9 +487,9 @@ static void print_cpu_stat_info(int cpu)
 	if (rsrp->gp_seq != rdp->gp_seq)
 		return;
 
-	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
-	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
-	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
+	rsr.cputime_irq     = kcpustat_field(CPUTIME_IRQ, cpu);
+	rsr.cputime_softirq = kcpustat_field(CPUTIME_SOFTIRQ, cpu);
+	rsr.cputime_system  = kcpustat_field(CPUTIME_SYSTEM, cpu);
 
 	pr_err("\t         hardirqs   softirqs   csw/system\n");
 	pr_err("\t number: %8lld %10d %12lld\n",
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index fbf31db0d2f3..caaaf0a04ced 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -975,10 +975,9 @@ static int kcpustat_field_vtime(u64 *cpustat,
 	return 0;
 }
 
-u64 kcpustat_field(struct kernel_cpustat *kcpustat,
-		   enum cpu_usage_stat usage, int cpu)
+u64 kcpustat_field(enum cpu_usage_stat usage, int cpu)
 {
-	u64 *cpustat = kcpustat->cpustat;
+	u64 *cpustat = kcpustat_cpu(cpu).cpustat;
 	u64 val = cpustat[usage];
 	struct rq *rq;
 	int err;
-- 
2.53.0

