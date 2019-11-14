Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbfKNMDD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 07:03:03 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEBwOn4057183
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:03:01 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w962es88p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 07:03:01 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 14 Nov 2019 12:02:59 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 5/8] net/smc: no WR buffer wait for terminating link group
Date: Thu, 14 Nov 2019 13:02:44 +0100
In-Reply-To: <20191114120247.68889-1-kgraul@linux.ibm.com>
References: <20191114120247.68889-1-kgraul@linux.ibm.com>
Message-Id: <20191114120247.68889-6-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Avoid waiting for a free work request buffer, if the link group
is already terminating.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c |  3 +++
 net/smc/smc_wr.c  | 10 ++++++----
 net/smc/smc_wr.h  | 10 ++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 26a18c872455..8d1b076021ed 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -656,6 +656,7 @@ void smc_llc_link_active(struct smc_link *link, int testlink_time)
 void smc_llc_link_deleting(struct smc_link *link)
 {
 	link->state = SMC_LNK_DELETING;
+	smc_wr_wakeup_tx_wait(link);
 }
 
 /* called in tasklet context */
@@ -663,6 +664,8 @@ void smc_llc_link_inactive(struct smc_link *link)
 {
 	link->state = SMC_LNK_INACTIVE;
 	cancel_delayed_work(&link->llc_testlink_wrk);
+	smc_wr_wakeup_reg_wait(link);
+	smc_wr_wakeup_tx_wait(link);
 }
 
 /* called in worker context */
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 50743dc56c86..619dd89fbac0 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -75,7 +75,7 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 			link->wr_reg_state = FAILED;
 		else
 			link->wr_reg_state = CONFIRMED;
-		wake_up(&link->wr_reg_wait);
+		smc_wr_wakeup_reg_wait(link);
 		return;
 	}
 
@@ -171,6 +171,7 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 			    struct smc_rdma_wr **wr_rdma_buf,
 			    struct smc_wr_tx_pend_priv **wr_pend_priv)
 {
+	struct smc_link_group *lgr = smc_get_lgr(link);
 	struct smc_wr_tx_pend *wr_pend;
 	u32 idx = link->wr_tx_cnt;
 	struct ib_send_wr *wr_ib;
@@ -179,19 +180,20 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
 
 	*wr_buf = NULL;
 	*wr_pend_priv = NULL;
-	if (in_softirq()) {
+	if (in_softirq() || lgr->terminating) {
 		rc = smc_wr_tx_get_free_slot_index(link, &idx);
 		if (rc)
 			return rc;
 	} else {
-		rc = wait_event_timeout(
+		rc = wait_event_interruptible_timeout(
 			link->wr_tx_wait,
 			link->state == SMC_LNK_INACTIVE ||
+			lgr->terminating ||
 			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
 			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
 		if (!rc) {
 			/* timeout - terminate connections */
-			smc_lgr_terminate_sched(smc_get_lgr(link));
+			smc_lgr_terminate_sched(lgr);
 			return -EPIPE;
 		}
 		if (idx == link->wr_tx_cnt)
diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index 09bf32fd3959..3ac99c898418 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -60,6 +60,16 @@ static inline void smc_wr_tx_set_wr_id(atomic_long_t *wr_tx_id, long val)
 	atomic_long_set(wr_tx_id, val);
 }
 
+static inline void smc_wr_wakeup_tx_wait(struct smc_link *lnk)
+{
+	wake_up_all(&lnk->wr_tx_wait);
+}
+
+static inline void smc_wr_wakeup_reg_wait(struct smc_link *lnk)
+{
+	wake_up(&lnk->wr_reg_wait);
+}
+
 /* post a new receive work request to fill a completed old work request entry */
 static inline int smc_wr_rx_post(struct smc_link *link)
 {
-- 
2.17.1
