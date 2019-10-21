Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbfJUONa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 10:13:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9LEDJx9004018
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vsd0ekv05-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 21 Oct 2019 10:13:28 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Mon, 21 Oct 2019 15:13:26 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 7/8] net/smc: introduce link group termination worker
Date: Mon, 21 Oct 2019 16:13:14 +0200
In-Reply-To: <20191021141315.58969-1-kgraul@linux.ibm.com>
References: <20191021141315.58969-1-kgraul@linux.ibm.com>
Message-Id: <20191021141315.58969-8-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Use a worker for link group termination to guarantee process context.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c |  9 +++++++++
 net/smc/smc_core.h |  7 +++++++
 net/smc/smc_llc.c  |  2 +-
 net/smc/smc_wr.c   | 10 +++++-----
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 6faaa38412b1..46d4b944c4c4 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -219,6 +219,14 @@ static void smc_lgr_free_work(struct work_struct *work)
 	smc_lgr_free(lgr);
 }
 
+static void smc_lgr_terminate_work(struct work_struct *work)
+{
+	struct smc_link_group *lgr = container_of(work, struct smc_link_group,
+						  terminate_work);
+
+	smc_lgr_terminate(lgr);
+}
+
 /* create a new SMC link group */
 static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
@@ -258,6 +266,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
 	memcpy(&lgr->id, (u8 *)&smc_lgr_list.num, SMC_LGR_ID_SIZE);
 	INIT_DELAYED_WORK(&lgr->free_work, smc_lgr_free_work);
+	INIT_WORK(&lgr->terminate_work, smc_lgr_terminate_work);
 	lgr->conns_all = RB_ROOT;
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 12c2818b293f..e6fd1ed42064 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -202,6 +202,7 @@ struct smc_link_group {
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
+	struct work_struct	terminate_work;	/* abnormal lgr termination */
 	u8			sync_err : 1;	/* lgr no longer fits to peer */
 	u8			terminating : 1;/* lgr is terminating */
 	u8			freefast : 1;	/* free worker scheduled fast */
@@ -282,6 +283,12 @@ static inline struct smc_connection *smc_lgr_find_conn(
 	return res;
 }
 
+static inline void smc_lgr_terminate_sched(struct smc_link_group *lgr)
+{
+	if (!lgr->terminating)
+		schedule_work(&lgr->terminate_work);
+}
+
 struct smc_sock;
 struct smc_clc_msg_accept_confirm;
 struct smc_clc_msg_local;
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 4fd60c522802..e1918ffaf125 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -475,7 +475,7 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 			smc_llc_prep_delete_link(llc, link, SMC_LLC_RESP, true);
 		}
 		smc_llc_send_message(link, llc, sizeof(*llc));
-		smc_lgr_schedule_free_work_fast(lgr);
+		smc_lgr_terminate_sched(lgr);
 	}
 }
 
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 253aa75dc2b6..50743dc56c86 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -101,7 +101,7 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 			clear_bit(i, link->wr_tx_mask);
 		}
 		/* terminate connections of this link group abnormally */
-		smc_lgr_terminate(smc_get_lgr(link));
+		smc_lgr_terminate_sched(smc_get_lgr(link));
 	}
 	if (pnd_snd.handler)
 		pnd_snd.handler(&pnd_snd.priv, link, wc->status);
@@ -191,7 +191,7 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
 		if (!rc) {
 			/* timeout - terminate connections */
-			smc_lgr_terminate(smc_get_lgr(link));
+			smc_lgr_terminate_sched(smc_get_lgr(link));
 			return -EPIPE;
 		}
 		if (idx == link->wr_tx_cnt)
@@ -247,7 +247,7 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
 	rc = ib_post_send(link->roce_qp, &link->wr_tx_ibs[pend->idx], NULL);
 	if (rc) {
 		smc_wr_tx_put_slot(link, priv);
-		smc_lgr_terminate(smc_get_lgr(link));
+		smc_lgr_terminate_sched(smc_get_lgr(link));
 	}
 	return rc;
 }
@@ -272,7 +272,7 @@ int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 					      SMC_WR_REG_MR_WAIT_TIME);
 	if (!rc) {
 		/* timeout - terminate connections */
-		smc_lgr_terminate(smc_get_lgr(link));
+		smc_lgr_terminate_sched(smc_get_lgr(link));
 		return -EPIPE;
 	}
 	if (rc == -ERESTARTSYS)
@@ -373,7 +373,7 @@ static inline void smc_wr_rx_process_cqes(struct ib_wc wc[], int num)
 				/* terminate connections of this link group
 				 * abnormally
 				 */
-				smc_lgr_terminate(smc_get_lgr(link));
+				smc_lgr_terminate_sched(smc_get_lgr(link));
 				break;
 			default:
 				smc_wr_rx_post(link); /* refill WR RX */
-- 
2.17.1
