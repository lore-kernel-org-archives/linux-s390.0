Return-Path: <linux-kernel-owner+w=401wt.eu-S1756099AbZHNL24@vger.kernel.org>
Message-Id: <20090814112613.939232047@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/34] qdio: continue polling if the queue is not finished
Content-Disposition: inline; filename=105-qdio-continue-polling.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

With commit c38f96080955854e54df9cb392bc674e1ae330e1 polling was
stopped for the queue even if new data is available.

Return immediately after scheduling the queue tasklet if the queue
is not done.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -798,8 +798,10 @@ static void __tiqdio_inbound_processing(
 
 	if (!qdio_inbound_q_done(q)) {
 		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop);
-		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED))
+		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED)) {
 			tasklet_schedule(&q->tasklet);
+			return;
+		}
 	}
 
 	qdio_stop_polling(q);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
