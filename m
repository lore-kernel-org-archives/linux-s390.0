Return-Path: <linux-kernel-owner+w=401wt.eu-S1758693AbYGAMxf@vger.kernel.org>
Message-Id: <20080701124958.040845762@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/14] cio: Allow adapter interrupt handlers per isc.
Content-Disposition: inline; filename=122-cio-airq-isc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Enhance the adapter interruption API so that device drivers can
register a handler for a specific interruption subclass. This
will allow different device drivers to move to differently
prioritized subclasses in order to avoid congestion.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/airq.c |   45 +++++++++++++++++++++++++--------------------
 drivers/s390/cio/cio.c  |    2 +-
 drivers/s390/cio/cio.h  |    2 +-
 drivers/s390/cio/qdio.c |    6 ++++--
 include/asm-s390/airq.h |    4 ++--
 5 files changed, 33 insertions(+), 26 deletions(-)

Index: quilt-2.6/drivers/s390/cio/airq.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/airq.c
+++ quilt-2.6/drivers/s390/cio/airq.c
@@ -15,6 +15,7 @@
 #include <linux/rcupdate.h>
 
 #include <asm/airq.h>
+#include <asm/isc.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -33,15 +34,15 @@ struct airq_t {
 	void *drv_data;
 };
 
-static union indicator_t indicators;
-static struct airq_t *airqs[NR_AIRQS];
+static union indicator_t indicators[MAX_ISC];
+static struct airq_t *airqs[MAX_ISC][NR_AIRQS];
 
-static int register_airq(struct airq_t *airq)
+static int register_airq(struct airq_t *airq, u8 isc)
 {
 	int i;
 
 	for (i = 0; i < NR_AIRQS; i++)
-		if (!cmpxchg(&airqs[i], NULL, airq))
+		if (!cmpxchg(&airqs[isc][i], NULL, airq))
 			return i;
 	return -ENOMEM;
 }
@@ -50,18 +51,21 @@ static int register_airq(struct airq_t *
  * s390_register_adapter_interrupt() - register adapter interrupt handler
  * @handler: adapter handler to be registered
  * @drv_data: driver data passed with each call to the handler
+ * @isc: isc for which the handler should be called
  *
  * Returns:
  *  Pointer to the indicator to be used on success
  *  ERR_PTR() if registration failed
  */
 void *s390_register_adapter_interrupt(adapter_int_handler_t handler,
-				      void *drv_data)
+				      void *drv_data, u8 isc)
 {
 	struct airq_t *airq;
 	char dbf_txt[16];
 	int ret;
 
+	if (isc > MAX_ISC)
+		return ERR_PTR(-EINVAL);
 	airq = kmalloc(sizeof(struct airq_t), GFP_KERNEL);
 	if (!airq) {
 		ret = -ENOMEM;
@@ -69,34 +73,35 @@ void *s390_register_adapter_interrupt(ad
 	}
 	airq->handler = handler;
 	airq->drv_data = drv_data;
-	ret = register_airq(airq);
-	if (ret < 0)
-		kfree(airq);
+
+	ret = register_airq(airq, isc);
 out:
 	snprintf(dbf_txt, sizeof(dbf_txt), "rairq:%d", ret);
 	CIO_TRACE_EVENT(4, dbf_txt);
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(airq);
 		return ERR_PTR(ret);
-	else
-		return &indicators.byte[ret];
+	} else
+		return &indicators[isc].byte[ret];
 }
 EXPORT_SYMBOL(s390_register_adapter_interrupt);
 
 /**
  * s390_unregister_adapter_interrupt - unregister adapter interrupt handler
  * @ind: indicator for which the handler is to be unregistered
+ * @isc: interruption subclass
  */
