Return-Path: <linux-kernel-owner+w=401wt.eu-S1762646AbYD2OR5@vger.kernel.org>
Message-Id: <20080429140249.771131252@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/15] Automatically detect added cpus.
Content-Disposition: inline; filename=005-cpu-detect.diff
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

 arch/s390/kernel/smp.c          |   19 ++++++++++++++-----
 drivers/s390/char/sclp_config.c |   17 ++++++++++++++++-
 include/asm-s390/smp.h          |    6 ++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -505,7 +505,7 @@ out:
 	return rc;
 }
 
-static int smp_rescan_cpus(void)
+static int __smp_rescan_cpus(void)
 {
 	cpumask_t avail;
 
@@ -570,7 +570,7 @@ out:
 	kfree(info);
 	printk(KERN_INFO "CPUs: %d configured, %d standby\n", c_cpus, s_cpus);
 	get_online_cpus();
-	smp_rescan_cpus();
+	__smp_rescan_cpus();
 	put_online_cpus();
 }
 
@@ -1088,8 +1088,8 @@ out:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static ssize_t __ref rescan_store(struct sys_device *dev,
-				  const char *buf, size_t count)
+
+int smp_rescan_cpus(void)
 {
 	cpumask_t newcpus;
 	int cpu;
@@ -1098,7 +1098,7 @@ static ssize_t __ref rescan_store(struct
 	get_online_cpus();
 	mutex_lock(&smp_cpu_state_mutex);
 	newcpus = cpu_present_map;
-	rc = smp_rescan_cpus();
+	rc = __smp_rescan_cpus();
 	if (rc)
 		goto out;
 	cpus_andnot(newcpus, cpu_present_map, newcpus);
@@ -1113,6 +1113,15 @@ out:
 	put_online_cpus();
 	if (!cpus_empty(newcpus))
 		topology_schedule_update();
+	return rc;
+}
+
+static ssize_t __ref rescan_store(struct sys_device *dev, const char *buf,
+				  size_t count)
+{
+	int rc;
+
+	rc = smp_rescan_cpus();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(rescan, 0200, NULL, rescan_store);
Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_config.c
+++ quilt-2.6/drivers/s390/char/sclp_config.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 #include <linux/sysdev.h>
 #include <linux/workqueue.h>
+#include <asm/smp.h>
 #include "sclp.h"
 
 #define TAG	"sclp_config: "
@@ -19,9 +20,11 @@ struct conf_mgm_data {
 	u8 ev_qualifier;
 } __attribute__((packed));
 
+#define EV_QUAL_CPU_CHANGE	1
 #define EV_QUAL_CAP_CHANGE	3
 
 static struct work_struct sclp_cpu_capability_work;
+static struct work_struct sclp_cpu_change_work;
 
 static void sclp_cpu_capability_notify(struct work_struct *work)
 {
@@ -37,13 +40,24 @@ static void sclp_cpu_capability_notify(s
 	put_online_cpus();
 }
 
+static void sclp_cpu_change_notify(struct work_struct *work)
+{
+	smp_rescan_cpus();
+}
+
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
 {
 	struct conf_mgm_data *cdata;
 
 	cdata = (struct conf_mgm_data *)(evbuf + 1);
-	if (cdata->ev_qualifier == EV_QUAL_CAP_CHANGE)
+	switch (cdata->ev_qualifier) {
+	case EV_QUAL_CPU_CHANGE:
+		schedule_work(&sclp_cpu_change_work);
+		break;
+	case EV_QUAL_CAP_CHANGE:
 		schedule_work(&sclp_cpu_capability_work);
+		break;
+	}
 }
 
 static struct sclp_register sclp_conf_register =
@@ -57,6 +71,7 @@ static int __init sclp_conf_init(void)
 	int rc;
 
 	INIT_WORK(&sclp_cpu_capability_work, sclp_cpu_capability_notify);
+	INIT_WORK(&sclp_cpu_change_work, sclp_cpu_change_notify);
 
 	rc = sclp_register(&sclp_conf_register);
 	if (rc) {
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h
+++ quilt-2.6/include/asm-s390/smp.h
@@ -108,5 +108,11 @@ static inline void smp_send_stop(void)
 #define smp_cpu_not_running(cpu)	1
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int smp_rescan_cpus(void);
+#else
+static inline int smp_rescan_cpus(void) { return 0; }
+#endif
+
 extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
