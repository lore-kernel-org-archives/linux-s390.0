Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389226AbfFKLVd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 07:21:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BBHe6I072379
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 07:21:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2b0rsbt1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 07:21:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 11 Jun 2019 12:21:30 +0100
Date: Tue, 11 Jun 2019 13:21:24 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH/RFC 2/3] s390: improve wait logic of stop_machine
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
 <20190608110853.35961-3-heiko.carstens@de.ibm.com>
 <20190611091546.GV3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611091546.GV3436@hirez.programming.kicks-ass.net>
Message-Id: <20190611112124.GA20654@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

On Tue, Jun 11, 2019 at 11:15:46AM +0200, Peter Zijlstra wrote:
> On Sat, Jun 08, 2019 at 01:08:52PM +0200, Heiko Carstens wrote:
> > --- a/arch/s390/kernel/processor.c
> > +++ b/arch/s390/kernel/processor.c
> > @@ -31,6 +31,7 @@ struct cpu_info {
> >  };
> >  
> >  static DEFINE_PER_CPU(struct cpu_info, cpu_info);
> > +static DEFINE_PER_CPU(int, cpu_relax_retry);
> >  
> >  static bool machine_has_cpu_mhz;
> >  
> > @@ -58,13 +59,21 @@ void s390_update_cpu_mhz(void)
> >  		on_each_cpu(update_cpu_mhz, NULL, 0);
> >  }
> >  
> > +void notrace cpu_relax_yield(const struct cpumask *cpumask)
> >  {
> > +	int cpu;
> > +
> > +	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
> > +		__this_cpu_write(cpu_relax_retry, 0);
> 
> I don't mind, but do we really need a per-cpu variable for this? Does it
> really matter if you spin on a stack variable and occasionally spin a
> bit longer due to the missed tail of the previous spin?

Well, that would have to be on the stack of the caller of this
function, since this function itself does not spin. I think the idea
was to hide the architecture details from the common code.

> > +		cpu = cpumask_next(smp_processor_id(), cpumask);
> > +		if (cpu >= nr_cpu_ids) {
> > +			cpu = cpumask_first(cpumask);
> > +			if (cpu == smp_processor_id())
> > +				return;
> 
> If this function is passed an empty cpumask, the above will result in
> 'cpu == nr_cpu_ids' and the below might be unhappy with that.
> 
> (FWIW we do have cpumask_next_wrap(), but I admit it is somewhat awkward
> to use)

I gave it a try; still compiles and boots, so must be correct ;)
Updated patch:

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index b0fcbc37b637..445ce9ee4404 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -36,6 +36,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/cpumask.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
 #include <asm/cpu.h>
@@ -225,7 +226,7 @@ static __no_kasan_or_inline unsigned short stap(void)
  * Give up the time slice of the virtual PU.
  */
 #define cpu_relax_yield cpu_relax_yield
-void cpu_relax_yield(void);
+void cpu_relax_yield(const struct cpumask *cpumask);
 
 #define cpu_relax() barrier()
 
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5de13307b703..4cdaefec1b7c 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -31,6 +31,7 @@ struct cpu_info {
 };
 
 static DEFINE_PER_CPU(struct cpu_info, cpu_info);
+static DEFINE_PER_CPU(int, cpu_relax_retry);
 
 static bool machine_has_cpu_mhz;
 
@@ -58,13 +59,19 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax_yield(void)
+void notrace cpu_relax_yield(const struct cpumask *cpumask)
 {
-	if (!smp_cpu_mtid && MACHINE_HAS_DIAG44) {
-		diag_stat_inc(DIAG_STAT_X044);
-		asm volatile("diag 0,0,0x44");
+	int cpu, this_cpu;
+
+	this_cpu = smp_processor_id();
+	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
+		__this_cpu_write(cpu_relax_retry, 0);
+		cpu = cpumask_next_wrap(this_cpu, cpumask, this_cpu, false);
+		if (cpu >= nr_cpu_ids)
+			return;
+		if (arch_vcpu_is_preempted(cpu))
+			smp_yield_cpu(cpu);
 	}
-	barrier();
 }
 EXPORT_SYMBOL(cpu_relax_yield);
 
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 35fafa2b91a8..a8eef7b7770a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -418,7 +418,7 @@ void smp_yield_cpu(int cpu)
 		diag_stat_inc_norecursion(DIAG_STAT_X09C);
 		asm volatile("diag %0,0,0x9c"
 			     : : "d" (pcpu_devices[cpu].address));
-	} else if (MACHINE_HAS_DIAG44) {
+	} else if (MACHINE_HAS_DIAG44 && !smp_cpu_mtid) {
 		diag_stat_inc_norecursion(DIAG_STAT_X044);
 		asm volatile("diag 0,0,0x44");
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..1f9f3160da7e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1519,7 +1519,7 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 #endif
 
 #ifndef cpu_relax_yield
-#define cpu_relax_yield() cpu_relax()
+#define cpu_relax_yield(cpumask) cpu_relax()
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2b5a6754646f..b8b0c5ff8da9 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -183,6 +183,7 @@ static int multi_cpu_stop(void *data)
 	struct multi_stop_data *msdata = data;
 	enum multi_stop_state curstate = MULTI_STOP_NONE;
 	int cpu = smp_processor_id(), err = 0;
+	const struct cpumask *cpumask;
 	unsigned long flags;
 	bool is_active;
 
@@ -192,15 +193,18 @@ static int multi_cpu_stop(void *data)
 	 */
 	local_save_flags(flags);
 
-	if (!msdata->active_cpus)
-		is_active = cpu == cpumask_first(cpu_online_mask);
-	else
-		is_active = cpumask_test_cpu(cpu, msdata->active_cpus);
+	if (!msdata->active_cpus) {
+		cpumask = cpu_online_mask;
+		is_active = cpu == cpumask_first(cpumask);
+	} else {
+		cpumask = msdata->active_cpus;
+		is_active = cpumask_test_cpu(cpu, cpumask);
+	}
 
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax_yield();
+		cpu_relax_yield(cpumask);
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.17.1
