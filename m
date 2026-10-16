Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A63815F3;
	Fri, 16 Oct 2026 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136043; cv=none; b=cZj3efJ5znuScMJLhlQr9vf/Rf6qI5iDsT/uXQS64d0QpOnI9NQEEAkqfKjM/qAEP0CioB9b8LvhXporEXskI2qJHB5cDYkGXt4o0I3vwpA9PDAqi6gajIZEFKKsRxF4HlOrqcXv9d4Afsk+GvsNjlpBqhYHhXTzvtikHjbPNMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136043; c=relaxed/simple;
	bh=6msiKErk0LHa6GMnJywjOPC5MhU1OSDvhpH63EfbynI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZsEPrea8lXnwYwtfb4W5zoE5AORQqEVoWLMIA22dMGegCvP0g9mneMDFqJ+wZ8yGdDL0ypfGpiWjNhPUPNE3pIssz36uItrZ4Fy0syTi5oPEnZPpY+0EWhth+YKeFFI1ACv939o8iNrhffQ1p1l09QtPLEDMl1cLwI7TUfDbCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fua9vejN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fua9vejN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9188014BF;
	Fri, 16 Oct 2026 00:33:50 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.84.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E38003F673;
	Fri, 16 Oct 2026 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792136033; bh=6msiKErk0LHa6GMnJywjOPC5MhU1OSDvhpH63EfbynI=;
	h=From:To:Cc:Subject:Date:From;
	b=Fua9vejNdTAwVxVcDvwRF688BpX829Ur6+DxJQ9TK+KBGRo6tAmnZndzm8kQutkiV
	 +IaTMj2EGUsWkhDR2aEy9oYO19ovHb5W9LmCiH7GGSqPzkUsiZUFmPJnU6RvhsLBjR
	 OnH2bw+MeZTu+gu5LtFTkhm/viZhaspseqdL4Ook=
From: Christian Loehle <christian.loehle@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: [PATCHv3] sched: Replace nr_iowait_cpu() with a bool accessor
Date: Fri, 16 Oct 2026 08:33:40 +0100
Message-Id: <20261016073341.575472-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The menu governor was the last consumer of the per-CPU I/O-wait count
that needed its magnitude, apart from nr_iowait() summing it globally.
Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
that use. All remaining per-CPU consumers only test for zero/nonzero.

Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
and s390 idle accounting callers. Have nr_iowait() read the counters
directly so that the global total and existing accounting are preserved.
Replace the stale menu comment with a description of the predicate.
Also convert the remaining open-coded idle accounting checks to use the
predicate, as suggested by Prateek.

The conversion was done with coccinelle:

@ predicate depends on patch @
expression cpu;
@@

- nr_iowait_cpu(cpu) > 0
+ cpu_has_iowait(cpu)

@ callers depends on patch @
expression cpu;
@@

- nr_iowait_cpu(cpu)
+ cpu_has_iowait(cpu)

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v3:
- Also convert open-coded users (Thanks K Prateek!)
- pick up tags

 arch/s390/kernel/idle.c    |  4 ++--
 include/linux/sched/stat.h |  2 +-
 kernel/sched/core.c        | 13 +++++--------
 kernel/sched/cputime.c     | 20 +++++++++-----------
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index dd12efb58201..ff9732ef494c 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -82,13 +82,13 @@ static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_del
 
 u64 arch_kcpustat_field_idle(int cpu)
 {
-	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
+	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !cpu_has_iowait(cpu));
 }
 EXPORT_SYMBOL_GPL(arch_kcpustat_field_idle);
 
 u64 arch_kcpustat_field_iowait(int cpu)
 {
-	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
+	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, cpu_has_iowait(cpu));
 }
 EXPORT_SYMBOL_GPL(arch_kcpustat_field_iowait);
 
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 0108a38bb64d..4810b14d0372 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -20,7 +20,7 @@ extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
 extern unsigned int nr_iowait(void);
