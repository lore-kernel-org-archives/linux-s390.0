Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A482F8EAD;
	Fri,  8 May 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246352; cv=none; b=PItP0IpwGZZsr2twaXYJ8XW6AIiSnnK2bp9P//CVSElJmWPjbUQIQe22U28apuMRpJrszQtrtBFbFZlojOuiS41Mvz6aqoE1qb83WQAakusKsnXRE6u6edzZEC7DiAydHH8r5eK5lE/bUX8eoTakSLeZMN7l6lXPH6Q7ML62zEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246352; c=relaxed/simple;
	bh=ZjX/QGQBOtdWF89NEwjI8Sd6Nc6B1+H44Jj11M9iRNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms8JUS3nsGUR7MM9PAXXDMHObCQriUQFOg/kqpmfJ+T3jEvBUXn7FJMQVaoxQuMj0MwZzK3qKukOHjZTQUlf/fX5FgA7np0vp/wam04dz1De34eu8e7J2WNqcla9/kVYPrIlXFfsSuJs8lipQDT9KRIjhCQEsmATJW5TcHQdlpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysovb7eN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysovb7eN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382E1C2BCB0;
	Fri,  8 May 2026 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246352;
	bh=ZjX/QGQBOtdWF89NEwjI8Sd6Nc6B1+H44Jj11M9iRNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ysovb7eNkYkPJa7Y4YwjblV8Mxrcy0tbylEObsepug8kgYoUJExyaen1oJu9s0bYa
	 CgtAR/WpjwWvDrqdJbJ2UR4fHPupCBU4ozlEIHPyDoFlIGdswhk44tFgsQ5aAA1je7
	 /6QxKhDX8HAcHrbyEhpgYmIplj+Sl395pQp4+xEUYB6QfNrgRyg61UFDrXdrSu4+nl
	 a21boZPKYWjAneLvHg3aCOVD7Gg9txu50iG7Q6x+Yp9iud4Z/v5dEXYpuJmZU45wFn
	 Jwd7d7Krwuk3mQwa3bVoESLLXc/HKqcQXhwV9xTgrsrs9pS0thbF/A8lJGlwiDCkeE
	 vJrFX6lLhP0UA==
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
Subject: [PATCH 15/15] sched/cputime: Handle dyntick-idle steal time correctly
Date: Fri,  8 May 2026 15:16:47 +0200
Message-ID: <20260508131647.43868-16-frederic@kernel.org>
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

The dyntick-idle steal time is currently accounted when the tick
restarts but the stolen idle time is not subtracted from the idle time
that was already accounted. This is to avoid observing the idle time
going backward as the dyntick-idle cputime accessors can't reliably know
in advance the stolen idle time.

In order to maintain a forward progressing idle cputime while
subtracting idle steal time from it, keep track of the previously
accounted idle stolen time and substract it from _later_ idle cputime
accounting.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/kernel_stat.h |  1 +
 kernel/sched/cputime.c      | 28 +++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 512104b0ff49..fce1392e2140 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -39,6 +39,7 @@ struct kernel_cpustat {
 	bool		idle_elapse;
 	seqcount_t	idle_sleeptime_seq;
 	u64		idle_entrytime;
+	u64		idle_stealtime[2];
 #endif
 	u64		cpustat[NR_STATS];
 };
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 94be22aa5cb6..244b57417240 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -425,19 +425,32 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
 	u64 *cpustat = kc->cpustat;
-	u64 delta;
+	u64 delta, steal, steal_delta;
+	int iowait;
 
 	if (!kc->idle_elapse)
 		return;
 
+	iowait = nr_iowait_cpu(smp_processor_id()) > 0;
 	delta = now - kc->idle_entrytime;
+	steal = steal_account_process_time(delta);
 
+	/*
+	 * Record the idle time after substracting the steal time from
+	 * previous update sequence. Don't substract the steal time from
+	 * the current update sequence to avoid readers moving backward.
+	 */
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
+	steal_delta = min_t(u64, kc->idle_stealtime[iowait], delta);
+	delta -= steal_delta;
+	kc->idle_stealtime[iowait] -= steal_delta;
+
+	if (iowait)
 		cpustat[CPUTIME_IOWAIT] += delta;
 	else
 		cpustat[CPUTIME_IDLE] += delta;
 
+	kc->idle_stealtime[iowait] += steal;
 	kc->idle_entrytime = now;
 	kc->idle_elapse = false;
 	write_seqcount_end(&kc->idle_sleeptime_seq);
@@ -464,7 +477,6 @@ void kcpustat_dyntick_stop(u64 now)
 		kcpustat_idle_stop(kc, now);
 		kc->idle_dyntick = false;
 		vtime_dyntick_stop();
-		steal_account_process_time(ULONG_MAX);
 	}
 }
 
@@ -508,6 +520,7 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 				  bool compute_delta, u64 now)
 {
 	struct kernel_cpustat *kc = &kcpustat_cpu(cpu);
+	int iowait = idx == CPUTIME_IOWAIT;
 	u64 *cpustat = kc->cpustat;
 	unsigned int seq;
 	u64 idle;
@@ -516,8 +529,13 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
 
 		idle = cpustat[idx];
-		if (kc->idle_elapse && compute_delta && now > kc->idle_entrytime)
-			idle += (now - kc->idle_entrytime);
+
+		if (kc->idle_elapse && compute_delta && now > kc->idle_entrytime) {
+			u64 delta = now - kc->idle_entrytime;
+
+			delta -= min_t(u64, kc->idle_stealtime[iowait], delta);
+			idle += delta;
+		}
 	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
 
 	return idle;
-- 
2.53.0

