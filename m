Return-Path: <linux-kernel-owner+w=401wt.eu-S1760041AbYFYOlz@vger.kernel.org>
Message-Id: <20080625143614.733404995@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/21] Cleanup appldata printk messages.
Content-Disposition: inline; filename=812-printk-appldata.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata.h         |   14 --------
 arch/s390/appldata/appldata_base.c    |   39 ++---------------------
 arch/s390/appldata/appldata_mem.c     |   43 +------------------------
 arch/s390/appldata/appldata_net_sum.c |   39 -----------------------
 arch/s390/appldata/appldata_os.c      |   57 +---------------------------------
 5 files changed, 11 insertions(+), 181 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -5,7 +5,7 @@
  * Exports appldata_register_ops() and appldata_unregister_ops() for the
  * data gathering modules.
  *
- * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright IBM Corp. 2003, 2008
  *
  * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
@@ -108,9 +108,6 @@ static LIST_HEAD(appldata_ops_list);
  */
 static void appldata_timer_function(unsigned long data)
 {
-	P_DEBUG("   -= Timer =-\n");
-	P_DEBUG("CPU: %i, expire_count: %i\n", smp_processor_id(),
-		atomic_read(&appldata_expire_count));
 	if (atomic_dec_and_test(&appldata_expire_count)) {
 		atomic_set(&appldata_expire_count, num_online_cpus());
 		queue_work(appldata_wq, (struct work_struct *) data);
@@ -128,14 +125,11 @@ static void appldata_work_fn(struct work
 	struct appldata_ops *ops;
 	int i;
 
-	P_DEBUG("  -= Work Queue =-\n");
 	i = 0;
 	get_online_cpus();
 	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
-		P_DEBUG("list_for_each loop: %i) active = %u, name = %s\n",
-			++i, ops->active, ops->name);
 		if (ops->active == 1) {
 			ops->callback(ops->data);
 		}
@@ -212,7 +206,6 @@ __appldata_vtimer_setup(int cmd)
 						 0, 1);
 		}
 		appldata_timer_active = 1;
-		P_INFO("Monitoring timer started.\n");
 		break;
 	case APPLDATA_DEL_TIMER:
 		for_each_online_cpu(i)
@@ -221,7 +214,6 @@ __appldata_vtimer_setup(int cmd)
 			break;
 		appldata_timer_active = 0;
 		atomic_set(&appldata_expire_count, num_online_cpus());
-		P_INFO("Monitoring timer stopped.\n");
 		break;
 	case APPLDATA_MOD_TIMER:
 		per_cpu_interval = (u64) (appldata_interval*1000 /
@@ -313,10 +305,8 @@ appldata_interval_handler(ctl_table *ctl
 	}
 	interval = 0;
 	sscanf(buf, "%i", &interval);
-	if (interval <= 0) {
-		P_ERROR("Timer CPU interval has to be > 0!\n");
+	if (interval <= 0)
 		return -EINVAL;
-	}
 
 	get_online_cpus();
 	spin_lock(&appldata_timer_lock);
@@ -324,9 +314,6 @@ appldata_interval_handler(ctl_table *ctl
 	__appldata_vtimer_setup(APPLDATA_MOD_TIMER);
 	spin_unlock(&appldata_timer_lock);
 	put_online_cpus();
-
-	P_INFO("Monitoring CPU interval set to %u milliseconds.\n",
-		 interval);
 out:
 	*lenp = len;
 	*ppos += len;
@@ -406,23 +393,16 @@ appldata_generic_handler(ctl_table *ctl,
 			P_ERROR("START DIAG 0xDC for %s failed, "
 				"return code: %d\n", ops->name, rc);
 			module_put(ops->owner);
-		} else {
-			P_INFO("Monitoring %s data enabled, "
-				"DIAG 0xDC started.\n", ops->name);
+		} else
 			ops->active = 1;
-		}
 	} else if ((buf[0] == '0') && (ops->active == 1)) {
 		ops->active = 0;
 		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
 				(unsigned long) ops->data, ops->size,
 				ops->mod_lvl);
-		if (rc != 0) {
+		if (rc != 0)
 			P_ERROR("STOP DIAG 0xDC for %s failed, "
 				"return code: %d\n", ops->name, rc);
-		} else {
-			P_INFO("Monitoring %s data disabled, "
-				"DIAG 0xDC stopped.\n", ops->name);
-		}
 		module_put(ops->owner);
 	}
 	spin_unlock(&appldata_ops_lock);
