Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7803D3D05;
	Wed, 25 Feb 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031117; cv=none; b=eXwbxJuEnN+qXk1gtMqE2+Bsqib55ij/wrdurKAzj/GfwrNYO/wqEjrXY+xv2+xYKPIJNI+OHtYL5C2nMgBknkyrwGSNSPhnVLoM/L5s7caBPN5kSaLJ7Lf2NBOR3v3fTrtEt7easx5LA1kiQ0Cc4IYOCLcrs65deaXiMv3Bj74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031117; c=relaxed/simple;
	bh=xI+1OkHgVIfHdM+Ng5NSVZ28IRsHLOi7M02HDZ05nuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLm+I5+ZuOq2PAJK/CRMhq2ozk7/Xs5o9YBOuYDLczP6bT7UcFQURfXf92NSPOq7XDv7qCp4tO9h8VniUBcQdwvy9zh0klMQ6jRB881sGATrCABIswmOdPbXU5UcOlk6cdsGO2Sg0dPWJuxlIB7mmp6UAShVHVioxKjHitYCRqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dgxCIZBO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dgxCIZBO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDE3vN2460426;
	Wed, 25 Feb 2026 14:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZyWwtUahPdwD3mv3P
	yreUdC80V0hR84kmyqRIQcEFbc=; b=dgxCIZBOCxkHAM3ug408wsdifvwOCZcMv
	eAR0pg41FTa0NGPauE6OED6CW5dB8bgbSymcsybOMzKbTGUcEWxQ6iwSdcKglxGh
	dMyyqMCYMJd95u9kW8o8BK34OYxjqO3lgjAnJR3XTSjiLZjEb//X5zraAEsJ5KZ5
	/xlPNw30wxIaNXRAQe1E31eBW6gnCtfdml1qMpaMeRT6tI8mWl59Ubjsv5GzsLs6
	sGYDAiiIUrYk+ouaoQfUmX4ZcxK9J8QCUjeHnOEZGoFEVFSBGQqntxdIHwxIqWoY
	z0n14CW5H5oR/x6nyFyQLpxOEmGdgds5HdISHtYe8LJrMTmbJcpZg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr0p2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PCZ38d001659;
	Wed, 25 Feb 2026 14:51:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n5qq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 14:51:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PEpkYf38535602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 14:51:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C783A20040;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98FB72004E;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 14:51:46 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 2/3] s390/idle: Provide arch specific kcpustat_field_idle()/kcpustat_field_iowait()
Date: Wed, 25 Feb 2026 15:51:45 +0100
Message-ID: <20260225145146.1031705-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225145146.1031705-1-hca@linux.ibm.com>
References: <20260225145146.1031705-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wA9x1sz8fr5emyKVPRE0PxWgSbB7OAv_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0MCBTYWx0ZWRfXzEMNFOH5y1Ar
 p/MzUXWv8tN4rLqel/aI52oo8DarWkxjgdW0Zo7/BVobBvGW6s0YGw/dD+fQ/Kf/tKrMyP2AeEu
 px5k2L5T05zaT64GcFplpW0p/jqcAaEglXsuY6gKX5OAn9qEY4D8oLTSbwh7cXfPFo5Om4V0Jtp
 D3EKu+vxmCh3GoqYOskHR4kdL3zHZwpMaT10+i7bwLLamzt3MvKUJt9ACNlu5TXR92mm6Py91TT
 HwUCIFEX/hPSob+fFeg2m8VuMnzCqKsVTyqWDy1v3enOSSnpC39d2BsFOMQAz16VCYWPqUMHRLh
 VcsHbXRjYym4t2xgn16SOEi3hPKztob6MRhIJQwDvl3ekb3pfBZY54HmO8+2bjiNpeJgnYooUyP
 3Puu7Y1gQK4Hgjue+Bz1Fwm3CfWrvmx0VNCaU9tJbEjRgwhPlDxO7XFubSoBCCTn83X3gGrpHoY
 MGXQ6HnRdy7b4cpQcLw==
X-Proofpoint-GUID: wA9x1sz8fr5emyKVPRE0PxWgSbB7OAv_
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699f0c88 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=aKkPzD3UafzY5Z0pq1kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250140

With commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time() and
corresponding code") the s390 specific arch_cpu_idle_time() was
removed. Reason for that was that the implementation was racy and reported
idle time could go backwards (see the referenced commit for details).

With Frederic Weisbecker's idle cputime accounting refactoring
kernel_cpustat got a sequence counter. Use this to implement s390 specific
variants of kcpustat_field_idle() and kcpustat_field_iowait(). This is
basically a revert of the referenced commit and at the same time addresses
all the outlined races.

For comparing cross cpu time stamps it is necessary to use the stcke
instead of the stckf instruction in irq entry path. Furthermore this
open-codes a sequence lock in assembler and C code, which is required to
copy the irq entry time stamp to the per-cpu idle_data structure in a
race-free manner.

With all of this the s390 idle time accounting should be very precise
again, while also avoiding that reported idle time goes backwards.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h      | 15 +++---
 arch/s390/include/asm/lowcore.h   |  9 ++--
 arch/s390/include/asm/timex.h     | 20 +-------
 arch/s390/include/asm/tod_types.h | 30 ++++++++++++
 arch/s390/kernel/asm-offsets.c    |  5 ++
 arch/s390/kernel/entry.S          |  7 ++-
 arch/s390/kernel/idle.c           | 78 +++++++++++++++++++++++++++----
 arch/s390/kernel/irq.c            |  2 +-
 arch/s390/kernel/setup.c          |  1 +
 arch/s390/kernel/smp.c            |  1 +
 arch/s390/kernel/vtime.c          | 37 ---------------
 drivers/s390/cio/qdio_main.c      |  2 +-
 drivers/s390/cio/qdio_thinint.c   |  2 +-
 include/linux/kernel_stat.h       | 27 +++++++++++
 include/linux/vtime.h             |  6 +++
 kernel/sched/cputime.c            |  4 +-
 16 files changed, 166 insertions(+), 80 deletions(-)
 create mode 100644 arch/s390/include/asm/tod_types.h

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 7f2a1240b6ff..dc04d63b6187 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -11,14 +11,17 @@
 #include <linux/percpu-defs.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <asm/tod_types.h>
 
 struct s390_idle_data {
-	bool	      idle_dyntick;
-	unsigned long idle_count;
-	unsigned long idle_time;
-	unsigned long clock_idle_enter;
-	unsigned long timer_idle_enter;
-	unsigned long mt_cycles_enter[8];
+	bool		in_idle;
+	unsigned int	sequence;
+	unsigned long	idle_count;
+	unsigned long	idle_time;
+	union tod_clock	clock_idle_enter;
+	union tod_clock	clock_idle_exit;
+	unsigned long	timer_idle_enter;
+	unsigned long	mt_cycles_enter[8];
 };
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 50ffe75adeb4..64b74ee3560c 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -10,6 +10,7 @@
 #define _ASM_S390_LOWCORE_H
 
 #include <linux/types.h>
+#include <asm/tod_types.h>
 #include <asm/machine.h>
 #include <asm/ptrace.h>
 #include <asm/ctlreg.h>
