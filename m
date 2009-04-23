Return-Path: <linux-kernel-owner+w=401wt.eu-S1754721AbZDWLsT@vger.kernel.org>
Message-Id: <20090423114725.624459709@de.ibm.com>
References: <20090423114638.865214111@de.ibm.com>
Date: Thu, 23 Apr 2009 13:46:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] /proc/stat idle field for idle cpus
Content-Disposition: inline; filename=003-idle-stat.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The cpu idle field in the output of /proc/stat is too small for cpus
that have been idle for more than a tick. Add the architecture hook
arch_idle_time that allows to add the not accounted idle time of a
sleeping cpu without waking the cpu.

The s390 implementation of arch_idle_time uses the already existing
s390_idle_data per_cpu variable to find the sleep time of a neighboring
idle cpu.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/cputime.h |    4 ++++
 arch/s390/kernel/vtime.c        |   16 ++++++++++++++++
 fs/proc/stat.c                  |    5 +++++
 3 files changed, 25 insertions(+)

Index: quilt-2.6/arch/s390/include/asm/cputime.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/cputime.h
+++ quilt-2.6/arch/s390/include/asm/cputime.h
@@ -174,4 +174,8 @@ cputime64_to_clock_t(cputime64_t cputime
        return __div(cputime, 4096000000ULL / USER_HZ);
 }
 
+cputime64_t s390_get_idle_time(int cpu);
+
+#define arch_idle_time(cpu) s390_get_idle_time(cpu)
+
 #endif /* _S390_CPUTIME_H */
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -240,6 +240,22 @@ void vtime_stop_cpu(void)
 	}
 }
 
+cputime64_t s390_get_idle_time(int cpu)
+{
+	struct s390_idle_data *idle;
+	unsigned long long now, idle_time, idle_enter;
+
+	idle = &per_cpu(s390_idle, cpu);
+	spin_lock(&idle->lock);
+	now = get_clock();
+	idle_time = 0;
+	idle_enter = idle->idle_enter;
+	if (idle_enter != 0ULL && idle_enter < now)
+		idle_time = now - idle_enter;
+	spin_unlock(&idle->lock);
+	return idle_time;
+}
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
Index: quilt-2.6/fs/proc/stat.c
===================================================================
--- quilt-2.6.orig/fs/proc/stat.c
+++ quilt-2.6/fs/proc/stat.c
@@ -18,6 +18,9 @@
 #ifndef arch_irq_stat
 #define arch_irq_stat() 0
 #endif
+#ifndef arch_idle_time
+#define arch_idle_time(cpu) 0
+#endif
 
 static int show_stat(struct seq_file *p, void *v)
 {
@@ -40,6 +43,7 @@ static int show_stat(struct seq_file *p,
 		nice = cputime64_add(nice, kstat_cpu(i).cpustat.nice);
 		system = cputime64_add(system, kstat_cpu(i).cpustat.system);
 		idle = cputime64_add(idle, kstat_cpu(i).cpustat.idle);
+		idle = cputime64_add(idle, arch_idle_time(i));
 		iowait = cputime64_add(iowait, kstat_cpu(i).cpustat.iowait);
 		irq = cputime64_add(irq, kstat_cpu(i).cpustat.irq);
 		softirq = cputime64_add(softirq, kstat_cpu(i).cpustat.softirq);
@@ -69,6 +73,7 @@ static int show_stat(struct seq_file *p,
 		nice = kstat_cpu(i).cpustat.nice;
 		system = kstat_cpu(i).cpustat.system;
 		idle = kstat_cpu(i).cpustat.idle;
+		idle = cputime64_add(idle, arch_idle_time(i));
 		iowait = kstat_cpu(i).cpustat.iowait;
 		irq = kstat_cpu(i).cpustat.irq;
 		softirq = kstat_cpu(i).cpustat.softirq;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
