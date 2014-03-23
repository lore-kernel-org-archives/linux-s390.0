Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20140323150752.720915842@linutronix.de>
Date: Sun, 23 Mar 2014 15:09:25 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 02/16] s390: tape: Add missing destroy_timer_on_stack()
References: <20140323150557.288925975@linutronix.de>
Content-Disposition: inline; filename=s390-tape-add-missing-destroy-timer.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Otherwise we leak a tracking object when DEBUG_OBJECTS is enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: s390 <linux-s390@vger.kernel.org>
---
 drivers/s390/char/tape_std.c |    1 +
 1 file changed, 1 insertion(+)

Index: tip/drivers/s390/char/tape_std.c
===================================================================
--- tip.orig/drivers/s390/char/tape_std.c
+++ tip/drivers/s390/char/tape_std.c
@@ -79,6 +79,7 @@ tape_std_assign(struct tape_device *devi
 	rc = tape_do_io_interruptible(device, request);
 
 	del_timer_sync(&timeout);
+	destroy_timer_on_stack(&timeout);
 
 	if (rc != 0) {
 		DBF_EVENT(3, "%08x: assign failed - device might be busy\n",
