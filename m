Return-Path: <linux-kernel-owner+w=401wt.eu-S1759303AbZFDQYs@vger.kernel.org>
Message-Id: <20090604161906.308867517@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 28/38] pm: iucv power management callbacks.
Content-Disposition: inline; filename=pm_iucv.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Patch calls the PM callback functions of iucv-bus devices, which are
responsible for removal of their established iucv pathes.

The PM freeze callback for the first iucv-bus device disables all iucv 
interrupts except the connection severed interrupt.
The PM freeze callback for the last iucv-bus device shuts down iucv.

The PM thaw callback for the first iucv-bus device re-enables iucv
if it has been shut down during freeze. If freezing has been interrupted,
it re-enables iucv interrupts according to the needs of iucv-exploiters.

The PM restore callback for the first iucv-bus device re-enables iucv.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 net/iucv/iucv.c |  179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

Index: linux-2.6/net/iucv/iucv.c
===================================================================
--- linux-2.6.orig/net/iucv/iucv.c
+++ linux-2.6/net/iucv/iucv.c
@@ -11,6 +11,8 @@
  *	Fritz Elfert (elfert@de.ibm.com, felfert@millenux.com)
  *    Rewritten for af_iucv:
  *	Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *    PM functions:
+ *	Ursula Braun (ursula.braun@de.ibm.com)
  *
  * Documentation used:
  *    The original source
@@ -77,9 +79,24 @@ static int iucv_bus_match(struct device 
 	return 0;
 }
 
+static int iucv_pm_prepare(struct device *);
+static void iucv_pm_complete(struct device *);
+static int iucv_pm_freeze(struct device *);
+static int iucv_pm_thaw(struct device *);
+static int iucv_pm_restore(struct device *);
+
+static struct dev_pm_ops iucv_pm_ops = {
+	.prepare = iucv_pm_prepare,
+	.complete = iucv_pm_complete,
+	.freeze = iucv_pm_freeze,
+	.thaw = iucv_pm_thaw,
+	.restore = iucv_pm_restore,
+};
+
 struct bus_type iucv_bus = {
 	.name = "iucv",
 	.match = iucv_bus_match,
+	.pm = &iucv_pm_ops,
 };
 EXPORT_SYMBOL(iucv_bus);
 
@@ -149,6 +166,7 @@ enum iucv_command_codes {
 	IUCV_RESUME = 14,
 	IUCV_SEVER = 15,
 	IUCV_SETMASK = 16,
+	IUCV_SETCONTROLMASK = 17,
 };
 
 /*
@@ -366,6 +384,18 @@ static void iucv_allow_cpu(void *data)
 	parm->set_mask.ipmask = 0xf8;
 	iucv_call_b2f0(IUCV_SETMASK, parm);
 
+	/*
+	 * Enable all iucv control interrupts.
+	 * ipmask contains bits for the different interrupts
+	 *	0x80 - Flag to allow pending connections interrupts
+	 *	0x40 - Flag to allow connection complete interrupts
+	 *	0x20 - Flag to allow connection severed interrupts
+	 *	0x10 - Flag to allow connection quiesced interrupts
+	 *	0x08 - Flag to allow connection resumed interrupts
+	 */
+	memset(parm, 0, sizeof(union iucv_param));
+	parm->set_mask.ipmask = 0xf8;
+	iucv_call_b2f0(IUCV_SETCONTROLMASK, parm);
 	/* Set indication that iucv interrupts are allowed for this cpu. */
 	cpu_set(cpu, iucv_irq_cpumask);
 }
