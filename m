Return-Path: <linux-kernel-owner+w=401wt.eu-S1755303AbYCLRe3@vger.kernel.org>
Message-Id: <20080312173217.724970802@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:32:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/10] Vertical cpu management.
Content-Disposition: inline; filename=107-vertical-cpus.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c      |   83 ++++++++++++++++++++++++++++++++++++++++++--
 arch/s390/kernel/topology.c |   66 +++++++++++++++++++++++++++++-----
 include/asm-s390/smp.h      |    1 
 include/asm-s390/topology.h |    9 ++++
 4 files changed, 146 insertions(+), 13 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -68,7 +68,9 @@ enum s390_cpu_state {
 };
 
 DEFINE_MUTEX(smp_cpu_state_mutex);
+int smp_cpu_polarization[NR_CPUS];
 static int smp_cpu_state[NR_CPUS];
+static int cpu_management;
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
@@ -454,6 +456,7 @@ static int smp_rescan_cpus_sigp(cpumask_
 		if (cpu_known(cpu_id))
 			continue;
 		__cpu_logical_map[logical_cpu] = cpu_id;
+		smp_cpu_polarization[logical_cpu] = POLARIZATION_UNKNWN;
 		if (!cpu_stopped(logical_cpu))
 			continue;
 		cpu_set(logical_cpu, cpu_present_map);
@@ -487,6 +490,7 @@ static int smp_rescan_cpus_sclp(cpumask_
 		if (cpu_known(cpu_id))
 			continue;
 		__cpu_logical_map[logical_cpu] = cpu_id;
+		smp_cpu_polarization[logical_cpu] = POLARIZATION_UNKNWN;
 		cpu_set(logical_cpu, cpu_present_map);
 		if (cpu >= info->configured)
 			smp_cpu_state[logical_cpu] = CPU_STATE_STANDBY;
@@ -844,6 +848,7 @@ void __init smp_prepare_boot_cpu(void)
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	current_set[0] = current;
 	smp_cpu_state[0] = CPU_STATE_CONFIGURED;
+	smp_cpu_polarization[0] = POLARIZATION_UNKNWN;
 	spin_lock_init(&(&__get_cpu_var(s390_idle))->lock);
 }
 
@@ -895,15 +900,19 @@ static ssize_t cpu_configure_store(struc
 	case 0:
 		if (smp_cpu_state[cpu] == CPU_STATE_CONFIGURED) {
 			rc = sclp_cpu_deconfigure(__cpu_logical_map[cpu]);
-			if (!rc)
+			if (!rc) {
 				smp_cpu_state[cpu] = CPU_STATE_STANDBY;
+				smp_cpu_polarization[cpu] = POLARIZATION_UNKNWN;
+			}
 		}
 		break;
 	case 1:
 		if (smp_cpu_state[cpu] == CPU_STATE_STANDBY) {
 			rc = sclp_cpu_configure(__cpu_logical_map[cpu]);
-			if (!rc)
+			if (!rc) {
 				smp_cpu_state[cpu] = CPU_STATE_CONFIGURED;
+				smp_cpu_polarization[cpu] = POLARIZATION_UNKNWN;
+			}
 		}
 		break;
 	default:
@@ -917,6 +926,34 @@ out:
 static SYSDEV_ATTR(configure, 0644, cpu_configure_show, cpu_configure_store);
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static ssize_t cpu_polarization_show(struct sys_device *dev, char *buf)
+{
+	int cpu = dev->id;
+	ssize_t count;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	switch (smp_cpu_polarization[cpu]) {
+	case POLARIZATION_HRZ:
+		count = sprintf(buf, "horizontal\n");
+		break;
+	case POLARIZATION_VL:
+		count = sprintf(buf, "vertical:low\n");
+		break;
+	case POLARIZATION_VM:
+		count = sprintf(buf, "vertical:medium\n");
+		break;
+	case POLARIZATION_VH:
+		count = sprintf(buf, "vertical:high\n");
+		break;
+	default:
+		count = sprintf(buf, "unknown\n");
+		break;
+	}
+	mutex_unlock(&smp_cpu_state_mutex);
+	return count;
+}
+static SYSDEV_ATTR(polarization, 0444, cpu_polarization_show, NULL);
+
 static ssize_t show_cpu_address(struct sys_device *dev, char *buf)
 {
 	return sprintf(buf, "%d\n", __cpu_logical_map[dev->id]);
@@ -929,6 +966,7 @@ static struct attribute *cpu_common_attr
 	&attr_configure.attr,
 #endif
 	&attr_address.attr,
+	&attr_polarization.attr,
 	NULL,
 };
 
@@ -1073,11 +1111,48 @@ static ssize_t __ref rescan_store(struct
 out:
 	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	if (!cpus_empty(newcpus))
+		topology_schedule_update();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(rescan, 0200, NULL, rescan_store);
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static ssize_t dispatching_show(struct sys_device *dev, char *buf)
+{
+	ssize_t count;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	count = sprintf(buf, "%d\n", cpu_management);
+	mutex_unlock(&smp_cpu_state_mutex);
+	return count;
+}
+
+static ssize_t dispatching_store(struct sys_device *dev, const char *buf,
+				 size_t count)
+{
+	int val, rc;
+	char delim;
+
+	if (sscanf(buf, "%d %c", &val, &delim) != 1)
+		return -EINVAL;
+	if (val != 0 && val != 1)
+		return -EINVAL;
+	rc = 0;
+	mutex_lock(&smp_cpu_state_mutex);
+	get_online_cpus();
+	if (cpu_management == val)
+		goto out;
+	rc = topology_set_cpu_management(val);
+	if (!rc)
+		cpu_management = val;
+out:
+	put_online_cpus();
+	mutex_unlock(&smp_cpu_state_mutex);
+	return rc ? rc : count;
+}
+static SYSDEV_ATTR(dispatching, 0644, dispatching_show, dispatching_store);
+
 static int __init topology_init(void)
 {
 	int cpu;
@@ -1091,6 +1166,10 @@ static int __init topology_init(void)
 	if (rc)
 		return rc;
 #endif
+	rc = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			       &attr_dispatching.attr);
+	if (rc)
+		return rc;
 	for_each_present_cpu(cpu) {
 		rc = smp_add_present_cpu(cpu);
 		if (rc)
Index: quilt-2.6/arch/s390/kernel/topology.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/topology.c
+++ quilt-2.6/arch/s390/kernel/topology.c
@@ -18,9 +18,17 @@
 #include <asm/s390_ext.h>
 
 #define CPU_BITS 64
+#define NR_MAG 6
+
+#define PTF_HORIZONTAL	(0UL)
+#define PTF_VERTICAL	(1UL)
+#define PTF_CHECK	(2UL)
 
 struct tl_cpu {
-	unsigned char reserved[6];
+	unsigned char reserved0[4];
+	unsigned char :6;
+	unsigned char pp:2;
+	unsigned char reserved1;
 	unsigned short origin;
 	unsigned long mask[CPU_BITS / BITS_PER_LONG];
 };
@@ -35,8 +43,6 @@ union tl_entry {
 	struct tl_container container;
 };
 
-#define NR_MAG 6
-
 struct tl_info {
 	unsigned char reserved0[2];
 	unsigned short length;
@@ -95,8 +101,10 @@ static void add_cpus_to_core(struct tl_c
 
 		rcpu = CPU_BITS - 1 - cpu + tl_cpu->origin;
 		for_each_present_cpu(lcpu) {
-			if (__cpu_logical_map[lcpu] == rcpu)
+			if (__cpu_logical_map[lcpu] == rcpu) {
 				cpu_set(lcpu, core->mask);
+				smp_cpu_polarization[lcpu] = tl_cpu->pp;
+			}
 		}
 	}
 }
@@ -151,7 +159,17 @@ static void tl_to_cores(struct tl_info *
 	mutex_unlock(&smp_cpu_state_mutex);
 }
 
-static int ptf(void)
+static void topology_update_polarization_simple(void)
+{
+	int cpu;
+
+	mutex_lock(&smp_cpu_state_mutex);
+	for_each_present_cpu(cpu)
+		smp_cpu_polarization[cpu] = POLARIZATION_HRZ;
+	mutex_unlock(&smp_cpu_state_mutex);
+}
+
+static int ptf(unsigned long fc)
 {
 	int rc;
 
@@ -160,7 +178,25 @@ static int ptf(void)
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		: "=d" (rc)
-		: "d" (2UL)  : "cc");
+		: "d" (fc)  : "cc");
+	return rc;
+}
+
+int topology_set_cpu_management(int fc)
+{
+	int cpu;
+	int rc;
+
+	if (!machine_has_topology)
+		return -EOPNOTSUPP;
+	if (fc)
+		rc = ptf(PTF_VERTICAL);
+	else
+		rc = ptf(PTF_HORIZONTAL);
+	if (rc)
+		return -EBUSY;
+	for_each_present_cpu(cpu)
+		smp_cpu_polarization[cpu] = POLARIZATION_UNKNWN;
 	return rc;
 }
 
@@ -170,9 +206,10 @@ void arch_update_cpu_topology(void)
 	struct sys_device *sysdev;
 	int cpu;
 
-	if (!machine_has_topology)
+	if (!machine_has_topology) {
+		topology_update_polarization_simple();
 		return;
-	ptf();
+	}
 	stsi(info, 15, 1, 2);
 	tl_to_cores(info);
 	for_each_online_cpu(cpu) {
@@ -186,10 +223,15 @@ static void topology_work_fn(struct work
 	arch_reinit_sched_domains();
 }
 
+void topology_schedule_update(void)
+{
+	schedule_work(&topology_work);
+}
+
 static void topology_timer_fn(unsigned long ignored)
 {
-	if (ptf())
-		schedule_work(&topology_work);
+	if (ptf(PTF_CHECK))
+		topology_schedule_update();
 	set_topology_timer();
 }
 
@@ -210,8 +252,10 @@ static int __init init_topology_update(v
 {
 	int rc;
 
-	if (!machine_has_topology)
+	if (!machine_has_topology) {
+		topology_update_polarization_simple();
 		return 0;
+	}
 	init_timer(&topology_timer);
 	if (machine_has_topology_irq) {
 		rc = register_external_interrupt(0x2005, topology_interrupt);
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h
+++ quilt-2.6/include/asm-s390/smp.h
@@ -91,6 +91,7 @@ extern void cpu_die (void) __attribute__
 extern int __cpu_up (unsigned int cpu);
 
 extern struct mutex smp_cpu_state_mutex;
+extern int smp_cpu_polarization[];
 
 extern int smp_call_function_mask(cpumask_t mask, void (*func)(void *),
 	void *info, int wait);
Index: quilt-2.6/include/asm-s390/topology.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/topology.h
+++ quilt-2.6/include/asm-s390/topology.h
@@ -9,6 +9,15 @@ cpumask_t cpu_coregroup_map(unsigned int
 
 #define topology_core_siblings(cpu)	(cpu_coregroup_map(cpu))
 
+int topology_set_cpu_management(int fc);
+void topology_schedule_update(void);
+
+#define POLARIZATION_UNKNWN	(-1)
+#define POLARIZATION_HRZ	(0)
+#define POLARIZATION_VL		(1)
+#define POLARIZATION_VM		(2)
+#define POLARIZATION_VH		(3)
+
 #ifdef CONFIG_SMP
 void s390_init_cpu_topology(void);
 #else

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