@@ -125,10 +126,10 @@ struct lowcore {
 	__u64	avg_steal_timer;		/* 0x0300 */
 	__u64	last_update_timer;		/* 0x0308 */
 	__u64	last_update_clock;		/* 0x0310 */
-	__u64	int_clock;			/* 0x0318 */
-	__u8	pad_0x0320[0x0328-0x0320];	/* 0x0320 */
-	__u64	clock_comparator;		/* 0x0328 */
-	__u8	pad_0x0330[0x0340-0x0330];	/* 0x0330 */
+	__u64	idle_data;			/* 0x0318 */
+	union tod_clock int_clock;		/* 0x0320 */
+	__u64	clock_comparator;		/* 0x0330 */
+	__u8	pad_0x0330[0x0340-0x0338];	/* 0x0338 */
 
 	/* Current process. */
 	__u64	current_task;			/* 0x0340 */
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 49447b40f038..ac3ab6c29912 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -12,6 +12,7 @@
 
 #include <linux/preempt.h>
 #include <linux/time64.h>
+#include <asm/tod_types.h>
 #include <asm/lowcore.h>
 #include <asm/machine.h>
 #include <asm/asm.h>
@@ -21,25 +22,6 @@
 
 extern u64 clock_comparator_max;
 
-union tod_clock {
-	__uint128_t val;
-	struct {
-		__uint128_t ei	:  8; /* epoch index */
-		__uint128_t tod : 64; /* bits 0-63 of tod clock */
-		__uint128_t	: 40;
-		__uint128_t pf	: 16; /* programmable field */
-	};
-	struct {
-		__uint128_t eitod : 72; /* epoch index + bits 0-63 tod clock */
-		__uint128_t	  : 56;
-	};
-	struct {
-		__uint128_t us	: 60; /* micro-seconds */
-		__uint128_t sus	: 12; /* sub-microseconds */
-		__uint128_t	: 56;
-	};
-} __packed;
-
 /* Inline functions for clock register access. */
 static inline int set_tod_clock(__u64 time)
 {
diff --git a/arch/s390/include/asm/tod_types.h b/arch/s390/include/asm/tod_types.h
new file mode 100644
index 000000000000..976fa0a1e895
--- /dev/null
+++ b/arch/s390/include/asm/tod_types.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_S390_TOD_TYPES_H
+#define _ASM_S390_TOD_TYPES_H
+
+#include <linux/types.h>
+
+#ifndef __ASSEMBLER__
+
+union tod_clock {
+	__uint128_t val;
+	struct {
+		__uint128_t ei	:  8; /* epoch index */
+		__uint128_t tod : 64; /* bits 0-63 of tod clock */
+		__uint128_t	: 40;
+		__uint128_t pf	: 16; /* programmable field */
+	};
+	struct {
+		__uint128_t eitod : 72; /* epoch index + bits 0-63 tod clock */
+		__uint128_t	  : 56;
+	};
+	struct {
+		__uint128_t us	: 60; /* micro-seconds */
+		__uint128_t sus	: 12; /* sub-microseconds */
+		__uint128_t	: 56;
+	};
+} __packed;
+
+#endif
+#endif
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index e1a5b5b54e4f..c580a5ec265c 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <asm/kvm_host_types.h>
 #include <asm/stacktrace.h>
 #include <asm/ptrace.h>
+#include <asm/idle.h>
 
 int main(void)
 {
@@ -126,6 +127,7 @@ int main(void)
 	OFFSET(__LC_EXIT_TIMER, lowcore, exit_timer);
 	OFFSET(__LC_LAST_UPDATE_TIMER, lowcore, last_update_timer);
 	OFFSET(__LC_LAST_UPDATE_CLOCK, lowcore, last_update_clock);
+	OFFSET(__LC_IDLE_DATA, lowcore, idle_data);
 	OFFSET(__LC_INT_CLOCK, lowcore, int_clock);
 	OFFSET(__LC_CURRENT, lowcore, current_task);
 	OFFSET(__LC_KERNEL_STACK, lowcore, kernel_stack);
@@ -180,6 +182,9 @@ int main(void)
 	DEFINE(OLDMEM_SIZE, PARMAREA + offsetof(struct parmarea, oldmem_size));
 	DEFINE(COMMAND_LINE, PARMAREA + offsetof(struct parmarea, command_line));
 	DEFINE(MAX_COMMAND_LINE_SIZE, PARMAREA + offsetof(struct parmarea, max_command_line_size));
+	/* idle data offsets */
+	OFFSET(__IDLE_CLOCK_EXIT, s390_idle_data, clock_idle_exit);
+	OFFSET(__IDLE_SEQUENCE, s390_idle_data, sequence);
 	OFFSET(__FTRACE_REGS_PT_REGS, __arch_ftrace_regs, regs);
 	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct __arch_ftrace_regs));
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 4873fe9d891b..19fd1541a0f3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -378,8 +378,13 @@ SYM_CODE_END(pgm_check_handler)
 SYM_CODE_START(\name)
 	STMG_LC	%r8,%r15,__LC_SAVE_AREA
 	GET_LC	%r13
-	stckf	__LC_INT_CLOCK(%r13)
+	lg	%r12,__LC_IDLE_DATA(%r13)
+	asi	__IDLE_SEQUENCE(%r12),1
+	stcke	__LC_INT_CLOCK(%r13)
 	stpt	__LC_SYS_ENTER_TIMER(%r13)
+	mvc	__IDLE_CLOCK_EXIT(16,%r12),__LC_INT_CLOCK(%r13)
+	ALTERNATIVE "bcr 15,0", "bcr 14,0", ALT_FACILITY(45)
+	asi	__IDLE_SEQUENCE(%r12),1
 	STBEAR	__LC_LAST_BREAK(%r13)
 	BPOFF
 	lmg	%r8,%r9,\lc_old_psw(%r13)
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index fb4f431342f5..ceb95c0d22eb 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -9,12 +9,14 @@
 
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
+#include <linux/sched/stat.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <trace/events/power.h>
 #include <asm/cpu_mf.h>
 #include <asm/cputime.h>
+#include <asm/lowcore.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
 #include "entry.h"
@@ -24,6 +26,7 @@ DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 void account_idle_time_irq(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
 	struct lowcore *lc = get_lowcore();
 	unsigned long idle_time;
 	u64 cycles_new[8];
@@ -35,27 +38,82 @@ void account_idle_time_irq(void)
 			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
+	write_seqcount_begin(&kc->idle_sleeptime_seq);
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	idle_time = lc->int_clock - idle->clock_idle_enter;
+	idle_time = lc->int_clock.tod - idle->clock_idle_enter.tod;
 	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
 	WRITE_ONCE(idle->idle_count, READ_ONCE(idle->idle_count) + 1);
 
-	/* Dyntick idle time accounted by nohz/scheduler */
-	if (idle->idle_dyntick)
-		return;
-
-	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
-	lc->last_update_clock = lc->int_clock;
+	lc->steal_timer += idle->clock_idle_enter.tod - lc->last_update_clock;
+	lc->last_update_clock = lc->int_clock.tod;
 
 	lc->system_timer += lc->last_update_timer - idle->timer_idle_enter;
 	lc->last_update_timer = lc->sys_enter_timer;
 
+	idle->in_idle = false;
 	account_idle_time(cputime_to_nsecs(idle_time));
+	write_seqcount_end(&kc->idle_sleeptime_seq);
+}
+
+static u64 arch_cpu_in_idle_time(int cpu)
+{
+	struct s390_idle_data *idle = &per_cpu(s390_idle, cpu);
+	union tod_clock now;
+	unsigned int seq;
+	u64 idle_time;
+
+	if (!idle->in_idle)
+		return 0;
+	/*
+	 * Open-coded read seqlock which pairs with assembler write seqlock
+	 * in entry.S. Its purpose is to prevent that reported idle time
+	 * goes backwards.
+	 */
+	do {
+		do {
+			seq = __atomic_read(&idle->sequence);
+			smp_mb();
+		} while (seq & 1);
+		store_tod_clock_ext(&now);
+		if (tod_after(idle->clock_idle_exit.tod, idle->clock_idle_enter.tod))
+			idle_time = idle->clock_idle_exit.tod - idle->clock_idle_enter.tod;
+		else
+			idle_time = now.tod - idle->clock_idle_enter.tod;
+		smp_mb();
+	} while (__atomic_read(&idle->sequence) != seq);
+	return tod_to_ns(idle_time);
+}
+
+static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_delta)
+{
+	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
+	u64 *cpustat = kc->cpustat;
+	unsigned int seq;
+	u64 idle_time;
+
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
 }
 
 void noinstr arch_cpu_idle(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+	struct kernel_cpustat *kc = kcpustat_this_cpu;
 	unsigned long psw_mask;
 
 	/* Wait for external, I/O or machine check interrupt. */
@@ -65,8 +123,12 @@ void noinstr arch_cpu_idle(void)
 	set_cpu_flag(CIF_ENABLED_WAIT);
 	if (smp_cpu_mtid)
 		stcctm(MT_DIAG, smp_cpu_mtid, (u64 *)&idle->mt_cycles_enter);
-	idle->clock_idle_enter = get_tod_clock_fast();
+	raw_write_seqcount_begin(&kc->idle_sleeptime_seq);
+	idle->in_idle = true;
+	store_tod_clock_ext(&idle->clock_idle_enter);
 	idle->timer_idle_enter = get_cpu_timer();
+	idle->clock_idle_exit = idle->clock_idle_enter;
+	raw_write_seqcount_end(&kc->idle_sleeptime_seq);
 	bpon();
 	__load_psw_mask(psw_mask);
 }
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index bdf9c7cb5685..8e3667bff225 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -103,7 +103,7 @@ static const struct irq_class irqclass_sub_desc[] = {
 
 static void do_IRQ(struct pt_regs *regs, int irq)
 {
-	if (tod_after_eq(get_lowcore()->int_clock,
+	if (tod_after_eq(get_lowcore()->int_clock.tod,
 			 get_lowcore()->clock_comparator))
 		/* Serve timer interrupts first. */
 		clock_comparator_work();
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c1fe0b53c5ac..2b1af286ef94 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -421,6 +421,7 @@ static void __init setup_lowcore(void)
 	lc->steal_timer = get_lowcore()->steal_timer;
 	lc->last_update_timer = get_lowcore()->last_update_timer;
 	lc->last_update_clock = get_lowcore()->last_update_clock;
+	lc->idle_data = (unsigned long)per_cpu_ptr(&s390_idle, 0);
 	/*
 	 * Allocate the global restart stack which is the same for
 	 * all CPUs in case *one* of them does a PSW restart.
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index b7429f30afc1..439eab2fb67a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -256,6 +256,7 @@ static void pcpu_prepare_secondary(struct pcpu *pcpu, int cpu)
 	lc->user_asce = s390_invalid_asce;
 	lc->user_timer = lc->system_timer =
 		lc->steal_timer = lc->avg_steal_timer = 0;
+	lc->idle_data = (unsigned long)per_cpu_ptr(&s390_idle, cpu);
 	abs_lc = get_abs_lowcore();
 	memcpy(lc->cregs_save_area, abs_lc->cregs_save_area, sizeof(lc->cregs_save_area));
 	put_abs_lowcore(abs_lc);
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index c19528eb4ee3..93255f442359 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -269,43 +269,6 @@ void vtime_account_hardirq(struct task_struct *tsk)
 	virt_timer_forward(delta);
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
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 7dd967165025..ffcb416f3f58 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -695,7 +695,7 @@ static void qdio_int_handler_pci(struct qdio_irq *irq_ptr)
 		return;
 
 	qdio_deliver_irq(irq_ptr);
-	irq_ptr->last_data_irq_time = get_lowcore()->int_clock;
+	irq_ptr->last_data_irq_time = get_lowcore()->int_clock.tod;
 }
 
 static void qdio_handle_activate_check(struct qdio_irq *irq_ptr,
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index f931954910c5..ca0d2e4b673f 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -99,7 +99,7 @@ static inline u32 clear_shared_ind(void)
 static void tiqdio_thinint_handler(struct airq_struct *airq,
 				   struct tpi_info *tpi_info)
 {
-	u64 irq_time = get_lowcore()->int_clock;
+	u64 irq_time = get_lowcore()->int_clock.tod;
 	u32 si_used = clear_shared_ind();
 	struct qdio_irq *irq;
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 24a54a6151ba..4ea9681a5f5c 100644
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
index a4506336002d..07c862fd0951 100644
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
index e0492e18cc5f..85a0f728e28e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -420,7 +420,7 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 						int nr_ticks) { }
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
-#ifdef CONFIG_NO_HZ_COMMON
+#if defined(CONFIG_NO_HZ_COMMON) && !defined(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE)
 static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
 	u64 *cpustat = kc->cpustat;
@@ -542,7 +542,7 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 {
 	return kcpustat_cpu(cpu).cpustat[idx];
 }
-#endif /* CONFIG_NO_HZ_COMMON */
+#endif /* CONFIG_NO_HZ_COMMON && !CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE */
 
 static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
 				 bool compute_delta, u64 *last_update_time)
-- 
2.51.0