@@ -391,6 +421,31 @@ static void iucv_block_cpu(void *data)
 }
 
 /**
+ * iucv_block_cpu_almost
+ * @data: unused
+ *
+ * Allow connection-severed interrupts only on this cpu.
+ */
+static void iucv_block_cpu_almost(void *data)
+{
+	int cpu = smp_processor_id();
+	union iucv_param *parm;
+
+	/* Allow iucv control interrupts only */
+	parm = iucv_param_irq[cpu];
+	memset(parm, 0, sizeof(union iucv_param));
+	parm->set_mask.ipmask = 0x08;
+	iucv_call_b2f0(IUCV_SETMASK, parm);
+	/* Allow iucv-severed interrupt only */
+	memset(parm, 0, sizeof(union iucv_param));
+	parm->set_mask.ipmask = 0x20;
+	iucv_call_b2f0(IUCV_SETCONTROLMASK, parm);
+
+	/* Clear indication that iucv interrupts are allowed for this cpu. */
+	cpu_clear(cpu, iucv_irq_cpumask);
+}
+
+/**
  * iucv_declare_cpu
  * @data: unused
  *
@@ -1764,6 +1819,130 @@ static void iucv_external_interrupt(u16 
 	spin_unlock(&iucv_queue_lock);
 }
 
+static int iucv_pm_prepare(struct device *dev)
+{
+	int rc = 0;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_INFO "iucv_pm_prepare\n");
+#endif
+	if (dev->driver && dev->driver->pm && dev->driver->pm->prepare)
+		rc = dev->driver->pm->prepare(dev);
+	return rc;
+}
+
+static void iucv_pm_complete(struct device *dev)
+{
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_INFO "iucv_pm_complete\n");
+#endif
+	if (dev->driver && dev->driver->pm && dev->driver->pm->complete)
+		dev->driver->pm->complete(dev);
+}
+
+/**
+ * iucv_path_table_empty() - determine if iucv path table is empty
+ *
+ * Returns 0 if there are still iucv pathes defined
+ *         1 if there are no iucv pathes defined
+ */
+int iucv_path_table_empty(void)
+{
+	int i;
+
+	for (i = 0; i < iucv_max_pathid; i++) {
+		if (iucv_path_table[i])
+			return 0;
+	}
+	return 1;
+}
+
+/**
+ * iucv_pm_freeze() - Freeze PM callback
+ * @dev:	iucv-based device
+ *
+ * disable iucv interrupts
+ * invoke callback function of the iucv-based driver
+ * shut down iucv, if no iucv-pathes are established anymore
+ */
+static int iucv_pm_freeze(struct device *dev)
+{
+	int cpu;
+	int rc = 0;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "iucv_pm_freeze\n");
+#endif
+	for_each_cpu_mask_nr(cpu, iucv_irq_cpumask)
+		smp_call_function_single(cpu, iucv_block_cpu_almost, NULL, 1);
+	if (dev->driver && dev->driver->pm && dev->driver->pm->freeze)
+		rc = dev->driver->pm->freeze(dev);
+	if (iucv_path_table_empty())
+		iucv_disable();
+	return rc;
+}
+
+/**
+ * iucv_pm_thaw() - Thaw PM callback
+ * @dev:	iucv-based device
+ *
+ * make iucv ready for use again: allocate path table, declare interrupt buffers
+ *				  and enable iucv interrupts
+ * invoke callback function of the iucv-based driver
+ */
+static int iucv_pm_thaw(struct device *dev)
+{
+	int rc = 0;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "iucv_pm_thaw\n");
+#endif
+	if (!iucv_path_table) {
+		rc = iucv_enable();
+		if (rc)
+			goto out;
+	}
+	if (cpus_empty(iucv_irq_cpumask)) {
+		if (iucv_nonsmp_handler)
+			/* enable interrupts on one cpu */
+			iucv_allow_cpu(NULL);
+		else
+			/* enable interrupts on all cpus */
+			iucv_setmask_mp();
+	}
+	if (dev->driver && dev->driver->pm && dev->driver->pm->thaw)
+		rc = dev->driver->pm->thaw(dev);
+out:
+	return rc;
+}
+
+/**
+ * iucv_pm_restore() - Restore PM callback
+ * @dev:	iucv-based device
+ *
+ * make iucv ready for use again: allocate path table, declare interrupt buffers
+ *				  and enable iucv interrupts
+ * invoke callback function of the iucv-based driver
+ */
+static int iucv_pm_restore(struct device *dev)
+{
+	int rc = 0;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "iucv_pm_restore %p\n", iucv_path_table);
+#endif
+	if (cpus_empty(iucv_irq_cpumask)) {
+		rc = iucv_query_maxconn();
+		rc = iucv_enable();
+		if (rc)
+			goto out;
+	}
+	if (dev->driver && dev->driver->pm && dev->driver->pm->restore)
+		rc = dev->driver->pm->restore(dev);
+out:
+	return rc;
+}
+
 /**
  * iucv_init
  *

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
