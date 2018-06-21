Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v12 10/11] sched: early boot clock
Date: Thu, 21 Jun 2018 17:25:17 -0400
Message-Id: <20180621212518.19914-11-pasha.tatashin@oracle.com>
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Allow sched_clock() to be used before schec_clock_init() and
sched_clock_init_late() are called. This provides us with a way to get
early boot timestamps on machines with unstable clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/sched/clock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 10c83e73837a..f034392b0f6c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -205,6 +205,11 @@ void clear_sched_clock_stable(void)
  */
 static int __init sched_clock_init_late(void)
 {
+	/* Transition to unstable clock from early clock */
+	local_irq_disable();
+	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
+	local_irq_enable();
+
 	sched_clock_running = 2;
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
@@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
-		return 0ull;
+	/* Use early clock until sched_clock_init_late() */
+	if (unlikely(sched_clock_running < 2))
+		return sched_clock() + __sched_clock_offset;
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
-- 
2.17.1
