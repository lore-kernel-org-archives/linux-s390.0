Return-Path: <linux-kernel-owner+w=401wt.eu-S1759409AbZFDQZB@vger.kernel.org>
Message-Id: <20090604161907.773749056@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 34/38] pm: memory hotplug power management callbacks
Content-Disposition: inline; filename=pm_sclp_mem.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/char/sclp_cmd.c |   42 ++++++++++++++++++++++++++++++++++++++----
 mm/Kconfig                   |    4 ++--
 2 files changed, 40 insertions(+), 6 deletions(-)

Index: linux-2.6/mm/Kconfig
===================================================================
--- linux-2.6.orig/mm/Kconfig
+++ linux-2.6/mm/Kconfig
@@ -128,11 +128,11 @@ config SPARSEMEM_VMEMMAP
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
 	depends on SPARSEMEM || X86_64_ACPI_NUMA
-	depends on HOTPLUG && !HIBERNATION && ARCH_ENABLE_MEMORY_HOTPLUG
+	depends on HOTPLUG && !(HIBERNATION && !S390) && ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on (IA64 || X86 || PPC64 || SUPERH || S390)
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
-	depends on SPARSEMEM && HOTPLUG && HIBERNATION
+	depends on SPARSEMEM && HOTPLUG && HIBERNATION && !S390
 
 config MEMORY_HOTPLUG_SPARSE
 	def_bool y
Index: linux-2.6/drivers/s390/char/sclp_cmd.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp_cmd.c
+++ linux-2.6/drivers/s390/char/sclp_cmd.c
@@ -1,9 +1,8 @@
 /*
- *  drivers/s390/char/sclp_cmd.c
+ * Copyright IBM Corp. 2007, 2009
  *
- *    Copyright IBM Corp. 2007
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
- *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ * Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *	      Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
 #define KMSG_COMPONENT "sclp_cmd"
@@ -12,11 +11,13 @@
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/memory.h>
+#include <linux/platform_device.h>
 #include <asm/chpid.h>
 #include <asm/sclp.h>
 #include <asm/setup.h>
@@ -292,6 +293,7 @@ static DEFINE_MUTEX(sclp_mem_mutex);
 static LIST_HEAD(sclp_mem_list);
 static u8 sclp_max_storage_id;
 static unsigned long sclp_storage_ids[256 / BITS_PER_LONG];
+static int sclp_mem_state_changed;
 
 struct memory_increment {
 	struct list_head list;
@@ -450,6 +452,8 @@ static int sclp_mem_notifier(struct noti
 		rc = -EINVAL;
 		break;
 	}
+	if (!rc)
+		sclp_mem_state_changed = 1;
 	mutex_unlock(&sclp_mem_mutex);
 	return rc ? NOTIFY_BAD : NOTIFY_OK;
 }
@@ -525,6 +529,14 @@ static void __init insert_increment(u16 
 	list_add(&new_incr->list, prev);
 }
 
+static int sclp_mem_freeze(struct device *dev)
+{
+	if (!sclp_mem_state_changed)
+		return 0;
+	pr_err("Memory hotplug state changed, suspend refused.\n");
+	return -EPERM;
+}
+
 struct read_storage_sccb {
 	struct sccb_header header;
 	u16 max_id;
@@ -534,8 +546,20 @@ struct read_storage_sccb {
 	u32 entries[0];
 } __packed;
 
+static struct dev_pm_ops sclp_mem_pm_ops = {
+	.freeze		= sclp_mem_freeze,
+};
+
+static struct platform_driver sclp_mem_pdrv = {
+	.driver = {
+		.name	= "sclp_mem",
+		.pm	= &sclp_mem_pm_ops,
+	},
+};
+
 static int __init sclp_detect_standby_memory(void)
 {
+	struct platform_device *sclp_pdev;
 	struct read_storage_sccb *sccb;
 	int i, id, assigned, rc;
 
@@ -588,7 +612,17 @@ static int __init sclp_detect_standby_me
 	rc = register_memory_notifier(&sclp_mem_nb);
 	if (rc)
 		goto out;
+	rc = platform_driver_register(&sclp_mem_pdrv);
+	if (rc)
+		goto out;
+	sclp_pdev = platform_device_register_simple("sclp_mem", -1, NULL, 0);
+	rc = IS_ERR(sclp_pdev) ? PTR_ERR(sclp_pdev) : 0;
+	if (rc)
+		goto out_driver;
 	sclp_add_standby_memory();
+	goto out;
+out_driver:
+	platform_driver_unregister(&sclp_mem_pdrv);
 out:
 	free_page((unsigned long) sccb);
 	return rc;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
