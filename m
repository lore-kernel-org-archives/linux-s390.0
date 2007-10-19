Return-Path: <linux-kernel-owner+w=401wt.eu-S935401AbXJSRXr@vger.kernel.org>
Message-Id: <20071019171944.110782461@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:18:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/10] Add per-cpu idle time / idle count sysfs attributes.
Content-Disposition: inline; filename=002-idle-time.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add two new sysfs entries per cpu: idle_count and idle_time.
idle_count contains the number of times a cpu went into idle state.
idle_time contains the time a cpu spent in idle state in microseconds.
This can be used e.g. by powertop to tell how often idle state is
entered and left.

# cat /sys/devices/system/cpu/cpu0/idle_count 
504
# cat /sys/devices/system/cpu/cpu0/idle_time  
469734037 us

Cc: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |   16 +++++++++++
 arch/s390/kernel/smp.c     |   63 ++++++++++++++++++++++++++++++++++++++++++---
 include/asm-s390/cpu.h     |   25 +++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -44,6 +44,7 @@
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/timer.h>
+#include <asm/cpu.h>
 
 asmlinkage void ret_from_fork(void) asm ("ret_from_fork");
 
@@ -91,6 +92,14 @@ EXPORT_SYMBOL(unregister_idle_notifier);
 
 void do_monitor_call(struct pt_regs *regs, long interruption_code)
 {
+	struct s390_idle_data *idle;
+
+	idle = &__get_cpu_var(s390_idle);
+	spin_lock(&idle->lock);
+	idle->idle_time += get_clock() - idle->idle_enter;
+	idle->in_idle = 0;
+	spin_unlock(&idle->lock);
+
 	/* disable monitor call class 0 */
 	__ctl_clear_bit(8, 15);
 
@@ -105,6 +114,7 @@ extern void s390_handle_mcck(void);
 static void default_idle(void)
 {
 	int cpu, rc;
+	struct s390_idle_data *idle;
 
 	/* CPU is going idle. */
 	cpu = smp_processor_id();
@@ -142,6 +152,12 @@ static void default_idle(void)
 		return;
 	}
 
+	idle = &__get_cpu_var(s390_idle);
+	spin_lock(&idle->lock);
+	idle->idle_count++;
+	idle->in_idle = 1;
+	idle->idle_enter = get_clock();
+	spin_unlock(&idle->lock);
 	trace_hardirqs_on();
 	/* Wait for external, I/O or machine check interrupt. */
 	__load_psw_mask(psw_kernel_bits | PSW_MASK_WAIT |
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -42,6 +42,7 @@
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
 #include <asm/lowcore.h>
+#include <asm/cpu.h>
 
 /*
  * An array with a pointer the lowcore of every CPU.
@@ -494,6 +495,8 @@ int __cpuinit start_secondary(void *cpuv
 	return 0;
 }
 
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
+
 static void __init smp_create_idle(unsigned int cpu)
 {
 	struct task_struct *p;
@@ -506,6 +509,7 @@ static void __init smp_create_idle(unsig
 	if (IS_ERR(p))
 		panic("failed fork for CPU %u: %li", cpu, PTR_ERR(p));
 	current_set[cpu] = p;
+	spin_lock_init(&(&per_cpu(s390_idle, cpu))->lock);
 }
 
 static int cpu_stopped(int cpu)
@@ -724,6 +728,7 @@ void __init smp_prepare_boot_cpu(void)
 	cpu_set(0, cpu_online_map);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
+	spin_lock_init(&(&__get_cpu_var(s390_idle))->lock);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -756,22 +761,71 @@ static ssize_t show_capability(struct sy
 }
 static SYSDEV_ATTR(capability, 0444, show_capability, NULL);
 
+static ssize_t show_idle_count(struct sys_device *dev, char *buf)
+{
+	struct s390_idle_data *idle;
+	unsigned long long idle_count;
+
+	idle = &per_cpu(s390_idle, dev->id);
+	spin_lock_irq(&idle->lock);
+	idle_count = idle->idle_count;
+	spin_unlock_irq(&idle->lock);
+	return sprintf(buf, "%llu\n", idle_count);
+}
+static SYSDEV_ATTR(idle_count, 0444, show_idle_count, NULL);
+
+static ssize_t show_idle_time(struct sys_device *dev, char *buf)
+{
+	struct s390_idle_data *idle;
+	unsigned long long new_time;
+
+	idle = &per_cpu(s390_idle, dev->id);
+	spin_lock_irq(&idle->lock);
+	if (idle->in_idle) {
+		new_time = get_clock();
+		idle->idle_time += new_time - idle->idle_enter;
+		idle->idle_enter = new_time;
+	}
+	new_time = idle->idle_time;
+	spin_unlock_irq(&idle->lock);
+	return sprintf(buf, "%llu us\n", new_time >> 12);
+}
+static SYSDEV_ATTR(idle_time, 0444, show_idle_time, NULL);
+
+static struct attribute *cpu_attrs[] = {
+	&attr_capability.attr,
+	&attr_idle_count.attr,
+	&attr_idle_time.attr,
+	NULL,
+};
+
+static struct attribute_group cpu_attr_group = {
+	.attrs = cpu_attrs,
+};
+
 static int __cpuinit smp_cpu_notify(struct notifier_block *self,
 				    unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned int)(long)hcpu;
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
+	struct s390_idle_data *idle;
 
 	switch (action) {
 	case CPU_ONLINE:
 	case CPU_ONLINE_FROZEN:
-		if (sysdev_create_file(s, &attr_capability))
+		idle = &per_cpu(s390_idle, cpu);
+		spin_lock_irq(&idle->lock);
+		idle->idle_enter = 0;
+		idle->idle_time = 0;
+		idle->idle_count = 0;
+		spin_unlock_irq(&idle->lock);
+		if (sysfs_create_group(&s->kobj, &cpu_attr_group))
 			return NOTIFY_BAD;
 		break;
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
-		sysdev_remove_file(s, &attr_capability);
+		sysfs_remove_group(&s->kobj, &cpu_attr_group);
 		break;
 	}
 	return NOTIFY_OK;
@@ -784,6 +838,7 @@ static struct notifier_block __cpuinitda
 static int __init topology_init(void)
 {
 	int cpu;
+	int rc;
 
 	register_cpu_notifier(&smp_cpu_nb);
 
@@ -796,7 +851,9 @@ static int __init topology_init(void)
 		if (!cpu_online(cpu))
 			continue;
 		s = &c->sysdev;
-		sysdev_create_file(s, &attr_capability);
+		rc = sysfs_create_group(&s->kobj, &cpu_attr_group);
+		if (rc)
+			return rc;
 	}
 	return 0;
 }
Index: quilt-2.6/include/asm-s390/cpu.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/cpu.h
@@ -0,0 +1,25 @@
+/*
+ *  include/asm-s390/cpu.h
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_CPU_H_
+#define _ASM_S390_CPU_H_
+
+#include <linux/types.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
+
+struct s390_idle_data {
+	spinlock_t lock;
+	unsigned int in_idle;
+	unsigned long long idle_count;
+	unsigned long long idle_enter;
+	unsigned long long idle_time;
+};
+
+DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
+
+#endif /* _ASM_S390_CPU_H_ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
