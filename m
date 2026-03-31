Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDC3E4C93;
	Tue, 31 Mar 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963060; cv=none; b=fYb0WNmV96zF0H8pMtocv5/aF5TnQzmkQn8ld0L3MHoNLqZ/JwGwZs2KpPyDOlsfFQefGOlDNYjO/cnyTFUUuS93MuJIZtTcL8YpvKTB5sPOxY3fi64QOA93k5jM07W78MbBjQtICejT8tdqZbCW3nfXeIxjcHuYDSvkbgEHv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963060; c=relaxed/simple;
	bh=TjYFIgCHyh+/o6L1KtAM5WwypjR946R5y+AKSoRMF7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdu6H/UlTbPYYsKs8JIYMi6wdGsmfWkBPZBmZNpE2Qm1ARCTmtrSe4deTndZSE6BsuEC93Y0kZ0ES92PJxfq50bHvm7++zN4j6q9O2aG8p65CuO8o7Uh7oFH3TQSVJGsATyr3uzi5oP24uMhhGgOtKuymg8S6Onz4ja9PnFk2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlxKKPwK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlxKKPwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CBCC2BCB2;
	Tue, 31 Mar 2026 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963059;
	bh=TjYFIgCHyh+/o6L1KtAM5WwypjR946R5y+AKSoRMF7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlxKKPwKpD/abGgPr/0nLZeecm+jfIIDBUsfwzJRzObTAqgHgyT3EvQVr1sAWC3JT
	 nbYWjM5uSHyojZLhY7d6NkcpgI+MSiDZSYmzSE/sI84vOAr6z9G633U7pFIi2ktoQl
	 z/6z9f4sLl6lS3MsRyYjPI5df9QNRItFO1Pr5T1t1ojEBmP4xekFvaeZj6NZh4GKqh
	 x1ELoJCBQFMez2x7QWmLg2wGaDFZYGnJCHK8Y2KNef6xJCjIEeKAnxg89h3qS6U2gA
	 HyrlrStC8pINuvV+EDY7wTUElJYf1K0/1zqhJZxnbMJ5RTkei7eL4eFSYU88wO+8qf
	 NHWKSq/l6aZzg==
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
Subject: [PATCH 09/14] tick/sched: Remove unused fields
Date: Tue, 31 Mar 2026 15:16:17 +0200
Message-ID: <20260331131622.30505-10-frederic@kernel.org>
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

Remove fields after the dyntick-idle cputime migration to scheduler
code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/time/tick-sched.h       | 12 ------------
 kernel/time/timer_list.c       |  6 +-----
 scripts/gdb/linux/timerlist.py |  4 ----
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index b4a7822f495d..79b9252047b1 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -44,9 +44,7 @@ struct tick_device {
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
  * @next_tick:		Next tick to be fired when in dynticks mode.
- * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_waketime:	Time when the idle was interrupted
- * @idle_sleeptime_seq:	sequence counter for data consistency
  * @idle_entrytime:	Time when the idle call was entered
  * @last_jiffies:	Base jiffies snapshot when next event was last computed
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
@@ -55,9 +53,6 @@ struct tick_device {
  * @idle_expires:	Next tick in idle, for debugging purpose only
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
- * @idle_exittime:	Time when the idle state was left
- * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
- * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
  * @check_clocks:	Notification mechanism about clocksource changes
  */
@@ -73,12 +68,10 @@ struct tick_sched {
 	struct hrtimer			sched_timer;
 	ktime_t				last_tick;
 	ktime_t				next_tick;
-	unsigned long			idle_jiffies;
 	ktime_t				idle_waketime;
 	unsigned int			got_idle_tick;
 
 	/* Idle entry */
-	seqcount_t			idle_sleeptime_seq;
 	ktime_t				idle_entrytime;
 
 	/* Tick stop */
@@ -90,11 +83,6 @@ struct tick_sched {
 	unsigned long			idle_calls;
 	unsigned long			idle_sleeps;
 
-	/* Idle exit */
-	ktime_t				idle_exittime;
-	ktime_t				idle_sleeptime;
-	ktime_t				iowait_sleeptime;
-
 	/* Full dynticks handling */
 	atomic_t			tick_dep_mask;
 
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 488e47e96e93..e77b512e8597 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -154,14 +154,10 @@ static void print_cpu(struct seq_file *m, int cpu, u64 now)
 		P_flag(highres, TS_FLAG_HIGHRES);
 		P_ns(last_tick);
 		P_flag(tick_stopped, TS_FLAG_STOPPED);
-		P(idle_jiffies);
 		P(idle_calls);
 		P(idle_sleeps);
 		P_ns(idle_entrytime);
 		P_ns(idle_waketime);
-		P_ns(idle_exittime);
-		P_ns(idle_sleeptime);
-		P_ns(iowait_sleeptime);
 		P(last_jiffies);
 		P(next_timer);
 		P_ns(idle_expires);
@@ -258,7 +254,7 @@ static void timer_list_show_tickdevices_header(struct seq_file *m)
 
 static inline void timer_list_header(struct seq_file *m, u64 now)
 {
-	SEQ_printf(m, "Timer List Version: v0.10\n");
+	SEQ_printf(m, "Timer List Version: v0.11\n");
 	SEQ_printf(m, "HRTIMER_MAX_CLOCK_BASES: %d\n", HRTIMER_MAX_CLOCK_BASES);
 	SEQ_printf(m, "now at %Ld nsecs\n", (unsigned long long)now);
 	SEQ_printf(m, "\n");
diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index ccc24d30de80..c14ce55674c9 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -90,14 +90,10 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
             text += f"  .{'nohz':15s}: {int(bool(ts['flags'] & TS_FLAG_NOHZ))}\n"
             text += f"  .{'last_tick':15s}: {ts['last_tick']}\n"
             text += f"  .{'tick_stopped':15s}: {int(bool(ts['flags'] & TS_FLAG_STOPPED))}\n"
-            text += f"  .{'idle_jiffies':15s}: {ts['idle_jiffies']}\n"
             text += f"  .{'idle_calls':15s}: {ts['idle_calls']}\n"
             text += f"  .{'idle_sleeps':15s}: {ts['idle_sleeps']}\n"
             text += f"  .{'idle_entrytime':15s}: {ts['idle_entrytime']} nsecs\n"
             text += f"  .{'idle_waketime':15s}: {ts['idle_waketime']} nsecs\n"
-            text += f"  .{'idle_exittime':15s}: {ts['idle_exittime']} nsecs\n"
-            text += f"  .{'idle_sleeptime':15s}: {ts['idle_sleeptime']} nsecs\n"
-            text += f"  .{'iowait_sleeptime':15s}: {ts['iowait_sleeptime']} nsecs\n"
             text += f"  .{'last_jiffies':15s}: {ts['last_jiffies']}\n"
             text += f"  .{'next_timer':15s}: {ts['next_timer']}\n"
             text += f"  .{'idle_expires':15s}: {ts['idle_expires']} nsecs\n"
-- 
2.53.0

