Return-Path: <linux-kernel-owner+w=401wt.eu-S1757907AbZFDQUk@vger.kernel.org>
Message-Id: <20090604161859.713228968@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/38] pm: Move nvs routines into a seperate file.
Content-Disposition: inline; filename=swsusp_split_out_nvs.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The *_nvs_* routines in swsusp.c make use of the io*map()
functions, which are only provided for HAS_IOMEM, thus
breaking compilation if HAS_IOMEM is not set. Fix this
by moving the *_nvs_* routines into nvs.c, which is only
compiled if HAS_IOMEM is set.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 include/linux/suspend.h |   18 ++++--
 kernel/power/Kconfig    |    4 +
 kernel/power/Makefile   |    1 
 kernel/power/nvs.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c   |  122 --------------------------------------------
 5 files changed, 147 insertions(+), 129 deletions(-)

Index: linux-2.6/kernel/power/nvs.c
===================================================================
--- /dev/null
+++ linux-2.6/kernel/power/nvs.c
@@ -0,0 +1,131 @@
+/*
+ * Routines for NVS memory handling
+ */
+
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/suspend.h>
+
+/*
+ * Platforms, like ACPI, may want us to save some memory used by them during
+ * hibernation and to restore the contents of this memory during the subsequent
+ * resume.  The code below implements a mechanism allowing us to do that.
+ */
+
+struct nvs_page {
+	unsigned long phys_start;
+	unsigned int size;
+	void *kaddr;
+	void *data;
+	struct list_head node;
+};
+
+static LIST_HEAD(nvs_list);
+
+/**
+ *	hibernate_nvs_register - register platform NVS memory region to save
+ *	@start - physical address of the region
+ *	@size - size of the region
+ *
+ *	The NVS region need not be page-aligned (both ends) and we arrange
+ *	things so that the data from page-aligned addresses in this region will
+ *	be copied into separate RAM pages.
+ */
+int hibernate_nvs_register(unsigned long start, unsigned long size)
+{
+	struct nvs_page *entry, *next;
+
+	while (size > 0) {
+		unsigned int nr_bytes;
+
+		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
+		if (!entry)
+			goto Error;
+
+		list_add_tail(&entry->node, &nvs_list);
+		entry->phys_start = start;
+		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
+		entry->size = (size < nr_bytes) ? size : nr_bytes;
+
+		start += entry->size;
+		size -= entry->size;
+	}
+	return 0;
+
+ Error:
+	list_for_each_entry_safe(entry, next, &nvs_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	return -ENOMEM;
+}
+
+/**
+ *	hibernate_nvs_free - free data pages allocated for saving NVS regions
+ */
+void hibernate_nvs_free(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			free_page((unsigned long)entry->data);
+			entry->data = NULL;
+			if (entry->kaddr) {
+				iounmap(entry->kaddr);
+				entry->kaddr = NULL;
+			}
+		}
+}
+
+/**
+ *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regions
+ */
+int hibernate_nvs_alloc(void)
+{
+	struct nvs_page *entry;
+
+	list_for_each_entry(entry, &nvs_list, node) {
+		entry->data = (void *)__get_free_page(GFP_KERNEL);
+		if (!entry->data) {
+			hibernate_nvs_free();
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+/**
+ *	hibernate_nvs_save - save NVS memory regions
+ */
+void hibernate_nvs_save(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Saving platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data) {
+			entry->kaddr = ioremap(entry->phys_start, entry->size);
+			memcpy(entry->data, entry->kaddr, entry->size);
+		}
+}
+
+/**
+ *	hibernate_nvs_restore - restore NVS memory regions
+ *
+ *	This function is going to be called with interrupts disabled, so it
+ *	cannot iounmap the virtual addresses used to access the NVS region.
+ */
+void hibernate_nvs_restore(void)
+{
+	struct nvs_page *entry;
+
+	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
+
+	list_for_each_entry(entry, &nvs_list, node)
+		if (entry->data)
+			memcpy(entry->kaddr, entry->data, entry->size);
+}
Index: linux-2.6/kernel/power/swsusp.c
===================================================================
--- linux-2.6.orig/kernel/power/swsusp.c
+++ linux-2.6/kernel/power/swsusp.c
@@ -262,125 +262,3 @@ int swsusp_shrink_memory(void)
 
 	return 0;
 }
-
-/*
- * Platforms, like ACPI, may want us to save some memory used by them during
- * hibernation and to restore the contents of this memory during the subsequent
- * resume.  The code below implements a mechanism allowing us to do that.
- */
-
-struct nvs_page {
-	unsigned long phys_start;
-	unsigned int size;
-	void *kaddr;
-	void *data;
-	struct list_head node;
-};
-
-static LIST_HEAD(nvs_list);
-
-/**
- *	hibernate_nvs_register - register platform NVS memory region to save
- *	@start - physical address of the region
- *	@size - size of the region
- *
- *	The NVS region need not be page-aligned (both ends) and we arrange
- *	things so that the data from page-aligned addresses in this region will
- *	be copied into separate RAM pages.
- */
-int hibernate_nvs_register(unsigned long start, unsigned long size)
-{
-	struct nvs_page *entry, *next;
-
-	while (size > 0) {
-		unsigned int nr_bytes;
-
-		entry = kzalloc(sizeof(struct nvs_page), GFP_KERNEL);
-		if (!entry)
-			goto Error;
-
-		list_add_tail(&entry->node, &nvs_list);
-		entry->phys_start = start;
-		nr_bytes = PAGE_SIZE - (start & ~PAGE_MASK);
-		entry->size = (size < nr_bytes) ? size : nr_bytes;
-
-		start += entry->size;
-		size -= entry->size;
-	}
-	return 0;
-
- Error:
-	list_for_each_entry_safe(entry, next, &nvs_list, node) {
-		list_del(&entry->node);
-		kfree(entry);
-	}
-	return -ENOMEM;
-}
-
-/**
- *	hibernate_nvs_free - free data pages allocated for saving NVS regions
- */
-void hibernate_nvs_free(void)
-{
-	struct nvs_page *entry;
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			free_page((unsigned long)entry->data);
-			entry->data = NULL;
-			if (entry->kaddr) {
-				iounmap(entry->kaddr);
-				entry->kaddr = NULL;
-			}
-		}
-}
-
-/**
- *	hibernate_nvs_alloc - allocate memory necessary for saving NVS regions
- */
-int hibernate_nvs_alloc(void)
-{
-	struct nvs_page *entry;
-
-	list_for_each_entry(entry, &nvs_list, node) {
-		entry->data = (void *)__get_free_page(GFP_KERNEL);
-		if (!entry->data) {
-			hibernate_nvs_free();
-			return -ENOMEM;
-		}
-	}
-	return 0;
-}
-
-/**
- *	hibernate_nvs_save - save NVS memory regions
- */
-void hibernate_nvs_save(void)
-{
-	struct nvs_page *entry;
-
-	printk(KERN_INFO "PM: Saving platform NVS memory\n");
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data) {
-			entry->kaddr = ioremap(entry->phys_start, entry->size);
-			memcpy(entry->data, entry->kaddr, entry->size);
-		}
-}
-
-/**
- *	hibernate_nvs_restore - restore NVS memory regions
- *
- *	This function is going to be called with interrupts disabled, so it
- *	cannot iounmap the virtual addresses used to access the NVS region.
- */
-void hibernate_nvs_restore(void)
-{
-	struct nvs_page *entry;
-
-	printk(KERN_INFO "PM: Restoring platform NVS memory\n");
-
-	list_for_each_entry(entry, &nvs_list, node)
-		if (entry->data)
-			memcpy(entry->kaddr, entry->data, entry->size);
-}
Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -116,9 +116,13 @@ config SUSPEND_FREEZER
 
 	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
 
