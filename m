Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57102 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728608AbgEAKsa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:30 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 02/13] net/smc: unmapping of buffers to support multiple links
Date: Fri,  1 May 2020 12:48:02 +0200
Message-Id: <20200501104813.76601-3-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

With the support of multiple links that are created and cleared there
is a need to unmap one link from all current buffers. Add unmapping by
link and by rmb. And make smcr_link_clear() available to be called from
the LLC layer.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 76 +++++++++++++++++++++++++++++++++++-----------
 net/smc/smc_core.h |  1 +
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index de6bc36fe9a7..d5ecea490b4e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -498,14 +498,69 @@ void smc_conn_free(struct smc_connection *conn)
 		smc_lgr_schedule_free_work(lgr);
 }
 
-static void smcr_link_clear(struct smc_link *lnk)
+/* unregister a link from a buf_desc */
+static void smcr_buf_unmap_link(struct smc_buf_desc *buf_desc, bool is_rmb,
+				struct smc_link *lnk)
+{
+	if (is_rmb)
+		buf_desc->is_reg_mr[lnk->link_idx] = false;
+	if (!buf_desc->is_map_ib[lnk->link_idx])
+		return;
+	if (is_rmb) {
+		if (buf_desc->mr_rx[lnk->link_idx]) {
+			smc_ib_put_memory_region(
+					buf_desc->mr_rx[lnk->link_idx]);
+			buf_desc->mr_rx[lnk->link_idx] = NULL;
+		}
+		smc_ib_buf_unmap_sg(lnk, buf_desc, DMA_FROM_DEVICE);
+	} else {
+		smc_ib_buf_unmap_sg(lnk, buf_desc, DMA_TO_DEVICE);
+	}
+	sg_free_table(&buf_desc->sgt[lnk->link_idx]);
+	buf_desc->is_map_ib[lnk->link_idx] = false;
+}
+
+/* unmap all buffers of lgr for a deleted link */
+static void smcr_buf_unmap_lgr(struct smc_link *lnk)
+{
+	struct smc_link_group *lgr = lnk->lgr;
+	struct smc_buf_desc *buf_desc, *bf;
+	int i;
+
+	for (i = 0; i < SMC_RMBE_SIZES; i++) {
+		mutex_lock(&lgr->rmbs_lock);
+		list_for_each_entry_safe(buf_desc, bf, &lgr->rmbs[i], list)
+			smcr_buf_unmap_link(buf_desc, true, lnk);
+		mutex_unlock(&lgr->rmbs_lock);
+		mutex_lock(&lgr->sndbufs_lock);
+		list_for_each_entry_safe(buf_desc, bf, &lgr->sndbufs[i],
+					 list)
+			smcr_buf_unmap_link(buf_desc, false, lnk);
+		mutex_unlock(&lgr->sndbufs_lock);
+	}
+}
+
+static void smcr_rtoken_clear_link(struct smc_link *lnk)
+{
+	struct smc_link_group *lgr = lnk->lgr;
+	int i;
+
+	for (i = 0; i < SMC_RMBS_PER_LGR_MAX; i++) {
+		lgr->rtokens[i][lnk->link_idx].rkey = 0;
+		lgr->rtokens[i][lnk->link_idx].dma_addr = 0;
+	}
+}
+
+void smcr_link_clear(struct smc_link *lnk)
 {
 	struct smc_ib_device *smcibdev;
 
-	if (lnk->peer_qpn == 0)
+	if (!lnk->lgr || lnk->state == SMC_LNK_UNUSED)
 		return;
 	lnk->peer_qpn = 0;
 	smc_llc_link_clear(lnk);
+	smcr_buf_unmap_lgr(lnk);
+	smcr_rtoken_clear_link(lnk);
 	smc_ib_modify_qp_reset(lnk);
 	smc_wr_free_link(lnk);
 	smc_ib_destroy_queue_pair(lnk);
@@ -522,23 +577,10 @@ static void smcr_link_clear(struct smc_link *lnk)
 static void smcr_buf_free(struct smc_link_group *lgr, bool is_rmb,
 			  struct smc_buf_desc *buf_desc)
 {
-	struct smc_link *lnk;
 	int i;
 
-	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-		lnk = &lgr->lnk[i];
-		if (!buf_desc->is_map_ib[lnk->link_idx])
-			continue;
-		if (is_rmb) {
-			if (buf_desc->mr_rx[lnk->link_idx])
-				smc_ib_put_memory_region(
-						buf_desc->mr_rx[lnk->link_idx]);
-			smc_ib_buf_unmap_sg(lnk, buf_desc, DMA_FROM_DEVICE);
-		} else {
-			smc_ib_buf_unmap_sg(lnk, buf_desc, DMA_TO_DEVICE);
-		}
-		sg_free_table(&buf_desc->sgt[lnk->link_idx]);
-	}
+	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++)
+		smcr_buf_unmap_link(buf_desc, is_rmb, &lgr->lnk[i]);
 
 	if (buf_desc->pages)
 		__free_pages(buf_desc->pages, buf_desc->order);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index fd512188d2c6..fa532a423fd7 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -367,6 +367,7 @@ void smc_lgr_schedule_free_work_fast(struct smc_link_group *lgr);
 int smc_core_init(void);
 void smc_core_exit(void);
 
+void smcr_link_clear(struct smc_link *lnk);
 int smcr_link_reg_rmb(struct smc_link *link, struct smc_buf_desc *rmb_desc);
 static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
 {
-- 
2.17.1
