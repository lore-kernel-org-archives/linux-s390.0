Return-Path: <linux-kernel-owner+w=401wt.eu-S1751834AbYGaMkF@vger.kernel.org>
Message-Id: <20080731123933.615471169@de.ibm.com>
References: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/6] dont use kthread for smp_rescan_cpus().
Content-Disposition: inline; filename=105-sclp-kthread-remove.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Since git commit 3da1c84c00c7e5fa8348336bd8c342f9128b0f14
"workqueues: make get_online_cpus() useable for work->func()"
it is safe to call get_online_cpus() from workqueue context.
So remove the kthread workaround again.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_config.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_config.c
+++ quilt-2.6/drivers/s390/char/sclp_config.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/cpu.h>
-#include <linux/kthread.h>
 #include <linux/sysdev.h>
 #include <linux/workqueue.h>
 #include <asm/smp.h>
@@ -41,19 +40,9 @@ static void sclp_cpu_capability_notify(s
 	put_online_cpus();
 }
 
-static int sclp_cpu_kthread(void *data)
-{
-	smp_rescan_cpus();
-	return 0;
-}
-
 static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
-	/* Can't call smp_rescan_cpus() from  workqueue context since it may
-	 * deadlock in case of cpu hotplug. So we have to create a kernel
-	 * thread in order to call it.
-	 */
-	kthread_run(sclp_cpu_kthread, NULL, "cpu_rescan");
+	smp_rescan_cpus();
 }
 
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
