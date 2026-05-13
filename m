Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3D2E7F39;
	Wed, 13 May 2026 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680910; cv=none; b=gno51gefn1Cs5x8UuJ59KWjFYQ0KsnzKrv5gzk3yEM30VKRhOZwbiVmH5rPYVt5eBTKmNunItImv4NAClZYh1EsZURVFhztCwmhYrTwbGBIS8NLkjOyiCuZaOeTmooyi7HuXTDj0KN/2vht7ivWUGUKR1Q1wfo6Fa1E6IcAlc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680910; c=relaxed/simple;
	bh=jmzUAJhTdNLAcjYIw55ApWvTq1PTY1XL3KRphT/DNpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsE+T0E7ezbLYu3RTJBljI7ornsUCtbSgTkaK1FWuVUcCw5rINLkhAcWwP7dBeLMmMVp9HEYots3gVToSBNKNMDAk+OBA7yKel8U3PVLRqk5czGBQM1sZ8AWa9FmMxbeDU/z4QTd8Z/XzWRxpjLDt4p3ckbLzXe3kLAOHuLWttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mPBRBBQJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mPBRBBQJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D2PWfe2611671;
	Wed, 13 May 2026 14:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LVberzqGTMy13qsxI
	tc+EEWpusk+1pNolhx5oS7oYY0=; b=mPBRBBQJSmo/b6JkmPAb6h3aI5jHI/OeU
	DlQ8iCP7EXHXUT4jYChbqXbKWBs6Im//sc8xRlO+quQG3r6JYOhzYbUl7Rrge+pL
	FsYaFx4UNOyUJlV05+3nEkg89xZa2kKffZNk5kpYVsX3t1XwIk/1Fj8Arg1W0pXR
	xPx57GlgUfiSs6MxNO3Wigk5b8pENDnGR2q6t5qYAw2piIzSAWG3J+/swX6Gb/Ak
	mxadRmCmvsqwVeGczcWDVV2Y7IUf+/UWgZ16VeqR+RrkpKKCXbAu9uNeGzuI+jYu
	+iyiD1nKRYz/RulgVMHUXEnkEVxDTLkgnYgBnax15m+MQpOSV9Bwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nve01n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DDsSsb021120;
	Wed, 13 May 2026 14:01:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgr20u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:01:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DE1UZj47710602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 14:01:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B9320040;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87E3E20043;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 14:01:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/4] s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()
Date: Wed, 13 May 2026 16:01:28 +0200
Message-ID: <20260513140129.4100822-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513140129.4100822-1-hca@linux.ibm.com>
References: <20260513140129.4100822-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a04843f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=ddtSMzlKRWPsOFDQFE8A:9
X-Proofpoint-GUID: BDx2FjSo-ulyNhhupuzi2rBM__fztMVU
X-Proofpoint-ORIG-GUID: BDx2FjSo-ulyNhhupuzi2rBM__fztMVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MCBTYWx0ZWRfXy6m9ZOxI5u+Y
 xMbe0kzmyrQIKZ+nwt9qSmLF35tGDIMWS3Ol3Qb8nS/Sp5+OZBccJnUyIwOeGJ8QhZ8IZThmcp6
 LxVacEw9RfJQwPb6AWAXI5W4U+UxvfvVGswAAcaEu06v0N5OUtgOFzQ0JkSZxUjHZcbpqzCrFN5
 zTFwwAHVNa0J7j20arL8KTG8jyRrhjUi8pzlO2vGJFivVS8/aYp5eGsLHl/GJtO/idLAzdZ+SUG
 s0MgIxShnlFCUc+rWMScepBPeEPTfGzaPTqll6cKOEE4i3LWePXzWHBPmCW6kt2PywAkNjM+UeA
 WVesyTFyCLMAAinviKB7YJ/RVzF6xh4rXKy8zRaz240j+w3xNteRBou6l5lwXs9AnIAsXvpgdy4
 L0T9D1b6e8ithYz1Sj08yKGzo3D2ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130140

The former s390 specific arch_cpu_idle_time() implementation was
removed, since its implementation was racy and reported idle time
could go backwards [1].

However this removal was not necessary, since independently of the s390
architecture specific races there exists the iowait counter update race,
which can also lead to reported idle time going backwards [2].

With Frederic Weisbecker's recent cpu idle time accounting refactoring
kernel_cpustat got a sequence counter. Use this to implement s390 specific
variants of kcpustat_field_idle() and kcpustat_field_iowait(). This is
logically a revert of [1] and moves cpu idle time accounting back into s390
architecture code, which is also more precise than the dyntick idle time
accounting by nohz/scheduler.

