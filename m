Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC853DEAE4;
	Tue, 31 Mar 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962993; cv=none; b=pV8c5f7RszeJPhO4B5+1ACXrWpY8wXMm0Fv9/zcNvv6XfXfryJrpkXrrJb1xOAPOYn6KmhidD2nPvy8w2H1JfiB0eJqiY5D1q6t5YozaN6jHSHe3xnQ3DDEcrv3AT1nKicXJ0q5dNdebALOQh6kclz9YYfElMw8D0dMHBUKzz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962993; c=relaxed/simple;
	bh=3ZPV2KN8EPNGWI/TpDqG6/w8urtND7i6PC8+hEDCYpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIWm4bXc71qdOGXxPj0w2j35DQGkOqYyFMm+Pws+sHOHHf3oFEj7M1qCacV+qc919FZeJvtN/flWgFfkf1N3QtpbyNVfWwlekfmkGKb5WkdGOXkPFXcecfs5NluxKr0ozdcpotRO8n1VV4INb/z1j6BRWOuGrSW9tdvVypPw0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlSVk4hs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlSVk4hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2379FC19423;
	Tue, 31 Mar 2026 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774962993;
	bh=3ZPV2KN8EPNGWI/TpDqG6/w8urtND7i6PC8+hEDCYpU=;
	h=From:To:Cc:Subject:Date:From;
	b=mlSVk4hsKqrfJJ3Fu2vnTKjR9JTi0AJ8OS3+rsEQL54ODPDOHu/uvdqw0bzNsagBW
	 oB2N8bfamYg+iiq9N7SkkPpw7CnErEmvp54wRpJE308vM1m/uvngBLqao3Bunk61bz
	 O6abRhDZ4VRd5Sx2m+GqdX3nIOMxbwD96dJVYfwZYdrCN9QeIQG/V7sDXdwItuXQK4
	 hc3CWuzsMyaWlELQMEieiKGaKj6ze9IUlP24Own3stiQiV7m0U2bXJ7+QmwXGuOnFK
	 gAzphn3zCOy+BK9s8QBeRLLnuF64ROdT+S1juUzYPJgkjefLltpGVzucYHKdUk0H1R
	 KR5uvZeCWWllw==
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
Subject: [PATCH 00/14 v3] tick/sched: Refactor idle cputime accounting
Date: Tue, 31 Mar 2026 15:16:08 +0200
Message-ID: <20260331131622.30505-1-frederic@kernel.org>
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

Changes since v2:

- Add tags

- Fix frenglish

- Add fixup from Heiko to s390 patch

- Drop "cpufreq: ondemand: Simplify idle cputime granularity test" as it's upstream

- Fix cpufreq regression reported by Shrikanth

- Simplfy irqtime handling with relying on kcpustat_idle_dyntick()

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        timers/core-v3

HEAD: e37a063888aac70d4c598ce2ed367f8ce3552a69

Thanks!

Frederic Weisbecker (14):
  sched/idle: Handle offlining first in idle loop
  sched/cputime: Remove superfluous and error prone kcpustat_field()
    parameter
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

 arch/powerpc/kernel/time.c         |  41 ++++
 arch/s390/include/asm/idle.h       |   2 +
 arch/s390/kernel/idle.c            |   5 +-
 arch/s390/kernel/vtime.c           |  57 +++++-
 drivers/cpufreq/cpufreq.c          |  29 +--
 drivers/cpufreq/cpufreq_governor.c |   6 +-
 drivers/macintosh/rack-meter.c     |   2 +-
 fs/proc/stat.c                     |  40 +---
 fs/proc/uptime.c                   |   8 +-
 include/linux/kernel_stat.h        |  76 ++++++--
 include/linux/tick.h               |   4 -
 include/linux/vtime.h              |  22 ++-
 kernel/rcu/tree.c                  |   9 +-
 kernel/rcu/tree_stall.h            |   7 +-
 kernel/sched/cputime.c             | 289 ++++++++++++++++++++++++-----
 kernel/sched/idle.c                |  13 +-
 kernel/time/tick-sched.c           | 202 ++++----------------
 kernel/time/tick-sched.h           |  12 --
 kernel/time/timer_list.c           |   6 +-
 scripts/gdb/linux/timerlist.py     |   4 -
 20 files changed, 481 insertions(+), 353 deletions(-)

-- 
2.53.0

