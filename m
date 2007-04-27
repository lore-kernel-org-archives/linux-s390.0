Return-Path: <linux-kernel-owner+w=401wt.eu-S1755943AbXD0OJM@vger.kernel.org>
Message-Id: <20070427140519.660995806@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 33/38] Processor degradation notification.
Content-Disposition: inline; filename=136-cpu-degradation.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Generate uevents for all cpus if cpu capability changes. This can
happen e.g. because the cpus are overheating. The cpu capability can
be read via /sys/devices/system/cpu/cpuN/capability.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/smp.c          |   48 ++++++++++++++++++++++---
 drivers/s390/char/Makefile      |    2 -
 drivers/s390/char/sclp.h        |    2 +
 drivers/s390/char/sclp_config.c |   75 ++++++++++++++++++++++++++++++++++++++++
 drivers/s390/sysinfo.c          |   18 +++++++++
 include/asm-s390/processor.h    |    1 
 6 files changed, 140 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/smp.c	2007-04-27 16:05:00.000000000 +0200
@@ -821,19 +821,57 @@
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
+static ssize_t show_capability(struct sys_device *dev, char *buf)
+{
+	unsigned int capability;
+	int rc;
+
+	rc = get_cpu_capability(&capability);
+	if (rc)
+		return rc;
+	return sprintf(buf, "%u\n", capability);
+}
+static SYSDEV_ATTR(capability, 0444, show_capability, NULL);
+
+static int __cpuinit smp_cpu_notify(struct notifier_block *self,
+				    unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned int)(long)hcpu;
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+	struct sys_device *s = &c->sysdev;
+
+	switch (action) {
+	case CPU_ONLINE:
+		if (sysdev_create_file(s, &attr_capability))
+			return NOTIFY_BAD;
+		break;
+	case CPU_DEAD:
+		sysdev_remove_file(s, &attr_capability);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata smp_cpu_nb = {
+	.notifier_call	= smp_cpu_notify,
+};
+
 static int __init topology_init(void)
 {
 	int cpu;
-	int ret;
+
+	register_cpu_notifier(&smp_cpu_nb);
 
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
+		struct sys_device *s = &c->sysdev;
 
 		c->hotpluggable = 1;
-		ret = register_cpu(c, cpu);
-		if (ret)
-			printk(KERN_WARNING "topology_init: register_cpu %d "
-			       "failed (%d)\n", cpu, ret);
+		register_cpu(c, cpu);
+		if (!cpu_online(cpu))
+			continue;
+		s = &c->sysdev;
+		sysdev_create_file(s, &attr_capability);
 	}
 	return 0;
 }
Index: quilt-2.6/drivers/s390/char/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/char/Makefile	2007-04-27 16:04:59.000000000 +0200
+++ quilt-2.6/drivers/s390/char/Makefile	2007-04-27 16:05:00.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
-	 sclp_info.o sclp_chp.o
+	 sclp_info.o sclp_config.o sclp_chp.o
 
 obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ quilt-2.6/drivers/s390/char/sclp_config.c	2007-04-27 16:05:00.000000000 +0200
@@ -0,0 +1,75 @@
+/*
+ *  drivers/s390/char/sclp_config.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/cpu.h>
+#include <linux/sysdev.h>
+#include <linux/workqueue.h>
+#include "sclp.h"
+
+#define TAG	"sclp_config: "
+
+struct conf_mgm_data {
+	u8 reserved;
+	u8 ev_qualifier;
+} __attribute__((packed));
+
+#define EV_QUAL_CAP_CHANGE	3
+
+static struct work_struct sclp_cpu_capability_work;
+
+static void sclp_cpu_capability_notify(struct work_struct *work)
+{
+	int cpu;
+	struct sys_device *sysdev;
+
+	printk(KERN_WARNING TAG "cpu capability changed.\n");
+	lock_cpu_hotplug();
+	for_each_online_cpu(cpu) {
+		sysdev = get_cpu_sysdev(cpu);
+		kobject_uevent(&sysdev->kobj, KOBJ_CHANGE);
+	}
+	unlock_cpu_hotplug();
+}
+
+static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
+{
+	struct conf_mgm_data *cdata;
+
+	cdata = (struct conf_mgm_data *)(evbuf + 1);
+	if (cdata->ev_qualifier == EV_QUAL_CAP_CHANGE)
+		schedule_work(&sclp_cpu_capability_work);
+}
+
+static struct sclp_register sclp_conf_register =
+{
+	.receive_mask = EVTYP_CONFMGMDATA_MASK,
+	.receiver_fn  = sclp_conf_receiver_fn,
+};
+
+static int __init sclp_conf_init(void)
+{
+	int rc;
+
+	INIT_WORK(&sclp_cpu_capability_work, sclp_cpu_capability_notify);
+
+	rc = sclp_register(&sclp_conf_register);
+	if (rc) {
+		printk(KERN_ERR TAG "failed to register (%d).\n", rc);
+		return rc;
+	}
+
+	if (!(sclp_conf_register.sclp_receive_mask & EVTYP_CONFMGMDATA_MASK)) {
+		printk(KERN_WARNING TAG "no configuration management.\n");
+		sclp_unregister(&sclp_conf_register);
+		rc = -ENOSYS;
+	}
+	return rc;
+}
+
+__initcall(sclp_conf_init);
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h	2007-04-27 16:05:00.000000000 +0200
+++ quilt-2.6/drivers/s390/char/sclp.h	2007-04-27 16:05:00.000000000 +0200
@@ -27,6 +27,7 @@
 #define EVTYP_CNTLPROGIDENT	0x0B
 #define EVTYP_SIGQUIESCE	0x1D
 #define EVTYP_VT220MSG		0x1A
+#define EVTYP_CONFMGMDATA	0x04
 #define EVTYP_SDIAS		0x1C
 
 #define EVTYP_OPCMD_MASK	0x80000000
@@ -37,6 +38,7 @@
 #define EVTYP_CTLPROGIDENT_MASK	0x00200000
 #define EVTYP_SIGQUIESCE_MASK	0x00000008
 #define EVTYP_VT220MSG_MASK	0x00000040
+#define EVTYP_CONFMGMDATA_MASK	0x10000000
 #define EVTYP_SDIAS_MASK	0x00000010
 
 #define GNRLMSGFLGS_DOM		0x8000
Index: quilt-2.6/drivers/s390/sysinfo.c
===================================================================
--- quilt-2.6.orig/drivers/s390/sysinfo.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/sysinfo.c	2007-04-27 16:05:00.000000000 +0200
@@ -357,6 +357,24 @@
 
 __initcall(create_proc_sysinfo);
 
+int get_cpu_capability(unsigned int *capability)
+{
+	struct sysinfo_1_2_2 *info;
+	int rc;
+
+	info = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	rc = stsi(info, 1, 2, 2);
+	if (rc == -ENOSYS)
+		goto out;
+	rc = 0;
+	*capability = info->capability;
+out:
+	free_page((unsigned long) info);
+	return rc;
+}
+
 /*
  * CPU capability might have changed. Therefore recalculate loops_per_jiffy.
  */
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h	2007-04-27 16:04:56.000000000 +0200
+++ quilt-2.6/include/asm-s390/processor.h	2007-04-27 16:05:00.000000000 +0200
@@ -57,6 +57,7 @@
 
 extern void s390_adjust_jiffies(void);
 extern void print_cpu_info(struct cpuinfo_S390 *);
+extern int get_cpu_capability(unsigned int *);
 
 /* Lazy FPU handling on uni-processor */
 extern struct task_struct *last_task_used_math;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
