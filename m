Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbfFHLJC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Jun 2019 07:09:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58B6it0027960
        for <linux-s390@vger.kernel.org>; Sat, 8 Jun 2019 07:09:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t09h53m6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 08 Jun 2019 07:09:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 8 Jun 2019 12:08:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 3/3] processor: get rid of cpu_relax_yield
Date: Sat,  8 Jun 2019 13:08:53 +0200
In-Reply-To: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
Message-Id: <20190608110853.35961-4-heiko.carstens@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

stop_machine is the only user left of cpu_relax_yield. Given that it
now has special semantics which are tied to stop_machine introduce a
weak stop_machine_yield function which architectures can override, and
get rid of the generic cpu_relax_yield implementation.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 6 ------
 arch/s390/kernel/processor.c      | 4 ++--
 include/linux/sched.h             | 4 ----
 include/linux/stop_machine.h      | 1 +
 kernel/stop_machine.c             | 7 ++++++-
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 445ce9ee4404..14883b1562e0 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -222,12 +222,6 @@ static __no_kasan_or_inline unsigned short stap(void)
 	return cpu_address;
 }
 
-/*
- * Give up the time slice of the virtual PU.
- */
-#define cpu_relax_yield cpu_relax_yield
-void cpu_relax_yield(const struct cpumask *cpumask);
-
 #define cpu_relax() barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 2c781e2b0078..f84eaf53c397 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -7,6 +7,7 @@
 #define KMSG_COMPONENT "cpu"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/stop_machine.h>
 #include <linux/cpufeature.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -59,7 +60,7 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax_yield(const struct cpumask *cpumask)
+void notrace stop_machine_yield(const struct cpumask *cpumask)
 {
 	int cpu;
 
@@ -75,7 +76,6 @@ void notrace cpu_relax_yield(const struct cpumask *cpumask)
 			smp_yield_cpu(cpu);
 	}
 }
-EXPORT_SYMBOL(cpu_relax_yield);
 
 /*
  * cpu_init - initializes state that is per-CPU.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1f9f3160da7e..911675416b05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1518,10 +1518,6 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 }
 #endif
 
-#ifndef cpu_relax_yield
-#define cpu_relax_yield(cpumask) cpu_relax()
-#endif
-
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
 extern int task_prio(const struct task_struct *p);
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 6d3635c86dbe..f9a0c6189852 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -36,6 +36,7 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
+void stop_machine_yield(const struct cpumask *cpumask);
 
 #else	/* CONFIG_SMP */
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b8b0c5ff8da9..b4f83f7bdf86 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -177,6 +177,11 @@ static void ack_state(struct multi_stop_data *msdata)
 		set_state(msdata, msdata->state + 1);
 }
 
+void __weak stop_machine_yield(const struct cpumask *cpumask)
+{
+	cpu_relax();
+}
+
 /* This is the cpu_stop function which stops the CPU. */
 static int multi_cpu_stop(void *data)
 {
@@ -204,7 +209,7 @@ static int multi_cpu_stop(void *data)
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax_yield(cpumask);
+		stop_machine_yield(cpumask);
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.17.1