For comparing cross cpu time stamps it is necessary to use the stcke
instead of the stckf instruction in irq entry path. Furthermore this
open-codes a sequence lock in assembler and C code, which is required to
update the irq entry time stamp to the per cpu idle_data structure in a
race free manner.

[1] commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and corresponding code")
[2] commit ead70b752373 ("timers/nohz: Add a comment about broken iowait counter update race")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h   |   5 +-
 arch/s390/kernel/asm-offsets.c |   7 +++
 arch/s390/kernel/entry.S       |  12 +++-
 arch/s390/kernel/idle.c        | 109 ++++++++++++++++++++++++++++++---
 arch/s390/kernel/vtime.c       |  55 +----------------
 include/linux/kernel_stat.h    |  27 ++++++++
 include/linux/vtime.h          |   6 ++
 kernel/sched/cputime.c         |   4 +-
 8 files changed, 158 insertions(+), 67 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 6963e92b60a1..f3502d5621c0 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -14,12 +14,15 @@
 #include <asm/tod_types.h>
 
 struct s390_idle_data {
-	bool	      idle_dyntick;
+#ifdef CONFIG_NO_HZ_COMMON
+	bool	      in_idle;
+#endif
 	unsigned long idle_count;
 	unsigned long idle_time;
 	unsigned long timer_idle_enter;
 	unsigned long mt_cycles_enter[8];
 	union tod_clock clock_idle_enter;
+	union tod_clock clock_idle_exit;
 };
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index fbd26f3e9f96..f6dd2b67dcee 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -11,9 +11,11 @@
 #include <linux/purgatory.h>
 #include <linux/pgtable.h>
 #include <linux/ftrace_regs.h>
+#include <linux/kernel_stat.h>
 #include <asm/kvm_host_types.h>
 #include <asm/stacktrace.h>
 #include <asm/ptrace.h>
+#include <asm/idle.h>
 
 int main(void)
 {
@@ -128,6 +130,7 @@ int main(void)
 	OFFSET(__LC_LAST_UPDATE_CLOCK, lowcore, last_update_clock);
 	OFFSET(__LC_INT_CLOCK, lowcore, int_clock);
 	OFFSET(__LC_CURRENT, lowcore, current_task);
+	OFFSET(__LC_PERCPU_OFFSET, lowcore, percpu_offset);
 	OFFSET(__LC_KERNEL_STACK, lowcore, kernel_stack);
 	OFFSET(__LC_ASYNC_STACK, lowcore, async_stack);
 	OFFSET(__LC_NODAT_STACK, lowcore, nodat_stack);
@@ -180,6 +183,10 @@ int main(void)
 	DEFINE(OLDMEM_SIZE, PARMAREA + offsetof(struct parmarea, oldmem_size));
 	DEFINE(COMMAND_LINE, PARMAREA + offsetof(struct parmarea, command_line));
 	DEFINE(MAX_COMMAND_LINE_SIZE, PARMAREA + offsetof(struct parmarea, max_command_line_size));
+	OFFSET(__IDLE_CLOCK_EXIT, s390_idle_data, clock_idle_exit);
+#ifdef CONFIG_NO_HZ_COMMON
+	OFFSET(__KCPUSTAT_SEQUENCE, kernel_cpustat, idle_sleeptime_seq);
+#endif
 	OFFSET(__FTRACE_REGS_PT_REGS, __arch_ftrace_regs, regs);
 	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct __arch_ftrace_regs));
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 7147f3e51ace..79a45efae23d 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -379,8 +379,19 @@ SYM_CODE_END(pgm_check_handler)
 SYM_CODE_START(\name)
 	STMG_LC	%r8,%r15,__LC_SAVE_AREA
 	GET_LC	%r13
+#ifdef CONFIG_NO_HZ_COMMON
+	larl	%r12,kernel_cpustat
+	ag	%r12,__LC_PERCPU_OFFSET(%r13)
+	asi	__KCPUSTAT_SEQUENCE(%r12),1
+#endif
 	stcke	__LC_INT_CLOCK(%r13)
 	stpt	__LC_SYS_ENTER_TIMER(%r13)
+	larl	%r10,s390_idle
+	ag	%r10,__LC_PERCPU_OFFSET(%r13)
+	mvc	__IDLE_CLOCK_EXIT(16,%r10),__LC_INT_CLOCK(%r13)
+#ifdef CONFIG_NO_HZ_COMMON
+	asi	__KCPUSTAT_SEQUENCE(%r12),1
+#endif
 	STBEAR	__LC_LAST_BREAK(%r13)
 	BPOFF
 	lmg	%r8,%r9,\lc_old_psw(%r13)
