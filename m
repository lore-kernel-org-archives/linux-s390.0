Return-Path: <linux-kernel-owner+w=401wt.eu-S932627AbXLTPoU@vger.kernel.org>
Message-Id: <20071220152104.869227664@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/47] cio: Extend adapter interrupt interface.
Content-Disposition: inline; filename=108-cio-airq.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
From: Cornelia Huck <cornelia.huck@de.ibm.com>

Change the adapter interrupt interface in order to allow multiple
adapter interrupt handlers to be registered. Indicators are now
allocated by cio instead of the device driver.

The qdio parts have been
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/DocBook/s390-drivers.tmpl |    1 
 drivers/s390/cio/airq.c                 |  177 +++++++++++++++++++++-----------
 drivers/s390/cio/airq.h                 |   10 -
 drivers/s390/cio/cio.c                  |    2 
 drivers/s390/cio/cio.h                  |    1 
 drivers/s390/cio/qdio.c                 |   35 +++---
 include/asm-s390/airq.h                 |   19 +++
 7 files changed, 157 insertions(+), 88 deletions(-)

Index: quilt-2.6/Documentation/DocBook/s390-drivers.tmpl
===================================================================
--- quilt-2.6.orig/Documentation/DocBook/s390-drivers.tmpl
+++ quilt-2.6/Documentation/DocBook/s390-drivers.tmpl
@@ -116,6 +116,7 @@
 !Iinclude/asm-s390/ccwdev.h
 !Edrivers/s390/cio/device.c
 !Edrivers/s390/cio/device_ops.c
+!Edrivers/s390/cio/airq.c
     </sect1>
     <sect1 id="cmf">
      <title>The channel-measurement facility</title>
