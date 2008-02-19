Return-Path: <linux-kernel-owner+w=401wt.eu-S1760742AbYBSOsO@vger.kernel.org>
Message-Id: <20080219144504.632335035@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/13] qdio: fix qdio_activate timeout handling.
Content-Disposition: inline; filename=008-qdio-timeout.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Utz Bacher <utz.bacher@de.ibm.com>, Jan Glauber <jan.glauber@de.ibm.com>, Ursula Braun <braunu@de.ibm.com>, Martin Peschke <mp3@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Current code in qdio_activate waits for at least 5 seconds
until it returns. It may return earlier if an error occurs,
but not if everything is ok. This large timeout value
became visible with commit dfa77f611ff295598e218aa0eb6efa73a5cf26d0
"qdio: set QDIO_ACTIVATE_TIMEOUT to 5s", which intended to
fix the timeout value which was zero. In turn setting an
FCP adapter online took 5 seconds.

In practice waiting for 5ms before continuing is sufficient
as pointed out by Utz Bacher and Cornelia Huck.

Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Jan Glauber <jan.glauber@de.ibm.com>
Cc: Ursula Braun <braunu@de.ibm.com>
Cc: Martin Peschke <mp3@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |   10 ++--------
 drivers/s390/cio/qdio.h |    2 +-
 2 files changed, 3 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -32,7 +32,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/proc_fs.h>
@@ -3332,13 +3332,7 @@ qdio_activate(struct ccw_device *cdev, i
 		}
 	}
 
-	wait_event_interruptible_timeout(cdev->private->wait_q,
-					 ((irq_ptr->state ==
-					  QDIO_IRQ_STATE_STOPPED) ||
-					  (irq_ptr->state ==
-					   QDIO_IRQ_STATE_ERR)),
-					 QDIO_ACTIVATE_TIMEOUT);
-
+	msleep(QDIO_ACTIVATE_TIMEOUT);
 	switch (irq_ptr->state) {
 	case QDIO_IRQ_STATE_STOPPED:
 	case QDIO_IRQ_STATE_ERR:
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -57,10 +57,10 @@
 					    of the queue to 0 */
 
 #define QDIO_ESTABLISH_TIMEOUT (1*HZ)
-#define QDIO_ACTIVATE_TIMEOUT (5*HZ)
 #define QDIO_CLEANUP_CLEAR_TIMEOUT (20*HZ)
 #define QDIO_CLEANUP_HALT_TIMEOUT (10*HZ)
 #define QDIO_FORCE_CHECK_TIMEOUT (10*HZ)
+#define QDIO_ACTIVATE_TIMEOUT (5) /* 5 ms */
 
 enum qdio_irq_states {
 	QDIO_IRQ_STATE_INACTIVE,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
