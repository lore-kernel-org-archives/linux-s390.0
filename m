Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2BA3ABD90;
	Thu, 15 Oct 2026 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053209; cv=none; b=OWPTyvgdUBmEvPV2MaZpt+zPa6AGSGRVlCkqsL0+FyjusVyknHMJOGuhBM42Q70MODXsq+ABsAn+8Rx/BKSHuzgz2JzawfoIE7+EorRXEZIK07OC1rvo+6tGtl1ZrUI3TLWPNrnfxw/BswjwFYaT9PjrQNkn0Uos/qlJUIQJqkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053209; c=relaxed/simple;
	bh=J0Rxn2Q2fOqFAHsyi54bdAjPM8D6Ka18TN/01+gu/Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnGkIzBY4blm7PCeQAd6spcY93E+iJeRcL4y0R6oPaSRpcH4yQQxW+VsqdFEvfpCakEfjZI0vHdm1YIjEVi0Py0g6vRPWYEbyZxNsG84LO4rc/TJhxjIT/6IFM5Kd1VGMmVDKvP7pVMMcC7+OjjxHpQlbAfY4bvpoLozc3YnemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FWEXT3aF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FWEXT3aF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C73D2F;
	Thu, 15 Oct 2026 01:33:23 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.88.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AEA93F871;
	Thu, 15 Oct 2026 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792053206; bh=J0Rxn2Q2fOqFAHsyi54bdAjPM8D6Ka18TN/01+gu/Ms=;
	h=From:To:Cc:Subject:Date:From;
	b=FWEXT3aFxAMtGC9f/OluSG+KqjijTyNIUE1qqaHIEQmDilQYtfi+kcMeN6PN1q8Na
	 HRuBlVVRqorOGgXk8eOaUEgKyO4rRVQtj0ebAOgMzENUm6dNDF+ISomBM3J4IA2mGq
	 6Icq7rjpiV6CZ4bvMz5R8/vmnifWoua7eyuOyw4Q=
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
	cocci@inria.fr,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] sched: Replace nr_iowait_cpu() with a bool accessor
Date: Thu, 15 Oct 2026 09:33:17 +0100
Message-Id: <20261015083317.3733733-1-christian.loehle@arm.com>
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
---
v2: Move the cocci excerpt to the commit message (Peter)


 arch/s390/kernel/idle.c    |  4 ++--
 include/linux/sched/stat.h |  2 +-
 kernel/sched/core.c        | 13 +++++--------
 kernel/sched/cputime.c     | 10 +++++-----
 4 files changed, 13 insertions(+), 16 deletions(-)

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
index 06bddaa738e5..1f84a950abed 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -431,7 +431,7 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 	if (!kc->idle_elapse)
 		return;
 
-	iowait = nr_iowait_cpu(smp_processor_id()) > 0;
+	iowait = cpu_has_iowait(smp_processor_id());
 	delta = now - kc->idle_entrytime;
 	steal = steal_account_process_time(delta);
 
@@ -544,14 +544,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
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
@@ -601,7 +601,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
-				     !nr_iowait_cpu(cpu), last_update_time);
+				     !cpu_has_iowait(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -625,7 +625,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
-				     nr_iowait_cpu(cpu), last_update_time);
+				     cpu_has_iowait(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
-- 
2.34.1

