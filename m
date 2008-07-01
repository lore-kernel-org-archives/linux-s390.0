Return-Path: <linux-kernel-owner+w=401wt.eu-S1759247AbYGAOIl@vger.kernel.org>
Message-Id: <20080701140624.830807533@de.ibm.com>
References: <20080701140551.168274793@de.ibm.com>
Date: Tue, 01 Jul 2008 16:05:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/5] qdio: new qdio driver, part 2.
Content-Disposition: inline; filename=202-nqio-main2.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: jang@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

List of major changes:
- split qdio driver into several files
- seperation of thin interrupt code
- improved handling for multiple thin interrupt devices
- inbound and outbound processing now always runs in tasklet context
- significant less tasklet schedules per interrupt needed
- merged qebsm with non-qebsm handling
- cleanup qdio interface and added kerneldoc
- coding style

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Utz Bacher <utz.bacher@de.ibm.com>
Reviewed-by: Ursula Braun <braunu@de.ibm.com>

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/Makefile       |    2 
 drivers/s390/cio/qdio.h         |  830 +++++++++++++---------------------------
 drivers/s390/cio/qdio_debug.c   |  238 +++++++++++
 drivers/s390/cio/qdio_debug.h   |   93 ++++
 drivers/s390/cio/qdio_perf.c    |  151 +++++++
 drivers/s390/cio/qdio_perf.h    |   54 ++
 drivers/s390/cio/qdio_setup.c   |  516 ++++++++++++++++++++++++
 drivers/s390/cio/qdio_thinint.c |  380 ++++++++++++++++++
 include/asm-s390/qdio.h         |  640 ++++++++++++++----------------
 9 files changed, 2029 insertions(+), 875 deletions(-)

Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile
+++ quilt-2.6/drivers/s390/cio/Makefile
@@ -9,4 +9,6 @@ ccw_device-objs += device_id.o device_pg
 obj-y += ccw_device.o cmf.o
 obj-$(CONFIG_CHSC_SCH) += chsc_sch.o
 obj-$(CONFIG_CCWGROUP) += ccwgroup.o
