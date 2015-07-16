Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/23] s390/time: Migrate to new 'set-state' interface
Date: Thu, 16 Jul 2015 16:56:26 +0530
Message-Id: <2acfde0fe9240c30c4d758befb1f54827b171702.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, John Stultz <john.stultz@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Xunlei Pang <pang.xunlei@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

Migrate s390 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in the ->set_mode() callback. So, this patch
doesn't provide any set-state callbacks.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/s390/kernel/time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 9e733d965e08..0a90d17132a9 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -117,11 +117,6 @@ static int s390_next_event(unsigned long delta,
 	return 0;
 }
 
-static void s390_set_mode(enum clock_event_mode mode,
-			  struct clock_event_device *evt)
-{
-}
-
 /*
  * Set up lowcore and control register of the current cpu to
  * enable TOD clock and clock comparator interrupts.
@@ -145,7 +140,6 @@ void init_cpu_timer(void)
 	cd->rating		= 400;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= s390_next_event;
-	cd->set_mode		= s390_set_mode;
 
 	clockevents_register_device(cd);
 
-- 
2.4.0
