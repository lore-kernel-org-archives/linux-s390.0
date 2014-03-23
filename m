Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20140323150752.607059123@linutronix.de>
Date: Sun, 23 Mar 2014 15:09:24 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 01/16] s390: tape: Use del_timer_sync()
References: <20140323150557.288925975@linutronix.de>
Content-Disposition: inline; filename=s390-tape-use-del-timer-sync.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

del_timer() does not wait for a possible running callback to
complete. So the call side might free request and the associated
objects while on another cpu the timer handler runs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: s390 <linux-s390@vger.kernel.org>
---
 drivers/s390/char/tape_std.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/drivers/s390/char/tape_std.c
===================================================================
--- tip.orig/drivers/s390/char/tape_std.c
+++ tip/drivers/s390/char/tape_std.c
@@ -78,7 +78,7 @@ tape_std_assign(struct tape_device *devi
 
 	rc = tape_do_io_interruptible(device, request);
 
-	del_timer(&timeout);
+	del_timer_sync(&timeout);
 
 	if (rc != 0) {
 		DBF_EVENT(3, "%08x: assign failed - device might be busy\n",
