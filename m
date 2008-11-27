Return-Path: <linux-kernel-owner+w=401wt.eu-S1754513AbYK0Kg1@vger.kernel.org>
Message-Id: <20081127103132.238008874@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/60] service level interface.
Content-Disposition: inline; filename=115-service-levels.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add a new proc interface /proc/service_levels that allows any code
to report a relevant service level, e.g. the microcode level of 
devices, the service level of the hypervisor, etc.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/sysinfo.h   |   11 +++
 drivers/s390/net/qeth_core.h      |    2 
 drivers/s390/net/qeth_core_main.c |   11 +++
 drivers/s390/sysinfo.c            |  127 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 149 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/sysinfo.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sysinfo.h
+++ quilt-2.6/arch/s390/include/asm/sysinfo.h
@@ -118,4 +118,15 @@ static inline int stsi(void *sysinfo, in
 	return r0;
 }
 
+/*
+ * Service level reporting interface.
+ */
+struct service_level {
+	struct list_head list;
+	void (*seq_print)(struct seq_file *, struct service_level *);
+};
+
+int register_service_level(struct service_level *);
+int unregister_service_level(struct service_level *);
+
 #endif /* __ASM_S390_SYSINFO_H */
Index: quilt-2.6/drivers/s390/net/qeth_core.h
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core.h
+++ quilt-2.6/drivers/s390/net/qeth_core.h
@@ -31,6 +31,7 @@
 #include <asm/qdio.h>
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
+#include <asm/sysinfo.h>
 
 #include "qeth_core_mpc.h"
 
@@ -733,6 +734,7 @@ struct qeth_card {
 	struct qeth_osn_info osn_info;
 	struct qeth_discipline discipline;
 	atomic_t force_alloc_skb;
+	struct service_level qeth_service_level;
 };
 
 struct qeth_card_list_struct {
Index: quilt-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ quilt-2.6/drivers/s390/net/qeth_core_main.c
@@ -1138,6 +1138,14 @@ static int qeth_setup_card(struct qeth_c
 	return 0;
 }
 
+static void qeth_core_sl_print(struct seq_file *m, struct service_level *slr)
+{
+	struct qeth_card *card = container_of(slr, struct qeth_card,
+					qeth_service_level);
+	seq_printf(m, "qeth: %s firmware level %s\n", CARD_BUS_ID(card),
+			card->info.mcl_level);
+}
+
 static struct qeth_card *qeth_alloc_card(void)
 {
 	struct qeth_card *card;
@@ -1157,6 +1165,8 @@ static struct qeth_card *qeth_alloc_card
 		return NULL;
 	}
 	card->options.layer2 = -1;
+	card->qeth_service_level.seq_print = qeth_core_sl_print;
+	register_service_level(&card->qeth_service_level);
 	return card;
 }
 
@@ -3730,6 +3740,7 @@ static void qeth_core_free_card(struct q
 		free_netdev(card->dev);
 	kfree(card->ip_tbd_list);
 	qeth_free_qdio_buffers(card);
+	unregister_service_level(&card->qeth_service_level);
 	kfree(card);
 }
 
Index: quilt-2.6/drivers/s390/sysinfo.c
===================================================================
--- quilt-2.6.orig/drivers/s390/sysinfo.c
+++ quilt-2.6/drivers/s390/sysinfo.c
@@ -1,17 +1,21 @@
 /*
  *  drivers/s390/sysinfo.c
  *
- *    Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Ulrich Weigand (Ulrich.Weigand@de.ibm.com)
+ *  Copyright IBM Corp. 2001, 2008
+ *  Author(s): Ulrich Weigand (Ulrich.Weigand@de.ibm.com)
+ *	       Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/module.h>
 #include <asm/ebcdic.h>
 #include <asm/sysinfo.h>
+#include <asm/cpcmd.h>
 
 /* Sigh, math-emu. Don't ask. */
 #include <asm/sfp-util.h>
@@ -271,6 +275,125 @@ static __init int create_proc_sysinfo(vo
 
 __initcall(create_proc_sysinfo);
 
+/*
+ * Service levels interface.
+ */
+
+static DECLARE_RWSEM(service_level_sem);
+static LIST_HEAD(service_level_list);
+
+int register_service_level(struct service_level *slr)
+{
+	struct service_level *ptr;
+
+	down_write(&service_level_sem);
+	list_for_each_entry(ptr, &service_level_list, list)
+		if (ptr == slr) {
+			up_write(&service_level_sem);
+			return -EEXIST;
+		}
+	list_add_tail(&slr->list, &service_level_list);
+	up_write(&service_level_sem);
+	return 0;
+}
+EXPORT_SYMBOL(register_service_level);
+
+int unregister_service_level(struct service_level *slr)
+{
+	struct service_level *ptr, *next;
+	int rc = -ENOENT;
+
+	down_write(&service_level_sem);
+	list_for_each_entry_safe(ptr, next, &service_level_list, list) {
+		if (ptr != slr)
+			continue;
+		list_del(&ptr->list);
+		rc = 0;
+		break;
+	}
+	up_write(&service_level_sem);
+	return rc;
+}
+EXPORT_SYMBOL(unregister_service_level);
+
+static void *service_level_start(struct seq_file *m, loff_t *pos)
+{
+	down_read(&service_level_sem);
+	return seq_list_start(&service_level_list, *pos);
+}
+
+static void *service_level_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next(p, &service_level_list, pos);
+}
+
+static void service_level_stop(struct seq_file *m, void *p)
+{
+	up_read(&service_level_sem);
+}
+
+static int service_level_show(struct seq_file *m, void *p)
+{
+	struct service_level *slr;
+
+	slr = list_entry(p, struct service_level, list);
+	slr->seq_print(m, slr);
+	return 0;
+}
+
+static const struct seq_operations service_level_seq_ops = {
+	.start		= service_level_start,
+	.next		= service_level_next,
+	.stop		= service_level_stop,
+	.show		= service_level_show
+};
+
+static int service_level_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &service_level_seq_ops);
+}
+
+static const struct file_operations service_level_ops = {
+	.open		= service_level_open,
+	.read		= seq_read,
+	.llseek 	= seq_lseek,
+	.release	= seq_release
+};
+
+static void service_level_vm_print(struct seq_file *m,
+				   struct service_level *slr)
+{
+	char *query_buffer, *str;
+
+	query_buffer = kmalloc(1024, GFP_KERNEL | GFP_DMA);
+	if (!query_buffer)
+		return;
+	cpcmd("QUERY CPLEVEL", query_buffer, 1024, NULL);
+	str = strchr(query_buffer, '\n');
+	if (str)
+		*str = 0;
+	seq_printf(m, "VM: %s\n", query_buffer);
+	kfree(query_buffer);
+}
+
+static struct service_level service_level_vm = {
+	.seq_print = service_level_vm_print
+};
+
+static __init int create_proc_service_level(void)
+{
+	proc_create("service_levels", 0, NULL, &service_level_ops);
+	if (MACHINE_IS_VM)
+		register_service_level(&service_level_vm);
+	return 0;
+}
+
+subsys_initcall(create_proc_service_level);
+
+/*
+ * Bogomips calculation based on cpu capability.
+ */
+
 int get_cpu_capability(unsigned int *capability)
 {
 	struct sysinfo_1_2_2 *info;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
