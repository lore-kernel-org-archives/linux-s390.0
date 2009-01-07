Return-Path: <linux-kernel-owner+w=401wt.eu-S1761610AbZAGUAx@vger.kernel.org>
Message-Id: <20090107195832.733912000@polaris-admin.engr.sgi.com>
References: <20090107195832.265117000@polaris-admin.engr.sgi.com>
Date: Wed, 07 Jan 2009 11:58:35 -0800
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 3/5] cpumask: convert misc driver functions
Content-Disposition: inline; filename=cpumask:convert-drivers.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org, Dean Nelson <dcn@sgi.com>, Robert Richter <robert.richter@amd.com>, oprofile-list@lists.sf.net, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ursula Braun <ursula.braun@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Rusty Russell <rusty@rustcorp.com.au>

Impact: use new cpumask API.

Convert misc driver functions to use struct cpumask.

To Do:
  - Convert iucv_buffer_cpumask to cpumask_var_t.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Mike Travis <travis@sgi.com>
Acked-by: Dean Nelson <dcn@sgi.com>
Cc: Robert Richter <robert.richter@amd.com>
Cc: oprofile-list@lists.sf.net
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org
Cc: xen-devel@lists.xensource.com
Cc: Ursula Braun <ursula.braun@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/base/cpu.c             |    2 +-
 drivers/misc/sgi-xp/xpc_main.c |    2 +-
 drivers/oprofile/buffer_sync.c |   22 ++++++++++++++++++----
 drivers/oprofile/buffer_sync.h |    4 ++++
 drivers/oprofile/oprof.c       |    9 ++++++++-
 drivers/xen/manage.c           |    2 +-
 net/iucv/iucv.c                |   28 ++++++++++++++++++----------
 7 files changed, 51 insertions(+), 18 deletions(-)

