Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57432C923;
	Fri,  8 May 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246344; cv=none; b=CTRlz9SDDvN58DFba3NWIjcP4aJJ2iYCBBN5NUPqo69ek2n6vV/+Hfv0LpXyR9+1rY9MaXrAFLMuTkRLHkcFO1fh3tpGmeLM3fQvQuNpgIgUkHSMKSRJDfPYXkU6fCMD9GeAEm/d+aCusf64uyI8nn44HhB74WfSxGHoCK59Gec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246344; c=relaxed/simple;
	bh=XFJ8pRWP/axY4OUs3PqKazFlUE7J3E8NIjuAoFfvd54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTnvbRuDXhBBbYH6yrO6ZU5P62Kptoy0kJmAi43YWZES/GKpPdf1KtvvW1ITqvyTcjlV57pMWL3OfjpOphUgusk4lhcq+Y4UJTWTjQmVh5y+AijQm0xph5j1lNPM3nzuLRrfsbU3UztzpfmGkC2oSCX56JUyNbYKwVOs2vISgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHbbX6uN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHbbX6uN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA590C2BCB0;
	Fri,  8 May 2026 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246343;
	bh=XFJ8pRWP/axY4OUs3PqKazFlUE7J3E8NIjuAoFfvd54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHbbX6uNw5iE1JmyAD29DJUX17xmu/WOfINYTTf/zyArVxcRB4G37uk5Iqv+RXV4z
	 HwbuiTsKWfCITC/thuYQbwa8cqqTJz197QCzqql6enFpRG4PfQNhOsF79owoGXVOBx
	 4H1TxhtNXAs9MLtt3xeLeey3Zb+6MWrLKkhk6p9XhCkfkuMc5zaTtUunLSfQLHCkY4
	 +2O5gu6PuMSb1ZwrTNn/vDjdtgQZ99zW5XSQm4QFemx60/kKG40Yu7RwqmYGzBjcto
	 8GvefEz008RHKOKpJxxd5alxoFAsfoZHUJfFVtUZv7IwJxhv5Qu09GIq3FqEIZkRu1
	 Ll6SZU2I+T4BQ==
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
Subject: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
Date: Fri,  8 May 2026 15:16:46 +0200
Message-ID: <20260508131647.43868-15-frederic@kernel.org>
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

The dyntick-idle cputime accounting always assumes that IRQ time
accounting is enabled and consequently stops elapsing the idle time
during dyntick-idle IRQs.

This doesn't mix up well with disabled IRQ time accounting because then
idle IRQs become a cputime blind-spot. Also this feature is disabled
on most configurations and the overhead of pausing dyntick-idle
accounting while in idle IRQs could then be avoided.

Fix the situation with conditionally pausing dyntick-idle accounting
during idle IRQs only iff either native vtime (which does IRQ time
accounting) or generic IRQ time accounting are enabled.

Also make sure that the accumulated IRQ time is not accidentally
substracted from later accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/cputime.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 335d2c127763..94be22aa5cb6 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -47,7 +47,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
 	u64_stats_update_begin(&irqtime->sync);
 	cpustat[idx] += delta;
 	irqtime->total += delta;
-	irqtime->tick_delta += delta;
+	if (!kcpustat_idle_dyntick())
+		irqtime->tick_delta += delta;
 	u64_stats_update_end(&irqtime->sync);
 }
 
@@ -444,6 +445,10 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 
 static void kcpustat_idle_start(struct kernel_cpustat *kc, u64 now)
 {
+	/* Irqtime accounting might have been enabled in the middle of the IRQ */
+	if (kc->idle_elapse)
+		return;
+
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
 	kc->idle_entrytime = now;
 	kc->idle_elapse = true;
@@ -478,7 +483,8 @@ void kcpustat_irq_enter(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -486,7 +492,15 @@ void kcpustat_irq_exit(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	/*
+	 * Generic vtime already does its own idle accounting.
+	 * But irqtime accounting or arch vtime which also accounts IRQs
+	 * need to pause nohz accounting. Resume nohz accounting as long
+	 * as the irqtime config is enabled to handle case where irqtime
+	 * accounting got runtime disabled in the middle of an IRQ.
+	 */
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (IS_ENABLED(CONFIG_IRQ_TIME_ACCOUNTING) || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
-- 
2.53.0