Index: quilt-2.6/drivers/s390/cio/airq.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/airq.c
+++ quilt-2.6/drivers/s390/cio/airq.c
@@ -1,12 +1,12 @@
 /*
  *  drivers/s390/cio/airq.c
- *   S/390 common I/O routines -- support for adapter interruptions
+ *    Support for adapter interruptions
  *
- *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
- *			      IBM Corporation
- *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *		 Cornelia Huck (cornelia.huck@de.ibm.com)
- *		 Arnd Bergmann (arndb@de.ibm.com)
+ *    Copyright IBM Corp. 1999,2007
+ *    Author(s): Ingo Adlung <adlung@de.ibm.com>
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>
+ *		 Arnd Bergmann <arndb@de.ibm.com>
+ *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
 #include <linux/init.h>
@@ -14,72 +14,131 @@
 #include <linux/slab.h>
 #include <linux/rcupdate.h>
 
-#include "cio_debug.h"
-#include "airq.h"
-
-static adapter_int_handler_t adapter_handler;
+#include <asm/airq.h>
 
-/*
- * register for adapter interrupts
- *
- * With HiperSockets the zSeries architecture provides for
- *  means of adapter interrups, pseudo I/O interrupts that are
- *  not tied to an I/O subchannel, but to an adapter. However,
- *  it doesn't disclose the info how to enable/disable them, but
- *  to recognize them only. Perhaps we should consider them
- *  being shared interrupts, and thus build a linked list
- *  of adapter handlers ... to be evaluated ...
- */
-int
-s390_register_adapter_interrupt (adapter_int_handler_t handler)
-{
-	int ret;
-	char dbf_txt[15];
+#include "cio.h"
+#include "cio_debug.h"
 
-	CIO_TRACE_EVENT (4, "rgaint");
+#define NR_AIRQS		32
+#define NR_AIRQS_PER_WORD	sizeof(unsigned long)
+#define NR_AIRQ_WORDS		(NR_AIRQS / NR_AIRQS_PER_WORD)
+
+union indicator_t {
+	unsigned long word[NR_AIRQ_WORDS];
+	unsigned char byte[NR_AIRQS];
+} __attribute__((packed));
+
+struct airq_t {
+	adapter_int_handler_t handler;
+	void *drv_data;
+};
 
-	if (handler == NULL)
-		ret = -EINVAL;
-	else
-		ret = (cmpxchg(&adapter_handler, NULL, handler) ? -EBUSY : 0);
-	if (!ret)
-		synchronize_sched();  /* Allow interrupts to complete. */
+static union indicator_t indicators;
+static struct airq_t *airqs[NR_AIRQS];
 
-	sprintf (dbf_txt, "ret:%d", ret);
-	CIO_TRACE_EVENT (4, dbf_txt);
+static int register_airq(struct airq_t *airq)
+{
+	int i;
 
-	return ret;
+	for (i = 0; i < NR_AIRQS; i++)
+		if (!cmpxchg(&airqs[i], NULL, airq))
+			return i;
+	return -ENOMEM;
 }
 
-int
-s390_unregister_adapter_interrupt (adapter_int_handler_t handler)
+/**
+ * s390_register_adapter_interrupt() - register adapter interrupt handler
+ * @handler: adapter handler to be registered
+ * @drv_data: driver data passed with each call to the handler
+ *
+ * Returns:
+ *  Pointer to the indicator to be used on success
+ *  ERR_PTR() if registration failed
+ */
+void *s390_register_adapter_interrupt(adapter_int_handler_t handler,
+				      void *drv_data)
 {
+	struct airq_t *airq;
+	char dbf_txt[16];
 	int ret;
-	char dbf_txt[15];
-
-	CIO_TRACE_EVENT (4, "urgaint");
 
-	if (handler == NULL)
-		ret = -EINVAL;
-	else {
-		adapter_handler = NULL;
-		synchronize_sched();  /* Allow interrupts to complete. */
-		ret = 0;
+	airq = kmalloc(sizeof(struct airq_t), GFP_KERNEL);
+	if (!airq) {
+		ret = -ENOMEM;
+		goto out;
 	}
-	sprintf (dbf_txt, "ret:%d", ret);
-	CIO_TRACE_EVENT (4, dbf_txt);
-
-	return ret;
+	airq->handler = handler;
+	airq->drv_data = drv_data;
+	ret = register_airq(airq);
+	if (ret < 0)
+		kfree(airq);
+out:
+	snprintf(dbf_txt, sizeof(dbf_txt), "rairq:%d", ret);
+	CIO_TRACE_EVENT(4, dbf_txt);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	else
+		return &indicators.byte[ret];
 }
+EXPORT_SYMBOL(s390_register_adapter_interrupt);
 
-void
-do_adapter_IO (void)
+/**
+ * s390_unregister_adapter_interrupt - unregister adapter interrupt handler
+ * @ind: indicator for which the handler is to be unregistered
+ */
+void s390_unregister_adapter_interrupt(void *ind)
 {
-	CIO_TRACE_EVENT (6, "doaio");
-
-	if (adapter_handler)
-		(*adapter_handler) ();
+	struct airq_t *airq;
+	char dbf_txt[16];
+	int i;
+
+	i = (int) ((addr_t) ind) - ((addr_t) &indicators.byte[0]);
+	snprintf(dbf_txt, sizeof(dbf_txt), "urairq:%d", i);
+	CIO_TRACE_EVENT(4, dbf_txt);
+	indicators.byte[i] = 0;
+	airq = xchg(&airqs[i], NULL);
+	/*
+	 * Allow interrupts to complete. This will ensure that the airq handle
+	 * is no longer referenced by any interrupt handler.
+	 */
+	synchronize_sched();
+	kfree(airq);
 }
+EXPORT_SYMBOL(s390_unregister_adapter_interrupt);
+
+#define INDICATOR_MASK	(0xffUL << ((NR_AIRQS_PER_WORD - 1) * 8))
 
-EXPORT_SYMBOL (s390_register_adapter_interrupt);
-EXPORT_SYMBOL (s390_unregister_adapter_interrupt);
+void do_adapter_IO(void)
+{
+	int w;
+	int i;
+	unsigned long word;
+	struct airq_t *airq;
+
+	/*
+	 * Access indicator array in word-sized chunks to minimize storage
+	 * fetch operations.
+	 */
+	for (w = 0; w < NR_AIRQ_WORDS; w++) {
+		word = indicators.word[w];
+		i = w * NR_AIRQS_PER_WORD;
+		/*
+		 * Check bytes within word for active indicators.
+		 */
+		while (word) {
+			if (word & INDICATOR_MASK) {
+				airq = airqs[i];
+				if (likely(airq))
+					airq->handler(&indicators.byte[i],
+						      airq->drv_data);
+				else
+					/*
+					 * Reset ill-behaved indicator.
+					 */
+					indicators.byte[i] = 0;
+			}
+			word <<= 8;
+			i++;
+		}
+	}
+}
Index: quilt-2.6/drivers/s390/cio/airq.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/airq.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef S390_AINTERRUPT_H
-#define S390_AINTERRUPT_H
-
-typedef	int (*adapter_int_handler_t)(void);
-
-extern int s390_register_adapter_interrupt(adapter_int_handler_t handler);
-extern int s390_unregister_adapter_interrupt(adapter_int_handler_t handler);
-extern void do_adapter_IO (void);
-
-#endif
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -23,7 +23,7 @@
 #include <asm/reset.h>
 #include <asm/ipl.h>
 #include <asm/chpid.h>
-#include "airq.h"
+#include <asm/airq.h>
 #include "cio.h"
 #include "css.h"
 #include "chsc.h"
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -99,6 +99,7 @@ extern int cio_get_options (struct subch
 extern int cio_modify (struct subchannel *);
 
 int cio_create_sch_lock(struct subchannel *);
+void do_adapter_IO(void);
 
 /* Use with care. */
 #ifdef CONFIG_CCW_CONSOLE
Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -48,11 +48,11 @@
 #include <asm/debug.h>
 #include <asm/s390_rdev.h>
 #include <asm/qdio.h>
+#include <asm/airq.h>
 
 #include "cio.h"
 #include "css.h"
 #include "device.h"
-#include "airq.h"
 #include "qdio.h"
 #include "ioasm.h"
 #include "chsc.h"
@@ -96,7 +96,7 @@ static debug_info_t *qdio_dbf_slsb_in;
 static volatile struct qdio_q *tiq_list=NULL; /* volatile as it could change
 						 during a while loop */
 static DEFINE_SPINLOCK(ttiq_list_lock);
-static int register_thinint_result;
+static void *tiqdio_ind;
 static void tiqdio_tl(unsigned long);
 static DECLARE_TASKLET(tiqdio_tasklet,tiqdio_tl,0);
 
@@ -399,7 +399,7 @@ qdio_get_indicator(void)
 {
 	int i;
 
-	for (i=1;i<INDICATORS_PER_CACHELINE;i++)
+	for (i = 0; i < INDICATORS_PER_CACHELINE; i++)
 		if (!indicator_used[i]) {
 			indicator_used[i]=1;
 			return indicators+i;
@@ -1911,8 +1911,7 @@ qdio_fill_thresholds(struct qdio_irq *ir
 	}
 }
 
-static int
-tiqdio_thinint_handler(void)
+static void tiqdio_thinint_handler(void *ind, void *drv_data)
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
@@ -1925,7 +1924,6 @@ tiqdio_thinint_handler(void)
 		tiqdio_clear_global_summary();
 
 	tiqdio_inbound_checks();
-	return 0;
 }
 
 static void
@@ -2445,7 +2443,7 @@ tiqdio_set_subchannel_ind(struct qdio_ir
 		real_addr_dev_st_chg_ind=0;
 	} else {
 		real_addr_local_summary_bit=
-			virt_to_phys((volatile void *)indicators);
+			virt_to_phys((volatile void *)tiqdio_ind);
 		real_addr_dev_st_chg_ind=
 			virt_to_phys((volatile void *)irq_ptr->dev_st_chg_ind);
 	}
@@ -3740,23 +3738,25 @@ static void
 tiqdio_register_thinints(void)
 {
 	char dbf_text[20];
-	register_thinint_result=
-		s390_register_adapter_interrupt(&tiqdio_thinint_handler);
-	if (register_thinint_result) {
-		sprintf(dbf_text,"regthn%x",(register_thinint_result&0xff));
+
+	tiqdio_ind =
+		s390_register_adapter_interrupt(&tiqdio_thinint_handler, NULL);
+	if (IS_ERR(tiqdio_ind)) {
+		sprintf(dbf_text, "regthn%lx", PTR_ERR(tiqdio_ind));
 		QDIO_DBF_TEXT0(0,setup,dbf_text);
 		QDIO_PRINT_ERR("failed to register adapter handler " \
-			       "(rc=%i).\nAdapter interrupts might " \
+			       "(rc=%li).\nAdapter interrupts might " \
 			       "not work. Continuing.\n",
-			       register_thinint_result);
+			       PTR_ERR(tiqdio_ind));
+		tiqdio_ind = NULL;
 	}
 }
 
 static void
 tiqdio_unregister_thinints(void)
 {
-	if (!register_thinint_result)
-		s390_unregister_adapter_interrupt(&tiqdio_thinint_handler);
+	if (tiqdio_ind)
+		s390_unregister_adapter_interrupt(tiqdio_ind);
 }
 
 static int
@@ -3768,8 +3768,8 @@ qdio_get_qdio_memory(void)
 	for (i=1;i<INDICATORS_PER_CACHELINE;i++)
 		indicator_used[i]=0;
 	indicators = kzalloc(sizeof(__u32)*(INDICATORS_PER_CACHELINE),
-				   GFP_KERNEL);
-       	if (!indicators)
+			     GFP_KERNEL);
+	if (!indicators)
 		return -ENOMEM;
 	return 0;
 }
@@ -3780,7 +3780,6 @@ qdio_release_qdio_memory(void)
 	kfree(indicators);
 }
 
-
 static void
 qdio_unregister_dbf_views(void)
 {
Index: quilt-2.6/include/asm-s390/airq.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/airq.h
@@ -0,0 +1,19 @@
+/*
+ *  include/asm-s390/airq.h
+ *
+ *    Copyright IBM Corp. 2002,2007
+ *    Author(s): Ingo Adlung <adlung@de.ibm.com>
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>
+ *		 Arnd Bergmann <arndb@de.ibm.com>
+ *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_AIRQ_H
+#define _ASM_S390_AIRQ_H
+
+typedef void (*adapter_int_handler_t)(void *, void *);
+
+void *s390_register_adapter_interrupt(adapter_int_handler_t, void *);
+void s390_unregister_adapter_interrupt(void *);
+
+#endif /* _ASM_S390_AIRQ_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
