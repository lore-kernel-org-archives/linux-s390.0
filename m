Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935673E3D8B;
	Fri,  8 May 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246277; cv=none; b=mcivQHC/XuNbLSVJYomlz27JrlkK5wxc58mOIOJ76xFFeoCHkdZBIEn5Stj3xDVIQbF/HEexkcFOsnNM48AtRn398MfD+Ah3OqF6EcF0IvsiwPWSmW8jG2Qa6jpyZcBQrF/mr4ChwL47a+PILop7wNHMHSjqCLNkmacKNQetefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246277; c=relaxed/simple;
	bh=M63ShCX7zqb5AHp58Bm1+/s5JI8DPbHl1tMtnbJNrS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A12RaybYb0yCrRTuE1hr1gLhzv4wUyG6doECPOtrIgJI++c2ULPAgSrkyC5/uOpbeU8a4jaF2QERb9n5uAWV53ibPPZlLwZxuqkqP9lve8B94bIapf2Xbz5is67SBFAOjmrz+iCntQpHO0nGwyhxJ/Jv2hZXxtr/TqskMjuFX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEupoMp8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEupoMp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56691C2BCB0;
	Fri,  8 May 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246277;
	bh=M63ShCX7zqb5AHp58Bm1+/s5JI8DPbHl1tMtnbJNrS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEupoMp8veMBv7bKoFjQb/HHLcQFnZgJICjroGoAB5EJzTOICKGlyxAFBQp/5Tc7q
	 gYbxWHkesd/KGX7EnKN+CfdfLhO3P8XNTUUwtODinS8KsbW3Cl30Mi+AScIYNV0Zma
	 WwCkedwTSqjfpiOhi6ZXDeA0IRG3vWd12zycXxKCijk+dfMsE9n/6pmSPcBu3FTFc8
	 R145rVOyDaV90+natkFLU0SdGT0Hp0oWgZ2kWtb5VYP5mtGU31tR97/O9Ed6fyoQW2
	 TAvGFs1WA/+SsoQ87vdQAl1HomAxl6K4ub0y53p7pLji11MtbhZCtU1LBYQOj1R3fm
	 /WEOK7Nwm9vIA==
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
Subject: [PATCH 06/15] s390/time: Prepare to stop elapsing in dynticks-idle
Date: Fri,  8 May 2026 15:16:38 +0200
Message-ID: <20260508131647.43868-7-frederic@kernel.org>
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

Currently the tick subsystem stores the idle cputime accounting in
private fields, allowing cohabitation with architecture idle vtime
accounting. The former is fetched on online CPUs, the latter on offline
CPUs.

For consolidation purpose, architecture vtime accounting will continue
to account the cputime but will make a break when the idle tick is
stopped. The dyntick cputime accounting will then be relayed by the tick
subsystem so that the idle cputime is still seen advancing coherently
even when the tick isn't there to flush the idle vtime.

Prepare for that and introduce three new APIs which will be used in
subsequent patches:

_ vtime_dynticks_start() is deemed to be called when idle enters in
  dyntick mode. The idle cputime that elapsed so far is accumulated
  and accounted. Also idle time accounting is ignored.

- vtime_dynticks_stop() is deemed to be called when idle exits from
  dyntick mode. The vtime entry clocks are fast-forward to current time
  so that idle accounting restarts elapsing from now. Also idle time
  accounting is resumed.

- vtime_reset() is deemed to be called from dynticks idle IRQ entry to
  fast-forward the clock to current time so that the IRQ time is still
  accounted by vtime while nohz cputime is paused.

Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
accounting twice the idle cputime, along with nohz accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/s390/include/asm/idle.h |  2 +
 arch/s390/kernel/idle.c      |  5 ++-
 arch/s390/kernel/vtime.c     | 75 ++++++++++++++++++++++++++++++++----
 3 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 32536ee34aa0..e4ad09a22400 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -8,10 +8,12 @@
 #ifndef _S390_IDLE_H
 #define _S390_IDLE_H
 
