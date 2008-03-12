Return-Path: <linux-kernel-owner+w=401wt.eu-S1754611AbYCLReO@vger.kernel.org>
Message-Id: <20080312173217.505558934@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:32:01 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/10] cpu topology support for s390.
Content-Disposition: inline; filename=106-nodes-support.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add s390 backend so we can give the scheduler some hints about the
cpu topology.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig           |    4 
 arch/s390/defconfig         |    1 
 arch/s390/kernel/Makefile   |    2 
 arch/s390/kernel/setup.c    |    2 
 arch/s390/kernel/smp.c      |    4 
 arch/s390/kernel/topology.c |  271 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/sysinfo.c      |    2 
 include/asm-s390/smp.h      |    2 
 include/asm-s390/system.h   |    1 
 include/asm-s390/topology.h |   16 ++
 10 files changed, 300 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/defconfig
===================================================================
--- quilt-2.6.orig/arch/s390/defconfig
+++ quilt-2.6/arch/s390/defconfig
@@ -3,6 +3,7 @@
 # Linux kernel version: 2.6.25-rc5
 # Wed Mar 12 14:10:52 2008
 #
+CONFIG_SCHED_MC=y
 CONFIG_MMU=y
 CONFIG_ZONE_DMA=y
 CONFIG_LOCKDEP_SUPPORT=y
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -3,6 +3,10 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
+config SCHED_MC
+	def_bool y
+	depends on SMP
+
 config MMU
 	def_bool y
 
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -19,7 +19,7 @@ obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,
 extra-y				+= head.o init_task.o vmlinux.lds
 
 obj-$(CONFIG_MODULES)		+= s390_ksyms.o module.o
-obj-$(CONFIG_SMP)		+= smp.o
+obj-$(CONFIG_SMP)		+= smp.o topology.o
 
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -39,6 +39,7 @@
 #include <linux/pfn.h>
 #include <linux/ctype.h>
 #include <linux/reboot.h>
+#include <linux/topology.h>
 
 #include <asm/ipl.h>
 #include <asm/uaccess.h>
