Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 16 Jul 2016 14:18:34 +0530
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] s390/cio/chp : Remove deprecated
 create_singlethread_workqueue
Message-ID: <20160716084834.GA7728@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

The workqueue "chp_wq" is involved in performing pending
configure tasks for channel paths.

It has a single work item(&cfg_work) and hence doesn't require
ordering. Also, it is not being used on a memory reclaim path.
Hence, the singlethreaded workqueue has been replaced with the use of
system_wq.

System workqueues have been able to handle high level of concurrency
for a long time now and hence it's not required to have a singlethreaded
workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
created with create_singlethread_workqueue(), system_wq allows multiple
work items to overlap executions even on the same CPU; however, a
per-cpu workqueue doesn't have any CPU locality or global ordering
guarantee unless the target CPU is explicitly specified and thus the
increase of local concurrency shouldn't make any difference.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/s390/cio/chp.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 50597f9..92413c4 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -47,8 +47,6 @@ static DEFINE_MUTEX(info_lock);
 /* Time after which channel-path status may be outdated. */
 static unsigned long chp_info_expires;

-/* Workqueue to perform pending configure tasks. */
-static struct workqueue_struct *chp_wq;
 static struct work_struct cfg_work;

 /* Wait queue for configure completion events. */
@@ -714,7 +712,7 @@ static void cfg_func(struct work_struct *work)
 		wake_up_interruptible(&cfg_wait_queue);
 		return;
 	}
-	queue_work(chp_wq, &cfg_work);
+	schedule_work(&cfg_work);
 }

 /**
@@ -732,7 +730,7 @@ void chp_cfg_schedule(struct chp_id chpid, int configure)
 	cfg_set_task(chpid, configure ? cfg_configure : cfg_deconfigure);
 	cfg_busy = 1;
 	mutex_unlock(&cfg_lock);
-	queue_work(chp_wq, &cfg_work);
+	schedule_work(&cfg_work);
 }

 /**
@@ -766,11 +764,6 @@ static int __init chp_init(void)
 	ret = crw_register_handler(CRW_RSC_CPATH, chp_process_crw);
 	if (ret)
 		return ret;
-	chp_wq = create_singlethread_workqueue("cio_chp");
-	if (!chp_wq) {
-		crw_unregister_handler(CRW_RSC_CPATH);
-		return -ENOMEM;
-	}
 	INIT_WORK(&cfg_work, cfg_func);
 	init_waitqueue_head(&cfg_wait_queue);
 	if (info_update())
--
2.1.4
