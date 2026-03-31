Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4D3DBD62;
	Tue, 31 Mar 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963089; cv=none; b=Pa+T9QcDX3gU7YvMuqCBWqBXyGL4Wzo2UD1e4Joy4Dch9/0yI/cStQ8LGAIB/IUBXqLOE1jhTyLJF9ega2WYLjKpVFf9sGkGagXZAqZ4Vqu4kSYcqJqMqJ37kwKnAkkF7dwvKL2MDUiRyijAX1vYQSPZ0RzT+9VXRYxgmGtlsys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963089; c=relaxed/simple;
	bh=92dsTpBynD1g68/x/29CHbwEUuiIPa/Iwbdac5kZ2Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4dnYOsKkQxOzQxhA64lsgoNhYOjH15JwPNNivLWJ5EWfNWx0WKA4DzNsFuSJYe3N6mKs4Fy2pOxDFVHwiFe4/SZf4dytX17vytHeI0m7538TJ//sZMAGhku48VdjXk0lJEPrnIv37218gybc1ySMz6MUlJR3Dr3+fIBUIXJlCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeFf0V7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeFf0V7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09445C19423;
	Tue, 31 Mar 2026 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963089;
	bh=92dsTpBynD1g68/x/29CHbwEUuiIPa/Iwbdac5kZ2Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WeFf0V7Q76pBqWbBm8IGxACxytO3klh4ei3hm4d7O+torfL3SL0J88znMRVk3JZmw
	 omf84HqK58CsG9RlCrTiYc7+bBSeYHg1vRC3OoshW/Au5njEL+lE6PY15qBPm6wcLt
	 2xWjsIqddQJwLG2HYfTTMM7ykffZVMd5qlLTrON6cT1cGi+j3nmvED7/989mH3RHh3
	 759W7vogKMpmVJ6QNpAFAaV8mdaMZl2RHtcwjuajIUZT4vsozdYWLQG6ajGRF59nS0
	 /ceyoU60qKQX7AEOXV+KNEF2biVlKfOj3qUymOffxL4QvLd6ryyQAUT6bAiirxUy+T
	 aqzSnvT3I0SBA==
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
Subject: [PATCH 13/14] sched/cputime: Handle idle irqtime gracefully
Date: Tue, 31 Mar 2026 15:16:21 +0200
Message-ID: <20260331131622.30505-14-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131622.30505-1-frederic@kernel.org>
References: <20260331131622.30505-1-frederic@kernel.org>
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
during idle IRQs only if neither native vtime (which does IRQ time
accounting) nor generic IRQ time accounting are enabled.

Also make sure that the accumulated IRQ time is not accidentally
substracted from later accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/cputime.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 137e6b099fa9..a77b6f1dbdca 100644
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
 
@@ -478,7 +479,8 @@ void kcpustat_irq_enter(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_stop(kc, now);
 }
 
@@ -486,7 +488,8 @@ void kcpustat_irq_exit(u64 now)
 {
 	struct kernel_cpustat *kc = kcpustat_this_cpu;
 
-	if (!vtime_generic_enabled_this_cpu())
+	if (!vtime_generic_enabled_this_cpu() &&
+	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
 		kcpustat_idle_start(kc, now);
 }
 
-- 
2.53.0