+#include <linux/percpu-defs.h>
 #include <linux/types.h>
 #include <linux/device.h>
 
 struct s390_idle_data {
+	bool	      idle_dyntick;
 	unsigned long idle_count;
 	unsigned long idle_time;
 	unsigned long clock_idle_enter;
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 1f1b06b6b4ef..4685d7c5bc51 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -31,7 +31,10 @@ void account_idle_time_irq(void)
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	__atomic64_add(idle_time, &idle->idle_time);
 	__atomic64_add_const(1, &idle->idle_count);
-	account_idle_time(cputime_to_nsecs(idle_time));
+
+	/* Dyntick idle time accounted by nohz/scheduler */
+	if (!idle->idle_dyntick)
+		account_idle_time(cputime_to_nsecs(idle_time));
 }
 
 void noinstr arch_cpu_idle(void)
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index bf48744d0912..d1102a6f80bd 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -17,6 +17,7 @@
 #include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>
+#include <asm/idle.h>
 #include <asm/smp.h>
 
 #include "entry.h"
@@ -110,6 +111,16 @@ static void account_system_index_scaled(struct task_struct *p, u64 cputime,
 	account_system_index_time(p, cputime_to_nsecs(cputime), index);
 }
 
+static inline void vtime_reset_last_update(struct lowcore *lc)
+{
+	asm volatile(
+		"	stpt	%0\n"	/* Store current cpu timer value */
+		"	stckf	%1"	/* Store current tod clock value */
+		: "=Q" (lc->last_update_timer),
+		  "=Q" (lc->last_update_clock)
+		: : "cc");
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
@@ -121,17 +132,16 @@ static int do_account_vtime(struct task_struct *tsk)
 
 	timer = lc->last_update_timer;
 	clock = lc->last_update_clock;
-	asm volatile(
-		"	stpt	%0\n"	/* Store current cpu timer value */
-		"	stckf	%1"	/* Store current tod clock value */
-		: "=Q" (lc->last_update_timer),
-		  "=Q" (lc->last_update_clock)
-		: : "cc");
+
+	vtime_reset_last_update(lc);
+
 	clock = lc->last_update_clock - clock;
 	timer -= lc->last_update_timer;
 
 	if (hardirq_count())
 		lc->hardirq_timer += timer;
+	else if (in_serving_softirq())
+		lc->softirq_timer += timer;
 	else
 		lc->system_timer += timer;
 
@@ -231,14 +241,63 @@ EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_softirq(struct task_struct *tsk)
 {
-	get_lowcore()->softirq_timer += vtime_delta();
+	if (!__this_cpu_read(s390_idle.idle_dyntick))
+		get_lowcore()->softirq_timer += vtime_delta();
+	else
+		vtime_flush(tsk);
 }
 
 void vtime_account_hardirq(struct task_struct *tsk)
 {
-	get_lowcore()->hardirq_timer += vtime_delta();
+	if (!__this_cpu_read(s390_idle.idle_dyntick)) {
+		get_lowcore()->hardirq_timer += vtime_delta();
+	} else {
+		/*
+		 * In dynticks mode, the idle cputime is accounted by the nohz
+		 * subsystem. Therefore the s390 timer/clocks are reset on IRQ
+		 * entry and steal time must be accounted now.
+		 */
+		vtime_flush(tsk);
+	}
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
+/**
+ * vtime_reset - Fast forward vtime entry clocks
+ *
+ * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
+ * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
+ */
+void vtime_reset(void)
+{
+	vtime_reset_last_update(get_lowcore());
+}
+
+/**
+ * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
+ *
+ * Called when idle enters in dyntick mode. The idle cputime that elapsed so far
+ * is flushed and the tick subsystem takes over the idle cputime accounting.
+ */
+void vtime_dyntick_start(void)
+{
+	__this_cpu_write(s390_idle.idle_dyntick, true);
+	vtime_flush(current);
+}
+
+/**
+ * vtime_dyntick_stop - Inform vtime about exit from idle-dynticks
+ *
+ * Called when idle exits from dyntick mode. The vtime entry clocks are
+ * fast-forward to current time and idle accounting resumes.
+ */
+void vtime_dyntick_stop(void)
+{
+	vtime_reset_last_update(get_lowcore());
+	__this_cpu_write(s390_idle.idle_dyntick, false);
+}
+#endif /* CONFIG_NO_HZ_COMMON */
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
-- 
2.53.0

