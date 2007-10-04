Return-Path: <linux-kernel-owner+w=401wt.eu-S1761679AbXJDLjv@vger.kernel.org>
Message-Id: <20071004112831.176824054@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/34] qdio: dont cast function pointers and use them to call functions.
Content-Disposition: inline; filename=024-qdio-casts.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

According to C99 6.3.2.3 it's undefined what happens if a converted
pointer is used to call a function whose type is not compatible with
the pointed-to type.
That's what the qdio code is doing, so fix it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -1024,9 +1024,9 @@ __qdio_outbound_processing(struct qdio_q
 }
 
 static void
-qdio_outbound_processing(struct qdio_q *q)
+qdio_outbound_processing(unsigned long q)
 {
-	__qdio_outbound_processing(q);
+	__qdio_outbound_processing((struct qdio_q *) q);
 }
 
 /************************* INBOUND ROUTINES *******************************/
@@ -1449,9 +1449,10 @@ out:
 }
 
 static void
-tiqdio_inbound_processing(struct qdio_q *q)
+tiqdio_inbound_processing(unsigned long q)
 {
-	__tiqdio_inbound_processing(q, atomic_read(&spare_indicator_usecount));
+	__tiqdio_inbound_processing((struct qdio_q *) q,
+				    atomic_read(&spare_indicator_usecount));
 }
 
 static void
@@ -1494,9 +1495,9 @@ again:
 }
 
 static void
-qdio_inbound_processing(struct qdio_q *q)
+qdio_inbound_processing(unsigned long q)
 {
-	__qdio_inbound_processing(q);
+	__qdio_inbound_processing((struct qdio_q *) q);
 }
 
 /************************* MAIN ROUTINES *******************************/
@@ -1760,12 +1761,15 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 		q->handler=input_handler;
 		q->dev_st_chg_ind=irq_ptr->dev_st_chg_ind;
 
-		q->tasklet.data=(unsigned long)q;
 		/* q->is_thinint_q isn't valid at this time, but
-		 * irq_ptr->is_thinint_irq is */
-		q->tasklet.func=(void(*)(unsigned long))
-			((irq_ptr->is_thinint_irq)?&tiqdio_inbound_processing:
-			 &qdio_inbound_processing);
+		 * irq_ptr->is_thinint_irq is
+		 */
+		if (irq_ptr->is_thinint_irq)
+			tasklet_init(&q->tasklet, tiqdio_inbound_processing,
+				     (unsigned long) q);
+		else
+			tasklet_init(&q->tasklet, qdio_inbound_processing,
+				     (unsigned long) q);
 
 		/* actually this is not used for inbound queues. yet. */
 		atomic_set(&q->busy_siga_counter,0);
@@ -1836,13 +1840,10 @@ qdio_fill_qs(struct qdio_irq *irq_ptr, s
 		q->last_move_ftc=0;
 		q->handler=output_handler;
 
-		q->tasklet.data=(unsigned long)q;
-		q->tasklet.func=(void(*)(unsigned long))
-			&qdio_outbound_processing;
-		q->timer.function=(void(*)(unsigned long))
-			&qdio_outbound_processing;
-		q->timer.data = (long)q;
-		init_timer(&q->timer);
+		tasklet_init(&q->tasklet, qdio_outbound_processing,
+			     (unsigned long) q);
+		setup_timer(&q->timer, qdio_outbound_processing,
+			    (unsigned long) q);
 
 		atomic_set(&q->busy_siga_counter,0);
 		q->timing.busy_start=0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
