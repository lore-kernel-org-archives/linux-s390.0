Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727428AbgBQPZH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFJvnW075752
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dp8aq15-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:06 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:04 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 4/6] net/smc: remove unused parameter of smc_lgr_terminate()
Date: Mon, 17 Feb 2020 16:24:53 +0100
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
Message-Id: <20200217152455.15341-5-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>

The soft parameter of smc_lgr_terminate() is not used and obsolete.
Remove it.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c  |  2 +-
 net/smc/smc_core.c | 18 ++++++++----------
 net/smc/smc_core.h |  2 +-
 net/smc/smc_llc.c  |  2 +-
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 86cccc24e52e..aee9ccfa99c2 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -349,7 +349,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
 		if (((struct smc_clc_msg_decline *)buf)->hdr.flag) {
 			smc->conn.lgr->sync_err = 1;
-			smc_lgr_terminate(smc->conn.lgr, true);
+			smc_lgr_terminate(smc->conn.lgr);
 		}
 	}
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 9b92b52952dd..53b6afbb1d93 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -229,7 +229,7 @@ static void smc_lgr_terminate_work(struct work_struct *work)
 	struct smc_link_group *lgr = container_of(work, struct smc_link_group,
 						  terminate_work);
 
-	smc_lgr_terminate(lgr, true);
+	smc_lgr_terminate(lgr);
 }
 
 /* create a new SMC link group */
@@ -581,7 +581,10 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 	}
 }
 
-/* terminate link group */
+/* terminate link group
+ * @soft: true if link group shutdown can take its time
+ *	  false if immediate link group shutdown is required
+ */
 static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 {
 	struct smc_connection *conn;
@@ -619,11 +622,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		smc_lgr_free(lgr);
 }
 
-/* unlink and terminate link group
- * @soft: true if link group shutdown can take its time
- *	  false if immediate link group shutdown is required
- */
-void smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
+/* unlink and terminate link group */
+void smc_lgr_terminate(struct smc_link_group *lgr)
 {
 	spinlock_t *lgr_lock;
 
@@ -633,11 +633,9 @@ void smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		spin_unlock_bh(lgr_lock);
 		return;	/* lgr already terminating */
 	}
-	if (!soft)
-		lgr->freeing = 1;
 	list_del_init(&lgr->list);
 	spin_unlock_bh(lgr_lock);
-	__smc_lgr_terminate(lgr, soft);
+	__smc_lgr_terminate(lgr, true);
 }
 
 /* Called when IB port is terminated */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index c472e12951d1..094d43c24345 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -296,7 +296,7 @@ struct smc_clc_msg_accept_confirm;
 struct smc_clc_msg_local;
 
 void smc_lgr_forget(struct smc_link_group *lgr);
-void smc_lgr_terminate(struct smc_link_group *lgr, bool soft);
+void smc_lgr_terminate(struct smc_link_group *lgr);
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport);
 void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
 			unsigned short vlan);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index a9f6431dd69a..b134a08c929e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -614,7 +614,7 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	rc = wait_for_completion_interruptible_timeout(&link->llc_testlink_resp,
 						       SMC_LLC_WAIT_TIME);
 	if (rc <= 0) {
-		smc_lgr_terminate(smc_get_lgr(link), true);
+		smc_lgr_terminate(smc_get_lgr(link));
 		return;
 	}
 	next_interval = link->llc_testlink_time;
-- 
2.17.1
