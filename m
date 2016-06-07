Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Jun 2016 03:29:12 +0530
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] s390/oprofile: Remove deprecated create_workqueue
Message-ID: <20160607215912.GA19722@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Robert Richter <rric@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

A dedicated workqueue has been used since the workqueue hws_wq with
workitem &cb->worker, is involved in hardware based sampling
on System z processors.

Since, these are long-running work items and aren't involved in memory
reclaim in any way, system_long_wq has been used.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 arch/s390/oprofile/hwsampler.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/s390/oprofile/hwsampler.c b/arch/s390/oprofile/hwsampler.c
index ff9b4eb..8b16bb8 100644
--- a/arch/s390/oprofile/hwsampler.c
+++ b/arch/s390/oprofile/hwsampler.c
@@ -42,7 +42,6 @@ static DEFINE_MUTEX(hws_sem_oom);
 static unsigned char hws_flush_all;
 static unsigned int hws_oom;
 static unsigned int hws_alert;
-static struct workqueue_struct *hws_wq;

 static unsigned int hws_state;
 enum {
@@ -189,8 +188,7 @@ static void hws_ext_handler(struct ext_code ext_code,
 	inc_irq_stat(IRQEXT_CMS);
 	atomic_xchg(&cb->ext_params, atomic_read(&cb->ext_params) | param32);

-	if (hws_wq)
-		queue_work(hws_wq, &cb->worker);
+		queue_work(system_long_wq, &cb->worker);
 }

 static void worker(struct work_struct *work);
@@ -566,15 +564,12 @@ int hwsampler_deactivate(unsigned int cpu)
 			} else  {
 				hws_flush_all = 1;
 				/* Add work to queue to read pending samples.*/
-				queue_work_on(cpu, hws_wq, &cb->worker);
+				queue_work_on(cpu, system_long_wq, &cb->worker);
 			}
 		}
 	}
 	mutex_unlock(&hws_sem);

-	if (hws_wq)
-		flush_workqueue(hws_wq);
-
 	return rc;
 }

@@ -740,7 +735,7 @@ static void worker_on_finish(unsigned int cpu)
 					continue;
 				if (!cb->finish) {
 					cb->finish = 1;
-					queue_work_on(i, hws_wq,
+					queue_work_on(i, system_long_wq,
 						&cb->worker);
 				}
 			}
@@ -997,9 +992,6 @@ int hwsampler_setup(void)
 		goto setup_exit;

 	rc = -EINVAL;
-	hws_wq = create_workqueue("hwsampler");
-	if (!hws_wq)
-		goto setup_exit;

 	register_cpu_notifier(&hws_cpu_notifier);

@@ -1049,9 +1041,6 @@ int hwsampler_shutdown(void)
 	if (hws_state == HWS_DEALLOCATED || hws_state == HWS_STOPPED) {
 		mutex_unlock(&hws_sem);

-		if (hws_wq)
-			flush_workqueue(hws_wq);
-
 		mutex_lock(&hws_sem);

 		if (hws_state == HWS_STOPPED) {
@@ -1059,10 +1048,6 @@ int hwsampler_shutdown(void)
 			hws_alert = 0;
 			deallocate_sdbt();
 		}
-		if (hws_wq) {
-			destroy_workqueue(hws_wq);
-			hws_wq = NULL;
-		}

 		unregister_external_irq(EXT_IRQ_MEASURE_ALERT, hws_ext_handler);
 		hws_state = HWS_INIT;
--
2.1.4
