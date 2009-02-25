Return-Path: <linux-kernel-owner+w=401wt.eu-S1759002AbZBYPPj@vger.kernel.org>
Message-Id: <20090225150836.857796972@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 35/46] qdio: add missing tiq_list locking
Content-Disposition: inline; filename=134-qdio-tiq-lock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Add a mutex to protect the tiq_list. Although reading the list is done
using RCU adding and removing elements from the list must still
happen locked since multiple qdio devices may change the list in parallel
otherwise.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c    |    1 +
 drivers/s390/cio/qdio_thinint.c |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -1112,6 +1112,7 @@ int qdio_shutdown(struct ccw_device *cde
 	if (!irq_ptr)
 		return -ENODEV;
 
+	BUG_ON(irqs_disabled());
 	DBF_EVENT("qshutdown:%4x", cdev->private->schid.sch_no);
 
 	mutex_lock(&irq_ptr->setup_mutex);
Index: quilt-2.6/drivers/s390/cio/qdio_thinint.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_thinint.c
+++ quilt-2.6/drivers/s390/cio/qdio_thinint.c
@@ -31,6 +31,7 @@
 
 /* list of thin interrupt input queues */
 static LIST_HEAD(tiq_list);
+DEFINE_MUTEX(tiq_list_lock);
 
 /* adapter local summary indicator */
 static unsigned char *tiqdio_alsi;
@@ -95,10 +96,10 @@ void tiqdio_add_input_queues(struct qdio
 	if (!css_qdio_omit_svs && irq_ptr->siga_flag.sync)
 		css_qdio_omit_svs = 1;
 
-	for_each_input_queue(irq_ptr, q, i) {
+	mutex_lock(&tiq_list_lock);
+	for_each_input_queue(irq_ptr, q, i)
 		list_add_rcu(&q->entry, &tiq_list);
-		synchronize_rcu();
-	}
+	mutex_unlock(&tiq_list_lock);
 	xchg(irq_ptr->dsci, 1);
 	tasklet_schedule(&tiqdio_tasklet);
 }
@@ -118,7 +119,10 @@ void tiqdio_remove_input_queues(struct q
 		/* if establish triggered an error */
 		if (!q || !q->entry.prev || !q->entry.next)
 			continue;
+
+		mutex_lock(&tiq_list_lock);
 		list_del_rcu(&q->entry);
+		mutex_unlock(&tiq_list_lock);
 		synchronize_rcu();
 	}
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
