Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728467AbgBQPZH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:07 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFKO3u119350
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dnsr093-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:06 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:05 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 5/6] net/smc: simplify normal link termination
Date: Mon, 17 Feb 2020 16:24:54 +0100
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
Message-Id: <20200217152455.15341-6-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>

smc_lgr_terminate() and smc_lgr_terminate_sched() both result in soft
link termination, smc_lgr_terminate_sched() is scheduling a worker for
this task. Take out complexity by always using the termination worker
and getting rid of smc_lgr_terminate() completely.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c  | 2 +-
 net/smc/smc_core.c | 9 +++++----
 net/smc/smc_core.h | 8 +-------
 net/smc/smc_llc.c  | 2 +-
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index aee9ccfa99c2..3e16b887cfcf 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -349,7 +349,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
 		if (((struct smc_clc_msg_decline *)buf)->hdr.flag) {
 			smc->conn.lgr->sync_err = 1;
-			smc_lgr_terminate(smc->conn.lgr);
+			smc_lgr_terminate_sched(smc->conn.lgr);
 		}
 	}
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 53b6afbb1d93..1bbce5531014 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -46,6 +46,7 @@ static DECLARE_WAIT_QUEUE_HEAD(lgrs_deleted);
 
 static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
 			 struct smc_buf_desc *buf_desc);
+static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft);
 
 /* return head of link group list and its lock for a given link group */
 static inline struct list_head *smc_lgr_list_head(struct smc_link_group *lgr,
@@ -229,7 +230,7 @@ static void smc_lgr_terminate_work(struct work_struct *work)
 	struct smc_link_group *lgr = container_of(work, struct smc_link_group,
 						  terminate_work);
 
-	smc_lgr_terminate(lgr);
+	__smc_lgr_terminate(lgr, true);
 }
 
 /* create a new SMC link group */
@@ -622,8 +623,8 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		smc_lgr_free(lgr);
 }
 
-/* unlink and terminate link group */
-void smc_lgr_terminate(struct smc_link_group *lgr)
+/* unlink link group and schedule termination */
+void smc_lgr_terminate_sched(struct smc_link_group *lgr)
 {
 	spinlock_t *lgr_lock;
 
@@ -635,7 +636,7 @@ void smc_lgr_terminate(struct smc_link_group *lgr)
 	}
 	list_del_init(&lgr->list);
 	spin_unlock_bh(lgr_lock);
-	__smc_lgr_terminate(lgr, true);
+	schedule_work(&lgr->terminate_work);
 }
 
 /* Called when IB port is terminated */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 094d43c24345..5695c7bc639e 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -285,18 +285,12 @@ static inline struct smc_connection *smc_lgr_find_conn(
 	return res;
 }
 
-static inline void smc_lgr_terminate_sched(struct smc_link_group *lgr)
-{
-	if (!lgr->terminating && !lgr->freeing)
-		schedule_work(&lgr->terminate_work);
-}
-
 struct smc_sock;
 struct smc_clc_msg_accept_confirm;
 struct smc_clc_msg_local;
 
 void smc_lgr_forget(struct smc_link_group *lgr);
-void smc_lgr_terminate(struct smc_link_group *lgr);
+void smc_lgr_terminate_sched(struct smc_link_group *lgr);
 void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport);
 void smc_smcd_terminate(struct smcd_dev *dev, u64 peer_gid,
 			unsigned short vlan);
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index b134a08c929e..0e52aab53d97 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -614,7 +614,7 @@ static void smc_llc_testlink_work(struct work_struct *work)
 	rc = wait_for_completion_interruptible_timeout(&link->llc_testlink_resp,
 						       SMC_LLC_WAIT_TIME);
 	if (rc <= 0) {
-		smc_lgr_terminate(smc_get_lgr(link));
+		smc_lgr_terminate_sched(smc_get_lgr(link));
 		return;
 	}
 	next_interval = link->llc_testlink_time;
-- 
2.17.1
