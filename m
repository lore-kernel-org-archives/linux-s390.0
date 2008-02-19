Return-Path: <linux-kernel-owner+w=401wt.eu-S1758171AbYBSOqc@vger.kernel.org>
Message-Id: <20080219144503.221183779@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/13] cio: Do timed recovery on workqueue.
Content-Disposition: inline; filename=002-cio-recovery.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We can't do our recovery in softirq context, so we schedule it from
our timer function.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1535,7 +1535,7 @@ static int recovery_check(struct device 
 	return 0;
 }
 
-static void recovery_func(unsigned long data)
+static void recovery_work_func(struct work_struct *unused)
 {
 	int redo = 0;
 
@@ -1553,6 +1553,17 @@ static void recovery_func(unsigned long 
 		CIO_MSG_EVENT(2, "recovery: end\n");
 }
 
+static DECLARE_WORK(recovery_work, recovery_work_func);
+
+static void recovery_func(unsigned long data)
+{
+	/*
+	 * We can't do our recovery in softirq context and it's not
+	 * performance critical, so we schedule it.
+	 */
+	schedule_work(&recovery_work);
+}
+
 void ccw_device_schedule_recovery(void)
 {
 	unsigned long flags;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
