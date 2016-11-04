Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 4 Nov 2016 15:45:03 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 11/25 v2] s390/smp: Convert to hotplug state machine
Message-ID: <20161104144502.7kd4bxz2rxqvtack@linutronix.de>
References: <20161103145021.28528-1-bigeasy@linutronix.de>
 <20161103145021.28528-12-bigeasy@linutronix.de>
 <20161104143427.GD4088@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161104143427.GD4088@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

cpuhp_setup_state() invokes the startup callback on all online cpus with
the proper protection, so we can remove the cpu hotplug protection from the
init function and the creation of the per cpu files for online cpus in
smp_add_present_cpu(). smp_add_present_cpu() is called also called from
__smp_rescan_cpus(), but this callpath never adds an online cpu, it merily
adds newly present cpus, so the creation of the cpu files is not required.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
v1…v2:
	- removed (or not adding) one empty line
	- rebase on top of the previous patch

 arch/s390/kernel/smp.c |   37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1047,23 +1047,18 @@ static struct attribute_group cpu_online
 	.attrs = cpu_online_attrs,
 };
 
-static int smp_cpu_notify(struct notifier_block *self, unsigned long action,
-			  void *hcpu)
+static int smp_cpu_online(unsigned int cpu)
 {
-	unsigned int cpu = (unsigned int)(long)hcpu;
 	struct device *s = &per_cpu(cpu_device, cpu)->dev;
-	int err = 0;
 
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		err = sysfs_create_group(&s->kobj, &cpu_online_attr_group);
-		break;
-	case CPU_DOWN_PREPARE:
-		sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
-		break;
-	}
-	return notifier_from_errno(err);
+	return sysfs_create_group(&s->kobj, &cpu_online_attr_group);
+}
+static int smp_cpu_pre_down(unsigned int cpu)
+{
+	struct device *s = &per_cpu(cpu_device, cpu)->dev;
+
+	sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
+	return 0;
 }
 
 static int smp_add_present_cpu(int cpu)
@@ -1084,20 +1079,12 @@ static int smp_add_present_cpu(int cpu)
 	rc = sysfs_create_group(&s->kobj, &cpu_common_attr_group);
 	if (rc)
 		goto out_cpu;
-	if (cpu_online(cpu)) {
-		rc = sysfs_create_group(&s->kobj, &cpu_online_attr_group);
-		if (rc)
-			goto out_online;
-	}
 	rc = topology_cpu_init(c);
 	if (rc)
 		goto out_topology;
 	return 0;
 
 out_topology:
-	if (cpu_online(cpu))
-		sysfs_remove_group(&s->kobj, &cpu_online_attr_group);
-out_online:
 	sysfs_remove_group(&s->kobj, &cpu_common_attr_group);
 out_cpu:
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1150,17 +1137,15 @@ static int __init s390_smp_init(void)
 	if (rc)
 		return rc;
 #endif
-	cpu_notifier_register_begin();
 	for_each_present_cpu(cpu) {
 		rc = smp_add_present_cpu(cpu);
 		if (rc)
 			goto out;
 	}
 
-	__hotcpu_notifier(smp_cpu_notify, 0);
-
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "s390/smp:online",
+			       smp_cpu_online, smp_cpu_pre_down);
 out:
-	cpu_notifier_register_done();
 	return rc;
 }
 subsys_initcall(s390_smp_init);