+
+qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_perf.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
Index: quilt-2.6/drivers/s390/cio/qdio_debug.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/qdio_debug.c
@@ -0,0 +1,238 @@
+/*
+ *  drivers/s390/cio/qdio_debug.c
+ *
+ *  Copyright IBM Corp. 2008
+ *
+ *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
+ */
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <asm/qdio.h>
+#include <asm/debug.h>
+#include "qdio_debug.h"
+#include "qdio.h"
+
+debug_info_t *qdio_dbf_setup;
+debug_info_t *qdio_dbf_trace;
+
+static struct dentry *debugfs_root;
+#define MAX_DEBUGFS_QUEUES	32
+static struct dentry *debugfs_queues[MAX_DEBUGFS_QUEUES] = { NULL };
+static DEFINE_MUTEX(debugfs_mutex);
+
+void qdio_allocate_do_dbf(struct qdio_initialize *init_data)
+{
+	char dbf_text[20];
+
+	sprintf(dbf_text, "qfmt:%x", init_data->q_format);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	QDIO_DBF_HEX0(0, setup, init_data->adapter_name, 8);
+	sprintf(dbf_text, "qpff%4x", init_data->qib_param_field_format);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	QDIO_DBF_HEX0(0, setup, &init_data->qib_param_field, sizeof(void *));
+	QDIO_DBF_HEX0(0, setup, &init_data->input_slib_elements, sizeof(void *));
+	QDIO_DBF_HEX0(0, setup, &init_data->output_slib_elements, sizeof(void *));
+	sprintf(dbf_text, "niq:%4x", init_data->no_input_qs);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	sprintf(dbf_text, "noq:%4x", init_data->no_output_qs);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	QDIO_DBF_HEX0(0, setup, &init_data->input_handler, sizeof(void *));
+	QDIO_DBF_HEX0(0, setup, &init_data->output_handler, sizeof(void *));
+	QDIO_DBF_HEX0(0, setup, &init_data->int_parm, sizeof(long));
+	QDIO_DBF_HEX0(0, setup, &init_data->flags, sizeof(long));
+	QDIO_DBF_HEX0(0, setup, &init_data->input_sbal_addr_array, sizeof(void *));
+	QDIO_DBF_HEX0(0, setup, &init_data->output_sbal_addr_array, sizeof(void *));
+}
+
+static void qdio_unregister_dbf_views(void)
+{
+	if (qdio_dbf_setup)
+		debug_unregister(qdio_dbf_setup);
+	if (qdio_dbf_trace)
+		debug_unregister(qdio_dbf_trace);
+}
+
+static int qdio_register_dbf_views(void)
+{
+	qdio_dbf_setup = debug_register("qdio_setup", QDIO_DBF_SETUP_PAGES,
+					QDIO_DBF_SETUP_NR_AREAS,
+					QDIO_DBF_SETUP_LEN);
+	if (!qdio_dbf_setup)
+		goto oom;
+	debug_register_view(qdio_dbf_setup, &debug_hex_ascii_view);
+	debug_set_level(qdio_dbf_setup, QDIO_DBF_SETUP_LEVEL);
+
+	qdio_dbf_trace = debug_register("qdio_trace", QDIO_DBF_TRACE_PAGES,
+					QDIO_DBF_TRACE_NR_AREAS,
+					QDIO_DBF_TRACE_LEN);
+	if (!qdio_dbf_trace)
+		goto oom;
+	debug_register_view(qdio_dbf_trace, &debug_hex_ascii_view);
+	debug_set_level(qdio_dbf_trace, QDIO_DBF_TRACE_LEVEL);
+	return 0;
+oom:
+	qdio_unregister_dbf_views();
+	return -ENOMEM;
+}
+
+static int qstat_show(struct seq_file *m, void *v)
+{
+	unsigned char state;
+	struct qdio_q *q = (struct qdio_q *)m->private;
+	int i;
+
+	if (!q)
+		return 0;
+
+	seq_printf(m, "device state indicator: %d\n", *q->irq_ptr->dsci);
+	seq_printf(m, "nr_used: %d\n", atomic_read(&q->nr_buf_used));
+	seq_printf(m, "ftc: %d\n", q->first_to_check);
+	seq_printf(m, "last_move_ftc: %d\n", q->last_move_ftc);
+	seq_printf(m, "polling: %d\n", atomic_read(&q->u.in.polling));
+	seq_printf(m, "slsb buffer states:\n");
+
+	qdio_siga_sync_q(q);
+	for (i = 0; i < QDIO_MAX_BUFFERS_PER_Q; i++) {
+		get_buf_state(q, i, &state);
+		switch (state) {
+		case SLSB_P_INPUT_NOT_INIT:
+		case SLSB_P_OUTPUT_NOT_INIT:
+			seq_printf(m, "N");
+			break;
+		case SLSB_P_INPUT_PRIMED:
+		case SLSB_CU_OUTPUT_PRIMED:
+			seq_printf(m, "+");
+			break;
+		case SLSB_P_INPUT_ACK:
+			seq_printf(m, "A");
+			break;
+		case SLSB_P_INPUT_ERROR:
+		case SLSB_P_OUTPUT_ERROR:
+			seq_printf(m, "x");
+			break;
+		case SLSB_CU_INPUT_EMPTY:
+		case SLSB_P_OUTPUT_EMPTY:
+			seq_printf(m, "-");
+			break;
+		case SLSB_P_INPUT_HALTED:
+		case SLSB_P_OUTPUT_HALTED:
+			seq_printf(m, ".");
+			break;
+		default:
+			seq_printf(m, "?");
+		}
+		if (i == 63)
+			seq_printf(m, "\n");
+	}
+	seq_printf(m, "\n");
+	return 0;
+}
+
+static ssize_t qstat_seq_write(struct file *file, const char __user *buf,
+			       size_t count, loff_t *off)
+{
+	struct seq_file *seq = file->private_data;
+	struct qdio_q *q = (struct qdio_q *)seq->private;
+
+	if (!q)
+		return 0;
+
+	if (q->is_input_q)
+		xchg(q->irq_ptr->dsci, 1);
+	tasklet_schedule(&q->tasklet);
+	return count;
+}
+
+static int qstat_seq_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, qstat_show,
+			   filp->f_path.dentry->d_inode->i_private);
+}
+
+static void get_queue_name(struct qdio_q *q, struct ccw_device *cdev, char *name)
+{
+	memset(name, 0, sizeof(name));
+	sprintf(name, "%s", cdev->dev.bus_id);
+	if (q->is_input_q)
+		sprintf(name + strlen(name), "_input");
+	else
+		sprintf(name + strlen(name), "_output");
+	sprintf(name + strlen(name), "_%d", q->nr);
+}
+
+static void remove_debugfs_entry(struct qdio_q *q)
+{
+	int i;
+
+	for (i = 0; i < MAX_DEBUGFS_QUEUES; i++) {
+		if (!debugfs_queues[i])
+			continue;
+		if (debugfs_queues[i]->d_inode->i_private == q) {
+			debugfs_remove(debugfs_queues[i]);
+			debugfs_queues[i] = NULL;
+		}
+	}
+}
+
+static struct file_operations debugfs_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = qstat_seq_open,
+	.read	 = seq_read,
+	.write	 = qstat_seq_write,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static void setup_debugfs_entry(struct qdio_q *q, struct ccw_device *cdev)
+{
+	int i = 0;
+	char name[40];
+
+	while (debugfs_queues[i] != NULL) {
+		i++;
+		if (i >= MAX_DEBUGFS_QUEUES)
+			return;
+	}
+	get_queue_name(q, cdev, name);
+	debugfs_queues[i] = debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR,
+						debugfs_root, q, &debugfs_fops);
+}
+
+void qdio_setup_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cdev)
+{
+	struct qdio_q *q;
+	int i;
+
+	mutex_lock(&debugfs_mutex);
+	for_each_input_queue(irq_ptr, q, i)
+		setup_debugfs_entry(q, cdev);
+	for_each_output_queue(irq_ptr, q, i)
+		setup_debugfs_entry(q, cdev);
+	mutex_unlock(&debugfs_mutex);
+}
+
+void qdio_shutdown_debug_entries(struct qdio_irq *irq_ptr, struct ccw_device *cdev)
+{
+	struct qdio_q *q;
+	int i;
+
+	mutex_lock(&debugfs_mutex);
+	for_each_input_queue(irq_ptr, q, i)
+		remove_debugfs_entry(q);
+	for_each_output_queue(irq_ptr, q, i)
+		remove_debugfs_entry(q);
+	mutex_unlock(&debugfs_mutex);
+}
+
+int __init qdio_debug_init(void)
+{
+	debugfs_root = debugfs_create_dir("qdio_queues", NULL);
+	return qdio_register_dbf_views();
+}
+
+void qdio_debug_exit(void)
+{
+	debugfs_remove(debugfs_root);
+	qdio_unregister_dbf_views();
+}
Index: quilt-2.6/drivers/s390/cio/qdio_debug.h
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/qdio_debug.h
@@ -0,0 +1,93 @@
+/*
+ *  drivers/s390/cio/qdio_debug.h
+ *
+ *  Copyright IBM Corp. 2008
+ *
+ *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
+ */
+#ifndef QDIO_DEBUG_H
+#define QDIO_DEBUG_H
+
+#include <asm/debug.h>
+#include <asm/qdio.h>
+#include "qdio.h"
+
+#define QDIO_DBF_HEX(ex, name, level, addr, len) \
+	do { \
+	if (ex) \
+		debug_exception(qdio_dbf_##name, level, (void *)(addr), len); \
+	else \
+		debug_event(qdio_dbf_##name, level, (void *)(addr), len); \
+	} while (0)
+#define QDIO_DBF_TEXT(ex, name, level, text) \
+	do { \
+	if (ex) \
+		debug_text_exception(qdio_dbf_##name, level, text); \
+	else \
+		debug_text_event(qdio_dbf_##name, level, text); \
+	} while (0)
+
+#define QDIO_DBF_HEX0(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 0, addr, len)
+#define QDIO_DBF_HEX1(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 1, addr, len)
+#define QDIO_DBF_HEX2(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 2, addr, len)
+
+#ifdef CONFIG_QDIO_DEBUG
+#define QDIO_DBF_HEX3(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 3, addr, len)
+#define QDIO_DBF_HEX4(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 4, addr, len)
+#define QDIO_DBF_HEX5(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 5, addr, len)
+#define QDIO_DBF_HEX6(ex, name, addr, len) QDIO_DBF_HEX(ex, name, 6, addr, len)
+#else
+#define QDIO_DBF_HEX3(ex, name, addr, len) do {} while (0)
+#define QDIO_DBF_HEX4(ex, name, addr, len) do {} while (0)
+#define QDIO_DBF_HEX5(ex, name, addr, len) do {} while (0)
+#define QDIO_DBF_HEX6(ex, name, addr, len) do {} while (0)
+#endif /* CONFIG_QDIO_DEBUG */
+
+#define QDIO_DBF_TEXT0(ex, name, text) QDIO_DBF_TEXT(ex, name, 0, text)
+#define QDIO_DBF_TEXT1(ex, name, text) QDIO_DBF_TEXT(ex, name, 1, text)
+#define QDIO_DBF_TEXT2(ex, name, text) QDIO_DBF_TEXT(ex, name, 2, text)
+
+#ifdef CONFIG_QDIO_DEBUG
+#define QDIO_DBF_TEXT3(ex, name, text) QDIO_DBF_TEXT(ex, name, 3, text)
+#define QDIO_DBF_TEXT4(ex, name, text) QDIO_DBF_TEXT(ex, name, 4, text)
+#define QDIO_DBF_TEXT5(ex, name, text) QDIO_DBF_TEXT(ex, name, 5, text)
+#define QDIO_DBF_TEXT6(ex, name, text) QDIO_DBF_TEXT(ex, name, 6, text)
+#else
+#define QDIO_DBF_TEXT3(ex, name, text) do {} while (0)
+#define QDIO_DBF_TEXT4(ex, name, text) do {} while (0)
+#define QDIO_DBF_TEXT5(ex, name, text) do {} while (0)
+#define QDIO_DBF_TEXT6(ex, name, text) do {} while (0)
+#endif /* CONFIG_QDIO_DEBUG */
+
+/* s390dbf views */
+#define QDIO_DBF_SETUP_LEN		8
+#define QDIO_DBF_SETUP_PAGES		4
+#define QDIO_DBF_SETUP_NR_AREAS		1
+
+#define QDIO_DBF_TRACE_LEN		8
+#define QDIO_DBF_TRACE_NR_AREAS		2
+
+#ifdef CONFIG_QDIO_DEBUG
+#define QDIO_DBF_TRACE_PAGES		16
+#define QDIO_DBF_SETUP_LEVEL		6
+#define QDIO_DBF_SBAL_LEVEL		6
+#define QDIO_DBF_TRACE_LEVEL		4
+#else /* !CONFIG_QDIO_DEBUG */
+#define QDIO_DBF_TRACE_PAGES		4
+#define QDIO_DBF_SETUP_LEVEL		2
+#define QDIO_DBF_SBAL_LEVEL		2
+#define QDIO_DBF_TRACE_LEVEL		2
+#endif /* CONFIG_QDIO_DEBUG */
+
+extern debug_info_t *qdio_dbf_setup;
+extern debug_info_t *qdio_dbf_trace;
+
+void qdio_allocate_do_dbf(struct qdio_initialize *init_data);
+void debug_print_bstat(struct qdio_q *q);
+void qdio_setup_debug_entries(struct qdio_irq *irq_ptr,
+			      struct ccw_device *cdev);
+void qdio_shutdown_debug_entries(struct qdio_irq *irq_ptr,
+				 struct ccw_device *cdev);
+int qdio_debug_init(void);
+void qdio_debug_exit(void);
+#endif
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -1,66 +1,20 @@
+/*
+ * linux/drivers/s390/cio/qdio.h
+ *
+ * Copyright 2000,2008 IBM Corp.
+ * Author(s): Utz Bacher <utz.bacher@de.ibm.com>
+ *	      Jan Glauber <jang@linux.vnet.ibm.com>
+ */
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
 #include <asm/page.h>
-#include <asm/isc.h>
 #include <asm/schid.h>
+#include "chsc.h"
 
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_VERBOSE_LEVEL 9
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_VERBOSE_LEVEL 5
-#endif /* CONFIG_QDIO_DEBUG */
-#define QDIO_USE_PROCESSING_STATE
-
-#define QDIO_MINIMAL_BH_RELIEF_TIME 16
-#define QDIO_TIMER_POLL_VALUE 1
-#define IQDIO_TIMER_POLL_VALUE 1
-
-/*
- * unfortunately this can't be (QDIO_MAX_BUFFERS_PER_Q*4/3) or so -- as
- * we never know, whether we'll get initiative again, e.g. to give the
- * transmit skb's back to the stack, however the stack may be waiting for
- * them... therefore we define 4 as threshold to start polling (which
- * will stop as soon as the asynchronous queue catches up)
- * btw, this only applies to the asynchronous HiperSockets queue
- */
-#define IQDIO_FILL_LEVEL_TO_POLL 4
-
-#define TIQDIO_THININT_ISC QDIO_AIRQ_ISC
-#define TIQDIO_DELAY_TARGET 0
-#define QDIO_BUSY_BIT_PATIENCE 100 /* in microsecs */
-#define QDIO_BUSY_BIT_GIVE_UP 10000000 /* 10 seconds */
-#define IQDIO_GLOBAL_LAPS 2 /* GLOBAL_LAPS are not used as we */
-#define IQDIO_GLOBAL_LAPS_INT 1 /* don't global summary */
-#define IQDIO_LOCAL_LAPS 4
-#define IQDIO_LOCAL_LAPS_INT 1
-#define IQDIO_GLOBAL_SUMMARY_CC_MASK 2
-/*#define IQDIO_IQDC_INT_PARM 0x1234*/
-
-#define QDIO_Q_LAPS 5
-
-#define QDIO_STORAGE_KEY PAGE_DEFAULT_KEY
-
-#define L2_CACHELINE_SIZE 256
-#define INDICATORS_PER_CACHELINE (L2_CACHELINE_SIZE/sizeof(__u32))
-
-#define QDIO_PERF "qdio_perf"
-
-/* must be a power of 2 */
-/*#define QDIO_STATS_NUMBER 4
-
-#define QDIO_STATS_CLASSES 2
-#define QDIO_STATS_COUNT_NEEDED 2*/
-
-#define QDIO_NO_USE_COUNT_TIMEOUT (1*HZ) /* wait for 1 sec on each q before
-					    exiting without having use_count
-					    of the queue to 0 */
-
-#define QDIO_ESTABLISH_TIMEOUT (1*HZ)
-#define QDIO_CLEANUP_CLEAR_TIMEOUT (20*HZ)
-#define QDIO_CLEANUP_HALT_TIMEOUT (10*HZ)
-#define QDIO_FORCE_CHECK_TIMEOUT (10*HZ)
-#define QDIO_ACTIVATE_TIMEOUT (5) /* 5 ms */
+#define QDIO_BUSY_BIT_PATIENCE		100	/* 100 microseconds */
+#define QDIO_BUSY_BIT_GIVE_UP		2000000	/* 2 seconds = eternity */
+#define QDIO_INPUT_THRESHOLD		500	/* 500 microseconds */
 
 enum qdio_irq_states {
 	QDIO_IRQ_STATE_INACTIVE,
@@ -72,224 +26,85 @@ enum qdio_irq_states {
 	NR_QDIO_IRQ_STATES,
 };
 
-/* used as intparm in do_IO: */
-#define QDIO_DOING_SENSEID 0
-#define QDIO_DOING_ESTABLISH 1
-#define QDIO_DOING_ACTIVATE 2
-#define QDIO_DOING_CLEANUP 3
-
-/************************* DEBUG FACILITY STUFF *********************/
-
-#define QDIO_DBF_HEX(ex,name,level,addr,len) \
-	do { \
-	if (ex) \
-		debug_exception(qdio_dbf_##name,level,(void*)(addr),len); \
-	else \
-		debug_event(qdio_dbf_##name,level,(void*)(addr),len); \
-	} while (0)
-#define QDIO_DBF_TEXT(ex,name,level,text) \
-	do { \
-	if (ex) \
-		debug_text_exception(qdio_dbf_##name,level,text); \
-	else \
-		debug_text_event(qdio_dbf_##name,level,text); \
-	} while (0)
-
-
-#define QDIO_DBF_HEX0(ex,name,addr,len) QDIO_DBF_HEX(ex,name,0,addr,len)
-#define QDIO_DBF_HEX1(ex,name,addr,len) QDIO_DBF_HEX(ex,name,1,addr,len)
-#define QDIO_DBF_HEX2(ex,name,addr,len) QDIO_DBF_HEX(ex,name,2,addr,len)
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_HEX3(ex,name,addr,len) QDIO_DBF_HEX(ex,name,3,addr,len)
-#define QDIO_DBF_HEX4(ex,name,addr,len) QDIO_DBF_HEX(ex,name,4,addr,len)
-#define QDIO_DBF_HEX5(ex,name,addr,len) QDIO_DBF_HEX(ex,name,5,addr,len)
-#define QDIO_DBF_HEX6(ex,name,addr,len) QDIO_DBF_HEX(ex,name,6,addr,len)
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_HEX3(ex,name,addr,len) do {} while (0)
-#define QDIO_DBF_HEX4(ex,name,addr,len) do {} while (0)
-#define QDIO_DBF_HEX5(ex,name,addr,len) do {} while (0)
-#define QDIO_DBF_HEX6(ex,name,addr,len) do {} while (0)
-#endif /* CONFIG_QDIO_DEBUG */
-
-#define QDIO_DBF_TEXT0(ex,name,text) QDIO_DBF_TEXT(ex,name,0,text)
-#define QDIO_DBF_TEXT1(ex,name,text) QDIO_DBF_TEXT(ex,name,1,text)
-#define QDIO_DBF_TEXT2(ex,name,text) QDIO_DBF_TEXT(ex,name,2,text)
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_TEXT3(ex,name,text) QDIO_DBF_TEXT(ex,name,3,text)
-#define QDIO_DBF_TEXT4(ex,name,text) QDIO_DBF_TEXT(ex,name,4,text)
-#define QDIO_DBF_TEXT5(ex,name,text) QDIO_DBF_TEXT(ex,name,5,text)
-#define QDIO_DBF_TEXT6(ex,name,text) QDIO_DBF_TEXT(ex,name,6,text)
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_TEXT3(ex,name,text) do {} while (0)
-#define QDIO_DBF_TEXT4(ex,name,text) do {} while (0)
-#define QDIO_DBF_TEXT5(ex,name,text) do {} while (0)
-#define QDIO_DBF_TEXT6(ex,name,text) do {} while (0)
-#endif /* CONFIG_QDIO_DEBUG */
-
-#define QDIO_DBF_SETUP_NAME "qdio_setup"
-#define QDIO_DBF_SETUP_LEN 8
-#define QDIO_DBF_SETUP_PAGES 4
-#define QDIO_DBF_SETUP_NR_AREAS 1
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_SETUP_LEVEL 6
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_SETUP_LEVEL 2
-#endif /* CONFIG_QDIO_DEBUG */
-
-#define QDIO_DBF_SBAL_NAME "qdio_labs" /* sbal */
-#define QDIO_DBF_SBAL_LEN 256
-#define QDIO_DBF_SBAL_PAGES 4
-#define QDIO_DBF_SBAL_NR_AREAS 2
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_SBAL_LEVEL 6
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_SBAL_LEVEL 2
-#endif /* CONFIG_QDIO_DEBUG */
-
-#define QDIO_DBF_TRACE_NAME "qdio_trace"
-#define QDIO_DBF_TRACE_LEN 8
-#define QDIO_DBF_TRACE_NR_AREAS 2
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_TRACE_PAGES 16
-#define QDIO_DBF_TRACE_LEVEL 4 /* -------- could be even more verbose here */
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_TRACE_PAGES 4
-#define QDIO_DBF_TRACE_LEVEL 2
-#endif /* CONFIG_QDIO_DEBUG */
-
-#define QDIO_DBF_SENSE_NAME "qdio_sense"
-#define QDIO_DBF_SENSE_LEN 64
-#define QDIO_DBF_SENSE_PAGES 2
-#define QDIO_DBF_SENSE_NR_AREAS 1
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_DBF_SENSE_LEVEL 6
-#else /* CONFIG_QDIO_DEBUG */
-#define QDIO_DBF_SENSE_LEVEL 2
-#endif /* CONFIG_QDIO_DEBUG */
-
-#ifdef CONFIG_QDIO_DEBUG
-#define QDIO_TRACE_QTYPE QDIO_ZFCP_QFMT
-
-#define QDIO_DBF_SLSB_OUT_NAME "qdio_slsb_out"
-#define QDIO_DBF_SLSB_OUT_LEN QDIO_MAX_BUFFERS_PER_Q
-#define QDIO_DBF_SLSB_OUT_PAGES 256
-#define QDIO_DBF_SLSB_OUT_NR_AREAS 1
-#define QDIO_DBF_SLSB_OUT_LEVEL 6
-
-#define QDIO_DBF_SLSB_IN_NAME "qdio_slsb_in"
-#define QDIO_DBF_SLSB_IN_LEN QDIO_MAX_BUFFERS_PER_Q
-#define QDIO_DBF_SLSB_IN_PAGES 256
-#define QDIO_DBF_SLSB_IN_NR_AREAS 1
-#define QDIO_DBF_SLSB_IN_LEVEL 6
-#endif /* CONFIG_QDIO_DEBUG */
-
-#define QDIO_PRINTK_HEADER QDIO_NAME ": "
-
-#if QDIO_VERBOSE_LEVEL>8
-#define QDIO_PRINT_STUPID(x...) printk( KERN_DEBUG QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_STUPID(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>7
-#define QDIO_PRINT_ALL(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_ALL(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>6
-#define QDIO_PRINT_INFO(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_INFO(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>5
-#define QDIO_PRINT_WARN(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_WARN(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>4
-#define QDIO_PRINT_ERR(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_ERR(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>3
-#define QDIO_PRINT_CRIT(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_CRIT(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>2
-#define QDIO_PRINT_ALERT(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_ALERT(x...) do { } while (0)
-#endif
-
-#if QDIO_VERBOSE_LEVEL>1
-#define QDIO_PRINT_EMERG(x...) printk( QDIO_PRINTK_HEADER x)
-#else
-#define QDIO_PRINT_EMERG(x...) do { } while (0)
-#endif
+/* used as intparm in do_IO */
+#define QDIO_DOING_ESTABLISH	1
+#define QDIO_DOING_ACTIVATE	2
+#define QDIO_DOING_CLEANUP	3
+
+#define SLSB_STATE_NOT_INIT	0x0
+#define SLSB_STATE_EMPTY	0x1
+#define SLSB_STATE_PRIMED	0x2
+#define SLSB_STATE_HALTED	0xe
+#define SLSB_STATE_ERROR	0xf
+#define SLSB_TYPE_INPUT		0x0
+#define SLSB_TYPE_OUTPUT	0x20
+#define SLSB_OWNER_PROG		0x80
+#define SLSB_OWNER_CU		0x40
+
+#define SLSB_P_INPUT_NOT_INIT	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_INPUT | SLSB_STATE_NOT_INIT)  /* 0x80 */
+#define SLSB_P_INPUT_ACK	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_INPUT | SLSB_STATE_EMPTY)	   /* 0x81 */
+#define SLSB_CU_INPUT_EMPTY	\
+	(SLSB_OWNER_CU | SLSB_TYPE_INPUT | SLSB_STATE_EMPTY)	   /* 0x41 */
+#define SLSB_P_INPUT_PRIMED	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_INPUT | SLSB_STATE_PRIMED)	   /* 0x82 */
+#define SLSB_P_INPUT_HALTED	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_INPUT | SLSB_STATE_HALTED)	   /* 0x8e */
+#define SLSB_P_INPUT_ERROR	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_INPUT | SLSB_STATE_ERROR)	   /* 0x8f */
+#define SLSB_P_OUTPUT_NOT_INIT	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_OUTPUT | SLSB_STATE_NOT_INIT) /* 0xa0 */
+#define SLSB_P_OUTPUT_EMPTY	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_OUTPUT | SLSB_STATE_EMPTY)	   /* 0xa1 */
+#define SLSB_CU_OUTPUT_PRIMED	\
+	(SLSB_OWNER_CU | SLSB_TYPE_OUTPUT | SLSB_STATE_PRIMED)	   /* 0x62 */
+#define SLSB_P_OUTPUT_HALTED	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_OUTPUT | SLSB_STATE_HALTED)   /* 0xae */
+#define SLSB_P_OUTPUT_ERROR	\
+	(SLSB_OWNER_PROG | SLSB_TYPE_OUTPUT | SLSB_STATE_ERROR)	   /* 0xaf */
+
+#define SLSB_ERROR_DURING_LOOKUP  0xff
+
+/* additional CIWs returned by extended Sense-ID */
+#define CIW_TYPE_EQUEUE			0x3 /* establish QDIO queues */
+#define CIW_TYPE_AQUEUE			0x4 /* activate QDIO queues */
 
-#define QDIO_HEXDUMP16(importance,header,ptr) \
-QDIO_PRINT_##importance(header "%02x %02x %02x %02x  " \
-			"%02x %02x %02x %02x  %02x %02x %02x %02x  " \
-			"%02x %02x %02x %02x\n",*(((char*)ptr)), \
-			*(((char*)ptr)+1),*(((char*)ptr)+2), \
-			*(((char*)ptr)+3),*(((char*)ptr)+4), \
-			*(((char*)ptr)+5),*(((char*)ptr)+6), \
-			*(((char*)ptr)+7),*(((char*)ptr)+8), \
-			*(((char*)ptr)+9),*(((char*)ptr)+10), \
-			*(((char*)ptr)+11),*(((char*)ptr)+12), \
-			*(((char*)ptr)+13),*(((char*)ptr)+14), \
-			*(((char*)ptr)+15)); \
-QDIO_PRINT_##importance(header "%02x %02x %02x %02x  %02x %02x %02x %02x  " \
-			"%02x %02x %02x %02x  %02x %02x %02x %02x\n", \
-			*(((char*)ptr)+16),*(((char*)ptr)+17), \
-			*(((char*)ptr)+18),*(((char*)ptr)+19), \
-			*(((char*)ptr)+20),*(((char*)ptr)+21), \
-			*(((char*)ptr)+22),*(((char*)ptr)+23), \
-			*(((char*)ptr)+24),*(((char*)ptr)+25), \
-			*(((char*)ptr)+26),*(((char*)ptr)+27), \
-			*(((char*)ptr)+28),*(((char*)ptr)+29), \
-			*(((char*)ptr)+30),*(((char*)ptr)+31));
-
-/****************** END OF DEBUG FACILITY STUFF *********************/
+/* flags for st qdio sch data */
+#define CHSC_FLAG_QDIO_CAPABILITY	0x80
+#define CHSC_FLAG_VALIDITY		0x40
 
-/*
- * Some instructions as assembly
- */
+/* qdio adapter-characteristics-1 flag */
+#define AC1_SIGA_INPUT_NEEDED		0x40	/* process input queues */
+#define AC1_SIGA_OUTPUT_NEEDED		0x20	/* process output queues */
+#define AC1_SIGA_SYNC_NEEDED		0x10	/* ask hypervisor to sync */
+#define AC1_AUTOMATIC_SYNC_ON_THININT	0x08	/* set by hypervisor */
+#define AC1_AUTOMATIC_SYNC_ON_OUT_PCI	0x04	/* set by hypervisor */
+#define AC1_SC_QEBSM_AVAILABLE		0x02	/* available for subchannel */
+#define AC1_SC_QEBSM_ENABLED		0x01	/* enabled for subchannel */
 
-static inline int
-do_sqbs(unsigned long sch, unsigned char state, int queue,
-       unsigned int *start, unsigned int *count)
-{
 #ifdef CONFIG_64BIT
-       register unsigned long _ccq asm ("0") = *count;
-       register unsigned long _sch asm ("1") = sch;
-       unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
-
-       asm volatile(
-	       "	.insn	rsy,0xeb000000008A,%1,0,0(%2)"
-	       : "+d" (_ccq), "+d" (_queuestart)
-	       : "d" ((unsigned long)state), "d" (_sch)
-	       : "memory", "cc");
-       *count = _ccq & 0xff;
-       *start = _queuestart & 0xff;
+static inline int do_sqbs(u64 sch, unsigned char state, int queue,
+			  int *start, int *count)
+{
+	register unsigned long _ccq asm ("0") = *count;
+	register unsigned long _sch asm ("1") = sch;
+	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
 
-       return (_ccq >> 32) & 0xff;
-#else
-       return 0;
-#endif
+	asm volatile(
+		"	.insn	rsy,0xeb000000008A,%1,0,0(%2)"
+		: "+d" (_ccq), "+d" (_queuestart)
+		: "d" ((unsigned long)state), "d" (_sch)
+		: "memory", "cc");
+	*count = _ccq & 0xff;
+	*start = _queuestart & 0xff;
+
+	return (_ccq >> 32) & 0xff;
 }
 
-static inline int
-do_eqbs(unsigned long sch, unsigned char *state, int queue,
-	unsigned int *start, unsigned int *count)
+static inline int do_eqbs(u64 sch, unsigned char *state, int queue,
+			  int *start, int *count)
 {
-#ifdef CONFIG_64BIT
 	register unsigned long _ccq asm ("0") = *count;
 	register unsigned long _sch asm ("1") = sch;
 	unsigned long _queuestart = ((unsigned long)queue << 32) | *start;
@@ -299,338 +114,265 @@ do_eqbs(unsigned long sch, unsigned char
 		"	.insn	rrf,0xB99c0000,%1,%2,0,0"
 		: "+d" (_ccq), "+d" (_queuestart), "+d" (_state)
 		: "d" (_sch)
-		: "memory", "cc" );
+		: "memory", "cc");
 	*count = _ccq & 0xff;
 	*start = _queuestart & 0xff;
 	*state = _state & 0xff;
 
 	return (_ccq >> 32) & 0xff;
-#else
-	return 0;
-#endif
-}
-
-
-static inline int
-do_siga_sync(struct subchannel_id schid, unsigned int mask1, unsigned int mask2)
-{
-	register unsigned long reg0 asm ("0") = 2;
-	register struct subchannel_id reg1 asm ("1") = schid;
-	register unsigned long reg2 asm ("2") = mask1;
-	register unsigned long reg3 asm ("3") = mask2;
-	int cc;
-
-	asm volatile(
-		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc)
-		: "d" (reg0), "d" (reg1), "d" (reg2), "d" (reg3) : "cc");
-	return cc;
-}
-
-static inline int
-do_siga_input(struct subchannel_id schid, unsigned int mask)
-{
-	register unsigned long reg0 asm ("0") = 1;
-	register struct subchannel_id reg1 asm ("1") = schid;
-	register unsigned long reg2 asm ("2") = mask;
-	int cc;
-
-	asm volatile(
-		"	siga	0\n"
-		"	ipm	%0\n"
-		"	srl	%0,28\n"
-		: "=d" (cc)
-		: "d" (reg0), "d" (reg1), "d" (reg2) : "cc", "memory");
-	return cc;
 }
+#else
+static inline int do_sqbs(u64 sch, unsigned char state, int queue,
+			  int *start, int *count) { return 0; }
+static inline int do_eqbs(u64 sch, unsigned char *state, int queue,
+			  int *start, int *count) { return 0; }
+#endif /* CONFIG_64BIT */
 
-static inline int
-do_siga_output(unsigned long schid, unsigned long mask, __u32 *bb,
-	       unsigned int fc)
-{
-	register unsigned long __fc asm("0") = fc;
-	register unsigned long __schid asm("1") = schid;
-	register unsigned long __mask asm("2") = mask;
-	int cc;
-
-	asm volatile(
-		"	siga	0\n"
-		"0:	ipm	%0\n"
-		"	srl	%0,28\n"
-		"1:\n"
-		EX_TABLE(0b,1b)
-		: "=d" (cc), "+d" (__fc), "+d" (__schid), "+d" (__mask)
-		: "0" (QDIO_SIGA_ERROR_ACCESS_EXCEPTION)
-		: "cc", "memory");
-	(*bb) = ((unsigned int) __fc) >> 31;
-	return cc;
-}
-
-static inline unsigned long
-do_clear_global_summary(void)
-{
-	register unsigned long __fn asm("1") = 3;
-	register unsigned long __tmp asm("2");
-	register unsigned long __time asm("3");
-
-	asm volatile(
-		"	.insn	rre,0xb2650000,2,0"
-		: "+d" (__fn), "=d" (__tmp), "=d" (__time));
-	return __time;
-}
-	
-/*
- * QDIO device commands returned by extended Sense-ID
- */
-#define DEFAULT_ESTABLISH_QS_CMD 0x1b
-#define DEFAULT_ESTABLISH_QS_COUNT 0x1000
-#define DEFAULT_ACTIVATE_QS_CMD 0x1f
-#define DEFAULT_ACTIVATE_QS_COUNT 0
-
-/*
- * additional CIWs returned by extended Sense-ID
- */
-#define CIW_TYPE_EQUEUE 0x3       /* establish QDIO queues */
-#define CIW_TYPE_AQUEUE 0x4       /* activate QDIO queues */
+struct qdio_irq;
 
-#define QDIO_CHSC_RESPONSE_CODE_OK 1
-/* flags for st qdio sch data */
-#define CHSC_FLAG_QDIO_CAPABILITY 0x80
-#define CHSC_FLAG_VALIDITY 0x40
+struct siga_flag {
+	u8 input:1;
+	u8 output:1;
+	u8 sync:1;
+	u8 no_sync_ti:1;
+	u8 no_sync_out_ti:1;
+	u8 no_sync_out_pci:1;
+	u8:2;
+} __attribute__ ((packed));
 
-#define CHSC_FLAG_SIGA_INPUT_NECESSARY 0x40
-#define CHSC_FLAG_SIGA_OUTPUT_NECESSARY 0x20
-#define CHSC_FLAG_SIGA_SYNC_NECESSARY 0x10
-#define CHSC_FLAG_SIGA_SYNC_DONE_ON_THININTS 0x08
-#define CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS 0x04
-
-struct qdio_chsc_ssqd {
+struct chsc_ssqd_area {
 	struct chsc_header request;
-	u16 reserved1:10;
-	u16 ssid:2;
-	u16 fmt:4;
+	u16:10;
+	u8 ssid:2;
+	u8 fmt:4;
 	u16 first_sch;
-	u16 reserved2;
+	u16:16;
 	u16 last_sch;
-	u32 reserved3;
+	u32:32;
 	struct chsc_header response;
-	u32 reserved4;
-	u8  flags;
-	u8  reserved5;
-	u16 sch;
-	u8  qfmt;
-	u8  parm;
-	u8  qdioac1;
-	u8  sch_class;
-	u8  pct;
-	u8  icnt;
-	u8  reserved7;
-	u8  ocnt;
-	u8  reserved8;
-	u8  mbccnt;
-	u16 qdioac2;
-	u64 sch_token;
-};
+	u32:32;
+	struct qdio_ssqd_desc qdio_ssqd;
+} __attribute__ ((packed));
 
-struct qdio_perf_stats {
-#ifdef CONFIG_64BIT
-	atomic64_t tl_runs;
-	atomic64_t outbound_tl_runs;
-	atomic64_t outbound_tl_runs_resched;
-	atomic64_t inbound_tl_runs;
-	atomic64_t inbound_tl_runs_resched;
-	atomic64_t inbound_thin_tl_runs;
-	atomic64_t inbound_thin_tl_runs_resched;
-
-	atomic64_t siga_outs;
-	atomic64_t siga_ins;
-	atomic64_t siga_syncs;
-	atomic64_t pcis;
-	atomic64_t thinints;
-	atomic64_t fast_reqs;
-
-	atomic64_t outbound_cnt;
-	atomic64_t inbound_cnt;
-#else /* CONFIG_64BIT */
-	atomic_t tl_runs;
-	atomic_t outbound_tl_runs;
-	atomic_t outbound_tl_runs_resched;
-	atomic_t inbound_tl_runs;
-	atomic_t inbound_tl_runs_resched;
-	atomic_t inbound_thin_tl_runs;
-	atomic_t inbound_thin_tl_runs_resched;
-
-	atomic_t siga_outs;
-	atomic_t siga_ins;
-	atomic_t siga_syncs;
-	atomic_t pcis;
-	atomic_t thinints;
-	atomic_t fast_reqs;
+struct scssc_area {
+	struct chsc_header request;
+	u16 operation_code;
+	u16:16;
+	u32:32;
+	u32:32;
+	u64 summary_indicator_addr;
+	u64 subchannel_indicator_addr;
+	u32 ks:4;
+	u32 kc:4;
+	u32:21;
+	u32 isc:3;
+	u32 word_with_d_bit;
+	u32:32;
+	struct subchannel_id schid;
+	u32 reserved[1004];
+	struct chsc_header response;
+	u32:32;
+} __attribute__ ((packed));
 
-	atomic_t outbound_cnt;
-	atomic_t inbound_cnt;
-#endif /* CONFIG_64BIT */
-};
+struct qdio_input_q {
+	/* input buffer acknowledgement flag */
+	atomic_t polling;
 
-/* unlikely as the later the better */
-#define SYNC_MEMORY if (unlikely(q->siga_sync)) qdio_siga_sync_q(q)
-#define SYNC_MEMORY_ALL if (unlikely(q->siga_sync)) \
-	qdio_siga_sync(q,~0U,~0U)
-#define SYNC_MEMORY_ALL_OUTB if (unlikely(q->siga_sync)) \
-	qdio_siga_sync(q,~0U,0)
-
-#define NOW qdio_get_micros()
-#define SAVE_TIMESTAMP(q) q->timing.last_transfer_time=NOW
-#define GET_SAVED_TIMESTAMP(q) (q->timing.last_transfer_time)
-#define SAVE_FRONTIER(q,val) q->last_move_ftc=val
-#define GET_SAVED_FRONTIER(q) (q->last_move_ftc)
+	/* last time of noticing incoming data */
+	u64 timestamp;
 
-#define MY_MODULE_STRING(x) #x
+	/* lock for clearing the acknowledgement */
+	spinlock_t lock;
+};
 
-#ifdef CONFIG_64BIT
-#define QDIO_GET_ADDR(x) ((__u32)(unsigned long)x)
-#else /* CONFIG_64BIT */
-#define QDIO_GET_ADDR(x) ((__u32)(long)x)
-#endif /* CONFIG_64BIT */
+struct qdio_output_q {
+	/* failed siga-w attempts*/
+	atomic_t busy_siga_counter;
 
-struct qdio_q {
-	volatile struct slsb slsb;
+	/* start time of busy condition */
+	u64 timestamp;
 
-	char unused[QDIO_MAX_BUFFERS_PER_Q];
+	/* PCIs are enabled for the queue */
+	unsigned int pci_out_enabled;
 
-	__u32 * dev_st_chg_ind;
+	/* timer to check for more outbound work */
+	struct timer_list timer;
+};
 
-	int is_input_q;
-	struct subchannel_id schid;
-	struct ccw_device *cdev;
+struct qdio_q {
+	struct slsb slsb;
+	union {
+		struct qdio_input_q in;
+		struct qdio_output_q out;
+	} u;
 
-	unsigned int is_iqdio_q;
-	unsigned int is_thinint_q;
+	/* queue number */
+	unsigned int nr;
 
-	/* bit 0 means queue 0, bit 1 means queue 1, ... */
+	/* bitmask of queue number */
 	unsigned int mask;
-	unsigned int q_no;
 
-	qdio_handler_t (*handler);
-
-	/* points to the next buffer to be checked for having
-	 * been processed by the card (outbound)
-	 * or to the next buffer the program should check for (inbound) */
-	volatile int first_to_check;
-	/* and the last time it was: */
-	volatile int last_move_ftc;
+	/* input or output queue */
+	unsigned int is_input_q;
 
-	atomic_t number_of_buffers_used;
-	atomic_t polling;
+	/* list of thinint input queues */
+	struct list_head entry;
 
-	unsigned int siga_in;
-	unsigned int siga_out;
-	unsigned int siga_sync;
-	unsigned int siga_sync_done_on_thinints;
-	unsigned int siga_sync_done_on_outb_tis;
-	unsigned int hydra_gives_outbound_pcis;
+	/* upper-layer program handler */
+	qdio_handler_t (*handler);
 
-	/* used to save beginning position when calling dd_handlers */
-	int first_element_to_kick;
+	/*
+	 * inbound: next buffer the program should check for
+	 * outbound: next buffer to check for having been processed
+	 * by the card
+	 */
+	int first_to_check;
+
+	/* first_to_check of the last time */
+	int last_move_ftc;
 
-	atomic_t use_count;
-	atomic_t is_in_shutdown;
+	/* beginning position for calling the program */
+	int first_to_kick;
 
-	void *irq_ptr;
+	/* number of buffers in use by the adapter */
+	atomic_t nr_buf_used;
 
-	struct timer_list timer;
-#ifdef QDIO_USE_TIMERS_FOR_POLLING
-	atomic_t timer_already_set;
-	spinlock_t timer_lock;
-#else /* QDIO_USE_TIMERS_FOR_POLLING */
+	struct qdio_irq *irq_ptr;
 	struct tasklet_struct tasklet;
-#endif /* QDIO_USE_TIMERS_FOR_POLLING */
-
-
-	enum qdio_irq_states state;
 
-	/* used to store the error condition during a data transfer */
+	/* error condition during a data transfer */
 	unsigned int qdio_error;
-	unsigned int siga_error;
-	unsigned int error_status_flags;
-
-	/* list of interesting queues */
-	volatile struct qdio_q *list_next;
-	volatile struct qdio_q *list_prev;
 
 	struct sl *sl;
-	volatile struct sbal *sbal[QDIO_MAX_BUFFERS_PER_Q];
+	struct qdio_buffer *sbal[QDIO_MAX_BUFFERS_PER_Q];
 
-	struct qdio_buffer *qdio_buffers[QDIO_MAX_BUFFERS_PER_Q];
-
-	unsigned long int_parm;
-
-	/*struct {
-		int in_bh_check_limit;
-		int threshold;
-	} threshold_classes[QDIO_STATS_CLASSES];*/
-
-	struct {
-		/* inbound: the time to stop polling
-		   outbound: the time to kick peer */
-		int threshold; /* the real value */
-
-		/* outbound: last time of do_QDIO
-		   inbound: last time of noticing incoming data */
-		/*__u64 last_transfer_times[QDIO_STATS_NUMBER];
-		int last_transfer_index; */
-
-		__u64 last_transfer_time;
-		__u64 busy_start;
-	} timing;
-	atomic_t busy_siga_counter;
-        unsigned int queue_type;
-	unsigned int is_pci_out;
-
-	/* leave this member at the end. won't be cleared in qdio_fill_qs */
-	struct slib *slib; /* a page is allocated under this pointer,
-			      sl points into this page, offset PAGE_SIZE/2
-			      (after slib) */
+	/*
+	 * Warning: Leave this member at the end so it won't be cleared in
+	 * qdio_fill_qs. A page is allocated under this pointer and used for
+	 * slib and sl. slib is 2048 bytes big and sl points to offset
+	 * PAGE_SIZE / 2.
+	 */
+	struct slib *slib;
 } __attribute__ ((aligned(256)));
 
 struct qdio_irq {
-	__u32 * volatile dev_st_chg_ind;
+	struct qib qib;
+	u32 *dsci;		/* address of device state change indicator */
+	struct ccw_device *cdev;
 
 	unsigned long int_parm;
 	struct subchannel_id schid;
-
-	unsigned int is_iqdio_irq;
-	unsigned int is_thinint_irq;
-	unsigned int hydra_gives_outbound_pcis;
-	unsigned int sync_done_on_outb_pcis;
-
-	/* QEBSM facility */
-	unsigned int is_qebsm;
-	unsigned long sch_token;
+	unsigned long sch_token;	/* QEBSM facility */
 
 	enum qdio_irq_states state;
 
-	unsigned int no_input_qs;
-	unsigned int no_output_qs;
+	struct siga_flag siga_flag;	/* siga sync information from qdioac */
 
-	unsigned char qdioac;
+	unsigned int nr_input_qs;
+	unsigned int nr_output_qs;
 
 	struct ccw1 ccw;
-
 	struct ciw equeue;
 	struct ciw aqueue;
 
-	struct qib qib;
-	
- 	void (*original_int_handler) (struct ccw_device *,
- 				      unsigned long, struct irb *);
+	struct qdio_ssqd_desc ssqd_desc;
+
+	void (*orig_handler) (struct ccw_device *, unsigned long, struct irb *);
 
-	/* leave these four members together at the end. won't be cleared in qdio_fill_irq */
+	/*
+	 * Warning: Leave these members together at the end so they won't be
+	 * cleared in qdio_setup_irq.
+	 */
 	struct qdr *qdr;
+	unsigned long chsc_page;
+
 	struct qdio_q *input_qs[QDIO_MAX_QUEUES_PER_IRQ];
 	struct qdio_q *output_qs[QDIO_MAX_QUEUES_PER_IRQ];
-	struct semaphore setting_up_sema;
+
+	struct mutex setup_mutex;
 };
-#endif
+
+/* helper functions */
+#define queue_type(q)	q->irq_ptr->qib.qfmt
+
+#define is_thinint_irq(irq) \
+	(irq->qib.qfmt == QDIO_IQDIO_QFMT || \
+	 css_general_characteristics.aif_osa)
+
+/* the highest iqdio queue is used for multicast */
+static inline int multicast_outbound(struct qdio_q *q)
+{
+	return ((q->irq_ptr->nr_output_qs > 1) &&
+		(q->nr == q->irq_ptr->nr_output_qs - 1));
+}
+
+static inline unsigned long long get_usecs(void)
+{
+	return monotonic_clock() >> 12;
+}
+
+#define pci_out_supported(q) \
+	(q->irq_ptr->qib.ac & QIB_AC_OUTBOUND_PCI_SUPPORTED)
+#define is_qebsm(q)			(q->irq_ptr->sch_token != 0)
+
+#define need_siga_sync_thinint(q)	(!q->irq_ptr->siga_flag.no_sync_ti)
+#define need_siga_sync_out_thinint(q)	(!q->irq_ptr->siga_flag.no_sync_out_ti)
+#define need_siga_in(q)			(q->irq_ptr->siga_flag.input)
+#define need_siga_out(q)		(q->irq_ptr->siga_flag.output)
+#define need_siga_sync(q)		(q->irq_ptr->siga_flag.sync)
+#define siga_syncs_out_pci(q)		(q->irq_ptr->siga_flag.no_sync_out_pci)
+
+#define for_each_input_queue(irq_ptr, q, i)	\
+	for (i = 0, q = irq_ptr->input_qs[0];	\
+		i < irq_ptr->nr_input_qs;	\
+		q = irq_ptr->input_qs[++i])
+#define for_each_output_queue(irq_ptr, q, i)	\
+	for (i = 0, q = irq_ptr->output_qs[0];	\
+		i < irq_ptr->nr_output_qs;	\
+		q = irq_ptr->output_qs[++i])
+
+#define prev_buf(bufnr)	\
+	((bufnr + QDIO_MAX_BUFFERS_MASK) & QDIO_MAX_BUFFERS_MASK)
+#define next_buf(bufnr)	\
+	((bufnr + 1) & QDIO_MAX_BUFFERS_MASK)
+#define add_buf(bufnr, inc) \
+	((bufnr + inc) & QDIO_MAX_BUFFERS_MASK)
+
+/* prototypes for thin interrupt */
+void qdio_sync_after_thinint(struct qdio_q *q);
+int get_buf_state(struct qdio_q *q, unsigned int bufnr, unsigned char *state);
+void qdio_check_outbound_after_thinint(struct qdio_q *q);
+int qdio_inbound_q_moved(struct qdio_q *q);
+void qdio_kick_inbound_handler(struct qdio_q *q);
+void qdio_stop_polling(struct qdio_q *q);
+int qdio_siga_sync_q(struct qdio_q *q);
+
+void qdio_setup_thinint(struct qdio_irq *irq_ptr);
+int qdio_establish_thinint(struct qdio_irq *irq_ptr);
+void qdio_shutdown_thinint(struct qdio_irq *irq_ptr);
+void tiqdio_add_input_queues(struct qdio_irq *irq_ptr);
+void tiqdio_remove_input_queues(struct qdio_irq *irq_ptr);
+void tiqdio_inbound_processing(unsigned long q);
+int tiqdio_allocate_memory(void);
+void tiqdio_free_memory(void);
+int tiqdio_register_thinints(void);
+void tiqdio_unregister_thinints(void);
+
+/* prototypes for setup */
+void qdio_init_buf_states(struct qdio_q *q);
+void qdio_inbound_processing(unsigned long data);
+void qdio_outbound_processing(unsigned long data);
+void qdio_outbound_timer(unsigned long data);
+void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
+		      struct irb *irb);
+int qdio_allocate_qs(struct qdio_irq *irq_ptr, int nr_input_qs,
+		     int nr_output_qs);
+void qdio_setup_ssqd_info(struct qdio_irq *irq_ptr);
+int qdio_setup_irq(struct qdio_initialize *init_data);
+void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
+				struct ccw_device *cdev);
+void qdio_release_memory(struct qdio_irq *irq_ptr);
+int qdio_setup_init(void);
+void qdio_setup_exit(void);
+
+#endif /* _CIO_QDIO_H */
Index: quilt-2.6/drivers/s390/cio/qdio_perf.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/qdio_perf.c
@@ -0,0 +1,151 @@
+/*
+ *  drivers/s390/cio/qdio_perf.c
+ *
+ *  Copyright IBM Corp. 2008
+ *
+ *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
+ */
+#include <linux/kernel.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <asm/ccwdev.h>
+
+#include "cio.h"
+#include "css.h"
+#include "device.h"
+#include "ioasm.h"
+#include "chsc.h"
+#include "qdio_debug.h"
+#include "qdio_perf.h"
+
+int qdio_performance_stats;
+struct qdio_perf_stats perf_stats;
+
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *qdio_perf_pde;
+#endif
+
+inline void qdio_perf_stat_inc(atomic_long_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_long_inc(count);
+}
+
+inline void qdio_perf_stat_dec(atomic_long_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_long_dec(count);
+}
+
+/*
+ * procfs functions
+ */
+static int qdio_perf_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "Number of qdio interrupts\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.qdio_int));
+	seq_printf(m, "Number of PCI interrupts\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.pci_int));
+	seq_printf(m, "Number of adapter interrupts\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.thin_int));
+	seq_printf(m, "\n");
+	seq_printf(m, "Inbound tasklet runs\t\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.tasklet_inbound));
+	seq_printf(m, "Outbound tasklet runs\t\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.tasklet_outbound));
+	seq_printf(m, "Adapter interrupt tasklet runs/loops\t\t: %li/%li\n",
+		   (long)atomic_long_read(&perf_stats.tasklet_thinint),
+		   (long)atomic_long_read(&perf_stats.tasklet_thinint_loop));
+	seq_printf(m, "Adapter interrupt inbound tasklet runs/loops\t: %li/%li\n",
+		   (long)atomic_long_read(&perf_stats.thinint_inbound),
+		   (long)atomic_long_read(&perf_stats.thinint_inbound_loop));
+	seq_printf(m, "\n");
+	seq_printf(m, "Number of SIGA In issued\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.siga_in));
+	seq_printf(m, "Number of SIGA Out issued\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.siga_out));
+	seq_printf(m, "Number of SIGA Sync issued\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.siga_sync));
+	seq_printf(m, "\n");
+	seq_printf(m, "Number of inbound transfers\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.inbound_handler));
+	seq_printf(m, "Number of outbound transfers\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.outbound_handler));
+	seq_printf(m, "\n");
+	seq_printf(m, "Number of fast requeues (outg. SBAL w/o SIGA)\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.fast_requeue));
+	seq_printf(m, "Number of outbound tasklet mod_timer calls\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.debug_tl_out_timer));
+	seq_printf(m, "Number of stop polling calls\t\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.debug_stop_polling));
+	seq_printf(m, "AI inbound tasklet loops after stop polling\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.thinint_inbound_loop2));
+	seq_printf(m, "\n");
+	return 0;
+}
+static int qdio_perf_seq_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, qdio_perf_proc_show, NULL);
+}
+
+static struct file_operations qdio_perf_proc_fops = {
+	.owner	 = THIS_MODULE,
+	.open	 = qdio_perf_seq_open,
+	.read	 = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+/*
+ * sysfs functions
+ */
+static ssize_t qdio_perf_stats_show(struct bus_type *bus, char *buf)
+{
+	return sprintf(buf, "%i\n", qdio_performance_stats ? 1 : 0);
+}
+
+static ssize_t qdio_perf_stats_store(struct bus_type *bus,
+			      const char *buf, size_t count)
+{
+	unsigned long i;
+
+	if (strict_strtoul(buf, 16, &i) != 0)
+		return -EINVAL;
+	if ((i != 0) && (i != 1))
+		return -EINVAL;
+	if (i == qdio_performance_stats)
+		return count;
+
+	qdio_performance_stats = i;
+	/* reset performance statistics */
+	if (i == 0)
+		memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
+	return count;
+}
+
+static BUS_ATTR(qdio_performance_stats, 0644, qdio_perf_stats_show,
+		qdio_perf_stats_store);
+
+int __init qdio_setup_perf_stats(void)
+{
+	int rc;
+
+	rc = bus_create_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
+	if (rc)
+		return rc;
+
+#ifdef CONFIG_PROC_FS
+	memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
+	qdio_perf_pde = proc_create("qdio_perf", S_IFREG | S_IRUGO,
+				    &proc_root, &qdio_perf_proc_fops);
+#endif
+	return 0;
+}
+
+void __exit qdio_remove_perf_stats(void)
+{
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("qdio_perf", &proc_root);
+#endif
+	bus_remove_file(&ccw_bus_type, &bus_attr_qdio_performance_stats);
+}
Index: quilt-2.6/drivers/s390/cio/qdio_perf.h
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/qdio_perf.h
@@ -0,0 +1,54 @@
+/*
+ *  drivers/s390/cio/qdio_perf.h
+ *
+ *  Copyright IBM Corp. 2008
+ *
+ *  Author: Jan Glauber (jang@linux.vnet.ibm.com)
+ */
+#ifndef QDIO_PERF_H
+#define QDIO_PERF_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <asm/atomic.h>
+
+struct qdio_perf_stats {
+	/* interrupt handler calls */
+	atomic_long_t qdio_int;
+	atomic_long_t pci_int;
+	atomic_long_t thin_int;
+
+	/* tasklet runs */
+	atomic_long_t tasklet_inbound;
+	atomic_long_t tasklet_outbound;
+	atomic_long_t tasklet_thinint;
+	atomic_long_t tasklet_thinint_loop;
+	atomic_long_t thinint_inbound;
+	atomic_long_t thinint_inbound_loop;
+	atomic_long_t thinint_inbound_loop2;
+
+	/* signal adapter calls */
+	atomic_long_t siga_out;
+	atomic_long_t siga_in;
+	atomic_long_t siga_sync;
+
+	/* misc */
+	atomic_long_t inbound_handler;
+	atomic_long_t outbound_handler;
+	atomic_long_t fast_requeue;
+
+	/* for debugging */
+	atomic_long_t debug_tl_out_timer;
+	atomic_long_t debug_stop_polling;
+};
+
+extern struct qdio_perf_stats perf_stats;
+extern int qdio_performance_stats;
+
+int qdio_setup_perf_stats(void);
+void qdio_remove_perf_stats(void);
+
+extern void qdio_perf_stat_inc(atomic_long_t *count);
+extern void qdio_perf_stat_dec(atomic_long_t *count);
+
+#endif
Index: quilt-2.6/drivers/s390/cio/qdio_setup.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/qdio_setup.c
@@ -0,0 +1,516 @@
+/*
+ * driver/s390/cio/qdio_setup.c
+ *
+ * qdio queue initialization
+ *
+ * Copyright (C) IBM Corp. 2008
+ * Author(s): Jan Glauber <jang@linux.vnet.ibm.com>
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <asm/qdio.h>
+
+#include "cio.h"
+#include "css.h"
+#include "device.h"
+#include "ioasm.h"
+#include "chsc.h"
+#include "qdio.h"
+#include "qdio_debug.h"
+
+static struct kmem_cache *qdio_q_cache;
+
+/*
+ * qib_param_field: pointer to 128 bytes or NULL, if no param field
+ * nr_input_qs: pointer to nr_queues*128 words of data or NULL
+ */
+static void set_impl_params(struct qdio_irq *irq_ptr,
+			    unsigned int qib_param_field_format,
+			    unsigned char *qib_param_field,
+			    unsigned long *input_slib_elements,
+			    unsigned long *output_slib_elements)
+{
+	struct qdio_q *q;
+	int i, j;
+
+	if (!irq_ptr)
+		return;
+
+	WARN_ON((unsigned long)&irq_ptr->qib & 0xff);
+	irq_ptr->qib.pfmt = qib_param_field_format;
+	if (qib_param_field)
+		memcpy(irq_ptr->qib.parm, qib_param_field,
+		       QDIO_MAX_BUFFERS_PER_Q);
+
+	if (!input_slib_elements)
+		goto output;
+
+	for_each_input_queue(irq_ptr, q, i) {
+		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++)
+			q->slib->slibe[j].parms =
+				input_slib_elements[i * QDIO_MAX_BUFFERS_PER_Q + j];
+	}
+output:
+	if (!output_slib_elements)
+		return;
+
+	for_each_output_queue(irq_ptr, q, i) {
+		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++)
+			q->slib->slibe[j].parms =
+				output_slib_elements[i * QDIO_MAX_BUFFERS_PER_Q + j];
+	}
+}
+
+static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
+{
+	struct qdio_q *q;
+	int i;
+
+	for (i = 0; i < nr_queues; i++) {
+		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		if (!q)
+			return -ENOMEM;
+		WARN_ON((unsigned long)q & 0xff);
+
+		q->slib = (struct slib *) __get_free_page(GFP_KERNEL);
+		if (!q->slib) {
+			kmem_cache_free(qdio_q_cache, q);
+			return -ENOMEM;
+		}
+		WARN_ON((unsigned long)q->slib & 0x7ff);
+		irq_ptr_qs[i] = q;
+	}
+	return 0;
+}
+
+int qdio_allocate_qs(struct qdio_irq *irq_ptr, int nr_input_qs, int nr_output_qs)
+{
+	int rc;
+
+	rc = __qdio_allocate_qs(irq_ptr->input_qs, nr_input_qs);
+	if (rc)
+		return rc;
+	rc = __qdio_allocate_qs(irq_ptr->output_qs, nr_output_qs);
+	return rc;
+}
+
+static void setup_queues_misc(struct qdio_q *q, struct qdio_irq *irq_ptr,
+			      qdio_handler_t *handler, int i)
+{
+	/* must be cleared by every qdio_establish */
+	memset(q, 0, ((char *)&q->slib) - ((char *)q));
+	memset(q->slib, 0, PAGE_SIZE);
+
+	q->irq_ptr = irq_ptr;
+	q->mask = 1 << (31 - i);
+	q->nr = i;
+	q->handler = handler;
+}
+
+static void setup_storage_lists(struct qdio_q *q, struct qdio_irq *irq_ptr,
+				void **sbals_array, char *dbf_text, int i)
+{
+	struct qdio_q *prev;
+	int j;
+
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	QDIO_DBF_HEX0(0, setup, &q, sizeof(void *));
+
+	q->sl = (struct sl *)((char *)q->slib + PAGE_SIZE / 2);
+
+	/* fill in sbal */
+	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++) {
+		q->sbal[j] = *sbals_array++;
+		WARN_ON((unsigned long)q->sbal[j] & 0xff);
+	}
+
+	/* fill in slib */
+	if (i > 0) {
+		prev = (q->is_input_q) ? irq_ptr->input_qs[i - 1]
+			: irq_ptr->output_qs[i - 1];
+		prev->slib->nsliba = (unsigned long)q->slib;
+	}
+
+	q->slib->sla = (unsigned long)q->sl;
+	q->slib->slsba = (unsigned long)&q->slsb.val[0];
+
+	/* fill in sl */
+	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++)
+		q->sl->element[j].sbal = (unsigned long)q->sbal[j];
+
+	QDIO_DBF_TEXT2(0, setup, "sl-sb-b0");
+	QDIO_DBF_HEX2(0, setup, q->sl, sizeof(void *));
+	QDIO_DBF_HEX2(0, setup, &q->slsb, sizeof(void *));
+	QDIO_DBF_HEX2(0, setup, q->sbal, sizeof(void *));
+
+	qdio_init_buf_states(q);
+}
+
+static void setup_queues(struct qdio_irq *irq_ptr,
+			 struct qdio_initialize *qdio_init)
+{
+	char dbf_text[20];
+	struct qdio_q *q;
+	void **input_sbal_array = qdio_init->input_sbal_addr_array;
+	void **output_sbal_array = qdio_init->output_sbal_addr_array;
+	int i;
+
+	sprintf(dbf_text, "qfqs%4x", qdio_init->cdev->private->schid.sch_no);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
+	for_each_input_queue(irq_ptr, q, i) {
+		sprintf(dbf_text, "in-q%4x", i);
+		setup_queues_misc(q, irq_ptr, qdio_init->input_handler, i);
+
+		q->is_input_q = 1;
+		spin_lock_init(&q->u.in.lock);
+		setup_storage_lists(q, irq_ptr, input_sbal_array, dbf_text, i);
+		input_sbal_array += QDIO_MAX_BUFFERS_PER_Q;
+
+		if (is_thinint_irq(irq_ptr))
+			tasklet_init(&q->tasklet, tiqdio_inbound_processing,
+				     (unsigned long) q);
+		else
+			tasklet_init(&q->tasklet, qdio_inbound_processing,
+				     (unsigned long) q);
+	}
+
+	for_each_output_queue(irq_ptr, q, i) {
+		sprintf(dbf_text, "outq%4x", i);
+		setup_queues_misc(q, irq_ptr, qdio_init->output_handler, i);
+
+		q->is_input_q = 0;
+		setup_storage_lists(q, irq_ptr, output_sbal_array,
+				    dbf_text, i);
+		output_sbal_array += QDIO_MAX_BUFFERS_PER_Q;
+
+		tasklet_init(&q->tasklet, qdio_outbound_processing,
+			     (unsigned long) q);
+		setup_timer(&q->u.out.timer, (void(*)(unsigned long))
+			    &qdio_outbound_timer, (unsigned long)q);
+	}
+}
+
+static void process_ac_flags(struct qdio_irq *irq_ptr, unsigned char qdioac)
+{
+	if (qdioac & AC1_SIGA_INPUT_NEEDED)
+		irq_ptr->siga_flag.input = 1;
+	if (qdioac & AC1_SIGA_OUTPUT_NEEDED)
+		irq_ptr->siga_flag.output = 1;
+	if (qdioac & AC1_SIGA_SYNC_NEEDED)
+		irq_ptr->siga_flag.sync = 1;
+	if (qdioac & AC1_AUTOMATIC_SYNC_ON_THININT)
+		irq_ptr->siga_flag.no_sync_ti = 1;
+	if (qdioac & AC1_AUTOMATIC_SYNC_ON_OUT_PCI)
+		irq_ptr->siga_flag.no_sync_out_pci = 1;
+
+	if (irq_ptr->siga_flag.no_sync_out_pci &&
+	    irq_ptr->siga_flag.no_sync_ti)
+		irq_ptr->siga_flag.no_sync_out_ti = 1;
+}
+
+static void check_and_setup_qebsm(struct qdio_irq *irq_ptr,
+				  unsigned char qdioac, unsigned long token)
+{
+	char dbf_text[15];
+
+	if (!(irq_ptr->qib.rflags & QIB_RFLAGS_ENABLE_QEBSM))
+		goto no_qebsm;
+	if (!(qdioac & AC1_SC_QEBSM_AVAILABLE) ||
+	    (!(qdioac & AC1_SC_QEBSM_ENABLED)))
+		goto no_qebsm;
+
+	irq_ptr->sch_token = token;
+
+	QDIO_DBF_TEXT0(0, setup, "V=V:1");
+	sprintf(dbf_text, "%8lx", irq_ptr->sch_token);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	return;
+
+no_qebsm:
+	irq_ptr->sch_token = 0;
+	irq_ptr->qib.rflags &= ~QIB_RFLAGS_ENABLE_QEBSM;
+	QDIO_DBF_TEXT0(0, setup, "noV=V");
+}
+
+static int __get_ssqd_info(struct qdio_irq *irq_ptr)
+{
+	struct chsc_ssqd_area *ssqd;
+	int rc;
+
+	QDIO_DBF_TEXT0(0, setup, "getssqd");
+	ssqd = (struct chsc_ssqd_area *)irq_ptr->chsc_page;
+	memset(ssqd, 0, PAGE_SIZE);
+
+	ssqd->request = (struct chsc_header) {
+		.length = 0x0010,
+		.code	= 0x0024,
+	};
+	ssqd->first_sch = irq_ptr->schid.sch_no;
+	ssqd->last_sch = irq_ptr->schid.sch_no;
+	ssqd->ssid = irq_ptr->schid.ssid;
+
+	if (chsc(ssqd))
+		return -EIO;
+	rc = chsc_error_from_response(ssqd->response.code);
+	if (rc)
+		return rc;
+
+	if (!(ssqd->qdio_ssqd.flags & CHSC_FLAG_QDIO_CAPABILITY) ||
+	    !(ssqd->qdio_ssqd.flags & CHSC_FLAG_VALIDITY) ||
+	    (ssqd->qdio_ssqd.sch != irq_ptr->schid.sch_no))
+		return -EINVAL;
+
+	memcpy(&irq_ptr->ssqd_desc, &ssqd->qdio_ssqd,
+	       sizeof(struct qdio_ssqd_desc));
+	return 0;
+}
+
+void qdio_setup_ssqd_info(struct qdio_irq *irq_ptr)
+{
+	unsigned char qdioac;
+	char dbf_text[15];
+	int rc;
+
+	rc = __get_ssqd_info(irq_ptr);
+	if (rc) {
+		QDIO_DBF_TEXT2(0, setup, "ssqdasig");
+		sprintf(dbf_text, "schno%x", irq_ptr->schid.sch_no);
+		QDIO_DBF_TEXT2(0, setup, dbf_text);
+		sprintf(dbf_text, "rc:%d", rc);
+		QDIO_DBF_TEXT2(0, setup, dbf_text);
+		/* all flags set, worst case */
+		qdioac = AC1_SIGA_INPUT_NEEDED | AC1_SIGA_OUTPUT_NEEDED |
+			 AC1_SIGA_SYNC_NEEDED;
+	} else
+		qdioac = irq_ptr->ssqd_desc.qdioac1;
+
+	check_and_setup_qebsm(irq_ptr, qdioac, irq_ptr->ssqd_desc.sch_token);
+	process_ac_flags(irq_ptr, qdioac);
+
+	sprintf(dbf_text, "qdioac%2x", qdioac);
+	QDIO_DBF_TEXT2(0, setup, dbf_text);
+}
+
+void qdio_release_memory(struct qdio_irq *irq_ptr)
+{
+	struct qdio_q *q;
+	int i;
+
+	/*
+	 * Must check queue array manually since irq_ptr->nr_input_queues /
+	 * irq_ptr->nr_input_queues may not yet be set.
+	 */
+	for (i = 0; i < QDIO_MAX_QUEUES_PER_IRQ; i++) {
+		q = irq_ptr->input_qs[i];
+		if (q) {
+			free_page((unsigned long) q->slib);
+			kmem_cache_free(qdio_q_cache, q);
+		}
+	}
+	for (i = 0; i < QDIO_MAX_QUEUES_PER_IRQ; i++) {
+		q = irq_ptr->output_qs[i];
+		if (q) {
+			free_page((unsigned long) q->slib);
+			kmem_cache_free(qdio_q_cache, q);
+		}
+	}
+	kfree(irq_ptr->qdr);
+	free_page(irq_ptr->chsc_page);
+	free_page((unsigned long) irq_ptr);
+}
+
+static void __qdio_allocate_fill_qdr(struct qdio_irq *irq_ptr,
+				     struct qdio_q **irq_ptr_qs,
+				     int i, int nr)
+{
+	irq_ptr->qdr->qdf0[i + nr].sliba =
+		(unsigned long)irq_ptr_qs[i]->slib;
+
+	irq_ptr->qdr->qdf0[i + nr].sla =
+		(unsigned long)irq_ptr_qs[i]->sl;
+
+	irq_ptr->qdr->qdf0[i + nr].slsba =
+		(unsigned long)&irq_ptr_qs[i]->slsb.val[0];
+
+	irq_ptr->qdr->qdf0[i + nr].akey = PAGE_DEFAULT_KEY;
+	irq_ptr->qdr->qdf0[i + nr].bkey = PAGE_DEFAULT_KEY;
+	irq_ptr->qdr->qdf0[i + nr].ckey = PAGE_DEFAULT_KEY;
+	irq_ptr->qdr->qdf0[i + nr].dkey = PAGE_DEFAULT_KEY;
+}
+
+static void setup_qdr(struct qdio_irq *irq_ptr,
+		      struct qdio_initialize *qdio_init)
+{
+	int i;
+
+	irq_ptr->qdr->qfmt = qdio_init->q_format;
+	irq_ptr->qdr->iqdcnt = qdio_init->no_input_qs;
+	irq_ptr->qdr->oqdcnt = qdio_init->no_output_qs;
+	irq_ptr->qdr->iqdsz = sizeof(struct qdesfmt0) / 4; /* size in words */
+	irq_ptr->qdr->oqdsz = sizeof(struct qdesfmt0) / 4;
+	irq_ptr->qdr->qiba = (unsigned long)&irq_ptr->qib;
+	irq_ptr->qdr->qkey = PAGE_DEFAULT_KEY;
+
+	for (i = 0; i < qdio_init->no_input_qs; i++)
+		__qdio_allocate_fill_qdr(irq_ptr, irq_ptr->input_qs, i, 0);
+
+	for (i = 0; i < qdio_init->no_output_qs; i++)
+		__qdio_allocate_fill_qdr(irq_ptr, irq_ptr->output_qs, i,
+					 qdio_init->no_input_qs);
+}
+
+static void setup_qib(struct qdio_irq *irq_ptr,
+		      struct qdio_initialize *init_data)
+{
+	if (css_general_characteristics.qebsm)
+		irq_ptr->qib.rflags |= QIB_RFLAGS_ENABLE_QEBSM;
+
+	irq_ptr->qib.qfmt = init_data->q_format;
+	if (init_data->no_input_qs)
+		irq_ptr->qib.isliba =
+			(unsigned long)(irq_ptr->input_qs[0]->slib);
+	if (init_data->no_output_qs)
+		irq_ptr->qib.osliba =
+			(unsigned long)(irq_ptr->output_qs[0]->slib);
+	memcpy(irq_ptr->qib.ebcnam, init_data->adapter_name, 8);
+}
+
+int qdio_setup_irq(struct qdio_initialize *init_data)
+{
+	struct ciw *ciw;
+	struct qdio_irq *irq_ptr = init_data->cdev->private->qdio_data;
+	int rc;
+
+	memset(irq_ptr, 0, ((char *)&irq_ptr->qdr) - ((char *)irq_ptr));
+	/* wipes qib.ac, required by ar7063 */
+	memset(irq_ptr->qdr, 0, sizeof(struct qdr));
+
+	irq_ptr->int_parm = init_data->int_parm;
+	irq_ptr->nr_input_qs = init_data->no_input_qs;
+	irq_ptr->nr_output_qs = init_data->no_output_qs;
+
+	irq_ptr->schid = ccw_device_get_subchannel_id(init_data->cdev);
+	irq_ptr->cdev = init_data->cdev;
+	setup_queues(irq_ptr, init_data);
+
+	if (!try_module_get(THIS_MODULE)) {
+		rc = -EINVAL;
+		goto out_err;
+	}
+
+	setup_qib(irq_ptr, init_data);
+	qdio_setup_thinint(irq_ptr);
+	set_impl_params(irq_ptr, init_data->qib_param_field_format,
+			init_data->qib_param_field,
+			init_data->input_slib_elements,
+			init_data->output_slib_elements);
+
+	/* fill input and output descriptors */
+	setup_qdr(irq_ptr, init_data);
+
+	/* qdr, qib, sls, slsbs, slibs, sbales are filled now */
+
+	/* get qdio commands */
+	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_EQUEUE);
+	if (!ciw) {
+		QDIO_DBF_TEXT2(1, setup, "no eq");
+		rc = -EINVAL;
+		goto out_err;
+	}
+	irq_ptr->equeue = *ciw;
+
+	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_AQUEUE);
+	if (!ciw) {
+		QDIO_DBF_TEXT2(1, setup, "no aq");
+		rc = -EINVAL;
+		goto out_err;
+	}
+	irq_ptr->aqueue = *ciw;
+
+	/* set new interrupt handler */
+	irq_ptr->orig_handler = init_data->cdev->handler;
+	init_data->cdev->handler = qdio_int_handler;
+	return 0;
+out_err:
+	qdio_release_memory(irq_ptr);
+	return rc;
+}
+
+void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
+				struct ccw_device *cdev)
+{
+	char s[80];
+
+	sprintf(s, "%s ", cdev->dev.bus_id);
+
+	switch (irq_ptr->qib.qfmt) {
+	case QDIO_QETH_QFMT:
+		sprintf(s + strlen(s), "OSADE ");
+		break;
+	case QDIO_ZFCP_QFMT:
+		sprintf(s + strlen(s), "ZFCP ");
+		break;
+	case QDIO_IQDIO_QFMT:
+		sprintf(s + strlen(s), "HiperSockets ");
+		break;
+	}
+	sprintf(s + strlen(s), "using: ");
+
+	if (!is_thinint_irq(irq_ptr))
+		sprintf(s + strlen(s), "no");
+	sprintf(s + strlen(s), "AdapterInterrupts ");
+	if (!(irq_ptr->sch_token != 0))
+		sprintf(s + strlen(s), "no");
+	sprintf(s + strlen(s), "QEBSM ");
+	if (!(irq_ptr->qib.ac & QIB_AC_OUTBOUND_PCI_SUPPORTED))
+		sprintf(s + strlen(s), "no");
+	sprintf(s + strlen(s), "OutboundPCI ");
+	if (!css_general_characteristics.aif_tdd)
+		sprintf(s + strlen(s), "no");
+	sprintf(s + strlen(s), "TDD\n");
+	printk(KERN_INFO "qdio: %s", s);
+
+	memset(s, 0, sizeof(s));
+	sprintf(s, "%s SIGA required: ", cdev->dev.bus_id);
+	if (irq_ptr->siga_flag.input)
+		sprintf(s + strlen(s), "Read ");
+	if (irq_ptr->siga_flag.output)
+		sprintf(s + strlen(s), "Write ");
+	if (irq_ptr->siga_flag.sync)
+		sprintf(s + strlen(s), "Sync ");
+	if (!irq_ptr->siga_flag.no_sync_ti)
+		sprintf(s + strlen(s), "SyncAI ");
+	if (!irq_ptr->siga_flag.no_sync_out_ti)
+		sprintf(s + strlen(s), "SyncOutAI ");
+	if (!irq_ptr->siga_flag.no_sync_out_pci)
+		sprintf(s + strlen(s), "SyncOutPCI");
+	sprintf(s + strlen(s), "\n");
+	printk(KERN_INFO "qdio: %s", s);
+}
+
+int __init qdio_setup_init(void)
+{
+	char dbf_text[15];
+
+	qdio_q_cache = kmem_cache_create("qdio_q", sizeof(struct qdio_q),
+					 256, 0, NULL);
+	if (!qdio_q_cache)
+		return -ENOMEM;
+
+	/* Check for OSA/FCP thin interrupts (bit 67). */
+	sprintf(dbf_text, "thini%1x",
+		(css_general_characteristics.aif_osa) ? 1 : 0);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+
+	/* Check for QEBSM support in general (bit 58). */
+	sprintf(dbf_text, "cssQBS:%1x",
+		(css_general_characteristics.qebsm) ? 1 : 0);
+	QDIO_DBF_TEXT0(0, setup, dbf_text);
+	return 0;
+}
+
+void __exit qdio_setup_exit(void)
+{
+	kmem_cache_destroy(qdio_q_cache);
+}
Index: quilt-2.6/drivers/s390/cio/qdio_thinint.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/qdio_thinint.c
@@ -0,0 +1,380 @@
+/*
+ * linux/drivers/s390/cio/thinint_qdio.c
+ *
+ * thin interrupt support for qdio
+ *
+ * Copyright 2000-2008 IBM Corp.
+ * Author(s): Utz Bacher <utz.bacher@de.ibm.com>
+ *	      Cornelia Huck <cornelia.huck@de.ibm.com>
+ *	      Jan Glauber <jang@linux.vnet.ibm.com>
+ */
+#include <linux/io.h>
+#include <asm/atomic.h>
+#include <asm/debug.h>
+#include <asm/qdio.h>
+#include <asm/airq.h>
+#include <asm/isc.h>
+
+#include "cio.h"
+#include "ioasm.h"
+#include "qdio.h"
+#include "qdio_debug.h"
+#include "qdio_perf.h"
+
+/*
+ * Restriction: only 63 iqdio subchannels would have its own indicator,
+ * after that, subsequent subchannels share one indicator
+ */
+#define TIQDIO_NR_NONSHARED_IND		63
+#define TIQDIO_NR_INDICATORS		(TIQDIO_NR_NONSHARED_IND + 1)
+#define TIQDIO_SHARED_IND		63
+
+/* list of thin interrupt input queues */
+static LIST_HEAD(tiq_list);
+
+/* adapter local summary indicator */
+static unsigned char *tiqdio_alsi;
+
+/* device state change indicators */
+struct indicator_t {
+	u32 ind;	/* u32 because of compare-and-swap performance */
+	atomic_t count; /* use count, 0 or 1 for non-shared indicators */
+};
+static struct indicator_t *indicators;
+
+static void tiqdio_tasklet_fn(unsigned long data);
+static DECLARE_TASKLET(tiqdio_tasklet, tiqdio_tasklet_fn, 0);
+
+static int css_qdio_omit_svs;
+
+static inline unsigned long do_clear_global_summary(void)
+{
+	register unsigned long __fn asm("1") = 3;
+	register unsigned long __tmp asm("2");
+	register unsigned long __time asm("3");
+
+	asm volatile(
+		"	.insn	rre,0xb2650000,2,0"
+		: "+d" (__fn), "=d" (__tmp), "=d" (__time));
+	return __time;
+}
+
+/* returns addr for the device state change indicator */
+static u32 *get_indicator(void)
+{
+	int i;
+
+	for (i = 0; i < TIQDIO_NR_NONSHARED_IND; i++)
+		if (!atomic_read(&indicators[i].count)) {
+			atomic_set(&indicators[i].count, 1);
+			return &indicators[i].ind;
+		}
+
+	/* use the shared indicator */
+	atomic_inc(&indicators[TIQDIO_SHARED_IND].count);
+	return &indicators[TIQDIO_SHARED_IND].ind;
+}
+
+static void put_indicator(u32 *addr)
+{
+	int i;
+
+	if (!addr)
+		return;
+
+	i = (addr - (u32 *)indicators) / sizeof(struct indicator_t);
+	atomic_dec(&indicators[i].count);
+}
+
+void tiqdio_add_input_queues(struct qdio_irq *irq_ptr)
+{
+	struct qdio_q *q;
+	int i;
+
+	/* No TDD facility? If we must use SIGA-s we can also omit SVS. */
+	if (!css_qdio_omit_svs && irq_ptr->siga_flag.sync)
+		css_qdio_omit_svs = 1;
+
+	for_each_input_queue(irq_ptr, q, i) {
+		list_add_rcu(&q->entry, &tiq_list);
+		synchronize_rcu();
+	}
+	xchg(irq_ptr->dsci, 1);
+	tasklet_schedule(&tiqdio_tasklet);
+}
+
+/*
+ * we cannot stop the tiqdio tasklet here since it is for all
+ * thinint qdio devices and it must run as long as there is a
+ * thinint device left
+ */
+void tiqdio_remove_input_queues(struct qdio_irq *irq_ptr)
+{
+	struct qdio_q *q;
+	int i;
+
+	for_each_input_queue(irq_ptr, q, i) {
+		list_del_rcu(&q->entry);
+		synchronize_rcu();
+	}
+}
+
+static inline int tiqdio_inbound_q_done(struct qdio_q *q)
+{
+	unsigned char state;
+
+	if (!atomic_read(&q->nr_buf_used))
+		return 1;
+
+	qdio_siga_sync_q(q);
+	get_buf_state(q, q->first_to_check, &state);
+
+	if (state == SLSB_P_INPUT_PRIMED)
+		/* more work coming */
+		return 0;
+	return 1;
+}
+
+static inline int shared_ind(struct qdio_irq *irq_ptr)
+{
+	return irq_ptr->dsci == &indicators[TIQDIO_SHARED_IND].ind;
+}
+
+static void __tiqdio_inbound_processing(struct qdio_q *q)
+{
+	qdio_perf_stat_inc(&perf_stats.thinint_inbound);
+	qdio_sync_after_thinint(q);
+
+	/*
+	 * Maybe we have work on our outbound queues... at least
+	 * we have to check the PCI capable queues.
+	 */
+	qdio_check_outbound_after_thinint(q);
+
+again:
+	if (!qdio_inbound_q_moved(q))
+		return;
+
+	qdio_kick_inbound_handler(q);
+
+	if (!tiqdio_inbound_q_done(q)) {
+		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop);
+		goto again;
+	}
+
+	qdio_stop_polling(q);
+	/*
+	 * We need to check again to not lose initiative after
+	 * resetting the ACK state.
+	 */
+	if (!tiqdio_inbound_q_done(q)) {
+		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop2);
+		goto again;
+	}
+}
+
+void tiqdio_inbound_processing(unsigned long data)
+{
+	struct qdio_q *q = (struct qdio_q *)data;
+
+	__tiqdio_inbound_processing(q);
+}
+
+/* check for work on all inbound thinint queues */
+static void tiqdio_tasklet_fn(unsigned long data)
+{
+	struct qdio_q *q;
+
+	qdio_perf_stat_inc(&perf_stats.tasklet_thinint);
+again:
+
+	/* protect tiq_list entries, only changed in activate or shutdown */
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(q, &tiq_list, entry)
+		/* only process queues from changed sets */
+		if (*q->irq_ptr->dsci) {
+
+			/* only clear it if the indicator is non-shared */
+			if (!shared_ind(q->irq_ptr))
+				xchg(q->irq_ptr->dsci, 0);
+			/*
+			 * don't call inbound processing directly since
+			 * that could starve other thinint queues
+			 */
+			tasklet_schedule(&q->tasklet);
+		}
+
+	rcu_read_unlock();
+
+	/*
+	 * if we used the shared indicator clear it now after all queues
+	 * were processed
+	 */
+	if (atomic_read(&indicators[TIQDIO_SHARED_IND].count)) {
+		xchg(&indicators[TIQDIO_SHARED_IND].ind, 0);
+
+		/* prevent racing */
+		if (*tiqdio_alsi)
+			xchg(&indicators[TIQDIO_SHARED_IND].ind, 1);
+	}
+
+	/* check for more work */
+	if (*tiqdio_alsi) {
+		xchg(tiqdio_alsi, 0);
+		qdio_perf_stat_inc(&perf_stats.tasklet_thinint_loop);
+		goto again;
+	}
+}
+
+/**
+ * tiqdio_thinint_handler - thin interrupt handler for qdio
+ * @ind: pointer to adapter local summary indicator
+ * @drv_data: NULL
+ */
+static void tiqdio_thinint_handler(void *ind, void *drv_data)
+{
+	qdio_perf_stat_inc(&perf_stats.thin_int);
+
+	/*
+	 * SVS only when needed: issue SVS to benefit from iqdio interrupt
+	 * avoidance (SVS clears adapter interrupt suppression overwrite)
+	 */
+	if (!css_qdio_omit_svs)
+		do_clear_global_summary();
+
+	/*
+	 * reset local summary indicator (tiqdio_alsi) to stop adapter
+	 * interrupts for now, the tasklet will clean all dsci's
+	 */
+	xchg((u8 *)ind, 0);
+	tasklet_hi_schedule(&tiqdio_tasklet);
+}
+
+static int set_subchannel_ind(struct qdio_irq *irq_ptr, int reset)
+{
+	struct scssc_area *scssc_area;
+	char dbf_text[15];
+	void *ptr;
+	int rc;
+
+	scssc_area = (struct scssc_area *)irq_ptr->chsc_page;
+	memset(scssc_area, 0, PAGE_SIZE);
+
+	if (reset) {
+		scssc_area->summary_indicator_addr = 0;
+		scssc_area->subchannel_indicator_addr = 0;
+	} else {
+		scssc_area->summary_indicator_addr = virt_to_phys(tiqdio_alsi);
+		scssc_area->subchannel_indicator_addr =
+			virt_to_phys(irq_ptr->dsci);
+	}
+
+	scssc_area->request = (struct chsc_header) {
+		.length = 0x0fe0,
+		.code	= 0x0021,
+	};
+	scssc_area->operation_code = 0;
+	scssc_area->ks = PAGE_DEFAULT_KEY;
+	scssc_area->kc = PAGE_DEFAULT_KEY;
+	scssc_area->isc = QDIO_AIRQ_ISC;
+	scssc_area->schid = irq_ptr->schid;
+
+	/* enable the time delay disablement facility */
+	if (css_general_characteristics.aif_tdd)
+		scssc_area->word_with_d_bit = 0x10000000;
+
+	rc = chsc(scssc_area);
+	if (rc)
+		return -EIO;
+
+	rc = chsc_error_from_response(scssc_area->response.code);
+	if (rc) {
+		sprintf(dbf_text, "sidR%4x", scssc_area->response.code);
+		QDIO_DBF_TEXT1(0, trace, dbf_text);
+		QDIO_DBF_TEXT1(0, setup, dbf_text);
+		ptr = &scssc_area->response;
+		QDIO_DBF_HEX2(1, setup, &ptr, QDIO_DBF_SETUP_LEN);
+		return rc;
+	}
+
+	QDIO_DBF_TEXT2(0, setup, "setscind");
+	QDIO_DBF_HEX2(0, setup, &scssc_area->summary_indicator_addr,
+		      sizeof(unsigned long));
+	QDIO_DBF_HEX2(0, setup, &scssc_area->subchannel_indicator_addr,
+		      sizeof(unsigned long));
+	return 0;
+}
+
+/* allocate non-shared indicators and shared indicator */
+int __init tiqdio_allocate_memory(void)
+{
+	indicators = kzalloc(sizeof(struct indicator_t) * TIQDIO_NR_INDICATORS,
+			     GFP_KERNEL);
+	if (!indicators)
+		return -ENOMEM;
+	return 0;
+}
+
+void tiqdio_free_memory(void)
+{
+	kfree(indicators);
+}
+
+int __init tiqdio_register_thinints(void)
+{
+	char dbf_text[20];
+
+	isc_register(QDIO_AIRQ_ISC);
+	tiqdio_alsi = s390_register_adapter_interrupt(&tiqdio_thinint_handler,
+						      NULL, QDIO_AIRQ_ISC);
+	if (IS_ERR(tiqdio_alsi)) {
+		sprintf(dbf_text, "regthn%lx", PTR_ERR(tiqdio_alsi));
+		QDIO_DBF_TEXT0(0, setup, dbf_text);
+		tiqdio_alsi = NULL;
+		isc_unregister(QDIO_AIRQ_ISC);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+int qdio_establish_thinint(struct qdio_irq *irq_ptr)
+{
+	if (!is_thinint_irq(irq_ptr))
+		return 0;
+
+	/* Check for aif time delay disablement. If installed,
+	 * omit SVS even under LPAR
+	 */
+	if (css_general_characteristics.aif_tdd)
+		css_qdio_omit_svs = 1;
+	return set_subchannel_ind(irq_ptr, 0);
+}
+
+void qdio_setup_thinint(struct qdio_irq *irq_ptr)
+{
+	if (!is_thinint_irq(irq_ptr))
+		return;
+	irq_ptr->dsci = get_indicator();
+	QDIO_DBF_HEX1(0, setup, &irq_ptr->dsci, sizeof(void *));
+}
+
+void qdio_shutdown_thinint(struct qdio_irq *irq_ptr)
+{
+	if (!is_thinint_irq(irq_ptr))
+		return;
+
+	/* reset adapter interrupt indicators */
+	put_indicator(irq_ptr->dsci);
+	set_subchannel_ind(irq_ptr, 1);
+}
+
+void __exit tiqdio_unregister_thinints(void)
+{
+	tasklet_disable(&tiqdio_tasklet);
+
+	if (tiqdio_alsi) {
+		s390_unregister_adapter_interrupt(tiqdio_alsi, QDIO_AIRQ_ISC);
+		isc_unregister(QDIO_AIRQ_ISC);
+	}
+}
Index: quilt-2.6/include/asm-s390/qdio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/qdio.h
+++ quilt-2.6/include/asm-s390/qdio.h
@@ -1,404 +1,382 @@
 /*
  * linux/include/asm-s390/qdio.h
  *
- * Linux for S/390 QDIO base support, Hipersocket base support
- * version 2
- *
- * Copyright 2000,2002 IBM Corporation
+ * Copyright 2000,2008 IBM Corp.
  * Author(s): Utz Bacher <utz.bacher@de.ibm.com>
+ *	      Jan Glauber <jang@linux.vnet.ibm.com>
  *
  */
 #ifndef __QDIO_H__
 #define __QDIO_H__
 
-/* note, that most of the typedef's are from ingo. */
-
 #include <linux/interrupt.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
 
-#define QDIO_NAME "qdio "
-
-#ifndef __s390x__
-#define QDIO_32_BIT
-#endif /* __s390x__ */
-
-/**** CONSTANTS, that are relied on without using these symbols *****/
-#define QDIO_MAX_QUEUES_PER_IRQ 32 /* used in width of unsigned int */
-/************************ END of CONSTANTS **************************/
-#define QDIO_MAX_BUFFERS_PER_Q 128 /* must be a power of 2 (%x=&(x-1)*/
-#define QDIO_BUF_ORDER 7 /* 2**this == number of pages used for sbals in 1 q */
-#define QDIO_MAX_ELEMENTS_PER_BUFFER 16
-#define SBAL_SIZE 256
-
-#define QDIO_QETH_QFMT 0
-#define QDIO_ZFCP_QFMT 1
-#define QDIO_IQDIO_QFMT 2
-#define QDIO_IQDIO_QFMT_ASYNCH 3
-
-struct qdio_buffer_element{
-	unsigned int flags;
-	unsigned int length;
-#ifdef QDIO_32_BIT
-	void *reserved;
-#endif /* QDIO_32_BIT */
-	void *addr;
-} __attribute__ ((packed,aligned(16)));
-
-struct qdio_buffer{
-	volatile struct qdio_buffer_element element[16];
-} __attribute__ ((packed,aligned(256)));
-
-
-/* params are: ccw_device, status, qdio_error, siga_error,
-   queue_number, first element processed, number of elements processed,
-   int_parm */
-typedef void qdio_handler_t(struct ccw_device *,unsigned int,unsigned int,
-			    unsigned int,unsigned int,int,int,unsigned long);
-
-
-#define QDIO_STATUS_INBOUND_INT 0x01
-#define QDIO_STATUS_OUTBOUND_INT 0x02
-#define QDIO_STATUS_LOOK_FOR_ERROR 0x04
-#define QDIO_STATUS_MORE_THAN_ONE_QDIO_ERROR 0x08
-#define QDIO_STATUS_MORE_THAN_ONE_SIGA_ERROR 0x10
-#define QDIO_STATUS_ACTIVATE_CHECK_CONDITION 0x20
-
-#define QDIO_SIGA_ERROR_ACCESS_EXCEPTION 0x10
-#define QDIO_SIGA_ERROR_B_BIT_SET 0x20
-
-/* for qdio_initialize */
-#define QDIO_INBOUND_0COPY_SBALS 0x01
-#define QDIO_OUTBOUND_0COPY_SBALS 0x02
-#define QDIO_USE_OUTBOUND_PCIS 0x04
-
-/* for qdio_cleanup */
-#define QDIO_FLAG_CLEANUP_USING_CLEAR 0x01
-#define QDIO_FLAG_CLEANUP_USING_HALT 0x02
-
-struct qdio_initialize {
-	struct ccw_device *cdev;
-	unsigned char q_format;
-	unsigned char adapter_name[8];
-       	unsigned int qib_param_field_format; /*adapter dependent*/
-	/* pointer to 128 bytes or NULL, if no param field */
-	unsigned char *qib_param_field; /* adapter dependent */
-	/* pointer to no_queues*128 words of data or NULL */
-	unsigned long *input_slib_elements;
-	unsigned long *output_slib_elements;
-	unsigned int min_input_threshold;
-	unsigned int max_input_threshold;
-	unsigned int min_output_threshold;
-	unsigned int max_output_threshold;
-	unsigned int no_input_qs;
-	unsigned int no_output_qs;
-	qdio_handler_t *input_handler;
-	qdio_handler_t *output_handler;
-	unsigned long int_parm;
-	unsigned long flags;
-	void **input_sbal_addr_array; /* addr of n*128 void ptrs */
-	void **output_sbal_addr_array; /* addr of n*128 void ptrs */
-};
-
-extern int qdio_initialize(struct qdio_initialize *init_data);
-extern int qdio_allocate(struct qdio_initialize *init_data);
-extern int qdio_establish(struct qdio_initialize *init_data);
-
-extern int qdio_activate(struct ccw_device *,int flags);
-
-#define QDIO_STATE_MUST_USE_OUTB_PCI	0x00000001
-#define QDIO_STATE_INACTIVE 		0x00000002 /* after qdio_cleanup */
-#define QDIO_STATE_ESTABLISHED 		0x00000004 /* after qdio_initialize */
-#define QDIO_STATE_ACTIVE 		0x00000008 /* after qdio_activate */
-#define QDIO_STATE_STOPPED 		0x00000010 /* after queues went down */
-extern unsigned long qdio_get_status(int irq);
-
-
-#define QDIO_FLAG_SYNC_INPUT     0x01
-#define QDIO_FLAG_SYNC_OUTPUT    0x02
-#define QDIO_FLAG_UNDER_INTERRUPT 0x04
-#define QDIO_FLAG_NO_INPUT_INTERRUPT_CONTEXT 0x08 /* no effect on
-						     adapter interrupts */
-#define QDIO_FLAG_DONT_SIGA 0x10
-#define QDIO_FLAG_PCI_OUT   0x20
-
-extern int do_QDIO(struct ccw_device*, unsigned int flags, 
-		   unsigned int queue_number,
-		   unsigned int qidx,unsigned int count,
-		   struct qdio_buffer *buffers);
-
-extern int qdio_get_ssqd_pct(struct ccw_device*);
-extern int qdio_synchronize(struct ccw_device*, unsigned int flags,
-			    unsigned int queue_number);
-
-extern int qdio_cleanup(struct ccw_device*, int how);
-extern int qdio_shutdown(struct ccw_device*, int how);
-extern int qdio_free(struct ccw_device*);
-
-unsigned char qdio_get_slsb_state(struct ccw_device*, unsigned int flag,
-				  unsigned int queue_number,
-				  unsigned int qidx);
-
-extern void qdio_init_scrubber(void);
-
+#define QDIO_MAX_QUEUES_PER_IRQ		32
+#define QDIO_MAX_BUFFERS_PER_Q		128
+#define QDIO_MAX_BUFFERS_MASK		(QDIO_MAX_BUFFERS_PER_Q - 1)
+#define QDIO_MAX_ELEMENTS_PER_BUFFER	16
+#define QDIO_SBAL_SIZE			256
+
+#define QDIO_QETH_QFMT			0
+#define QDIO_ZFCP_QFMT			1
+#define QDIO_IQDIO_QFMT			2
+
+/**
+ * struct qdesfmt0 - queue descriptor, format 0
+ * @sliba: storage list information block address
+ * @sla: storage list address
+ * @slsba: storage list state block address
+ * @akey: access key for DLIB
+ * @bkey: access key for SL
+ * @ckey: access key for SBALs
+ * @dkey: access key for SLSB
+ */
 struct qdesfmt0 {
-#ifdef QDIO_32_BIT
-	unsigned long res1;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long sliba;            /* storage-list-information-block
-					   address */
-#ifdef QDIO_32_BIT
-	unsigned long res2;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long sla;              /* storage-list address */
-#ifdef QDIO_32_BIT
-	unsigned long res3;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long slsba;            /* storage-list-state-block address */
-	unsigned int  res4;		/* reserved */
-	unsigned int  akey  :  4;       /* access key for DLIB */
-	unsigned int  bkey  :  4;       /* access key for SL */
-	unsigned int  ckey  :  4;       /* access key for SBALs */
-	unsigned int  dkey  :  4;       /* access key for SLSB */
-	unsigned int  res5  : 16;       /* reserved */
+	u64 sliba;
+	u64 sla;
+	u64 slsba;
+	u32	 : 32;
+	u32 akey : 4;
+	u32 bkey : 4;
+	u32 ckey : 4;
+	u32 dkey : 4;
+	u32	 : 16;
 } __attribute__ ((packed));
 
-/*
- * Queue-Description record (QDR)
+/**
+ * struct qdr - queue description record (QDR)
+ * @qfmt: queue format
+ * @pfmt: implementation dependent parameter format
+ * @ac: adapter characteristics
+ * @iqdcnt: input queue descriptor count
+ * @oqdcnt: output queue descriptor count
+ * @iqdsz: inpout queue descriptor size
+ * @oqdsz: output queue descriptor size
+ * @qiba: queue information block address
+ * @qkey: queue information block key
+ * @qdf0: queue descriptions
  */
 struct qdr {
-	unsigned int  qfmt    :  8;     /* queue format */
-	unsigned int  pfmt    :  8;     /* impl. dep. parameter format */
-	unsigned int  res1    :  8;     /* reserved */
-	unsigned int  ac      :  8;     /* adapter characteristics */
-	unsigned int  res2    :  8;     /* reserved */
-	unsigned int  iqdcnt  :  8;     /* input-queue-descriptor count */
-	unsigned int  res3    :  8;     /* reserved */
-	unsigned int  oqdcnt  :  8;     /* output-queue-descriptor count */
-	unsigned int  res4    :  8;     /* reserved */
-	unsigned int  iqdsz   :  8;     /* input-queue-descriptor size */
-	unsigned int  res5    :  8;     /* reserved */
-	unsigned int  oqdsz   :  8;     /* output-queue-descriptor size */
-	unsigned int  res6[9];          /* reserved */
-#ifdef QDIO_32_BIT
-	unsigned long res7;		/* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long qiba;             /* queue-information-block address */
-	unsigned int  res8;             /* reserved */
-	unsigned int  qkey    :  4;	/* queue-information-block key */
-	unsigned int  res9    : 28;     /* reserved */
-/*	union _qd {*/ /* why this? */
-		struct qdesfmt0 qdf0[126];
-/*	} qd;*/
-} __attribute__ ((packed,aligned(4096)));
-
+	u32 qfmt   : 8;
+	u32 pfmt   : 8;
+	u32	   : 8;
+	u32 ac	   : 8;
+	u32	   : 8;
+	u32 iqdcnt : 8;
+	u32	   : 8;
+	u32 oqdcnt : 8;
+	u32	   : 8;
+	u32 iqdsz  : 8;
+	u32	   : 8;
+	u32 oqdsz  : 8;
+	/* private: */
+	u32 res[9];
+	/* public: */
+	u64 qiba;
+	u32	   : 32;
+	u32 qkey   : 4;
+	u32	   : 28;
+	struct qdesfmt0 qdf0[126];
+} __attribute__ ((packed, aligned(4096)));
 
-/*
- * queue information block (QIB)
- */
-#define QIB_AC_INBOUND_PCI_SUPPORTED 	0x80
-#define QIB_AC_OUTBOUND_PCI_SUPPORTED 	0x40
+#define QIB_AC_OUTBOUND_PCI_SUPPORTED	0x40
 #define QIB_RFLAGS_ENABLE_QEBSM		0x80
 
+/**
+ * struct qib - queue information block (QIB)
+ * @qfmt: queue format
+ * @pfmt: implementation dependent parameter format
+ * @rflags: QEBSM
+ * @ac: adapter characteristics
+ * @isliba: absolute address of first input SLIB
+ * @osliba: absolute address of first output SLIB
+ * @ebcnam: adapter identifier in EBCDIC
+ * @parm: implementation dependent parameters
+ */
 struct qib {
-	unsigned int  qfmt    :  8;     /* queue format */
-	unsigned int  pfmt    :  8;     /* impl. dep. parameter format */
-	unsigned int  rflags  :  8;	/* QEBSM */
-	unsigned int  ac      :  8;     /* adapter characteristics */
-	unsigned int  res2;             /* reserved */
-#ifdef QDIO_32_BIT
-	unsigned long res3;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long isliba;           /* absolute address of 1st
-					   input SLIB */
-#ifdef QDIO_32_BIT
-	unsigned long res4;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long osliba;           /* absolute address of 1st
-					   output SLIB */
-	unsigned int  res5;             /* reserved */
-	unsigned int  res6;             /* reserved */
-	unsigned char ebcnam[8];        /* adapter identifier in EBCDIC */
-	unsigned char res7[88];         /* reserved */
-	unsigned char parm[QDIO_MAX_BUFFERS_PER_Q];
-					/* implementation dependent
-					   parameters */
-} __attribute__ ((packed,aligned(256)));
-
-
-/*
- * storage-list-information block element (SLIBE)
+	u32 qfmt   : 8;
+	u32 pfmt   : 8;
+	u32 rflags : 8;
+	u32 ac	   : 8;
+	u32	   : 32;
+	u64 isliba;
+	u64 osliba;
+	u32	   : 32;
+	u32	   : 32;
+	u8 ebcnam[8];
+	/* private: */
+	u8 res[88];
+	/* public: */
+	u8 parm[QDIO_MAX_BUFFERS_PER_Q];
+} __attribute__ ((packed, aligned(256)));
+
+/**
+ * struct slibe - storage list information block element (SLIBE)
+ * @parms: implementation dependent parameters
  */
 struct slibe {
-#ifdef QDIO_32_BIT
-	unsigned long res;              /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long parms;            /* implementation dependent
-					   parameters */
+	u64 parms;
 };
 
-/*
- * storage-list-information block (SLIB)
+/**
+ * struct slib - storage list information block (SLIB)
+ * @nsliba: next SLIB address (if any)
+ * @sla: SL address
+ * @slsba: SLSB address
+ * @slibe: SLIB elements
  */
 struct slib {
-#ifdef QDIO_32_BIT
-	unsigned long res1;             /* reserved */
-#endif /* QDIO_32_BIT */
-        unsigned long nsliba;           /* next SLIB address (if any) */
-#ifdef QDIO_32_BIT
-	unsigned long res2;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long sla;              /* SL address */
-#ifdef QDIO_32_BIT
-	unsigned long res3;             /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long slsba;            /* SLSB address */
-	unsigned char res4[1000];       /* reserved */
-	struct slibe slibe[QDIO_MAX_BUFFERS_PER_Q];    /* SLIB elements */
-} __attribute__ ((packed,aligned(2048)));
-
+	u64 nsliba;
+	u64 sla;
+	u64 slsba;
+	/* private: */
+	u8 res[1000];
+	/* public: */
+	struct slibe slibe[QDIO_MAX_BUFFERS_PER_Q];
+} __attribute__ ((packed, aligned(2048)));
+
+/**
+ * struct sbal_flags - storage block address list flags
+ * @last: last entry
+ * @cont: contiguous storage
+ * @frag: fragmentation
+ */
 struct sbal_flags {
-	unsigned char res1  : 1;   /* reserved */
-	unsigned char last  : 1;   /* last entry */
-	unsigned char cont  : 1;   /* contiguous storage */
-	unsigned char res2  : 1;   /* reserved */
-	unsigned char frag  : 2;   /* fragmentation (s.below) */
-	unsigned char res3  : 2;   /* reserved */
+	u8	: 1;
+	u8 last : 1;
+	u8 cont : 1;
+	u8	: 1;
+	u8 frag : 2;
+	u8	: 2;
 } __attribute__ ((packed));
 
-#define SBAL_FLAGS_FIRST_FRAG	     0x04000000UL
-#define SBAL_FLAGS_MIDDLE_FRAG	     0x08000000UL
-#define SBAL_FLAGS_LAST_FRAG	     0x0c000000UL
-#define SBAL_FLAGS_LAST_ENTRY	     0x40000000UL
-#define SBAL_FLAGS_CONTIGUOUS	     0x20000000UL
+#define SBAL_FLAGS_FIRST_FRAG		0x04000000UL
+#define SBAL_FLAGS_MIDDLE_FRAG		0x08000000UL
+#define SBAL_FLAGS_LAST_FRAG		0x0c000000UL
+#define SBAL_FLAGS_LAST_ENTRY		0x40000000UL
+#define SBAL_FLAGS_CONTIGUOUS		0x20000000UL
 
-#define SBAL_FLAGS0_DATA_CONTINUATION 0x20UL
+#define SBAL_FLAGS0_DATA_CONTINUATION	0x20UL
 
 /* Awesome OpenFCP extensions */
-#define SBAL_FLAGS0_TYPE_STATUS       0x00UL
-#define SBAL_FLAGS0_TYPE_WRITE        0x08UL
-#define SBAL_FLAGS0_TYPE_READ         0x10UL
-#define SBAL_FLAGS0_TYPE_WRITE_READ   0x18UL
-#define SBAL_FLAGS0_MORE_SBALS	      0x04UL
-#define SBAL_FLAGS0_COMMAND           0x02UL
-#define SBAL_FLAGS0_LAST_SBAL         0x00UL
-#define SBAL_FLAGS0_ONLY_SBAL         SBAL_FLAGS0_COMMAND
-#define SBAL_FLAGS0_MIDDLE_SBAL       SBAL_FLAGS0_MORE_SBALS
-#define SBAL_FLAGS0_FIRST_SBAL        SBAL_FLAGS0_MORE_SBALS | SBAL_FLAGS0_COMMAND
-/* Naught of interest beyond this point */
-
-#define SBAL_FLAGS0_PCI		0x40
+#define SBAL_FLAGS0_TYPE_STATUS		0x00UL
+#define SBAL_FLAGS0_TYPE_WRITE		0x08UL
+#define SBAL_FLAGS0_TYPE_READ		0x10UL
+#define SBAL_FLAGS0_TYPE_WRITE_READ	0x18UL
+#define SBAL_FLAGS0_MORE_SBALS		0x04UL
+#define SBAL_FLAGS0_COMMAND		0x02UL
+#define SBAL_FLAGS0_LAST_SBAL		0x00UL
+#define SBAL_FLAGS0_ONLY_SBAL		SBAL_FLAGS0_COMMAND
+#define SBAL_FLAGS0_MIDDLE_SBAL		SBAL_FLAGS0_MORE_SBALS
+#define SBAL_FLAGS0_FIRST_SBAL SBAL_FLAGS0_MORE_SBALS | SBAL_FLAGS0_COMMAND
+#define SBAL_FLAGS0_PCI			0x40
+
+/**
+ * struct sbal_sbalf_0 - sbal flags for sbale 0
+ * @pci: PCI indicator
+ * @cont: data continuation
+ * @sbtype: storage-block type (FCP)
+ */
 struct sbal_sbalf_0 {
-	unsigned char res1  : 1;   /* reserved */
-	unsigned char pci   : 1;   /* PCI indicator */
-	unsigned char cont  : 1;   /* data continuation */
-	unsigned char sbtype: 2;   /* storage-block type (OpenFCP) */
-	unsigned char res2  : 3;   /* reserved */
+	u8	  : 1;
+	u8 pci	  : 1;
+	u8 cont   : 1;
+	u8 sbtype : 2;
+	u8	  : 3;
 } __attribute__ ((packed));
 
+/**
+ * struct sbal_sbalf_1 - sbal flags for sbale 1
+ * @key: storage key
+ */
 struct sbal_sbalf_1 {
-	unsigned char res1  : 4;   /* reserved */
-	unsigned char key   : 4;   /* storage key */
+	u8     : 4;
+	u8 key : 4;
 } __attribute__ ((packed));
 
+/**
+ * struct sbal_sbalf_14 - sbal flags for sbale 14
+ * @erridx: error index
+ */
 struct sbal_sbalf_14 {
-	unsigned char res1   : 4;  /* reserved */
-	unsigned char erridx : 4;  /* error index */
+	u8	  : 4;
+	u8 erridx : 4;
 } __attribute__ ((packed));
 
+/**
+ * struct sbal_sbalf_15 - sbal flags for sbale 15
+ * @reason: reason for error state
+ */
 struct sbal_sbalf_15 {
-	unsigned char reason;      /* reserved */
+	u8 reason;
 } __attribute__ ((packed));
 
+/**
+ * union sbal_sbalf - storage block address list flags
+ * @i0: sbalf0
+ * @i1: sbalf1
+ * @i14: sbalf14
+ * @i15: sblaf15
+ * @value: raw value
+ */
 union sbal_sbalf {
 	struct sbal_sbalf_0  i0;
 	struct sbal_sbalf_1  i1;
 	struct sbal_sbalf_14 i14;
 	struct sbal_sbalf_15 i15;
-	unsigned char value;
+	u8 value;
 };
 
-struct sbal_element {
-	union {
-		struct sbal_flags  bits;       /* flags */
-		unsigned char value;
-	} flags;
-	unsigned int  res1  : 16;   /* reserved */
-	union sbal_sbalf  sbalf;       /* SBAL flags */
-	unsigned int  res2  : 16;  /* reserved */
-	unsigned int  count : 16;  /* data count */
-#ifdef QDIO_32_BIT
-	unsigned long res3;        /* reserved */
-#endif /* QDIO_32_BIT */
-	unsigned long addr;        /* absolute data address */
-} __attribute__ ((packed,aligned(16)));
+/**
+ * struct qdio_buffer_element - SBAL entry
+ * @flags: flags
+ * @length: length
+ * @addr: address
+*/
+struct qdio_buffer_element {
+	u32 flags;
+	u32 length;
+#ifdef CONFIG_32BIT
+	/* private: */
+	void *reserved;
+	/* public: */
+#endif
+	void *addr;
+} __attribute__ ((packed, aligned(16)));
 
-/*
- * strorage-block access-list (SBAL)
+/**
+ * struct qdio_buffer - storage block address list (SBAL)
+ * @element: SBAL entries
  */
-struct sbal {
-	struct sbal_element element[QDIO_MAX_ELEMENTS_PER_BUFFER];
-} __attribute__ ((packed,aligned(256)));
-
-/*
- * storage-list (SL)
+struct qdio_buffer {
+	struct qdio_buffer_element element[QDIO_MAX_ELEMENTS_PER_BUFFER];
+} __attribute__ ((packed, aligned(256)));
+
+/**
+ * struct sl_element - storage list entry
+ * @sbal: absolute SBAL address
  */
 struct sl_element {
-#ifdef QDIO_32_BIT
-        unsigned long res;     /* reserved */
-#endif /* QDIO_32_BIT */
-        unsigned long sbal;    /* absolute SBAL address */
+#ifdef CONFIG_32BIT
+	/* private: */
+	unsigned long reserved;
+	/* public: */
+#endif
+	unsigned long sbal;
 } __attribute__ ((packed));
 
+/**
+ * struct sl - storage list (SL)
+ * @element: SL entries
+ */
 struct sl {
 	struct sl_element element[QDIO_MAX_BUFFERS_PER_Q];
-} __attribute__ ((packed,aligned(1024)));
+} __attribute__ ((packed, aligned(1024)));
 
-/*
- * storage-list-state block (SLSB)
+/**
+ * struct slsb - storage list state block (SLSB)
+ * @val: state per buffer
  */
-struct slsb_flags {
-	unsigned char owner  : 2;   /* SBAL owner */
-	unsigned char type   : 1;   /* buffer type */
-	unsigned char state  : 5;   /* processing state */
+struct slsb {
+	u8 val[QDIO_MAX_BUFFERS_PER_Q];
+} __attribute__ ((packed, aligned(256)));
+
+struct qdio_ssqd_desc {
+	u8 flags;
+	u8:8;
+	u16 sch;
+	u8 qfmt;
+	u8 parm;
+	u8 qdioac1;
+	u8 sch_class;
+	u8 pcnt;
+	u8 icnt;
+	u8:8;
+	u8 ocnt;
+	u8:8;
+	u8 mbccnt;
+	u16 qdioac2;
+	u64 sch_token;
+	u64:64;
 } __attribute__ ((packed));
 
+/* params are: ccw_device, qdio_error, queue_number,
+   first element processed, number of elements processed, int_parm */
+typedef void qdio_handler_t(struct ccw_device *, unsigned int, int,
+			    int, int, unsigned long);
+
+/* qdio errors reported to the upper-layer program */
+#define QDIO_ERROR_SIGA_ACCESS_EXCEPTION	0x10
+#define QDIO_ERROR_SIGA_BUSY			0x20
+#define QDIO_ERROR_ACTIVATE_CHECK_CONDITION	0x40
+#define QDIO_ERROR_SLSB_STATE			0x80
 
-struct slsb {
-	union {
-		unsigned char val[QDIO_MAX_BUFFERS_PER_Q];
-		struct slsb_flags flags[QDIO_MAX_BUFFERS_PER_Q];
-	} acc;
-} __attribute__ ((packed,aligned(256)));
+/* for qdio_initialize */
+#define QDIO_INBOUND_0COPY_SBALS		0x01
+#define QDIO_OUTBOUND_0COPY_SBALS		0x02
+#define QDIO_USE_OUTBOUND_PCIS			0x04
 
-/*
- * SLSB values
+/* for qdio_cleanup */
+#define QDIO_FLAG_CLEANUP_USING_CLEAR		0x01
+#define QDIO_FLAG_CLEANUP_USING_HALT		0x02
+
+/**
+ * struct qdio_initialize - qdio initalization data
+ * @cdev: associated ccw device
+ * @q_format: queue format
+ * @adapter_name: name for the adapter
+ * @qib_param_field_format: format for qib_parm_field
+ * @qib_param_field: pointer to 128 bytes or NULL, if no param field
+ * @input_slib_elements: pointer to no_input_qs * 128 words of data or NULL
+ * @output_slib_elements: pointer to no_output_qs * 128 words of data or NULL
+ * @no_input_qs: number of input queues
+ * @no_output_qs: number of output queues
+ * @input_handler: handler to be called for input queues
+ * @output_handler: handler to be called for output queues
+ * @int_parm: interruption parameter
+ * @flags: initialization flags
+ * @input_sbal_addr_array:  address of no_input_qs * 128 pointers
+ * @output_sbal_addr_array: address of no_output_qs * 128 pointers
  */
-#define SLSB_OWNER_PROG              1
-#define SLSB_OWNER_CU                2
+struct qdio_initialize {
+	struct ccw_device *cdev;
+	unsigned char q_format;
+	unsigned char adapter_name[8];
+	unsigned int qib_param_field_format;
+	unsigned char *qib_param_field;
+	unsigned long *input_slib_elements;
+	unsigned long *output_slib_elements;
+	unsigned int no_input_qs;
+	unsigned int no_output_qs;
+	qdio_handler_t *input_handler;
+	qdio_handler_t *output_handler;
+	unsigned long int_parm;
+	unsigned long flags;
+	void **input_sbal_addr_array;
+	void **output_sbal_addr_array;
+};
 
-#define SLSB_TYPE_INPUT              0
-#define SLSB_TYPE_OUTPUT             1
+#define QDIO_STATE_INACTIVE		0x00000002 /* after qdio_cleanup */
+#define QDIO_STATE_ESTABLISHED		0x00000004 /* after qdio_establish */
+#define QDIO_STATE_ACTIVE		0x00000008 /* after qdio_activate */
+#define QDIO_STATE_STOPPED		0x00000010 /* after queues went down */
+
+#define QDIO_FLAG_SYNC_INPUT		0x01
+#define QDIO_FLAG_SYNC_OUTPUT		0x02
+#define QDIO_FLAG_PCI_OUT		0x10
 
-#define SLSB_STATE_NOT_INIT          0
-#define SLSB_STATE_EMPTY             1
-#define SLSB_STATE_PRIMED            2
-#define SLSB_STATE_HALTED          0xe
-#define SLSB_STATE_ERROR           0xf
-
-#define SLSB_P_INPUT_NOT_INIT     0x80
-#define SLSB_P_INPUT_PROCESSING	  0x81
-#define SLSB_CU_INPUT_EMPTY       0x41
-#define SLSB_P_INPUT_PRIMED       0x82
-#define SLSB_P_INPUT_HALTED       0x8E
-#define SLSB_P_INPUT_ERROR        0x8F
-
-#define SLSB_P_OUTPUT_NOT_INIT    0xA0
-#define SLSB_P_OUTPUT_EMPTY       0xA1
-#define SLSB_CU_OUTPUT_PRIMED     0x62
-#define SLSB_P_OUTPUT_HALTED      0xAE
-#define SLSB_P_OUTPUT_ERROR       0xAF
+extern int qdio_initialize(struct qdio_initialize *init_data);
+extern int qdio_allocate(struct qdio_initialize *init_data);
+extern int qdio_establish(struct qdio_initialize *init_data);
+extern int qdio_activate(struct ccw_device *);
 
-#define SLSB_ERROR_DURING_LOOKUP  0xFF
+extern int do_QDIO(struct ccw_device*, unsigned int flags,
+		   int q_nr, int qidx, int count);
+extern int qdio_cleanup(struct ccw_device*, int how);
+extern int qdio_shutdown(struct ccw_device*, int how);
+extern int qdio_free(struct ccw_device *);
+extern struct qdio_ssqd_desc *qdio_get_ssqd_desc(struct ccw_device *cdev);
 
 #endif /* __QDIO_H__ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
