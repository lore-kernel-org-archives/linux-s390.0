Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD0C37F00C;
	Fri,  8 May 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246243; cv=none; b=EjUGvNr+43spF0VAUPf6CJ68xEPTe6kUysZyyiXfc0C7b6edA1JDIebq92lf+IEfoZWt94p9AVxHhEc02D/ZmHZ+pvc4RviaN5ekiBJZOqBOLqALN5r1tnp9yAoCDQH+TDOG19wGq8oeyinHm6VxTwD+XtE3WI+UrQI8wcXMZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246243; c=relaxed/simple;
	bh=UeCeMdJXLMsqcLiyE7L6BjEm2BBFQStG53xrIqv/KCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn3lWF/nIc+0LjZMTeeMn/jrQNfpZswQpz3QoaI3yJ3xe5XNpmhgyItH75+JQOAhDYa96msrcrRTjDI8IYAS9baKC9YrfsAhFaShjL/7RMdHRlPgRSmWl9l3ikrN7auImU0pO77UQkTHri+oUQQ0Xyi5VcYCZHEqFFMEiXbljCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWkHfw6j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWkHfw6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985AFC2BCC7;
	Fri,  8 May 2026 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246243;
	bh=UeCeMdJXLMsqcLiyE7L6BjEm2BBFQStG53xrIqv/KCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWkHfw6jK75cNMzAAZKQ5+/l6MQMArstvk7RP/tFCMfz1+R6CNXzwQ3L0ZyjukjaW
	 0uyIzp+bWzVXPIlYleMk1IZZD7hH0tto03sYlMgkIkkouJZt7q9EatrTk/zPWIdMq2
	 NihSRoDrT0G0J7hUFIithGrluCdjOPrWuIJyxPvZVeAZHZpJJFDYPkIUFJ+5LaAPEA
	 4HiPOFmjN8qjLPKmjUuPfz+KrRUCy11VGrzeX571pG2Wrc/Ql8CU5O0Y2ldbRSTgKK
	 xyPyr6dHzCFJb7Bcu1S9kcPxV2uY4hoIYSRtyG8CBqKhj51y1CXnCOZA2CKC6q4tty
	 wyUJbfcdYY/Vg==
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
Subject: [PATCH 02/15] sched/idle: Handle offlining first in idle loop
Date: Fri,  8 May 2026 15:16:34 +0200
Message-ID: <20260508131647.43868-3-frederic@kernel.org>
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

Offline handling happens from within the inner idle loop,
after the beginning of dyntick cputime accounting, nohz idle
load balancing and TIF_NEED_RESCHED polling.

This is not necessary and even buggy because:

* There is no dyntick handling to do. And calling tick_nohz_idle_enter()
  messes up with the struct tick_sched reset that was performed on
  tick_sched_timer_dying().

* There is no nohz idle balancing to do.

* Polling on TIF_RESCHED is irrelevant at this stage, there are no more
  tasks allowed to run.

* No need to check if need_resched() before offline handling since
  stop_machine is done and all per-cpu kthread should be done with
  their job.

Therefore move the offline handling at the beginning of the idle loop.
This will also ease the idle cputime unification later by not elapsing
idle time while offline through the call to:

	tick_nohz_idle_enter() -> tick_nohz_start_idle()

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/idle.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index a83be0c834dd..aa7e3dc59856 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -280,6 +280,14 @@ static void do_idle(void)
 	int cpu = smp_processor_id();
 	bool got_tick = false;
 
+	if (cpu_is_offline(cpu)) {
+		local_irq_disable();
+		/* All per-CPU kernel threads should be done by now. */
+		WARN_ON_ONCE(need_resched());
+		cpuhp_report_idle_dead();
+		arch_cpu_idle_dead();
+	}
+
 	/*
 	 * Check if we need to update blocked load
 	 */
@@ -331,11 +339,6 @@ static void do_idle(void)
 		 */
 		local_irq_disable();
 
-		if (cpu_is_offline(cpu)) {
-			cpuhp_report_idle_dead();
-			arch_cpu_idle_dead();
-		}
-
 		arch_cpu_idle_enter();
 		rcu_nocb_flush_deferred_wakeup();
 
-- 
2.53.0

