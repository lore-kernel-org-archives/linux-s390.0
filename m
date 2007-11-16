Return-Path: <linux-kernel-owner+w=401wt.eu-S1756635AbXKPOgW@vger.kernel.org>
Message-Id: <20071116143321.735302368@de.ibm.com>
References: <20071116142942.978412023@de.ibm.com>
Date: Fri, 16 Nov 2007 15:29:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/6] Standby cpu activation/deactivation.
Content-Disposition: inline; filename=103-sclp-cpu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use the sclp interface so that also standby cpus can be activated and
deactivated. CPUs that are brought offline will be automatically put
in standby state.
If a logical cpu is brought online the first cpu in stopped state will
be used. If none is available the first standby cpu will be used.
On IPL only configured cpus will be used. And on reboot/shutdown all
cpus will remain in their current state (configured/standby).

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c      |    3 
 arch/s390/kernel/setup.c      |    2 
 arch/s390/kernel/smp.c        |  401 ++++++++++++++++++++++++++++++++++--------
 drivers/s390/char/Makefile    |    2 
 drivers/s390/char/sclp.h      |    4 
 drivers/s390/char/sclp_cmd.c  |  319 +++++++++++++++++++++++++++++++++
 drivers/s390/char/sclp_info.c |  116 ------------
 include/asm-s390/sclp.h       |   21 ++
 8 files changed, 675 insertions(+), 193 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/early.c linux-2.6-patched/arch/s390/kernel/early.c
--- linux-2.6/arch/s390/kernel/early.c	2007-11-16 14:27:46.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/early.c	2007-11-16 14:27:48.000000000 +0100
@@ -276,8 +276,9 @@ void __init startup_init(void)
 	create_kernel_nss();
 	sort_main_extable();
 	setup_lowcore_early();
-	sclp_readinfo_early();
+	sclp_read_info_early();
 	sclp_facilities_detect();
+	sclp_read_cpu_info_early();
 	memsize = sclp_memory_detect();
 #ifndef CONFIG_64BIT
 	/*
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2007-11-16 14:27:41.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2007-11-16 14:27:48.000000000 +0100
@@ -922,7 +922,7 @@ setup_arch(char **cmdline_p)
 
 void __cpuinit print_cpu_info(struct cpuinfo_S390 *cpuinfo)
 {
-   printk("cpu %d "
+   printk(KERN_INFO "cpu %d "
 #ifdef CONFIG_SMP
            "phys_idx=%d "
 #endif
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2007-11-16 14:27:44.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2007-11-16 14:27:48.000000000 +0100
@@ -42,6 +42,7 @@
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
 #include <asm/lowcore.h>
+#include <asm/sclp.h>
 #include <asm/cpu.h>
 
 /*
@@ -58,6 +59,22 @@ EXPORT_SYMBOL(cpu_possible_map);
 
 static struct task_struct *current_set[NR_CPUS];
 
+static u8 smp_cpu_type;
+static int smp_use_sigp_detection;
+
+enum s390_cpu_state {
+	CPU_STATE_STANDBY,
+	CPU_STATE_CONFIGURED,
+};
+
+#ifdef CONFIG_HOTPLUG_CPU
+static DEFINE_MUTEX(smp_cpu_state_mutex);
+#endif
+static int smp_cpu_state[NR_CPUS];
+
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
+
 static void smp_ext_bitcall(int, ec_bit_sig);
 
 /*
@@ -355,6 +372,13 @@ void smp_ctl_clear_bit(int cr, int bit)
 }
 EXPORT_SYMBOL(smp_ctl_clear_bit);
 
+/*
+ * In early ipl state a temp. logically cpu number is needed, so the sigp
+ * functions can be used to sense other cpus. Since NR_CPUS is >= 2 on
+ * CONFIG_SMP and the ipl cpu is logical cpu 0, it must be 1.
+ */
+#define CPU_INIT_NO	1
+
 #if defined(CONFIG_ZFCPDUMP) || defined(CONFIG_ZFCPDUMP_MODULE)
 
 /*
@@ -376,8 +400,9 @@ static void __init smp_get_save_area(uns
 		return;
 	}
 	zfcpdump_save_areas[cpu] = alloc_bootmem(sizeof(union save_area));
-	__cpu_logical_map[1] = (__u16) phy_cpu;
-	while (signal_processor(1, sigp_stop_and_store_status) == sigp_busy)
+	__cpu_logical_map[CPU_INIT_NO] = (__u16) phy_cpu;
+	while (signal_processor(CPU_INIT_NO, sigp_stop_and_store_status) ==
+	       sigp_busy)
 		cpu_relax();
 	memcpy(zfcpdump_save_areas[cpu],
 	       (void *)(unsigned long) store_prefix() + SAVE_AREA_BASE,
@@ -397,32 +422,166 @@ static inline void smp_get_save_area(uns
 
 #endif /* CONFIG_ZFCPDUMP || CONFIG_ZFCPDUMP_MODULE */
 