@@ -468,7 +448,6 @@ int appldata_register_ops(struct appldat
 	ops->sysctl_header = register_sysctl_table(ops->ctl_table);
 	if (!ops->sysctl_header)
 		goto out;
-	P_INFO("%s-ops registered!\n", ops->name);
 	return 0;
 out:
 	spin_lock(&appldata_ops_lock);
@@ -490,7 +469,6 @@ void appldata_unregister_ops(struct appl
 	spin_unlock(&appldata_ops_lock);
 	unregister_sysctl_table(ops->sysctl_header);
 	kfree(ops->ctl_table);
-	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
 
@@ -553,14 +531,9 @@ static int __init appldata_init(void)
 {
 	int i;
 
-	P_DEBUG("sizeof(parameter_list) = %lu\n",
-		sizeof(struct appldata_parameter_list));
-
 	appldata_wq = create_singlethread_workqueue("appldata");
-	if (!appldata_wq) {
-		P_ERROR("Could not create work queue\n");
+	if (!appldata_wq)
 		return -ENOMEM;
-	}
 
 	get_online_cpus();
 	for_each_online_cpu(i)
@@ -571,8 +544,6 @@ static int __init appldata_init(void)
 	register_hotcpu_notifier(&appldata_nb);
 
 	appldata_sysctl_header = register_sysctl_table(appldata_dir_table);
-
-	P_DEBUG("Base interface initialized.\n");
 	return 0;
 }
 
Index: quilt-2.6/arch/s390/appldata/appldata.h
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata.h
+++ quilt-2.6/arch/s390/appldata/appldata.h
@@ -3,13 +3,11 @@
  *
  * Definitions and interface for Linux - z/VM Monitor Stream.
  *
- * Copyright (C) 2003,2006 IBM Corporation, IBM Deutschland Entwicklung GmbH.
+ * Copyright IBM Corp. 2003, 2008
  *
  * Author: Gerald Schaefer <gerald.schaefer@de.ibm.com>
  */
 
-//#define APPLDATA_DEBUG			/* Debug messages on/off */
-
 #define APPLDATA_MAX_REC_SIZE	  4024	/* Maximum size of the */
 					/* data buffer */
 #define APPLDATA_MAX_PROCS 100
@@ -28,16 +26,6 @@
 #define CTL_APPLDATA_NET_SUM	2125
 #define CTL_APPLDATA_PROC	2126
 
-#define P_INFO(x...)	printk(KERN_INFO MY_PRINT_NAME " info: " x)
-#define P_ERROR(x...)	printk(KERN_ERR MY_PRINT_NAME " error: " x)
-#define P_WARNING(x...)	printk(KERN_WARNING MY_PRINT_NAME " status: " x)
-
-#ifdef APPLDATA_DEBUG
-#define P_DEBUG(x...)   printk(KERN_DEBUG MY_PRINT_NAME " debug: " x)
-#else
-#define P_DEBUG(x...)   do {} while (0)
-#endif
-
 struct appldata_ops {
 	struct list_head list;
 	struct ctl_table_header *sysctl_header;
Index: quilt-2.6/arch/s390/appldata/appldata_mem.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_mem.c
+++ quilt-2.6/arch/s390/appldata/appldata_mem.c
@@ -14,14 +14,13 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
-#include <asm/io.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <asm/io.h>
 
 #include "appldata.h"
 
 
-#define MY_PRINT_NAME "appldata_mem"		/* for debug messages, etc. */
 #define P2K(x) ((x) << (PAGE_SHIFT - 10))	/* Converts #Pages to KB */
 
 /*
@@ -70,30 +69,6 @@ static struct appldata_mem_data {
 } __attribute__((packed)) appldata_mem_data;
 
 
-static inline void appldata_debug_print(struct appldata_mem_data *mem_data)
-{
-	P_DEBUG("--- MEM - RECORD ---\n");
-	P_DEBUG("pgpgin     = %8lu KB\n", mem_data->pgpgin);
-	P_DEBUG("pgpgout    = %8lu KB\n", mem_data->pgpgout);
-	P_DEBUG("pswpin     = %8lu Pages\n", mem_data->pswpin);
-	P_DEBUG("pswpout    = %8lu Pages\n", mem_data->pswpout);
-	P_DEBUG("pgalloc    = %8lu \n", mem_data->pgalloc);
-	P_DEBUG("pgfault    = %8lu \n", mem_data->pgfault);
-	P_DEBUG("pgmajfault = %8lu \n", mem_data->pgmajfault);
-	P_DEBUG("sharedram  = %8lu KB\n", mem_data->sharedram);
-	P_DEBUG("totalram   = %8lu KB\n", mem_data->totalram);
-	P_DEBUG("freeram    = %8lu KB\n", mem_data->freeram);
-	P_DEBUG("totalhigh  = %8lu KB\n", mem_data->totalhigh);
-	P_DEBUG("freehigh   = %8lu KB\n", mem_data->freehigh);
-	P_DEBUG("bufferram  = %8lu KB\n", mem_data->bufferram);
-	P_DEBUG("cached     = %8lu KB\n", mem_data->cached);
-	P_DEBUG("totalswap  = %8lu KB\n", mem_data->totalswap);
-	P_DEBUG("freeswap   = %8lu KB\n", mem_data->freeswap);
-	P_DEBUG("sync_count_1 = %u\n", mem_data->sync_count_1);
-	P_DEBUG("sync_count_2 = %u\n", mem_data->sync_count_2);
-	P_DEBUG("timestamp    = %lX\n", mem_data->timestamp);
-}
-
 /*
  * appldata_get_mem_data()
  *
@@ -140,9 +115,6 @@ static void appldata_get_mem_data(void *
 
 	mem_data->timestamp = get_clock();
 	mem_data->sync_count_2++;
-#ifdef APPLDATA_DEBUG
-	appldata_debug_print(mem_data);
-#endif
 }
 
 
@@ -164,17 +136,7 @@ static struct appldata_ops ops = {
  */
 static int __init appldata_mem_init(void)
 {
-	int rc;
-
-	P_DEBUG("sizeof(mem) = %lu\n", sizeof(struct appldata_mem_data));
-
-	rc = appldata_register_ops(&ops);
-	if (rc != 0) {
-		P_ERROR("Error registering ops, rc = %i\n", rc);
-	} else {
-		P_DEBUG("%s-ops registered!\n", ops.name);
-	}
-	return rc;
+	return appldata_register_ops(&ops);
 }
 
 /*
@@ -185,7 +147,6 @@ static int __init appldata_mem_init(void
 static void __exit appldata_mem_exit(void)
 {
 	appldata_unregister_ops(&ops);
-	P_DEBUG("%s-ops unregistered!\n", ops.name);
 }
 
 
Index: quilt-2.6/arch/s390/appldata/appldata_net_sum.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_net_sum.c
+++ quilt-2.6/arch/s390/appldata/appldata_net_sum.c
@@ -21,9 +21,6 @@
 #include "appldata.h"
 
 
-#define MY_PRINT_NAME	"appldata_net_sum"	/* for debug messages, etc. */
-
-
 /*
  * Network data
  *
@@ -60,26 +57,6 @@ static struct appldata_net_sum_data {
 } __attribute__((packed)) appldata_net_sum_data;
 
 
-static inline void appldata_print_debug(struct appldata_net_sum_data *net_data)
-{
-	P_DEBUG("--- NET - RECORD ---\n");
-
-	P_DEBUG("nr_interfaces = %u\n", net_data->nr_interfaces);
-	P_DEBUG("rx_packets    = %8lu\n", net_data->rx_packets);
-	P_DEBUG("tx_packets    = %8lu\n", net_data->tx_packets);
-	P_DEBUG("rx_bytes      = %8lu\n", net_data->rx_bytes);
-	P_DEBUG("tx_bytes      = %8lu\n", net_data->tx_bytes);
-	P_DEBUG("rx_errors     = %8lu\n", net_data->rx_errors);
-	P_DEBUG("tx_errors     = %8lu\n", net_data->tx_errors);
-	P_DEBUG("rx_dropped    = %8lu\n", net_data->rx_dropped);
-	P_DEBUG("tx_dropped    = %8lu\n", net_data->tx_dropped);
-	P_DEBUG("collisions    = %8lu\n", net_data->collisions);
-
-	P_DEBUG("sync_count_1 = %u\n", net_data->sync_count_1);
-	P_DEBUG("sync_count_2 = %u\n", net_data->sync_count_2);
-	P_DEBUG("timestamp    = %lX\n", net_data->timestamp);
-}
-
 /*
  * appldata_get_net_sum_data()
  *
@@ -135,9 +112,6 @@ static void appldata_get_net_sum_data(vo
 
 	net_data->timestamp = get_clock();
 	net_data->sync_count_2++;
-#ifdef APPLDATA_DEBUG
-	appldata_print_debug(net_data);
-#endif
 }
 
 
@@ -159,17 +133,7 @@ static struct appldata_ops ops = {
  */
 static int __init appldata_net_init(void)
 {
-	int rc;
-
-	P_DEBUG("sizeof(net) = %lu\n", sizeof(struct appldata_net_sum_data));
-
-	rc = appldata_register_ops(&ops);
-	if (rc != 0) {
-		P_ERROR("Error registering ops, rc = %i\n", rc);
-	} else {
-		P_DEBUG("%s-ops registered!\n", ops.name);
-	}
-	return rc;
+	return appldata_register_ops(&ops);
 }
 
 /*
@@ -180,7 +144,6 @@ static int __init appldata_net_init(void
 static void __exit appldata_net_exit(void)
 {
 	appldata_unregister_ops(&ops);
-	P_DEBUG("%s-ops unregistered!\n", ops.name);
 }
 
 
Index: quilt-2.6/arch/s390/appldata/appldata_os.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_os.c
+++ quilt-2.6/arch/s390/appldata/appldata_os.c
@@ -89,44 +89,6 @@ static struct appldata_ops ops = {
 };
 
 
-static inline void appldata_print_debug(struct appldata_os_data *os_data)
-{
-	int a0, a1, a2, i;
-
-	P_DEBUG("--- OS - RECORD ---\n");
-	P_DEBUG("nr_threads   = %u\n", os_data->nr_threads);
-	P_DEBUG("nr_running   = %u\n", os_data->nr_running);
-	P_DEBUG("nr_iowait    = %u\n", os_data->nr_iowait);
-	P_DEBUG("avenrun(int) = %8x / %8x / %8x\n", os_data->avenrun[0],
-		os_data->avenrun[1], os_data->avenrun[2]);
-	a0 = os_data->avenrun[0];
-	a1 = os_data->avenrun[1];
-	a2 = os_data->avenrun[2];
-	P_DEBUG("avenrun(float) = %d.%02d / %d.%02d / %d.%02d\n",
-		LOAD_INT(a0), LOAD_FRAC(a0), LOAD_INT(a1), LOAD_FRAC(a1),
-		LOAD_INT(a2), LOAD_FRAC(a2));
-
-	P_DEBUG("nr_cpus = %u\n", os_data->nr_cpus);
-	for (i = 0; i < os_data->nr_cpus; i++) {
-		P_DEBUG("cpu%u : user = %u, nice = %u, system = %u, "
-			"idle = %u, irq = %u, softirq = %u, iowait = %u, "
-			"steal = %u\n",
-				os_data->os_cpu[i].cpu_id,
-				os_data->os_cpu[i].per_cpu_user,
-				os_data->os_cpu[i].per_cpu_nice,
-				os_data->os_cpu[i].per_cpu_system,
-				os_data->os_cpu[i].per_cpu_idle,
-				os_data->os_cpu[i].per_cpu_irq,
-				os_data->os_cpu[i].per_cpu_softirq,
-				os_data->os_cpu[i].per_cpu_iowait,
-				os_data->os_cpu[i].per_cpu_steal);
-	}
-
-	P_DEBUG("sync_count_1 = %u\n", os_data->sync_count_1);
-	P_DEBUG("sync_count_2 = %u\n", os_data->sync_count_2);
-	P_DEBUG("timestamp    = %lX\n", os_data->timestamp);
-}
-
 /*
  * appldata_get_os_data()
  *
@@ -180,13 +142,10 @@ static void appldata_get_os_data(void *d
 					   APPLDATA_START_INTERVAL_REC,
 					   (unsigned long) ops.data, new_size,
 					   ops.mod_lvl);
-			if (rc != 0) {
+			if (rc != 0)
 				P_ERROR("os: START NEW DIAG 0xDC failed, "
 					"return code: %d, new size = %i\n", rc,
 					new_size);
-				P_INFO("os: stopping old record now\n");
-			} else
-				P_INFO("os: new record size = %i\n", new_size);
 
 			rc = appldata_diag(APPLDATA_RECORD_OS_ID,
 					   APPLDATA_STOP_REC,
@@ -204,9 +163,6 @@ static void appldata_get_os_data(void *d
 	}
 	os_data->timestamp = get_clock();
 	os_data->sync_count_2++;
-#ifdef APPLDATA_DEBUG
-	appldata_print_debug(os_data);
-#endif
 }
 
 
@@ -227,12 +183,9 @@ static int __init appldata_os_init(void)
 		rc = -ENOMEM;
 		goto out;
 	}
-	P_DEBUG("max. sizeof(os) = %i, sizeof(os_cpu) = %lu\n", max_size,
-		sizeof(struct appldata_os_per_cpu));
 
 	appldata_os_data = kzalloc(max_size, GFP_DMA);
 	if (appldata_os_data == NULL) {
-		P_ERROR("No memory for %s!\n", ops.name);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -240,17 +193,12 @@ static int __init appldata_os_init(void)
 	appldata_os_data->per_cpu_size = sizeof(struct appldata_os_per_cpu);
 	appldata_os_data->cpu_offset   = offsetof(struct appldata_os_data,
 							os_cpu);
-	P_DEBUG("cpu offset = %u\n", appldata_os_data->cpu_offset);
 
 	ops.data = appldata_os_data;
 	ops.callback  = &appldata_get_os_data;
 	rc = appldata_register_ops(&ops);
-	if (rc != 0) {
-		P_ERROR("Error registering ops, rc = %i\n", rc);
+	if (rc != 0)
 		kfree(appldata_os_data);
-	} else {
-		P_DEBUG("%s-ops registered!\n", ops.name);
-	}
 out:
 	return rc;
 }
@@ -264,7 +212,6 @@ static void __exit appldata_os_exit(void
 {
 	appldata_unregister_ops(&ops);
 	kfree(appldata_os_data);
-	P_DEBUG("%s-ops unregistered!\n", ops.name);
 }
 
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