-extern unsigned int nr_iowait_cpu(int cpu);
+extern bool cpu_has_iowait(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1fe40de6ebe3..1bde5187dafd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5588,15 +5588,12 @@ unsigned long long nr_context_switches(void)
 }
 
 /*
- * Consumers of these two interfaces, like for example the cpuidle menu
- * governor, are using nonsensical data. Preferring shallow idle state selection
- * for a CPU that has IO-wait which might not even end up running the task when
- * it does become runnable.
+ * Return whether any tasks are accounted as I/O waiters on this CPU.
+ * They may wake up on a different CPU.
  */
-
-unsigned int nr_iowait_cpu(int cpu)
+bool cpu_has_iowait(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	return atomic_read(&cpu_rq(cpu)->nr_iowait) != 0;
 }
 
 /*
@@ -5634,7 +5631,7 @@ unsigned int nr_iowait(void)
 	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
-		sum += nr_iowait_cpu(i);
+		sum += atomic_read(&cpu_rq(i)->nr_iowait);
 
 	return sum;
 }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 06bddaa738e5..b79a44b6f57d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -226,9 +226,8 @@ void account_steal_time(u64 cputime)
 void account_idle_time(u64 cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (cpu_has_iowait(smp_processor_id()))
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
@@ -431,7 +430,7 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 	if (!kc->idle_elapse)
 		return;
 
-	iowait = nr_iowait_cpu(smp_processor_id()) > 0;
+	iowait = cpu_has_iowait(smp_processor_id());
 	delta = now - kc->idle_entrytime;
 	steal = steal_account_process_time(delta);
 
@@ -544,14 +543,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 u64 kcpustat_field_idle(int cpu)
 {
 	return kcpustat_field_dyntick(cpu, CPUTIME_IDLE,
-				      !nr_iowait_cpu(cpu), ktime_get());
+				      !cpu_has_iowait(cpu), ktime_get());
 }
 EXPORT_SYMBOL_GPL(kcpustat_field_idle);
 
 u64 kcpustat_field_iowait(int cpu)
 {
 	return kcpustat_field_dyntick(cpu, CPUTIME_IOWAIT,
-				      nr_iowait_cpu(cpu), ktime_get());
+				      cpu_has_iowait(cpu), ktime_get());
 }
 EXPORT_SYMBOL_GPL(kcpustat_field_iowait);
 #else
@@ -601,7 +600,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
-				     !nr_iowait_cpu(cpu), last_update_time);
+				     !cpu_has_iowait(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -625,7 +624,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
-				     nr_iowait_cpu(cpu), last_update_time);
+				     cpu_has_iowait(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
@@ -1109,7 +1108,6 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				int cpu, u64 *val)
 {
 	struct vtime *vtime = &tsk->vtime;
-	struct rq *rq = cpu_rq(cpu);
 	unsigned int seq;
 
 	do {
@@ -1152,11 +1150,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		case CPUTIME_IDLE:
-			if (state == VTIME_IDLE && !atomic_read(&rq->nr_iowait))
+			if (state == VTIME_IDLE && !cpu_has_iowait(cpu))
 				*val += vtime_delta(vtime);
 			break;
 		case CPUTIME_IOWAIT:
-			if (state == VTIME_IDLE && atomic_read(&rq->nr_iowait) > 0)
+			if (state == VTIME_IDLE && cpu_has_iowait(cpu))
 				*val += vtime_delta(vtime);
 			break;
 		default:
@@ -1251,7 +1249,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 			}
 			break;
 		case VTIME_IDLE:
-			if (atomic_read(&cpu_rq(cpu)->nr_iowait) > 0)
+			if (cpu_has_iowait(cpu))
 				cpustat[CPUTIME_IOWAIT] += delta;
 			else
 				cpustat[CPUTIME_IDLE] += delta;
-- 
2.34.1

