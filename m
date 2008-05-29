Return-Path: <linux-kernel-owner+w=401wt.eu-S1755816AbYE2NBl@vger.kernel.org>
Message-Id: <20080529125729.887875614@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/11] sclp_vt220: fix scheduling while atomic bug.
Content-Disposition: inline; filename=007-sclp_vt220.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The driver incorrectly assumed that putchar will only be called from
schedulable process context and therefore blocked and waited if no
free output buffers where available.
Since putchar may also be called from BH context this may lead to
deadlocks.
To fix this just return the number of characters accepted and let the
upper layer handle the rest.

The console write function will busy wait (sclp_sync_wait) until a
buffer is available again.

Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_vt220.c |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -71,9 +71,6 @@ static struct list_head sclp_vt220_outqu
 /* Number of requests in outqueue */
 static int sclp_vt220_outqueue_count;
 
-/* Wait queue used to delay write requests while we've run out of buffers */
-static wait_queue_head_t sclp_vt220_waitq;
-
 /* Timer used for delaying write requests to merge subsequent messages into
  * a single buffer */
 static struct timer_list sclp_vt220_timer;
@@ -133,7 +130,6 @@ sclp_vt220_process_queue(struct sclp_vt2
 	} while (request && __sclp_vt220_emit(request));
 	if (request == NULL && sclp_vt220_flush_later)
 		sclp_vt220_emit_current();
-	wake_up(&sclp_vt220_waitq);
 	/* Check if the tty needs a wake up call */
 	if (sclp_vt220_tty != NULL) {
 		tty_wakeup(sclp_vt220_tty);
@@ -383,7 +379,7 @@ sclp_vt220_timeout(unsigned long data)
  */
 static int
 __sclp_vt220_write(const unsigned char *buf, int count, int do_schedule,
-		   int convertlf, int may_schedule)
+		   int convertlf, int may_fail)
 {
 	unsigned long flags;
 	void *page;
@@ -395,15 +391,14 @@ __sclp_vt220_write(const unsigned char *
 	overall_written = 0;
 	spin_lock_irqsave(&sclp_vt220_lock, flags);
 	do {
-		/* Create a sclp output buffer if none exists yet */
+		/* Create an sclp output buffer if none exists yet */
 		if (sclp_vt220_current_request == NULL) {
 			while (list_empty(&sclp_vt220_empty)) {
 				spin_unlock_irqrestore(&sclp_vt220_lock, flags);
-				if (in_interrupt() || !may_schedule)
-					sclp_sync_wait();
+				if (may_fail)
+					goto out;
 				else
-					wait_event(sclp_vt220_waitq,
-						!list_empty(&sclp_vt220_empty));
+					sclp_sync_wait();
 				spin_lock_irqsave(&sclp_vt220_lock, flags);
 			}
 			page = (void *) sclp_vt220_empty.next;
@@ -437,6 +432,7 @@ __sclp_vt220_write(const unsigned char *
 		add_timer(&sclp_vt220_timer);
 	}
 	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+out:
 	return overall_written;
 }
 
@@ -520,19 +516,11 @@ sclp_vt220_close(struct tty_struct *tty,
  * character to the tty device.  If the kernel uses this routine,
  * it must call the flush_chars() routine (if defined) when it is
  * done stuffing characters into the driver.
- *
- * NOTE: include/linux/tty_driver.h specifies that a character should be
- * ignored if there is no room in the queue. This driver implements a different
- * semantic in that it will block when there is no more room left.
- *
- * FIXME: putchar can currently be called from BH and other non blocking
- * handlers so  this semantic isn't a good idea.
  */
 static int
 sclp_vt220_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	__sclp_vt220_write(&ch, 1, 0, 0, 1);
-	return 1;
+	return __sclp_vt220_write(&ch, 1, 0, 0, 1);
 }
 
 /*
@@ -653,7 +641,6 @@ static int __init __sclp_vt220_init(void
 	spin_lock_init(&sclp_vt220_lock);
 	INIT_LIST_HEAD(&sclp_vt220_empty);
 	INIT_LIST_HEAD(&sclp_vt220_outqueue);
-	init_waitqueue_head(&sclp_vt220_waitq);
 	init_timer(&sclp_vt220_timer);
 	sclp_vt220_current_request = NULL;
 	sclp_vt220_buffered_chars = 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
