Return-Path: <linux-kernel-owner+w=401wt.eu-S1755839AbYJAJCv@vger.kernel.org>
Message-Id: <20081001084125.504618165@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/21] qdio: speed up multicast traffic on full HiperSocket queue
Content-Disposition: inline; filename=100-qdio-perf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

If an asynchronous HiperSockets queue runs full, no further packet
can be sent. In this case the next initiative to give transmitted
skbs back to the stack is triggered only by a 10-seconds qdio timer.
This timer has been introduced for low multicast traffic scenarios
to guarantee freeing of skbs in a limited amount of time. For high
HiperSocket multicast traffic scenarios progress checking on the
outbound queue should be enforced by tasklet rescheduling.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.h      |    8 ++++++++
 drivers/s390/cio/qdio_main.c |    6 ++++++
 2 files changed, 14 insertions(+)

Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -16,6 +16,14 @@
 #define QDIO_BUSY_BIT_GIVE_UP		2000000	/* 2 seconds = eternity */
 #define QDIO_INPUT_THRESHOLD		500	/* 500 microseconds */
 
+/*
+ * if an asynchronous HiperSockets queue runs full, the 10 seconds timer wait
+ * till next initiative to give transmitted skbs back to the stack is too long.
+ * Therefore polling is started in case of multicast queue is filled more
+ * than 50 percent.
+ */
+#define QDIO_IQDIO_POLL_LVL		65	/* HS multicast queue */
+
 enum qdio_irq_states {
 	QDIO_IRQ_STATE_INACTIVE,
 	QDIO_IRQ_STATE_ESTABLISHED,
Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -851,6 +851,12 @@ static void __qdio_outbound_processing(s
 	if (queue_type(q) == QDIO_IQDIO_QFMT && !multicast_outbound(q))
 		return;
 
+	if ((queue_type(q) == QDIO_IQDIO_QFMT) &&
+	    (atomic_read(&q->nr_buf_used)) > QDIO_IQDIO_POLL_LVL) {
+		tasklet_schedule(&q->tasklet);
+		return;
+	}
+
 	if (q->u.out.pci_out_enabled)
 		return;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