-void s390_unregister_adapter_interrupt(void *ind)
+void s390_unregister_adapter_interrupt(void *ind, u8 isc)
 {
 	struct airq_t *airq;
 	char dbf_txt[16];
 	int i;
 
-	i = (int) ((addr_t) ind) - ((addr_t) &indicators.byte[0]);
+	i = (int) ((addr_t) ind) - ((addr_t) &indicators[isc].byte[0]);
 	snprintf(dbf_txt, sizeof(dbf_txt), "urairq:%d", i);
 	CIO_TRACE_EVENT(4, dbf_txt);
-	indicators.byte[i] = 0;
-	airq = xchg(&airqs[i], NULL);
+	indicators[isc].byte[i] = 0;
+	airq = xchg(&airqs[isc][i], NULL);
 	/*
 	 * Allow interrupts to complete. This will ensure that the airq handle
 	 * is no longer referenced by any interrupt handler.
@@ -108,7 +113,7 @@ EXPORT_SYMBOL(s390_unregister_adapter_in
 
 #define INDICATOR_MASK	(0xffUL << ((NR_AIRQS_PER_WORD - 1) * 8))
 
-void do_adapter_IO(void)
+void do_adapter_IO(u8 isc)
 {
 	int w;
 	int i;
@@ -120,22 +125,22 @@ void do_adapter_IO(void)
 	 * fetch operations.
 	 */
 	for (w = 0; w < NR_AIRQ_WORDS; w++) {
-		word = indicators.word[w];
+		word = indicators[isc].word[w];
 		i = w * NR_AIRQS_PER_WORD;
 		/*
 		 * Check bytes within word for active indicators.
 		 */
 		while (word) {
 			if (word & INDICATOR_MASK) {
-				airq = airqs[i];
+				airq = airqs[isc][i];
 				if (likely(airq))
-					airq->handler(&indicators.byte[i],
+					airq->handler(&indicators[isc].byte[i],
 						      airq->drv_data);
 				else
 					/*
 					 * Reset ill-behaved indicator.
 					 */
-					indicators.byte[i] = 0;
+					indicators[isc].byte[i] = 0;
 			}
 			word <<= 8;
 			i++;
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -641,7 +641,7 @@ do_IRQ (struct pt_regs *regs)
 		 */
 		if (tpi_info->adapter_IO == 1 &&
 		    tpi_info->int_type == IO_INTERRUPT_TYPE) {
-			do_adapter_IO();
+			do_adapter_IO(tpi_info->isc);
 			continue;
 		}
 		sch = (struct subchannel *)(unsigned long)tpi_info->intparm;
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -106,7 +106,7 @@ int cio_tm_start_key(struct subchannel *
 int cio_tm_intrg(struct subchannel *sch);
 
 int cio_create_sch_lock(struct subchannel *);
-void do_adapter_IO(void);
+void do_adapter_IO(u8 isc);
 void do_IRQ(struct pt_regs *);
 
 /* Use with care. */
Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -3713,7 +3713,8 @@ tiqdio_register_thinints(void)
 	char dbf_text[20];
 
 	tiqdio_ind =
-		s390_register_adapter_interrupt(&tiqdio_thinint_handler, NULL);
+		s390_register_adapter_interrupt(&tiqdio_thinint_handler, NULL,
+						TIQDIO_THININT_ISC);
 	if (IS_ERR(tiqdio_ind)) {
 		sprintf(dbf_text, "regthn%lx", PTR_ERR(tiqdio_ind));
 		QDIO_DBF_TEXT0(0,setup,dbf_text);
@@ -3729,7 +3730,8 @@ static void
 tiqdio_unregister_thinints(void)
 {
 	if (tiqdio_ind)
-		s390_unregister_adapter_interrupt(tiqdio_ind);
+		s390_unregister_adapter_interrupt(tiqdio_ind,
+						  TIQDIO_THININT_ISC);
 }
 
 static int
Index: quilt-2.6/include/asm-s390/airq.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/airq.h
+++ quilt-2.6/include/asm-s390/airq.h
@@ -13,7 +13,7 @@
 
 typedef void (*adapter_int_handler_t)(void *, void *);
 
-void *s390_register_adapter_interrupt(adapter_int_handler_t, void *);
-void s390_unregister_adapter_interrupt(void *);
+void *s390_register_adapter_interrupt(adapter_int_handler_t, void *, u8);
+void s390_unregister_adapter_interrupt(void *, u8);
 
 #endif /* _ASM_S390_AIRQ_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