--- linux-2.6-for-ingo.orig/drivers/base/cpu.c
+++ linux-2.6-for-ingo/drivers/base/cpu.c
@@ -107,7 +107,7 @@ static SYSDEV_ATTR(crash_notes, 0400, sh
 /*
  * Print cpu online, possible, present, and system maps
  */
-static ssize_t print_cpus_map(char *buf, cpumask_t *map)
+static ssize_t print_cpus_map(char *buf, const struct cpumask *map)
 {
 	int n = cpulist_scnprintf(buf, PAGE_SIZE-2, map);
 
--- linux-2.6-for-ingo.orig/drivers/misc/sgi-xp/xpc_main.c
+++ linux-2.6-for-ingo/drivers/misc/sgi-xp/xpc_main.c
@@ -318,7 +318,7 @@ xpc_hb_checker(void *ignore)
 
 	/* this thread was marked active by xpc_hb_init() */
 
-	set_cpus_allowed_ptr(current, &cpumask_of_cpu(XPC_HB_CHECK_CPU));
+	set_cpus_allowed_ptr(current, cpumask_of(XPC_HB_CHECK_CPU));
 
 	/* set our heartbeating to other partitions into motion */
 	xpc_hb_check_timeout = jiffies + (xpc_hb_check_interval * HZ);
--- linux-2.6-for-ingo.orig/drivers/oprofile/buffer_sync.c
+++ linux-2.6-for-ingo/drivers/oprofile/buffer_sync.c
@@ -37,7 +37,7 @@
 
 static LIST_HEAD(dying_tasks);
 static LIST_HEAD(dead_tasks);
-static cpumask_t marked_cpus = CPU_MASK_NONE;
+static cpumask_var_t marked_cpus;
 static DEFINE_SPINLOCK(task_mortuary);
 static void process_task_mortuary(void);
 
@@ -489,10 +489,10 @@ static void mark_done(int cpu)
 {
 	int i;
 
-	cpu_set(cpu, marked_cpus);
+	cpumask_set_cpu(cpu, marked_cpus);
 
 	for_each_online_cpu(i) {
-		if (!cpu_isset(i, marked_cpus))
+		if (!cpumask_test_cpu(i, marked_cpus))
 			return;
 	}
 
@@ -501,7 +501,7 @@ static void mark_done(int cpu)
 	 */
 	process_task_mortuary();
 
-	cpus_clear(marked_cpus);
+	cpumask_clear(marked_cpus);
 }
 
 
@@ -595,6 +595,20 @@ void sync_buffer(int cpu)
 	mutex_unlock(&buffer_mutex);
 }
 
+int __init buffer_sync_init(void)
+{
+	if (!alloc_cpumask_var(&marked_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_clear(marked_cpus);
+		return 0;
+}
+
+void __exit buffer_sync_cleanup(void)
+{
+	free_cpumask_var(marked_cpus);
+}
+
 /* The function can be used to add a buffer worth of data directly to
  * the kernel buffer. The buffer is assumed to be a circular buffer.
  * Take the entries from index start and end at index end, wrapping
--- linux-2.6-for-ingo.orig/drivers/oprofile/buffer_sync.h
+++ linux-2.6-for-ingo/drivers/oprofile/buffer_sync.h
@@ -19,4 +19,8 @@ void sync_stop(void);
 /* sync the given CPU's buffer */
 void sync_buffer(int cpu);
 
+/* initialize/destroy the buffer system. */
+int buffer_sync_init(void);
+void buffer_sync_cleanup(void);
+
 #endif /* OPROFILE_BUFFER_SYNC_H */
--- linux-2.6-for-ingo.orig/drivers/oprofile/oprof.c
+++ linux-2.6-for-ingo/drivers/oprofile/oprof.c
@@ -183,6 +183,10 @@ static int __init oprofile_init(void)
 {
 	int err;
 
+	err = buffer_sync_init();
+	if (err)
+		return err;
+
 	err = oprofile_arch_init(&oprofile_ops);
 
 	if (err < 0 || timer) {
@@ -191,8 +195,10 @@ static int __init oprofile_init(void)
 	}
 
 	err = oprofilefs_register();
-	if (err)
+	if (err) {
 		oprofile_arch_exit();
+		buffer_sync_cleanup();
+	}
 
 	return err;
 }
@@ -202,6 +208,7 @@ static void __exit oprofile_exit(void)
 {
 	oprofilefs_unregister();
 	oprofile_arch_exit();
+	buffer_sync_cleanup();
 }
 
 
--- linux-2.6-for-ingo.orig/drivers/xen/manage.c
+++ linux-2.6-for-ingo/drivers/xen/manage.c
@@ -100,7 +100,7 @@ static void do_suspend(void)
 	/* XXX use normal device tree? */
 	xenbus_suspend();
 
-	err = stop_machine(xen_suspend, &cancelled, &cpumask_of_cpu(0));
+	err = stop_machine(xen_suspend, &cancelled, cpumask_of(0));
 	if (err) {
 		printk(KERN_ERR "failed to start xen_suspend: %d\n", err);
 		goto out;
--- linux-2.6-for-ingo.orig/net/iucv/iucv.c
+++ linux-2.6-for-ingo/net/iucv/iucv.c
@@ -492,15 +492,14 @@ static void iucv_setmask_mp(void)
  *
  * Allow iucv interrupts on a single cpu.
  */
-static void iucv_setmask_up(void)
+static void iucv_setmask_up(struct cpumask *cpumask)
 {
-	cpumask_t cpumask;
 	int cpu;
 
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
-	cpumask = iucv_irq_cpumask;
-	cpu_clear(first_cpu(iucv_irq_cpumask), cpumask);
-	for_each_cpu_mask_nr(cpu, cpumask)
+	cpumask_copy(cpumask, iucv_irq_cpumask);
+	cpumask_clear_cpu(cpumask_first(iucv_irq_cpumask), cpumask);
+	for_each_cpu(cpu, cpumask)
 		smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
 }
 
@@ -558,7 +557,7 @@ static void iucv_disable(void)
 static int __cpuinit iucv_cpu_notify(struct notifier_block *self,
 				     unsigned long action, void *hcpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
 	long cpu = (long) hcpu;
 
 	switch (action) {
@@ -593,15 +592,20 @@ static int __cpuinit iucv_cpu_notify(str
 		break;
 	case CPU_DOWN_PREPARE:
 	case CPU_DOWN_PREPARE_FROZEN:
-		cpumask = iucv_buffer_cpumask;
-		cpu_clear(cpu, cpumask);
-		if (cpus_empty(cpumask))
+		if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+			return NOTIFY_BAD;
+		cpumask_copy(cpumask, &iucv_buffer_cpumask);
+		cpumask_clear_cpu(cpu, cpumask);
+		if (cpumask_empty(cpumask)) {
 			/* Can't offline last IUCV enabled cpu. */
+			free_cpumask_var(cpumask);
 			return NOTIFY_BAD;
+		}
 		smp_call_function_single(cpu, iucv_retrieve_cpu, NULL, 1);
 		if (cpus_empty(iucv_irq_cpumask))
 			smp_call_function_single(first_cpu(iucv_buffer_cpumask),
 						 iucv_allow_cpu, NULL, 1);
+		free_cpumask_var(cpumask);
 		break;
 	}
 	return NOTIFY_OK;
@@ -686,9 +690,12 @@ static void iucv_cleanup_queue(void)
 int iucv_register(struct iucv_handler *handler, int smp)
 {
 	int rc;
+	cpumask_var_t scratch;
 
 	if (!iucv_available)
 		return -ENOSYS;
+	if (!alloc_cpumask_var(&scratch, GFP_KERNEL))
+		return -ENOMEM;
 	mutex_lock(&iucv_register_mutex);
 	if (!smp)
 		iucv_nonsmp_handler++;
@@ -697,7 +704,7 @@ int iucv_register(struct iucv_handler *h
 		if (rc)
 			goto out_mutex;
 	} else if (!smp && iucv_nonsmp_handler == 1)
-		iucv_setmask_up();
+		iucv_setmask_up(scratch);
 	INIT_LIST_HEAD(&handler->paths);
 
 	spin_lock_bh(&iucv_table_lock);
@@ -706,6 +713,7 @@ int iucv_register(struct iucv_handler *h
 	rc = 0;
 out_mutex:
 	mutex_unlock(&iucv_register_mutex);
+	free_cpumask_var(scratch);
 	return rc;
 }
 EXPORT_SYMBOL(iucv_register);

-- 