@@ -830,6 +831,7 @@ setup_arch(char **cmdline_p)
 
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
+	s390_init_cpu_topology();
 
 	/*
 	 * Setup capabilities (ELF_HWCAP & ELF_PLATFORM).
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -67,9 +67,7 @@ enum s390_cpu_state {
 	CPU_STATE_CONFIGURED,
 };
 
-#ifdef CONFIG_HOTPLUG_CPU
-static DEFINE_MUTEX(smp_cpu_state_mutex);
-#endif
+DEFINE_MUTEX(smp_cpu_state_mutex);
 static int smp_cpu_state[NR_CPUS];
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
Index: quilt-2.6/arch/s390/kernel/topology.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/topology.c
@@ -0,0 +1,271 @@
+/*
+ *  arch/s390/kernel/topology.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/bootmem.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include <linux/cpu.h>
+#include <linux/smp.h>
+#include <asm/delay.h>
+#include <asm/s390_ext.h>
+
+#define CPU_BITS 64
+
+struct tl_cpu {
+	unsigned char reserved[6];
+	unsigned short origin;
+	unsigned long mask[CPU_BITS / BITS_PER_LONG];
+};
+
+struct tl_container {
+	unsigned char reserved[8];
+};
+
+union tl_entry {
+	unsigned char nl;
+	struct tl_cpu cpu;
+	struct tl_container container;
+};
+
+#define NR_MAG 6
+
+struct tl_info {
+	unsigned char reserved0[2];
+	unsigned short length;
+	unsigned char mag[NR_MAG];
+	unsigned char reserved1;
+	unsigned char mnest;
+	unsigned char reserved2[4];
+	union tl_entry tle[0];
+};
+
+struct core_info {
+	struct core_info *next;
+	cpumask_t mask;
+};
+
+static void topology_work_fn(struct work_struct *work);
+static struct tl_info *tl_info;
+static struct core_info core_info;
+static int machine_has_topology;
+static int machine_has_topology_irq;
+static struct timer_list topology_timer;
+static void set_topology_timer(void);
+static DECLARE_WORK(topology_work, topology_work_fn);
+
+cpumask_t cpu_coregroup_map(unsigned int cpu)
+{
+	struct core_info *core = &core_info;
+	cpumask_t mask;
+
+	cpus_clear(mask);
+	if (!machine_has_topology)
+		return cpu_present_map;
+	mutex_lock(&smp_cpu_state_mutex);
+	while (core) {
+		if (cpu_isset(cpu, core->mask)) {
+			mask = core->mask;
+			break;
+		}
+		core = core->next;
+	}
+	mutex_unlock(&smp_cpu_state_mutex);
+	if (cpus_empty(mask))
+		mask = cpumask_of_cpu(cpu);
+	return mask;
+}
+
+static void add_cpus_to_core(struct tl_cpu *tl_cpu, struct core_info *core)
+{
+	unsigned int cpu;
+
+	for (cpu = find_first_bit(&tl_cpu->mask[0], CPU_BITS);
+	     cpu < CPU_BITS;
+	     cpu = find_next_bit(&tl_cpu->mask[0], CPU_BITS, cpu + 1))
+	{
+		unsigned int rcpu, lcpu;
+
+		rcpu = CPU_BITS - 1 - cpu + tl_cpu->origin;
+		for_each_present_cpu(lcpu) {
+			if (__cpu_logical_map[lcpu] == rcpu)
+				cpu_set(lcpu, core->mask);
+		}
+	}
+}
+
+static void clear_cores(void)
+{
+	struct core_info *core = &core_info;
+
+	while (core) {
+		cpus_clear(core->mask);
+		core = core->next;
+	}
+}
+
+static union tl_entry *next_tle(union tl_entry *tle)
+{
+	if (tle->nl)
+		return (union tl_entry *)((struct tl_container *)tle + 1);
+	else
+		return (union tl_entry *)((struct tl_cpu *)tle + 1);
+}
+
+static void tl_to_cores(struct tl_info *info)
+{
+	union tl_entry *tle, *end;
+	struct core_info *core = &core_info;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	clear_cores();
+	tle = (union tl_entry *)&info->tle;
+	end = (union tl_entry *)((unsigned long)info + info->length);
+	while (tle < end) {
+		switch (tle->nl) {
+		case 5:
+		case 4:
+		case 3:
+		case 2:
+			break;
+		case 1:
+			core = core->next;
+			break;
+		case 0:
+			add_cpus_to_core(&tle->cpu, core);
+			break;
+		default:
+			clear_cores();
+			machine_has_topology = 0;
+			return;
+		}
+		tle = next_tle(tle);
+	}
+	mutex_unlock(&smp_cpu_state_mutex);
+}
+
+static int ptf(void)
+{
+	int rc;
+
+	asm volatile(
+		"	.insn	rre,0xb9a20000,%1,%1\n"
+		"	ipm	%0\n"
+		"	srl	%0,28\n"
+		: "=d" (rc)
+		: "d" (2UL)  : "cc");
+	return rc;
+}
+
+void arch_update_cpu_topology(void)
+{
+	struct tl_info *info = tl_info;
+	struct sys_device *sysdev;
+	int cpu;
+
+	if (!machine_has_topology)
+		return;
+	ptf();
+	stsi(info, 15, 1, 2);
+	tl_to_cores(info);
+	for_each_online_cpu(cpu) {
+		sysdev = get_cpu_sysdev(cpu);
+		kobject_uevent(&sysdev->kobj, KOBJ_CHANGE);
+	}
+}
+
+static void topology_work_fn(struct work_struct *work)
+{
+	arch_reinit_sched_domains();
+}
+
+static void topology_timer_fn(unsigned long ignored)
+{
+	if (ptf())
+		schedule_work(&topology_work);
+	set_topology_timer();
+}
+
+static void set_topology_timer(void)
+{
+	topology_timer.function = topology_timer_fn;
+	topology_timer.data = 0;
+	topology_timer.expires = jiffies + 60 * HZ;
+	add_timer(&topology_timer);
+}
+
+static void topology_interrupt(__u16 code)
+{
+	schedule_work(&topology_work);
+}
+
+static int __init init_topology_update(void)
+{
+	int rc;
+
+	if (!machine_has_topology)
+		return 0;
+	init_timer(&topology_timer);
+	if (machine_has_topology_irq) {
+		rc = register_external_interrupt(0x2005, topology_interrupt);
+		if (rc)
+			return rc;
+		ctl_set_bit(0, 8);
+	}
+	else
+		set_topology_timer();
+	return 0;
+}
+__initcall(init_topology_update);
+
+void __init s390_init_cpu_topology(void)
+{
+	unsigned long long facility_bits;
+	struct tl_info *info;
+	struct core_info *core;
+	int nr_cores;
+	int i;
+
+	if (stfle(&facility_bits, 1) <= 0)
+		return;
+	if (!(facility_bits & (1ULL << 52)) || !(facility_bits & (1ULL << 61)))
+		return;
+	machine_has_topology = 1;
+
+	if (facility_bits & (1ULL << 51))
+		machine_has_topology_irq = 1;
+
+	tl_info = alloc_bootmem_pages(PAGE_SIZE);
+	if (!tl_info)
+		goto error;
+	info = tl_info;
+	stsi(info, 15, 1, 2);
+
+	nr_cores = info->mag[NR_MAG - 2];
+	for (i = 0; i < info->mnest - 2; i++)
+		nr_cores *= info->mag[NR_MAG - 3 - i];
+
+	printk(KERN_INFO "CPU topology:");
+	for (i = 0; i < NR_MAG; i++)
+		printk(" %d", info->mag[i]);
+	printk(" / %d\n", info->mnest);
+
+	core = &core_info;
+	for (i = 0; i < nr_cores; i++) {
+		core->next = alloc_bootmem(sizeof(struct core_info));
+		core = core->next;
+		if (!core)
+			goto error;
+	}
+	return;
+error:
+	machine_has_topology = 0;
+	machine_has_topology_irq = 0;
+}
Index: quilt-2.6/drivers/s390/sysinfo.c
===================================================================
--- quilt-2.6.orig/drivers/s390/sysinfo.c
+++ quilt-2.6/drivers/s390/sysinfo.c
@@ -105,7 +105,7 @@ struct sysinfo_3_2_2 {
 	} vm[8];
 };
 
-static inline int stsi(void *sysinfo, int fc, int sel1, int sel2)
+int stsi(void *sysinfo, int fc, int sel1, int sel2)
 {
 	register int r0 asm("0") = (fc << 28) | sel1;
 	register int r1 asm("1") = sel2;
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h
+++ quilt-2.6/include/asm-s390/smp.h
@@ -90,6 +90,8 @@ extern void __cpu_die (unsigned int cpu)
 extern void cpu_die (void) __attribute__ ((noreturn));
 extern int __cpu_up (unsigned int cpu);
 
+extern struct mutex smp_cpu_state_mutex;
+
 extern int smp_call_function_mask(cpumask_t mask, void (*func)(void *),
 	void *info, int wait);
 #endif
Index: quilt-2.6/include/asm-s390/system.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/system.h
+++ quilt-2.6/include/asm-s390/system.h
@@ -406,6 +406,7 @@ __set_psw_mask(unsigned long mask)
 #define local_mcck_enable()  __set_psw_mask(psw_kernel_bits)
 #define local_mcck_disable() __set_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK)
 
+int stsi(void *sysinfo, int fc, int sel1, int sel2);
 int stfle(unsigned long long *list, int doublewords);
 
 #ifdef CONFIG_SMP
Index: quilt-2.6/include/asm-s390/topology.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/topology.h
+++ quilt-2.6/include/asm-s390/topology.h
@@ -1,6 +1,22 @@
 #ifndef _ASM_S390_TOPOLOGY_H
 #define _ASM_S390_TOPOLOGY_H
 
+#include <linux/cpumask.h>
+
+#define mc_capable()	(1)
+
+cpumask_t cpu_coregroup_map(unsigned int cpu);
+
+#define topology_core_siblings(cpu)	(cpu_coregroup_map(cpu))
+
+#ifdef CONFIG_SMP
+void s390_init_cpu_topology(void);
+#else
+static inline void s390_init_cpu_topology(void)
+{
+};
+#endif
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_S390_TOPOLOGY_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
