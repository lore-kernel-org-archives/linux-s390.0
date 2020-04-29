Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16752 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbgD2PLv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 11:11:51 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 08/13] net/smc: move testlink work to system work queue
Date: Wed, 29 Apr 2020 17:10:44 +0200
Message-Id: <20200429151049.49979-9-kgraul@linux.ibm.com>
In-Reply-To: <20200429151049.49979-1-kgraul@linux.ibm.com>
References: <20200429151049.49979-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The testlink work waits for a response to the testlink request and
blocks the single threaded llc_wq. This type of work does not have to be
serialized and can be moved to the system work queue.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index c267f5006faa..69cc0d65b437 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -613,14 +613,15 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	/* receive TEST LINK response over RoCE fabric */
 	rc = wait_for_completion_interruptible_timeout(&link->llc_testlink_resp,
 						       SMC_LLC_WAIT_TIME);
+	if (link->state != SMC_LNK_ACTIVE)
+		return;		/* link state changed */
 	if (rc <= 0) {
 		smc_lgr_terminate_sched(smc_get_lgr(link));
 		return;
 	}
 	next_interval = link->llc_testlink_time;
 out:
-	queue_delayed_work(link->llc_wq, &link->llc_testlink_wrk,
-			   next_interval);
+	schedule_delayed_work(&link->llc_testlink_wrk, next_interval);
 }
 
 int smc_llc_link_init(struct smc_link *link)
@@ -648,8 +649,8 @@ void smc_llc_link_active(struct smc_link *link, int testlink_time)
 	link->state = SMC_LNK_ACTIVE;
 	if (testlink_time) {
 		link->llc_testlink_time = testlink_time * HZ;
-		queue_delayed_work(link->llc_wq, &link->llc_testlink_wrk,
-				   link->llc_testlink_time);
+		schedule_delayed_work(&link->llc_testlink_wrk,
+				      link->llc_testlink_time);
 	}
 }
 
@@ -665,7 +666,7 @@ void smc_llc_link_inactive(struct smc_link *link)
 	if (link->state == SMC_LNK_INACTIVE)
 		return;
 	link->state = SMC_LNK_INACTIVE;
-	cancel_delayed_work(&link->llc_testlink_wrk);
+	cancel_delayed_work_sync(&link->llc_testlink_wrk);
 	smc_wr_wakeup_reg_wait(link);
 	smc_wr_wakeup_tx_wait(link);
 }
-- 
2.17.1
