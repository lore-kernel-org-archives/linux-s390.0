Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B92930F95F;
	Fri,  8 May 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246227; cv=none; b=df0LbJKRnNsYKVbBiBVTD+x/lS2ss1GXBRvt7aDhIiqogG7GhZGR+QAIjHOdxHhCpXfSKQ4c4/Wo6R2PoJCYXwTC1slPXf7Hc3O53z3VlElRBtxd/Tw24vQWexFwVyqW7vNcuCm81Ag9Tjp9g8kfX5eqpnA5MPAwetlBNvcTH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246227; c=relaxed/simple;
	bh=Vta7hllmwFIumsR7obeWKsvWVRLZq990abYtI1WVcNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCX7bKnhUqlP9GHnWZcSpehCGvDR5m6CUifN2MQh8VpcR+M5lawa3pta/4Rktw8w9z2x6ISYPBdh9DaAZBYpcZAVPsAHWT81+s68SJbkXhXAev4L9ZHVE9TPlyeRj8UjnAhRuwA+9t1LndjPs9y+6ezDGiuOCV2O2HON5xQF3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGP5FK9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGP5FK9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1B3C2BCB0;
	Fri,  8 May 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246226;
	bh=Vta7hllmwFIumsR7obeWKsvWVRLZq990abYtI1WVcNk=;
	h=From:To:Cc:Subject:Date:From;
	b=MGP5FK9r9QEOy860Im4ejrteL4FwEhVVu14vipu9Z+cC0I316uNQwgOy0hPfLaVhY
	 zQhpMRfoyyqaX7J92xkQ+LLBJPltZMpkOyxK8CW1LDab4vsyBS15jl9dAajLFcYQ+d
	 kK5YF3Hom2fADVLNDaSgsqvXA0DaQeukbeZ8GVvmIZvU7rBkXPEHxGdUBBENsvirza
	 ARd5MU8U0tleul+fXPjitjj+XOBfZwXLfuLAE6K8/NWnjBl5m1NH7Ymk0sokSPUqTJ
	 I2DswfY8YWOGs4TB0lt1eaRgSZBvqBl+VOwwXu2m22zdvgatVVuQ0wwR7N55pFdd2N
	 d+E2RmzRgmsqQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ben Segall <bsegall@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Sashiko,
	Ingo Molnar <mingo@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Boqun Feng <boqun.feng@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Kieran Bingham <kbingham@kernel.org>,
	Xin Zhao <jackzxcui1989@163.com>,
	linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 00/15 v4] tick/sched: Refactor idle cputime accounting
Date: Fri,  8 May 2026 15:16:32 +0200
Message-ID: <20260508131647.43868-1-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

After the issue reported here:

        https://lore.kernel.org/all/20251210083135.3993562-1-jackzxcui1989@163.com/

It occurs that the idle cputime accounting is a big mess that
accumulates within two concurrent statistics, each having their own
shortcomings:

* The accounting for online CPUs which is based on the delta between
  tick_nohz_start_idle() and tick_nohz_stop_idle().

  Pros:
       - Works when the tick is off

       - Has nsecs granularity

  Cons:
       - Account idle steal time but doesn't substract it from idle
         cputime.

       - Assumes CONFIG_IRQ_TIME_ACCOUNTING by not accounting IRQs but
         the IRQ time is simply ignored when
         CONFIG_IRQ_TIME_ACCOUNTING=n

       - The windows between 1) idle task scheduling and the first call
         to tick_nohz_start_idle() and 2) idle task between the last
         tick_nohz_stop_idle() and the rest of the idle time are
         blindspots wrt. cputime accounting (though mostly insignificant
         amount)

       - Relies on private fields outside of kernel stats, with specific
         accessors.

* The accounting for offline CPUs which is based on ticks and the
  jiffies delta during which the tick was stopped.

  Pros:
       - Handles steal time correctly

       - Handle CONFIG_IRQ_TIME_ACCOUNTING=y and
         CONFIG_IRQ_TIME_ACCOUNTING=n correctly.

       - Handles the whole idle task

       - Accounts directly to kernel stats, without midlayer accumulator.

   Cons:
       - Doesn't elapse when the tick is off, which doesn't make it
         suitable for online CPUs.

       - Has TICK_NSEC granularity (jiffies)

       - Needs to track the dyntick-idle ticks that were accounted and
         substract them from the total jiffies time spent while the tick
         was stopped. This is an ugly workaround.

