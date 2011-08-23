From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/3] use direct ktime path for s390 clockevent device
Date: Tue, 23 Aug 2011 15:29:44 +0200
Message-ID: <20110823133143.153017933@de.ibm.com>
References: <20110823132941.744407154@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline; filename=clockevent-feat-ktime-s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The clock comparator on s390 uses the same format as the TOD clock.
If the value in the clock comparator is smaller than the current TOD
value an interrupt is pending. Use the CLOCK_EVT_FEAT_KTIME feature
to get the unmodified ktime of the next clockevent expiration and
use it to program the clock comparator without querying the TOD clock.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/time.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-clockevents/arch/s390/kernel/time.c
===================================================================
--- linux-clockevents.orig/arch/s390/kernel/time.c	2011-05-31 12:30:48.082228487 +0200
+++ linux-clockevents/arch/s390/kernel/time.c	2011-08-23 15:16:03.219640374 +0200
@@ -109,10 +109,14 @@
 	set_clock_comparator(S390_lowcore.clock_comparator);
 }
 
-static int s390_next_event(unsigned long delta,
+static int s390_next_ktime(ktime_t expires,
 			   struct clock_event_device *evt)
 {
-	S390_lowcore.clock_comparator = get_clock() + delta;
+	s64 nsecs;
+
+	nsecs = ktime_to_ns(ktime_sub(expires, ktime_get_monotonic_offset()));
+	do_div(nsecs, 125);
+	S390_lowcore.clock_comparator = TOD_UNIX_EPOCH + (nsecs << 9);
 	set_clock_comparator(S390_lowcore.clock_comparator);
 	return 0;
 }
@@ -137,14 +141,15 @@
 	cpu = smp_processor_id();
 	cd = &per_cpu(comparators, cpu);
 	cd->name		= "comparator";
-	cd->features		= CLOCK_EVT_FEAT_ONESHOT;
+	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_KTIME;
 	cd->mult		= 16777;
 	cd->shift		= 12;
 	cd->min_delta_ns	= 1;
 	cd->max_delta_ns	= LONG_MAX;
 	cd->rating		= 400;
 	cd->cpumask		= cpumask_of(cpu);
-	cd->set_next_event	= s390_next_event;
+	cd->set_next_ktime	= s390_next_ktime;
 	cd->set_mode		= s390_set_mode;
 
 	clockevents_register_device(cd);
