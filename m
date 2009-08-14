Return-Path: <linux-kernel-owner+w=401wt.eu-S1755902AbZHNLb0@vger.kernel.org>
Message-Id: <20090814112617.470784614@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/34] tape: use init_timer_on_stack() rather than init_timer()
Content-Disposition: inline; filename=120-tape-timer-on-stack.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

With CONFIG_DEBUG_OBJECTS_TIMERS=y "chccwdev --online" for a tape device
will fail with message "ODEBUG: object is on stack, but not annotated".
We now use init_timer_on_stack.

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape_std.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/char/tape_std.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_std.c
+++ quilt-2.6/drivers/s390/char/tape_std.c
@@ -68,7 +68,7 @@ tape_std_assign(struct tape_device *devi
 	 * to another host (actually this shouldn't happen but it does).
 	 * So we set up a timeout for this call.
 	 */
-	init_timer(&timeout);
+	init_timer_on_stack(&timeout);
 	timeout.function = tape_std_assign_timeout;
 	timeout.data     = (unsigned long) request;
 	timeout.expires  = jiffies + 2 * HZ;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
