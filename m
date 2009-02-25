Return-Path: <linux-kernel-owner+w=401wt.eu-S932279AbZBYPYj@vger.kernel.org>
Message-Id: <20090225150834.992834654@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 28/46] cio/crw: add/fix locking
Content-Disposition: inline; filename=127-cio-mutex.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The crw_unregister_handler uses xchg + synchronize_sched when
unregistering a crw_handler.
This doesn't protect crw_collect_info to potentially jump to NULL since
it has unlocked code like this:

if (crw_handlers[i])
        crw_handlers[i](NULL, NULL, 1);

So add a mutex which protects the crw handler array for changes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/crw.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/crw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/crw.c
+++ quilt-2.6/drivers/s390/cio/crw.c
@@ -9,11 +9,13 @@
  */
 
 #include <linux/semaphore.h>
+#include <linux/mutex.h>
 #include <linux/kthread.h>
 #include <linux/init.h>
 #include <asm/crw.h>
 
 static struct semaphore crw_semaphore;
+static DEFINE_MUTEX(crw_handler_mutex);
 static crw_handler_t crw_handlers[NR_RSCS];
 
 /**
@@ -25,11 +27,17 @@ static crw_handler_t crw_handlers[NR_RSC
  */
 int crw_register_handler(int rsc, crw_handler_t handler)
 {
+	int rc = 0;
+
 	if ((rsc < 0) || (rsc >= NR_RSCS))
 		return -EINVAL;
-	if (!cmpxchg(&crw_handlers[rsc], NULL, handler))
-		return 0;
-	return -EBUSY;
+	mutex_lock(&crw_handler_mutex);
+	if (crw_handlers[rsc])
+		rc = -EBUSY;
+	else
+		crw_handlers[rsc] = handler;
+	mutex_unlock(&crw_handler_mutex);
+	return rc;
 }
 
 /**
@@ -40,8 +48,9 @@ void crw_unregister_handler(int rsc)
 {
 	if ((rsc < 0) || (rsc >= NR_RSCS))
 		return;
-	xchg(&crw_handlers[rsc], NULL);
-	synchronize_sched();
+	mutex_lock(&crw_handler_mutex);
+	crw_handlers[rsc] = NULL;
+	mutex_unlock(&crw_handler_mutex);
 }
 
 /*
@@ -58,6 +67,8 @@ repeat:
 	ignore = down_interruptible(&crw_semaphore);
 	chain = 0;
 	while (1) {
+		crw_handler_t handler;
+
 		if (unlikely(chain > 1)) {
 			struct crw tmp_crw;
 
@@ -90,10 +101,12 @@ repeat:
 			int i;
 
 			pr_debug("%s: crw overflow detected!\n", __func__);
+			mutex_lock(&crw_handler_mutex);
 			for (i = 0; i < NR_RSCS; i++) {
 				if (crw_handlers[i])
 					crw_handlers[i](NULL, NULL, 1);
 			}
+			mutex_unlock(&crw_handler_mutex);
 			chain = 0;
 			continue;
 		}
@@ -101,10 +114,11 @@ repeat:
 			chain++;
 			continue;
 		}
-		if (crw_handlers[crw[chain].rsc])
-			crw_handlers[crw[chain].rsc](&crw[0],
-						     chain ? &crw[1] : NULL,
-						     0);
+		mutex_lock(&crw_handler_mutex);
+		handler = crw_handlers[crw[chain].rsc];
+		if (handler)
+			handler(&crw[0], chain ? &crw[1] : NULL, 0);
+		mutex_unlock(&crw_handler_mutex);
 		/* chain is always 0 or 1 here. */
 		chain = crw[chain].chn ? chain + 1 : 0;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
