Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728742AbgEDMTP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:15 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 05/12] net/smc: wait for departure of an IB message
Date: Mon,  4 May 2020 14:18:41 +0200
Message-Id: <20200504121848.46585-6-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Introduce smc_wr_tx_send_wait() to send an IB message and wait for the
tx completion event of the message. This makes sure that the message is
no longer in-flight when the function returns.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h |  1 +
 net/smc/smc_wr.c   | 39 +++++++++++++++++++++++++++++++++++++++
 net/smc/smc_wr.h   |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 584f11230c4f..86eebbadc8f6 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -85,6 +85,7 @@ struct smc_link {
 	struct smc_rdma_sges	*wr_tx_rdma_sges;/*RDMA WRITE gather meta data*/
 	struct smc_rdma_wr	*wr_tx_rdmas;	/* WR RDMA WRITE */
 	struct smc_wr_tx_pend	*wr_tx_pends;	/* WR send waiting for CQE */
+	struct completion	*wr_tx_compl;	/* WR send CQE completion */
 	/* above four vectors have wr_tx_cnt elements and use the same index */
 	dma_addr_t		wr_tx_dma_addr;	/* DMA address of wr_tx_bufs */
 	atomic_long_t		wr_tx_id;	/* seq # of last sent WR */
diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 3fd27bea4f7a..7239ba9b99dc 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -44,6 +44,7 @@ struct smc_wr_tx_pend {	/* control data for a pending send request */
 	struct smc_link		*link;
 	u32			idx;
 	struct smc_wr_tx_pend_priv priv;
+	u8			compl_requested;
 };
 
 /******************************** send queue *********************************/
@@ -103,6 +104,8 @@ static inline void smc_wr_tx_process_cqe(struct ib_wc *wc)
 	if (pnd_snd_idx == link->wr_tx_cnt)
 		return;
 	link->wr_tx_pends[pnd_snd_idx].wc_status = wc->status;
+	if (link->wr_tx_pends[pnd_snd_idx].compl_requested)
+		complete(&link->wr_tx_compl[pnd_snd_idx]);
 	memcpy(&pnd_snd, &link->wr_tx_pends[pnd_snd_idx], sizeof(pnd_snd));
 	/* clear the full struct smc_wr_tx_pend including .priv */
 	memset(&link->wr_tx_pends[pnd_snd_idx], 0,
@@ -275,6 +278,33 @@ int smc_wr_tx_send(struct smc_link *link, struct smc_wr_tx_pend_priv *priv)
 	return rc;
 }
 
+/* Send prepared WR slot via ib_post_send and wait for send completion
+ * notification.
+ * @priv: pointer to smc_wr_tx_pend_priv identifying prepared message buffer
+ */
+int smc_wr_tx_send_wait(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
+			unsigned long timeout)
+{
+	struct smc_wr_tx_pend *pend;
+	int rc;
+
+	pend = container_of(priv, struct smc_wr_tx_pend, priv);
+	pend->compl_requested = 1;
+	init_completion(&link->wr_tx_compl[pend->idx]);
+
+	rc = smc_wr_tx_send(link, priv);
+	if (rc)
+		return rc;
+	/* wait for completion by smc_wr_tx_process_cqe() */
+	rc = wait_for_completion_interruptible_timeout(
+					&link->wr_tx_compl[pend->idx], timeout);
+	if (rc <= 0)
+		rc = -ENODATA;
+	if (rc > 0)
+		rc = 0;
+	return rc;
+}
+
 /* Register a memory region and wait for result. */
 int smc_wr_reg_send(struct smc_link *link, struct ib_mr *mr)
 {
@@ -555,6 +585,8 @@ void smc_wr_free_link(struct smc_link *lnk)
 
 void smc_wr_free_link_mem(struct smc_link *lnk)
 {
+	kfree(lnk->wr_tx_compl);
+	lnk->wr_tx_compl = NULL;
 	kfree(lnk->wr_tx_pends);
 	lnk->wr_tx_pends = NULL;
 	kfree(lnk->wr_tx_mask);
@@ -625,8 +657,15 @@ int smc_wr_alloc_link_mem(struct smc_link *link)
 				    GFP_KERNEL);
 	if (!link->wr_tx_pends)
 		goto no_mem_wr_tx_mask;
+	link->wr_tx_compl = kcalloc(SMC_WR_BUF_CNT,
+				    sizeof(link->wr_tx_compl[0]),
+				    GFP_KERNEL);
+	if (!link->wr_tx_compl)
+		goto no_mem_wr_tx_pends;
 	return 0;
 
+no_mem_wr_tx_pends:
+	kfree(link->wr_tx_pends);
 no_mem_wr_tx_mask:
 	kfree(link->wr_tx_mask);
 no_mem_wr_rx_sges:
diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
index f7eaeb3391f3..423b8709f1c9 100644
--- a/net/smc/smc_wr.h
+++ b/net/smc/smc_wr.h
@@ -101,6 +101,8 @@ int smc_wr_tx_put_slot(struct smc_link *link,
 		       struct smc_wr_tx_pend_priv *wr_pend_priv);
 int smc_wr_tx_send(struct smc_link *link,
 		   struct smc_wr_tx_pend_priv *wr_pend_priv);
+int smc_wr_tx_send_wait(struct smc_link *link, struct smc_wr_tx_pend_priv *priv,
+			unsigned long timeout);
 void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context);
 void smc_wr_tx_dismiss_slots(struct smc_link *lnk, u8 wr_rx_hdr_type,
 			     smc_wr_tx_filter filter,
-- 
2.17.1
