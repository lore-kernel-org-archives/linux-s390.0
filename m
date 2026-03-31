Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BE1C3F0C;
	Tue, 31 Mar 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963067; cv=none; b=DtarcMzh4SghU5W9ha/4EICzAHgjOsT+3ZNh/VtrRi9NWBg8T2yHKxF2s0cSRT7BFdvTF2YhazKIo9G4UTcvu1L2XS08LdbFG/SDDzk+8t7ENyl0Vub5r3Hz03X7fk/O6owUSYXY634jk9bZKKbjuKzj6OvAJdSMzqWNLLMyTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963067; c=relaxed/simple;
	bh=b0ahYWXnH1OlnVL9k+U+tBmKrl/hr/iIMc+t5ZPZsTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1lWkEvLw76ozNmNMBEXfsilHEDxPpL7SZ3seIWeHAuPpsM7BctHgU5uz0KaVPxfqSaRg50+tiCE+JRKFRG/HvDKdRsgRAMVZBHzAWwGbJWd+W+ZjZrf+E4cuZ3bDyJZeIN/bU69zjhCzy3UnZaU2/wCs9hOhgd533ub6PCBSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g247PlHX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g247PlHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED080C2BC9E;
	Tue, 31 Mar 2026 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963066;
	bh=b0ahYWXnH1OlnVL9k+U+tBmKrl/hr/iIMc+t5ZPZsTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g247PlHXKumCwTjBUEPH/OaEm97Ov8XRAiN+XxOLgKeikZwSsUuHEOpgz+lL1Fcll
	 u4tm+fBpVaGBDmc+Hd0er8OJZozmuf1jab1eyiLVQOlghTUrrL9x5mwxzXyM+UX6Qo
	 /r39+MUozV4AJUk4QEu9Y+cGMWBDwbm1O+8f4RsI70Az/uDlGYf6mBmuIFFiQmCxuT
	 8yPpijKwrB5RY8+Mkph0ycgLsCcaLpueAYAd24Jxu3ZIBVf2PGZU4/zHTjxMxe9eYx
	 OThNyt16b8efCE5VXYwaKeNuCagh3SOO6uMCgpmfLBIEnVFdbN7icAFmqJn/EFfVgw
	 nR8+ZCc/81b1w==
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
Subject: [PATCH 10/14] tick/sched: Account tickless idle cputime only when tick is stopped
Date: Tue, 31 Mar 2026 15:16:18 +0200
Message-ID: <20260331131622.30505-11-frederic@kernel.org>
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

There is no real point in switching to dyntick-idle cputime accounting
mode if the tick is not actually stopped. This just adds overhead,
notably fetching the GTOD, on each idle exit and each idle IRQ entry for
no reason during short idle trips.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/time/tick-sched.c | 44 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 0da83d9b324a..923cae35827a 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1144,8 +1144,10 @@ void tick_nohz_idle_stop_tick(void)
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
 
-		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED))
+		if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+			kcpustat_dyntick_start(ts->idle_entrytime);
 			nohz_balance_enter_idle(cpu);
+		}
 	} else {
 		tick_nohz_retain_tick(ts);
 	}
@@ -1187,7 +1189,6 @@ void tick_nohz_idle_enter(void)
 	WARN_ON_ONCE(ts->timer_expires_base);
 	tick_sched_flag_set(ts, TS_FLAG_INIDLE);
 	ts->idle_entrytime = ktime_get();
-	kcpustat_dyntick_start(ts->idle_entrytime);
 	tick_nohz_clock_sleep(ts);
 
 	local_irq_enable();
@@ -1217,9 +1218,10 @@ void tick_nohz_irq_exit(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (tick_sched_flag_test(ts, TS_FLAG_INIDLE)) {
-		ts->idle_entrytime = ktime_get();
-		kcpustat_irq_exit(ts->idle_entrytime);
 		tick_nohz_clock_sleep(ts);
+		ts->idle_entrytime = ktime_get();
+		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
+			kcpustat_irq_exit(ts->idle_entrytime);
 	} else {
 		tick_nohz_full_update_tick(ts);
 	}
@@ -1320,8 +1322,11 @@ void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
+		ktime_t now = ktime_get();
+		kcpustat_dyntick_stop(now);
+		tick_nohz_restart_sched_tick(ts, now);
+	}
 }
 
 static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
@@ -1351,7 +1356,6 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 void tick_nohz_idle_exit(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-	bool idle_active, tick_stopped;
 	ktime_t now;
 
 	local_irq_disable();
@@ -1360,18 +1364,13 @@ void tick_nohz_idle_exit(void)
 	WARN_ON_ONCE(ts->timer_expires_base);
 
 	tick_sched_flag_clear(ts, TS_FLAG_INIDLE);
-	idle_active = tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE);
-	tick_stopped = tick_sched_flag_test(ts, TS_FLAG_STOPPED);
+	tick_nohz_clock_wakeup(ts);
 
-	if (idle_active || tick_stopped)
+	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 		now = ktime_get();
-
-	if (idle_active)
-		tick_nohz_clock_wakeup(ts);
-
-	if (tick_stopped)
+		kcpustat_dyntick_stop(now);
 		tick_nohz_idle_update_tick(ts, now);
-	kcpustat_dyntick_stop(now);
+	}
 
 	local_irq_enable();
 }
@@ -1425,15 +1424,13 @@ static inline void tick_nohz_irq_enter(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now;
 
-	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED | TS_FLAG_IDLE_ACTIVE))
+	tick_nohz_clock_wakeup(ts);
+
+	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED))
 		return;
 
 	now = ktime_get();
-
-	if (tick_sched_flag_test(ts, TS_FLAG_IDLE_ACTIVE)) {
-		tick_nohz_clock_wakeup(ts);
-		kcpustat_irq_enter(now);
-	}
+	kcpustat_irq_enter(now);
 
 	/*
 	 * If all CPUs are idle we may need to update a stale jiffies value.
@@ -1442,8 +1439,7 @@ static inline void tick_nohz_irq_enter(void)
 	 * rare case (typically stop machine). So we must make sure we have a
 	 * last resort.
 	 */
-	if (tick_sched_flag_test(ts, TS_FLAG_STOPPED))
-		tick_nohz_update_jiffies(now);
+	tick_nohz_update_jiffies(now);
 }
 
 #else
-- 
2.53.0

