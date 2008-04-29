Return-Path: <linux-kernel-owner+w=401wt.eu-S1764655AbYD2OTh@vger.kernel.org>
Message-Id: <20080429140250.553361834@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/15] Add topology_core_siblings to topology.h
Content-Disposition: inline; filename=008-nodes-s390-siblings.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This exposes the core siblings to user space via sysfs.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

---

 arch/s390/kernel/topology.c |   21 ++++++++++++++++++---
 include/asm-s390/topology.h |    4 ++++
 2 files changed, 22 insertions(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/kernel/topology.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/topology.c
+++ quilt-2.6/arch/s390/kernel/topology.c
@@ -66,6 +66,8 @@ static struct timer_list topology_timer;
 static void set_topology_timer(void);
 static DECLARE_WORK(topology_work, topology_work_fn);
 
+cpumask_t cpu_core_map[NR_CPUS];
+
 cpumask_t cpu_coregroup_map(unsigned int cpu)
 {
 	struct core_info *core = &core_info;
@@ -199,6 +201,14 @@ int topology_set_cpu_management(int fc)
 	return rc;
 }
 
+static void update_cpu_core_map(void)
+{
+	int cpu;
+
+	for_each_present_cpu(cpu)
+		cpu_core_map[cpu] = cpu_coregroup_map(cpu);
+}
+
 void arch_update_cpu_topology(void)
 {
 	struct tl_info *info = tl_info;
@@ -206,11 +216,13 @@ void arch_update_cpu_topology(void)
 	int cpu;
 
 	if (!machine_has_topology) {
+		update_cpu_core_map();
 		topology_update_polarization_simple();
 		return;
 	}
 	stsi(info, 15, 1, 2);
 	tl_to_cores(info);
+	update_cpu_core_map();
 	for_each_online_cpu(cpu) {
 		sysdev = get_cpu_sysdev(cpu);
 		kobject_uevent(&sysdev->kobj, KOBJ_CHANGE);
@@ -251,20 +263,23 @@ static int __init init_topology_update(v
 {
 	int rc;
 
+	rc = 0;
 	if (!machine_has_topology) {
 		topology_update_polarization_simple();
-		return 0;
+		goto out;
 	}
 	init_timer_deferrable(&topology_timer);
 	if (machine_has_topology_irq) {
 		rc = register_external_interrupt(0x2005, topology_interrupt);
 		if (rc)
-			return rc;
+			goto out;
 		ctl_set_bit(0, 8);
 	}
 	else
 		set_topology_timer();
-	return 0;
+out:
+	update_cpu_core_map();
+	return rc;
 }
 __initcall(init_topology_update);
 
Index: quilt-2.6/include/asm-s390/topology.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/topology.h
+++ quilt-2.6/include/asm-s390/topology.h
@@ -7,6 +7,10 @@
 
 cpumask_t cpu_coregroup_map(unsigned int cpu);
 
+extern cpumask_t cpu_core_map[NR_CPUS];
+
+#define topology_core_siblings(cpu)	(cpu_core_map[cpu])
+
 int topology_set_cpu_management(int fc);
 void topology_schedule_update(void);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