+static int cpu_stopped(int cpu)
+{
+	__u32 status;
+
+	/* Check for stopped state */
+	if (signal_processor_ps(&status, 0, cpu, sigp_sense) ==
+	    sigp_status_stored) {
+		if (status & 0x40)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Lets check how many CPUs we have.
  */
-static unsigned int __init smp_count_cpus(void)
+static void __init smp_count_cpus(unsigned int *configured_cpus,
+				  unsigned int *standby_cpus)
 {
-	unsigned int cpu, num_cpus;
-	__u16 boot_cpu_addr;
+	unsigned int cpu;
+	struct sclp_cpu_info *info;
+	u16 boot_cpu_addr, cpu_addr;
 
-	/*
-	 * cpu 0 is the boot cpu. See smp_prepare_boot_cpu.
-	 */
 	boot_cpu_addr = S390_lowcore.cpu_data.cpu_addr;
 	current_thread_info()->cpu = 0;
-	num_cpus = 1;
-	for (cpu = 0; cpu <= 65535; cpu++) {
-		if ((__u16) cpu == boot_cpu_addr)
+	*configured_cpus = 1;
+	*standby_cpus = 0;
+
+	info = alloc_bootmem_pages(sizeof(*info));
+	if (!info)
+		disabled_wait((unsigned long) __builtin_return_address(0));
+
+	/* Use sigp detection algorithm if sclp doesn't work. */
+	if (sclp_get_cpu_info(info)) {
+		smp_use_sigp_detection = 1;
+		for (cpu = 0; cpu <= 65535; cpu++) {
+			if (cpu == boot_cpu_addr)
+				continue;
+			__cpu_logical_map[CPU_INIT_NO] = cpu;
+			if (cpu_stopped(CPU_INIT_NO))
+				(*configured_cpus)++;
+		}
+		goto out;
+	}
+
+	if (info->has_cpu_type) {
+		for (cpu = 0; cpu < info->combined; cpu++) {
+			if (info->cpu[cpu].address == boot_cpu_addr) {
+				smp_cpu_type = info->cpu[cpu].type;
+				break;
+			}
+		}
+	}
+	/* Count cpus. */
+	for (cpu = 0; cpu < info->combined; cpu++) {
+		if (info->has_cpu_type && info->cpu[cpu].type != smp_cpu_type)
 			continue;
-		__cpu_logical_map[1] = (__u16) cpu;
-		if (signal_processor(1, sigp_sense) == sigp_not_operational)
+		cpu_addr = info->cpu[cpu].address;
+		if (cpu_addr == boot_cpu_addr)
 			continue;
-		smp_get_save_area(num_cpus, cpu);
-		num_cpus++;
+		__cpu_logical_map[CPU_INIT_NO] = cpu_addr;
+		if (!cpu_stopped(CPU_INIT_NO)) {
+			(*standby_cpus)++;
+			continue;
+		}
+		smp_get_save_area(*configured_cpus, cpu_addr);
+		(*configured_cpus)++;
 	}
-	printk("Detected %d CPU's\n", (int) num_cpus);
-	printk("Boot cpu address %2X\n", boot_cpu_addr);
-	return num_cpus;
+out:
+	printk(KERN_INFO "CPUs: %d configured, %d standby\n",
+	       *configured_cpus, *standby_cpus);
+	free_bootmem((unsigned long) info, sizeof(*info));
+}
+
+static int cpu_known(int cpu_id)
+{
+	int cpu;
+
+	for_each_present_cpu(cpu) {
+		if (__cpu_logical_map[cpu] == cpu_id)
+			return 1;
+	}
+	return 0;
+}
+
+static int smp_rescan_cpus_sigp(cpumask_t avail)
+{
+	int cpu_id, logical_cpu;
+
+	logical_cpu = first_cpu(avail);
+	if (logical_cpu == NR_CPUS)
+		return 0;
+	for (cpu_id = 0; cpu_id <= 65535; cpu_id++) {
+		if (cpu_known(cpu_id))
+			continue;
+		__cpu_logical_map[logical_cpu] = cpu_id;
+		if (!cpu_stopped(logical_cpu))
+			continue;
+		cpu_set(logical_cpu, cpu_present_map);
+		smp_cpu_state[logical_cpu] = CPU_STATE_CONFIGURED;
+		logical_cpu = next_cpu(logical_cpu, avail);
+		if (logical_cpu == NR_CPUS)
+			break;
+	}
+	return 0;
+}
+
+static int __init_refok smp_rescan_cpus_sclp(cpumask_t avail)
+{
+	struct sclp_cpu_info *info;
+	int cpu_id, logical_cpu, cpu;
+	int rc;
+
+	logical_cpu = first_cpu(avail);
+	if (logical_cpu == NR_CPUS)
+		return 0;
+	if (slab_is_available())
+		info = kmalloc(sizeof(*info), GFP_KERNEL);
+	else
+		info = alloc_bootmem(sizeof(*info));
+	if (!info)
+		return -ENOMEM;
+	rc = sclp_get_cpu_info(info);
+	if (rc)
+		goto out;
+	for (cpu = 0; cpu < info->combined; cpu++) {
+		if (info->has_cpu_type && info->cpu[cpu].type != smp_cpu_type)
+			continue;
+		cpu_id = info->cpu[cpu].address;
+		if (cpu_known(cpu_id))
+			continue;
+		__cpu_logical_map[logical_cpu] = cpu_id;
+		cpu_set(logical_cpu, cpu_present_map);
+		if (cpu >= info->configured)
+			smp_cpu_state[logical_cpu] = CPU_STATE_STANDBY;
+		else
+			smp_cpu_state[logical_cpu] = CPU_STATE_CONFIGURED;
+		logical_cpu = next_cpu(logical_cpu, avail);
+		if (logical_cpu == NR_CPUS)
+			break;
+	}
+out:
+	if (slab_is_available())
+		kfree(info);
+	else
+		free_bootmem((unsigned long) info, sizeof(*info));
+	return rc;
+}
+
+static int smp_rescan_cpus(void)
+{
+	cpumask_t avail;
+
+	cpus_setall(avail);
+	cpus_and(avail, avail, cpu_possible_map);
+	cpus_andnot(avail, avail, cpu_present_map);
+	if (smp_use_sigp_detection)
+		return smp_rescan_cpus_sigp(avail);
+	else
+		return smp_rescan_cpus_sclp(avail);
 }
 
 /*
@@ -453,8 +612,6 @@ int __cpuinit start_secondary(void *cpuv
 	return 0;
 }
 
-DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
-
 static void __init smp_create_idle(unsigned int cpu)
 {
 	struct task_struct *p;
@@ -470,37 +627,16 @@ static void __init smp_create_idle(unsig
 	spin_lock_init(&(&per_cpu(s390_idle, cpu))->lock);
 }
 
-static int cpu_stopped(int cpu)
-{
-	__u32 status;
-
-	/* Check for stopped state */
-	if (signal_processor_ps(&status, 0, cpu, sigp_sense) ==
-	    sigp_status_stored) {
-		if (status & 0x40)
-			return 1;
-	}
-	return 0;
-}
-
 /* Upping and downing of CPUs */
-
 int __cpu_up(unsigned int cpu)
 {
 	struct task_struct *idle;
 	struct _lowcore *cpu_lowcore;
 	struct stack_frame *sf;
 	sigp_ccode ccode;
-	int curr_cpu;
 
-	for (curr_cpu = 0; curr_cpu <= 65535; curr_cpu++) {
-		__cpu_logical_map[cpu] = (__u16) curr_cpu;
-		if (cpu_stopped(cpu))
-			break;
-	}
-
-	if (!cpu_stopped(cpu))
-		return -ENODEV;
+	if (smp_cpu_state[cpu] != CPU_STATE_CONFIGURED)
+		return -EIO;
 
 	ccode = signal_processor_p((__u32)(unsigned long)(lowcore_ptr[cpu]),
 				   cpu, sigp_set_prefix);
@@ -543,21 +679,18 @@ static unsigned int __initdata possible_
 
 void __init smp_setup_cpu_possible_map(void)
 {
-	unsigned int phy_cpus, pos_cpus, cpu;
-
-	phy_cpus = smp_count_cpus();
-	pos_cpus = min(phy_cpus + additional_cpus, (unsigned int) NR_CPUS);
+	unsigned int pos_cpus, cpu;
+	unsigned int configured_cpus, standby_cpus;
 
+	smp_count_cpus(&configured_cpus, &standby_cpus);
+	pos_cpus = min(configured_cpus + standby_cpus + additional_cpus,
+		       (unsigned int) NR_CPUS);
 	if (possible_cpus)
 		pos_cpus = min(possible_cpus, (unsigned int) NR_CPUS);
-
 	for (cpu = 0; cpu < pos_cpus; cpu++)
 		cpu_set(cpu, cpu_possible_map);
-
-	phy_cpus = min(phy_cpus, pos_cpus);
-
-	for (cpu = 0; cpu < phy_cpus; cpu++)
-		cpu_set(cpu, cpu_present_map);
+	cpu_present_map = cpumask_of_cpu(0);
+	smp_rescan_cpus();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -612,7 +745,7 @@ void __cpu_die(unsigned int cpu)
 	/* Wait until target cpu is down */
 	while (!smp_cpu_not_running(cpu))
 		cpu_relax();
-	printk("Processor %d spun down\n", cpu);
+	printk(KERN_INFO "Processor %d spun down\n", cpu);
 }
 
 void cpu_die(void)
@@ -686,12 +819,12 @@ void __init smp_prepare_boot_cpu(void)
 	cpu_set(0, cpu_online_map);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
+	smp_cpu_state[0] = CPU_STATE_CONFIGURED;
 	spin_lock_init(&(&__get_cpu_var(s390_idle))->lock);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	cpu_present_map = cpu_possible_map;
 }
 
 /*
@@ -705,7 +838,79 @@ int setup_profiling_timer(unsigned int m
 	return 0;
 }
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+#ifdef CONFIG_HOTPLUG_CPU
+static ssize_t cpu_configure_show(struct sys_device *dev, char *buf)
+{
+	ssize_t count;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	count = sprintf(buf, "%d\n", smp_cpu_state[dev->id]);
+	mutex_unlock(&smp_cpu_state_mutex);
+	return count;
+}
+
+static ssize_t cpu_configure_store(struct sys_device *dev, const char *buf,
+				   size_t count)
+{
+	int cpu = dev->id;
+	int val, rc;
+	char delim;
+
+	if (sscanf(buf, "%d %c", &val, &delim) != 1)
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	lock_cpu_hotplug();
+	rc = -EBUSY;
+	if (cpu_online(cpu))
+		goto out;
+	rc = 0;
+	switch (val) {
+	case 0:
+		if (smp_cpu_state[cpu] == CPU_STATE_CONFIGURED) {
+			rc = sclp_cpu_deconfigure(__cpu_logical_map[cpu]);
+			if (!rc)
+				smp_cpu_state[cpu] = CPU_STATE_STANDBY;
+		}
+		break;
+	case 1:
+		if (smp_cpu_state[cpu] == CPU_STATE_STANDBY) {
+			rc = sclp_cpu_configure(__cpu_logical_map[cpu]);
+			if (!rc)
+				smp_cpu_state[cpu] = CPU_STATE_CONFIGURED;
+		}
+		break;
+	default:
+		break;
+	}
+out:
+	unlock_cpu_hotplug();
+	mutex_unlock(&smp_cpu_state_mutex);
+	return rc ? rc : count;
+}
+static SYSDEV_ATTR(configure, 0644, cpu_configure_show, cpu_configure_store);
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static ssize_t show_cpu_address(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n", __cpu_logical_map[dev->id]);
+}
+static SYSDEV_ATTR(address, 0444, show_cpu_address, NULL);
+
+
+static struct attribute *cpu_common_attrs[] = {
+#ifdef CONFIG_HOTPLUG_CPU
+	&attr_configure.attr,
+#endif
+	&attr_address.attr,
+	NULL,
+};
+
+static struct attribute_group cpu_common_attr_group = {
+	.attrs = cpu_common_attrs,
+};
 
 static ssize_t show_capability(struct sys_device *dev, char *buf)
 {
@@ -750,15 +955,15 @@ static ssize_t show_idle_time(struct sys
 }
 static SYSDEV_ATTR(idle_time_us, 0444, show_idle_time, NULL);
 
-static struct attribute *cpu_attrs[] = {
+static struct attribute *cpu_online_attrs[] = {
 	&attr_capability.attr,
 	&attr_idle_count.attr,
 	&attr_idle_time_us.attr,
 	NULL,
 };
 
-static struct attribute_group cpu_attr_group = {
-	.attrs = cpu_attrs,
+static struct attribute_group cpu_online_attr_group = {
+	.attrs = cpu_online_attrs,
 };
 
 static int __cpuinit smp_cpu_notify(struct notifier_block *self,
@@ -778,12 +983,12 @@ static int __cpuinit smp_cpu_notify(stru
 		idle->idle_time = 0;
 		idle->idle_count = 0;
 		spin_unlock_irq(&idle->lock);
-		if (sysfs_create_group(&s->kobj, &cpu_attr_group))
+		if (sysfs_create_group(&s->kobj, &cpu_online_attr_group))
 			return NOTIFY_BAD;
 		break;
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
-		sysfs_remove_group(&s->kobj, &cpu_attr_group);
+		sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
 		break;
 	}
 	return NOTIFY_OK;
@@ -793,6 +998,62 @@ static struct notifier_block __cpuinitda
 	.notifier_call = smp_cpu_notify,
 };
 
+static int smp_add_present_cpu(int cpu)
+{
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+	struct sys_device *s = &c->sysdev;
+	int rc;
+
+	c->hotpluggable = 1;
+	rc = register_cpu(c, cpu);
+	if (rc)
+		goto out;
+	rc = sysfs_create_group(&s->kobj, &cpu_common_attr_group);
+	if (rc)
+		goto out_cpu;
+	if (!cpu_online(cpu))
+		goto out;
+	rc = sysfs_create_group(&s->kobj, &cpu_online_attr_group);
+	if (!rc)
+		return 0;
+	sysfs_remove_group(&s->kobj, &cpu_common_attr_group);
+out_cpu:
+#ifdef CONFIG_HOTPLUG_CPU
+	unregister_cpu(c);
+#endif
+out:
+	return rc;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static ssize_t rescan_store(struct sys_device *dev, const char *buf,
+			    size_t count)
+{
+	cpumask_t newcpus;
+	int cpu;
+	int rc;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	lock_cpu_hotplug();
+	newcpus = cpu_present_map;
+	rc = smp_rescan_cpus();
+	if (rc)
+		goto out;
+	cpus_andnot(newcpus, cpu_present_map, newcpus);
+	for_each_cpu_mask(cpu, newcpus) {
+		rc = smp_add_present_cpu(cpu);
+		if (rc)
+			cpu_clear(cpu, cpu_present_map);
+	}
+	rc = 0;
+out:
+	unlock_cpu_hotplug();
+	mutex_unlock(&smp_cpu_state_mutex);
+	return rc ? rc : count;
+}
+static SYSDEV_ATTR(rescan, 0200, NULL, rescan_store);
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static int __init topology_init(void)
 {
 	int cpu;
@@ -800,16 +1061,14 @@ static int __init topology_init(void)
 
 	register_cpu_notifier(&smp_cpu_nb);
 
-	for_each_possible_cpu(cpu) {
-		struct cpu *c = &per_cpu(cpu_devices, cpu);
-		struct sys_device *s = &c->sysdev;
-
-		c->hotpluggable = 1;
-		register_cpu(c, cpu);
-		if (!cpu_online(cpu))
-			continue;
-		s = &c->sysdev;
-		rc = sysfs_create_group(&s->kobj, &cpu_attr_group);
+#ifdef CONFIG_HOTPLUG_CPU
+	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			       &attr_rescan.attr);
+	if (rc)
+		return rc;
+#endif
+	for_each_present_cpu(cpu) {
+		rc = smp_add_present_cpu(cpu);
 		if (rc)
 			return rc;
 	}
diff -urpN linux-2.6/drivers/s390/char/Makefile linux-2.6-patched/drivers/s390/char/Makefile
--- linux-2.6/drivers/s390/char/Makefile	2007-11-16 14:27:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/Makefile	2007-11-16 14:27:48.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
-	 sclp_info.o sclp_config.o sclp_chp.o sclp_cpi_sys.o
+	 sclp_cmd.o sclp_config.o sclp_chp.o sclp_cpi_sys.o
 
 obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
diff -urpN linux-2.6/drivers/s390/char/sclp_cmd.c linux-2.6-patched/drivers/s390/char/sclp_cmd.c
--- linux-2.6/drivers/s390/char/sclp_cmd.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp_cmd.c	2007-11-16 14:27:48.000000000 +0100
@@ -0,0 +1,319 @@
+/*
+ *  drivers/s390/char/sclp_cmd.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#include <linux/completion.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <asm/sclp.h>
+#include "sclp.h"
+
+#define TAG	"sclp_cmd: "
+
+#define SCLP_CMDW_READ_SCP_INFO		0x00020001
+#define SCLP_CMDW_READ_SCP_INFO_FORCED	0x00120001
+
+struct read_info_sccb {
+	struct	sccb_header header;	/* 0-7 */
+	u16	rnmax;			/* 8-9 */
+	u8	rnsize;			/* 10 */
+	u8	_reserved0[24 - 11];	/* 11-15 */
+	u8	loadparm[8];		/* 24-31 */
+	u8	_reserved1[48 - 32];	/* 32-47 */
+	u64	facilities;		/* 48-55 */
+	u8	_reserved2[84 - 56];	/* 56-83 */
+	u8	fac84;			/* 84 */
+	u8	_reserved3[91 - 85];	/* 85-90 */
+	u8	flags;			/* 91 */
+	u8	_reserved4[100 - 92];	/* 92-99 */
+	u32	rnsize2;		/* 100-103 */
+	u64	rnmax2;			/* 104-111 */
+	u8	_reserved5[4096 - 112];	/* 112-4095 */
+} __attribute__((packed, aligned(PAGE_SIZE)));
+
+static struct read_info_sccb __initdata early_read_info_sccb;
+static int __initdata early_read_info_sccb_valid;
+
+u64 sclp_facilities;
+static u8 sclp_fac84;
+
+static int __init sclp_cmd_sync_early(sclp_cmdw_t cmd, void *sccb)
+{
+	int rc;
+
+	__ctl_set_bit(0, 9);
+	rc = sclp_service_call(cmd, sccb);
+	if (rc)
+		goto out;
+	__load_psw_mask(PSW_BASE_BITS | PSW_MASK_EXT |
+			PSW_MASK_WAIT | PSW_DEFAULT_KEY);
+	local_irq_disable();
+out:
+	/* Contents of the sccb might have changed. */
+	barrier();
+	__ctl_clear_bit(0, 9);
+	return rc;
+}
+
+void __init sclp_read_info_early(void)
+{
+	int rc;
+	int i;
+	struct read_info_sccb *sccb;
+	sclp_cmdw_t commands[] = {SCLP_CMDW_READ_SCP_INFO_FORCED,
+				  SCLP_CMDW_READ_SCP_INFO};
+
+	sccb = &early_read_info_sccb;
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		do {
+			memset(sccb, 0, sizeof(*sccb));
+			sccb->header.length = sizeof(*sccb);
+			sccb->header.control_mask[2] = 0x80;
+			rc = sclp_cmd_sync_early(commands[i], sccb);
+		} while (rc == -EBUSY);
+
+		if (rc)
+			break;
+		if (sccb->header.response_code == 0x10) {
+			early_read_info_sccb_valid = 1;
+			break;
+		}
+		if (sccb->header.response_code != 0x1f0)
+			break;
+	}
+}
+
+void __init sclp_facilities_detect(void)
+{
+	if (!early_read_info_sccb_valid)
+		return;
+	sclp_facilities = early_read_info_sccb.facilities;
+	sclp_fac84 = early_read_info_sccb.fac84;
+}
+
+unsigned long long __init sclp_memory_detect(void)
+{
+	unsigned long long memsize;
+	struct read_info_sccb *sccb;
+
+	if (!early_read_info_sccb_valid)
+		return 0;
+	sccb = &early_read_info_sccb;
+	if (sccb->rnsize)
+		memsize = sccb->rnsize << 20;
+	else
+		memsize = sccb->rnsize2 << 20;
+	if (sccb->rnmax)
+		memsize *= sccb->rnmax;
+	else
+		memsize *= sccb->rnmax2;
+	return memsize;
+}
+
+/*
+ * This function will be called after sclp_memory_detect(), which gets called
+ * early from early.c code. Therefore the sccb should have valid contents.
+ */
+void __init sclp_get_ipl_info(struct sclp_ipl_info *info)
+{
+	struct read_info_sccb *sccb;
+
+	if (!early_read_info_sccb_valid)
+		return;
+	sccb = &early_read_info_sccb;
+	info->is_valid = 1;
+	if (sccb->flags & 0x2)
+		info->has_dump = 1;
+	memcpy(&info->loadparm, &sccb->loadparm, LOADPARM_LEN);
+}
+
+static void sclp_sync_callback(struct sclp_req *req, void *data)
+{
+	struct completion *completion = data;
+
+	complete(completion);
+}
+
+static int do_sync_request(sclp_cmdw_t cmd, void *sccb)
+{
+	struct completion completion;
+	struct sclp_req *request;
+	int rc;
+
+	request = kzalloc(sizeof(*request), GFP_KERNEL);
+	if (!request)
+		return -ENOMEM;
+	request->command = cmd;
+	request->sccb = sccb;
+	request->status = SCLP_REQ_FILLED;
+	request->callback = sclp_sync_callback;
+	request->callback_data = &completion;
+	init_completion(&completion);
+
+	/* Perform sclp request. */
+	rc = sclp_add_request(request);
+	if (rc)
+		goto out;
+	wait_for_completion(&completion);
+
+	/* Check response. */
+	if (request->status != SCLP_REQ_DONE) {
+		printk(KERN_WARNING TAG "sync request failed "
+		       "(cmd=0x%08x, status=0x%02x)\n", cmd, request->status);
+		rc = -EIO;
+	}
+out:
+	kfree(request);
+	return rc;
+}
+
+/*
+ * CPU configuration related functions.
+ */
+
+#define SCLP_CMDW_READ_CPU_INFO		0x00010001
+#define SCLP_CMDW_CONFIGURE_CPU		0x00110001
+#define SCLP_CMDW_DECONFIGURE_CPU	0x00100001
+
+struct read_cpu_info_sccb {
+	struct	sccb_header header;
+	u16	nr_configured;
+	u16	offset_configured;
+	u16	nr_standby;
+	u16	offset_standby;
+	u8	reserved[4096 - 16];
+} __attribute__((packed, aligned(PAGE_SIZE)));
+
+static struct read_cpu_info_sccb __initdata early_read_cpu_info_sccb;
+static struct sclp_cpu_info __initdata sclp_cpu_info;
+
+static void sclp_fill_cpu_info(struct sclp_cpu_info *info,
+			       struct read_cpu_info_sccb *sccb)
+{
+	char *page = (char *) sccb;
+
+	memset(info, 0, sizeof(*info));
+	info->configured = sccb->nr_configured;
+	info->standby = sccb->nr_standby;
+	info->combined = sccb->nr_configured + sccb->nr_standby;
+	info->has_cpu_type = sclp_fac84 & 0x1;
+	memcpy(&info->cpu, page + sccb->offset_configured,
+	       info->combined * sizeof(struct sclp_cpu_entry));
+}
+
+void __init sclp_read_cpu_info_early(void)
+{
+	int rc;
+	struct read_cpu_info_sccb *sccb;
+
+	if (!SCLP_HAS_CPU_INFO)
+		return;
+
+	sccb = &early_read_cpu_info_sccb;
+	do {
+		memset(sccb, 0, sizeof(*sccb));
+		sccb->header.length = sizeof(*sccb);
+		rc = sclp_cmd_sync_early(SCLP_CMDW_READ_CPU_INFO, sccb);
+	} while (rc == -EBUSY);
+
+	if (rc)
+		return;
+	if (sccb->header.response_code != 0x10)
+		return;
+	sclp_fill_cpu_info(&sclp_cpu_info, sccb);
+}
+
+static int __init sclp_get_cpu_info_early(struct sclp_cpu_info *info)
+{
+	if (!SCLP_HAS_CPU_INFO)
+		return -EOPNOTSUPP;
+	*info = sclp_cpu_info;
+	return 0;
+}
+
+static int sclp_get_cpu_info_late(struct sclp_cpu_info *info)
+{
+	int rc;
+	struct read_cpu_info_sccb *sccb;
+
+	if (!SCLP_HAS_CPU_INFO)
+		return -EOPNOTSUPP;
+	sccb = (struct read_cpu_info_sccb *)  __get_free_page(GFP_KERNEL
+							      | GFP_DMA);
+	if (!sccb)
+		return -ENOMEM;
+	memset(sccb, 0, sizeof(*sccb));
+	sccb->header.length = sizeof(*sccb);
+	rc = do_sync_request(SCLP_CMDW_READ_CPU_INFO, sccb);
+	if (rc)
+		goto out;
+	if (sccb->header.response_code != 0x0010) {
+		printk(KERN_WARNING TAG "readcpuinfo failed "
+		       "(response=0x%04x)\n", sccb->header.response_code);
+		rc = -EIO;
+		goto out;
+	}
+	sclp_fill_cpu_info(info, sccb);
+out:
+	free_page((unsigned long) sccb);
+	return rc;
+}
+
+int __init_refok sclp_get_cpu_info(struct sclp_cpu_info *info)
+{
+	if (slab_is_available())
+		return sclp_get_cpu_info_late(info);
+	return sclp_get_cpu_info_early(info);
+}
+
+struct cpu_configure_sccb {
+	struct sccb_header header;
+} __attribute__((packed, aligned(8)));
+
+static int do_cpu_configure(sclp_cmdw_t cmd)
+{
+	struct cpu_configure_sccb *sccb;
+	int rc;
+
+	if (!SCLP_HAS_CPU_RECONFIG)
+		return -EOPNOTSUPP;
+	/*
+	 * This is not going to cross a page boundary since we force
+	 * kmalloc to have a minimum alignment of 8 bytes on s390.
+	 */
+	sccb = kzalloc(sizeof(*sccb), GFP_KERNEL | GFP_DMA);
+	if (!sccb)
+		return -ENOMEM;
+	sccb->header.length = sizeof(*sccb);
+	rc = do_sync_request(cmd, sccb);
+	if (rc)
+		goto out;
+	switch (sccb->header.response_code) {
+	case 0x0020:
+	case 0x0120:
+		break;
+	default:
+		printk(KERN_WARNING TAG "configure cpu failed (cmd=0x%08x, "
+		       "response=0x%04x)\n", cmd, sccb->header.response_code);
+		rc = -EIO;
+		break;
+	}
+out:
+	kfree(sccb);
+	return rc;
+}
+
+int sclp_cpu_configure(u8 cpu)
+{
+	return do_cpu_configure(SCLP_CMDW_CONFIGURE_CPU | cpu << 8);
+}
+
+int sclp_cpu_deconfigure(u8 cpu)
+{
+	return do_cpu_configure(SCLP_CMDW_DECONFIGURE_CPU | cpu << 8);
+}
diff -urpN linux-2.6/drivers/s390/char/sclp.h linux-2.6-patched/drivers/s390/char/sclp.h
--- linux-2.6/drivers/s390/char/sclp.h	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp.h	2007-11-16 14:27:48.000000000 +0100
@@ -56,8 +56,6 @@ typedef unsigned int sclp_cmdw_t;
 #define SCLP_CMDW_READ_EVENT_DATA	0x00770005
 #define SCLP_CMDW_WRITE_EVENT_DATA	0x00760005
 #define SCLP_CMDW_WRITE_EVENT_MASK	0x00780005