Having two different accounting for a single context is not the only
problem: since those accountings are of different natures, it is
possible to observe the global idle time going backward after a CPU goes
offline, as reported by Xin Zhao.

Clean up the situation with introducing a hybrid approach that stays
coherent, fixes the backward jumps and works for both online and offline
CPUs:

* Tick based or native vtime accounting operate before the tick is
  stopped and resumes once the tick is restarted.

* When the idle loop starts, switch to dynticks-idle accounting as is
  done currently, except that the statistics accumulate directly to the
  relevant kernel stat fields.

* Private dyntick cputime accounting fields are removed.

* Works on both online and offline case.

* Move most of the relevant code to the common sched/cputime subsystem

* Handle CONFIG_IRQ_TIME_ACCOUNTING=n correctly such that the
  dynticks-idle accounting still elapses while on IRQs.

* Correctly substract idle steal cputime from idle time

Changes since v3 (among which a lot of relevant reviews from Sashiko):

- Add new tags

- Rebase on latest -rc1

- Add "tick/sched: Fix TOCTOU in nohz idle time fetch" (Sashiko)

- Fix buggy state refetch in kcpustat_cpu_fetch_vtime() (Sashiko)

- Fix build issue on powerpc (Christophe Leroy)

- Fix s390 lost steal time occuring on idle IRQs (call vtime_flush() on
  vtime_account_hardirq() and vtime_account_softirq()) (Sashiko)

- Fix build issue on s390

- Fix uninitialized idle_sleeptime_seq (Sashiko)

- Fix irqtime being disabled or enabled in the middle of an idle IRQ
  (Sashiko)
  
- Fix tick restart and then restop in the same idle loop (Sashiko)

- Fix "sched/cputime: Handle idle irqtime gracefully" changelog (Sashiko)

- Fix idle steal time substracted from the wrong index between idle and
  iowait kcpustat. (Sashiko)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core-v4

HEAD: e64ba052ce04e363ff76d3cb8bedc5f812188acb
Thanks,
	Frederic
---

Frederic Weisbecker (15):
      tick/sched: Fix TOCTOU in nohz idle time fetch
      sched/idle: Handle offlining first in idle loop
      sched/cputime: Remove superfluous and error prone kcpustat_field() parameter
      sched/cputime: Correctly support generic vtime idle time
      powerpc/time: Prepare to stop elapsing in dynticks-idle
      s390/time: Prepare to stop elapsing in dynticks-idle
      tick/sched: Unify idle cputime accounting
      tick/sched: Remove nohz disabled special case in cputime fetch
      tick/sched: Move dyntick-idle cputime accounting to cputime code
      tick/sched: Remove unused fields
      tick/sched: Account tickless idle cputime only when tick is stopped
      tick/sched: Consolidate idle time fetching APIs
      sched/cputime: Provide get_cpu_[idle|iowait]_time_us() off-case
      sched/cputime: Handle idle irqtime gracefully
      sched/cputime: Handle dyntick-idle steal time correctly

 arch/powerpc/kernel/time.c         |  41 +++++
 arch/s390/include/asm/idle.h       |   2 +
 arch/s390/kernel/idle.c            |   5 +-
 arch/s390/kernel/vtime.c           |  75 ++++++++-
 drivers/cpufreq/cpufreq.c          |  29 +---
 drivers/cpufreq/cpufreq_governor.c |   6 +-
 drivers/macintosh/rack-meter.c     |   2 +-
 fs/proc/stat.c                     |  40 +----
 fs/proc/uptime.c                   |   8 +-
 include/linux/kernel_stat.h        |  76 +++++++--
 include/linux/tick.h               |   4 -
 include/linux/vtime.h              |  22 ++-
 kernel/rcu/tree.c                  |   9 +-
 kernel/rcu/tree_stall.h            |   7 +-
 kernel/sched/core.c                |   6 +-
 kernel/sched/cputime.c             | 308 +++++++++++++++++++++++++++++++------
 kernel/sched/idle.c                |  13 +-
 kernel/time/tick-sched.c           | 212 ++++++-------------------
 kernel/time/tick-sched.h           |  12 --
 kernel/time/timer_list.c           |   6 +-
 scripts/gdb/linux/timerlist.py     |   4 -
 21 files changed, 529 insertions(+), 358 deletions(-)