+config NVS
+	bool
+
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
+	select NVS if HAS_IOMEM
 	---help---
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
Index: linux-2.6/kernel/power/Makefile
===================================================================
--- linux-2.6.orig/kernel/power/Makefile
+++ linux-2.6/kernel/power/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_PM_SLEEP)		+= console.o
 obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o disk.o snapshot.o swap.o user.o
+obj-$(CONFIG_NVS)		+= nvs.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
Index: linux-2.6/include/linux/suspend.h
===================================================================
--- linux-2.6.orig/include/linux/suspend.h
+++ linux-2.6/include/linux/suspend.h
@@ -245,11 +245,6 @@ extern unsigned long get_safe_page(gfp_t
 
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
-extern int hibernate_nvs_register(unsigned long start, unsigned long size);
-extern int hibernate_nvs_alloc(void);
-extern void hibernate_nvs_free(void);
-extern void hibernate_nvs_save(void);
-extern void hibernate_nvs_restore(void);
 extern bool system_entering_hibernation(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
@@ -258,6 +253,16 @@ static inline void swsusp_unset_page_fre
 
 static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
+static inline bool system_entering_hibernation(void) { return false; }
+#endif /* CONFIG_HIBERNATION */
+
+#ifdef CONFIG_NVS
+extern int hibernate_nvs_register(unsigned long start, unsigned long size);
+extern int hibernate_nvs_alloc(void);
+extern void hibernate_nvs_free(void);
+extern void hibernate_nvs_save(void);
+extern void hibernate_nvs_restore(void);
+#else /* CONFIG_NVS */
 static inline int hibernate_nvs_register(unsigned long a, unsigned long b)
 {
 	return 0;
@@ -266,8 +271,7 @@ static inline int hibernate_nvs_alloc(vo
 static inline void hibernate_nvs_free(void) {}
 static inline void hibernate_nvs_save(void) {}
 static inline void hibernate_nvs_restore(void) {}
-static inline bool system_entering_hibernation(void) { return false; }
-#endif /* CONFIG_HIBERNATION */
+#endif /* CONFIG_NVS */
 
 #ifdef CONFIG_PM_SLEEP
 void save_processor_state(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
