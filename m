Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79D1C3F0C;
	Tue, 31 Mar 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963096; cv=none; b=srIgHwUa+2ZOFA1hG6PDoepfYSv7p20QNdXl0o5mksqv3mTKkhVFGArAbqjP0mJi8eTLphh+lyUXq/OD1GpCZr5NcywhB7mLa3D2MnLWBRf+4yvi7dRPWpgY5chfNziOyypQuZOj/Kbud+yqxeu4yhQqFP4z4Iy+M0Kq5DZZrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963096; c=relaxed/simple;
	bh=PFIpn22Lqg8nUvYixerHksrQguG7VQqiCjtgoj0+dII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRRnYZ2PoPHATITCRmj86LV6Sy7YlAhAhxipPnlok5a/kaXRMm26v4bvKcDpcazrbxd1IAjydC9YUVdviYYlMPE0YNvaBrtHy/zfZFIcs4VS5JJhmnr4KeTvyOrTxkZl0MWhFliHeEnB8KuVxYnoSKuOwOzGdnfS10JHh4dL2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcjY+/i5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcjY+/i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B76BC2BC9E;
	Tue, 31 Mar 2026 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963096;
	bh=PFIpn22Lqg8nUvYixerHksrQguG7VQqiCjtgoj0+dII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcjY+/i5y/kMyQ5zzBs/8HbtBsPy4rODD3TLaBkViHed+LXJHBdR3Hl4Ou6uEQL1/
	 dh5y2JRw47HtffMZP5vvW6JDLevDFG3rthVqd2dVCUquw82FQw9f/WnKemDfCb6ydo
	 7zkk1apR5DmFqaq6YaEvuktsM7cxFtBOxTKP33IISuWEowhBJYUNt8qVHw/MRVQyif
	 FtmCHCuJIBkqo/w31e+CcNNUhEY21vWe5DD+2vEPKRTmCD9TZ2Io/CfwC2NK7r5Mqe
	 FYokXoKTBVBio+IyccRpfZkPOshlHMzMTAwv6aXrSbzrq6tzoumbKFgRXvqEa3e2Wn
	 Z0LqDOdVIb2Og==
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
Subject: [PATCH 14/14] sched/cputime: Handle dyntick-idle steal time correctly
Date: Tue, 31 Mar 2026 15:16:22 +0200
Message-ID: <20260331131622.30505-15-frederic@kernel.org>
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
 kernel/sched/cputime.c      | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 512104b0ff49..24a54a6151ba 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -39,6 +39,7 @@ struct kernel_cpustat {
 	bool		idle_elapse;
 	seqcount_t	idle_sleeptime_seq;
 	u64		idle_entrytime;
+	u64		idle_stealtime;
 #endif
 	u64		cpustat[NR_STATS];
 };
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a77b6f1dbdca..4ae779b161b5 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -425,19 +425,25 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
 {
 	u64 *cpustat = kc->cpustat;
-	u64 delta;
+	u64 delta, steal, steal_delta;
 
 	if (!kc->idle_elapse)
 		return;
 
 	delta = now - kc->idle_entrytime;
+	steal = steal_account_process_time(delta);
 
 	write_seqcount_begin(&kc->idle_sleeptime_seq);
+	steal_delta = min_t(u64, kc->idle_stealtime, delta);
+	delta -= steal_delta;
+	kc->idle_stealtime -= steal_delta;
+
 	if (nr_iowait_cpu(smp_processor_id()) > 0)
 		cpustat[CPUTIME_IOWAIT] += delta;
 	else
 		cpustat[CPUTIME_IDLE] += delta;
 
+	kc->idle_stealtime += steal;
 	kc->idle_entrytime = now;
 	kc->idle_elapse = false;
 	write_seqcount_end(&kc->idle_sleeptime_seq);
@@ -460,7 +466,6 @@ void kcpustat_dyntick_stop(u64 now)
 		kcpustat_idle_stop(kc, now);
 		kc->idle_dyntick = false;
 		vtime_dyntick_stop();
-		steal_account_process_time(ULONG_MAX);
 	}
 }
 
@@ -504,10 +509,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
 	do {
 		seq = read_seqcount_begin(&kc->idle_sleeptime_seq);
 
-		if (kc->idle_elapse && compute_delta)
-			idle = cpustat[idx] + (now - kc->idle_entrytime);
-		else
-			idle = cpustat[idx];
+		idle = cpustat[idx];
+
+		if (kc->idle_elapse && compute_delta) {
+			u64 delta = now - kc->idle_entrytime;
+
+			delta -= min_t(u64, kc->idle_stealtime, delta);
+			idle += delta;
+		}
 	} while (read_seqcount_retry(&kc->idle_sleeptime_seq, seq));
 
 	return idle;
-- 
2.53.0