-#define SCLP_CMDW_READ_SCP_INFO		0x00020001
-#define SCLP_CMDW_READ_SCP_INFO_FORCED	0x00120001
 
 #define GDS_ID_MDSMU		0x1310
 #define GDS_ID_MDSROUTEINFO	0x1311
@@ -83,6 +81,8 @@ extern u64 sclp_facilities;
 
 #define SCLP_HAS_CHP_INFO	(sclp_facilities & 0x8000000000000000ULL)
 #define SCLP_HAS_CHP_RECONFIG	(sclp_facilities & 0x2000000000000000ULL)
+#define SCLP_HAS_CPU_INFO	(sclp_facilities & 0x0800000000000000ULL)
+#define SCLP_HAS_CPU_RECONFIG	(sclp_facilities & 0x0400000000000000ULL)
 
 struct gds_subvector {
 	u8	length;
diff -urpN linux-2.6/drivers/s390/char/sclp_info.c linux-2.6-patched/drivers/s390/char/sclp_info.c
--- linux-2.6/drivers/s390/char/sclp_info.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_info.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,116 +0,0 @@
-/*
- *  drivers/s390/char/sclp_info.c
- *
- *    Copyright IBM Corp. 2007
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
- */
-
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <asm/sclp.h>
-#include "sclp.h"
-
-struct sclp_readinfo_sccb {
-	struct	sccb_header header;	/* 0-7 */
-	u16	rnmax;			/* 8-9 */
-	u8	rnsize;			/* 10 */
-	u8	_reserved0[24 - 11];	/* 11-23 */
-	u8	loadparm[8];		/* 24-31 */
-	u8	_reserved1[48 - 32];	/* 32-47 */
-	u64	facilities;		/* 48-55 */
-	u8	_reserved2[91 - 56];	/* 56-90 */
-	u8	flags;			/* 91 */
-	u8	_reserved3[100 - 92];	/* 92-99 */
-	u32	rnsize2;		/* 100-103 */
-	u64	rnmax2;			/* 104-111 */
-	u8	_reserved4[4096 - 112];	/* 112-4095 */
-} __attribute__((packed, aligned(4096)));
-
-static struct sclp_readinfo_sccb __initdata early_readinfo_sccb;
-static int __initdata early_readinfo_sccb_valid;
-
-u64 sclp_facilities;
-
-void __init sclp_readinfo_early(void)
-{
-	int ret;
-	int i;
-	struct sclp_readinfo_sccb *sccb;
-	sclp_cmdw_t commands[] = {SCLP_CMDW_READ_SCP_INFO_FORCED,
-				  SCLP_CMDW_READ_SCP_INFO};
-
-	/* Enable service signal subclass mask. */
-	__ctl_set_bit(0, 9);
-	sccb = &early_readinfo_sccb;
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		do {
-			memset(sccb, 0, sizeof(*sccb));
-			sccb->header.length = sizeof(*sccb);
-			sccb->header.control_mask[2] = 0x80;
-			ret = sclp_service_call(commands[i], sccb);
-		} while (ret == -EBUSY);
-
-		if (ret)
-			break;
-		__load_psw_mask(PSW_BASE_BITS | PSW_MASK_EXT |
-				PSW_MASK_WAIT | PSW_DEFAULT_KEY);
-		local_irq_disable();
-		/*
-		 * Contents of the sccb might have changed
-		 * therefore a barrier is needed.
-		 */
-		barrier();
-		if (sccb->header.response_code == 0x10) {
-			early_readinfo_sccb_valid = 1;
-			break;
-		}
-		if (sccb->header.response_code != 0x1f0)
-			break;
-	}
-	/* Disable service signal subclass mask again. */
-	__ctl_clear_bit(0, 9);
-}
-
-void __init sclp_facilities_detect(void)
-{
-	if (!early_readinfo_sccb_valid)
-		return;
-	sclp_facilities = early_readinfo_sccb.facilities;
-}
-
-unsigned long long __init sclp_memory_detect(void)
-{
-	unsigned long long memsize;
-	struct sclp_readinfo_sccb *sccb;
-
-	if (!early_readinfo_sccb_valid)
-		return 0;
-	sccb = &early_readinfo_sccb;
-	if (sccb->rnsize)
-		memsize = sccb->rnsize << 20;
-	else
-		memsize = sccb->rnsize2 << 20;
-	if (sccb->rnmax)
-		memsize *= sccb->rnmax;
-	else
-		memsize *= sccb->rnmax2;
-	return memsize;
-}
-
-/*
- * This function will be called after sclp_memory_detect(), which gets called
- * early from early.c code. Therefore the sccb should have valid contents.
- */
-void __init sclp_get_ipl_info(struct sclp_ipl_info *info)
-{
-	struct sclp_readinfo_sccb *sccb;
-
-	if (!early_readinfo_sccb_valid)
-		return;
-	sccb = &early_readinfo_sccb;
-	info->is_valid = 1;
-	if (sccb->flags & 0x2)
-		info->has_dump = 1;
-	memcpy(&info->loadparm, &sccb->loadparm, LOADPARM_LEN);
-}
diff -urpN linux-2.6/include/asm-s390/sclp.h linux-2.6-patched/include/asm-s390/sclp.h
--- linux-2.6/include/asm-s390/sclp.h	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/sclp.h	2007-11-16 14:27:48.000000000 +0100
@@ -27,7 +27,26 @@ struct sclp_ipl_info {
 	char loadparm[LOADPARM_LEN];
 };
 
-void sclp_readinfo_early(void);
+struct sclp_cpu_entry {
+	u8 address;
+	u8 reserved0[13];
+	u8 type;
+	u8 reserved1;
+} __attribute__((packed));
+
+struct sclp_cpu_info {
+	unsigned int configured;
+	unsigned int standby;
+	unsigned int combined;
+	int has_cpu_type;
+	struct sclp_cpu_entry cpu[255];
+};
+
+int sclp_get_cpu_info(struct sclp_cpu_info *info);
+int sclp_cpu_configure(u8 cpu);
+int sclp_cpu_deconfigure(u8 cpu);
+void sclp_read_info_early(void);
+void sclp_read_cpu_info_early(void);
 void sclp_facilities_detect(void);
 unsigned long long sclp_memory_detect(void);
 int sclp_sdias_blk_count(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