@@ -407,7 +418,6 @@ SYM_CODE_START(\name)
 	xgr	%r5,%r5
 	xgr	%r6,%r6
 	xgr	%r7,%r7
-	xgr	%r10,%r10
 	xgr	%r12,%r12
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA(%r13)
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 36020dffb86b..b5fae512fc9c 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched/stat.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
@@ -21,22 +22,111 @@
 
 DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
-void account_idle_time_irq(void)
+static __always_inline void __account_idle_time_irq(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	unsigned long idle_time;
 
-	idle_time = get_lowcore()->int_clock.tod - idle->clock_idle_enter.tod;
-
-	/* Account time spent with enabled wait psw loaded as idle time. */
+	idle_time = idle->clock_idle_exit.tod - idle->clock_idle_enter.tod;
 	__atomic64_add(idle_time, &idle->idle_time);
 	__atomic64_add_const(1, &idle->idle_count);
-
-	/* Dyntick idle time accounted by nohz/scheduler */
-	if (!idle->idle_dyntick)
-		account_idle_time(cputime_to_nsecs(idle_time));
+	account_idle_time(cputime_to_nsecs(idle_time));
 }
 
+static __always_inline void __account_idle_time_setup(void)
+{
+	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+
+	store_tod_clock_ext(&idle->clock_idle_enter);
+	idle->timer_idle_enter = get_cpu_timer();
+	idle->clock_idle_exit = idle->clock_idle_enter;
+}
+
+#ifdef CONFIG_NO_HZ_COMMON
+
+static u64 arch_cpu_in_idle_time(int cpu)
+{
+	struct s390_idle_data *idle = &per_cpu(s390_idle, cpu);
+	union tod_clock now;
+	u64 idle_time;
+
+	if (!idle->in_idle)
+		return 0;
+	store_tod_clock_ext(&now);
+	if (tod_after(idle->clock_idle_exit.tod, idle->clock_idle_enter.tod))
+		idle_time = idle->clock_idle_exit.tod - idle->clock_idle_enter.tod;
+	else
+		idle_time = now.tod - idle->clock_idle_enter.tod;
+	return cputime_to_nsecs(idle_time);
+}
+
+static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_delta)
+{
+	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
+	u64 *cpustat = kc->cpustat;
+	unsigned int seq;
+	u64 idle_time;
+
+	/*
+	 * The open coded seqcount writer in entry.S relies on the
+	 * raw counting mechanism without any writer protection.
+	 */
+	typecheck(typeof(kc->idle_sleeptime_seq), seqcount_t);
+	do {
+		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
+		idle_time = cpustat[idx];
+		if (compute_delta)
+			idle_time += arch_cpu_in_idle_time(cpu);
+	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
+	return idle_time;
+}
+
+u64 arch_kcpustat_field_idle(int cpu)
+{
+	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
+}
+
+u64 arch_kcpustat_field_iowait(int cpu)
+{
+	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
+}
+
+void account_idle_time_irq(void)
+{
+	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	idle->in_idle = false;
+	__account_idle_time_irq();
+	write_seqcount_end(&kc->idle_sleeptime_seq);
+}
+
+static __always_inline void account_idle_time_setup(void)
+{
+	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
+
+	raw_write_seqcount_begin(&kc->idle_sleeptime_seq);
+	idle->in_idle = true;
+	__account_idle_time_setup();
+	raw_write_seqcount_end(&kc->idle_sleeptime_seq);
+}
+
+#else  /* CONFIG_NO_HZ_COMMON */
+
+void account_idle_time_irq(void)
+{
+	__account_idle_time_irq();
+}
+
+static __always_inline void account_idle_time_setup(void)
+{
+	__account_idle_time_setup();
+}
+
+#endif /* CONFIG_NO_HZ_COMMON */
+
 void noinstr arch_cpu_idle(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
@@ -49,8 +139,7 @@ void noinstr arch_cpu_idle(void)
 	set_cpu_flag(CIF_ENABLED_WAIT);
 	if (smp_cpu_mtid)
 		stcctm(MT_DIAG, smp_cpu_mtid, (u64 *)&idle->mt_cycles_enter);
-	store_tod_clock_ext(&idle->clock_idle_enter);
-	idle->timer_idle_enter = get_cpu_timer();
+	account_idle_time_setup();
 	bpon();
 	__load_psw_mask(psw_mask);
 }
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index d1102a6f80bd..d804e1140c2e 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -140,8 +140,6 @@ static int do_account_vtime(struct task_struct *tsk)
 
 	if (hardirq_count())
 		lc->hardirq_timer += timer;
-	else if (in_serving_softirq())
-		lc->softirq_timer += timer;
 	else
 		lc->system_timer += timer;
 
@@ -241,63 +239,14 @@ EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_softirq(struct task_struct *tsk)
 {
-	if (!__this_cpu_read(s390_idle.idle_dyntick))
-		get_lowcore()->softirq_timer += vtime_delta();
-	else
-		vtime_flush(tsk);
+	get_lowcore()->softirq_timer += vtime_delta();
 }
 
 void vtime_account_hardirq(struct task_struct *tsk)
 {
-	if (!__this_cpu_read(s390_idle.idle_dyntick)) {
-		get_lowcore()->hardirq_timer += vtime_delta();
-	} else {
-		/*
-		 * In dynticks mode, the idle cputime is accounted by the nohz
-		 * subsystem. Therefore the s390 timer/clocks are reset on IRQ
-		 * entry and steal time must be accounted now.
-		 */
-		vtime_flush(tsk);
-	}
+	get_lowcore()->hardirq_timer += vtime_delta();
 }
 
-#ifdef CONFIG_NO_HZ_COMMON
-/**
- * vtime_reset - Fast forward vtime entry clocks
- *
- * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
- * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
- */
-void vtime_reset(void)
-{
-	vtime_reset_last_update(get_lowcore());
-}
-
-/**
- * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
- *
- * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
- * is flushed and the tick subsystem takes over the idle cputime accounting.
- */
-void vtime_dyntick_start(void)
-{
-	__this_cpu_write(s390_idle.idle_dyntick, true);
-	vtime_flush(current);
-}
-
-/**
- * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
- *
- * Called when idle exits from dyntick mode. The vtime entry clocks are
- * fast-forward to current time and idle accounting resumes.
- */
-void vtime_dyntick_stop(void)
-{
-	vtime_reset_last_update(get_lowcore());
-	__this_cpu_write(s390_idle.idle_dyntick, false);
-}
-#endif /* CONFIG_NO_HZ_COMMON */
-
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index fce1392e2140..9ca6c2259dfe 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -107,6 +107,30 @@ static inline unsigned long kstat_cpu_irqs_sum(unsigned int cpu)
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
+
+#ifdef CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE
+
+static inline void kcpustat_dyntick_start(u64 now) { }
+static inline void kcpustat_dyntick_stop(u64 now) { }
+static inline void kcpustat_irq_enter(u64 now) { }
+static inline void kcpustat_irq_exit(u64 now) { }
+static inline bool kcpustat_idle_dyntick(void) { return false; }
+
+extern u64 arch_kcpustat_field_idle(int cpu);
+extern u64 arch_kcpustat_field_iowait(int cpu);
+
+static inline u64 kcpustat_field_idle(int cpu)
+{
+	return arch_kcpustat_field_idle(cpu);
+}
+
+static inline u64 kcpustat_field_iowait(int cpu)
+{
+	return arch_kcpustat_field_iowait(cpu);
+}
+
+#else /* !CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE */
+
 extern void kcpustat_dyntick_start(u64 now);
 extern void kcpustat_dyntick_stop(u64 now);
 extern void kcpustat_irq_enter(u64 now);
@@ -118,6 +142,9 @@ static inline bool kcpustat_idle_dyntick(void)
 {
 	return __this_cpu_read(kernel_cpustat.idle_dyntick);
 }
+
+#endif /* !CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE */
+
 #else
 static inline u64 kcpustat_field_idle(int cpu)
 {
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 9dc25b04a119..82825e775499 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -42,9 +42,15 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
 extern void vtime_account_softirq(struct task_struct *tsk);
 extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
+#ifdef CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE
+static inline void vtime_reset(void) { }
+static inline void vtime_dyntick_start(void) { }
+static inline void vtime_dyntick_stop(void) { }
+#else
 extern void vtime_reset(void);
 extern void vtime_dyntick_start(void);
 extern void vtime_dyntick_stop(void);
+#endif
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
 static inline void vtime_account_softirq(struct task_struct *tsk) { }
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 244b57417240..ed49a1e23d17 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -421,7 +421,7 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 						int nr_ticks) { }
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
-#ifdef CONFIG_NO_HZ_COMMON
+#if defined(CONFIG_NO_HZ_COMMON) && !defined(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE)
 static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
 	u64 *cpustat = kc->cpustat;
@@ -560,7 +560,7 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 {
 	return kcpustat_cpu(cpu).cpustat[idx];
 }
-#endif /* CONFIG_NO_HZ_COMMON */
+#endif /* CONFIG_NO_HZ_COMMON && !CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE */
 
 static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 				 bool compute_delta, u64 *last_update_time)
-- 
2.51.0

