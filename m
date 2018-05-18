From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 8/9] net/smc: change smc_buf_free function parameters
Date: Fri, 18 May 2018 09:34:17 +0200
Message-ID: <20180518073418.91878-9-ubraun@linux.ibm.com>
References: <20180518073418.91878-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180518073418.91878-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

This patch changes the function smc_buf_free to use the SMC link group
instead of the link as function parameter. Also, it changes the order of
the other two parameters.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c63cf7b07ccc..1e5c0e90a706 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -36,8 +36,8 @@ static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 	.num = 0,
 };
 
-static void smc_buf_free(struct smc_buf_desc *buf_desc, struct smc_link *lnk,
-			 bool is_rmb);
+static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
+			 struct smc_buf_desc *buf_desc);
 
 static void smc_lgr_schedule_free_work(struct smc_link_group *lgr)
 {
@@ -249,14 +249,12 @@ static void smc_buf_unuse(struct smc_connection *conn)
 		} else {
 			/* buf registration failed, reuse not possible */
 			struct smc_link_group *lgr = conn->lgr;
-			struct smc_link *lnk;
 
 			write_lock_bh(&lgr->rmbs_lock);
 			list_del(&conn->rmb_desc->list);
 			write_unlock_bh(&lgr->rmbs_lock);
 
-			lnk = &lgr->lnk[SMC_SINGLE_LINK];
-			smc_buf_free(conn->rmb_desc, lnk, true);
+			smc_buf_free(lgr, true, conn->rmb_desc);
 		}
 	}
 }
@@ -282,9 +280,11 @@ static void smc_link_clear(struct smc_link *lnk)
 	smc_wr_free_link_mem(lnk);
 }
 
-static void smc_buf_free(struct smc_buf_desc *buf_desc, struct smc_link *lnk,
-			 bool is_rmb)
+static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
+			 struct smc_buf_desc *buf_desc)
 {
+	struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
+
 	if (is_rmb) {
 		if (buf_desc->mr_rx[SMC_SINGLE_LINK])
 			smc_ib_put_memory_region(
@@ -303,7 +303,6 @@ static void smc_buf_free(struct smc_buf_desc *buf_desc, struct smc_link *lnk,
 
 static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 {
-	struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
 	struct smc_buf_desc *buf_desc, *bf_desc;
 	struct list_head *buf_list;
 	int i;
@@ -316,7 +315,7 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
 			list_del(&buf_desc->list);
-			smc_buf_free(buf_desc, lnk, is_rmb);
+			smc_buf_free(lgr, is_rmb, buf_desc);
 		}
 	}
 }
@@ -627,7 +626,7 @@ static struct smc_buf_desc *smc_new_buf_create(struct smc_link_group *lgr,
 	rc = sg_alloc_table(&buf_desc->sgt[SMC_SINGLE_LINK], 1,
 			    GFP_KERNEL);
 	if (rc) {
-		smc_buf_free(buf_desc, lnk, is_rmb);
+		smc_buf_free(lgr, is_rmb, buf_desc);
 		return ERR_PTR(rc);
 	}
 	sg_set_buf(buf_desc->sgt[SMC_SINGLE_LINK].sgl,
@@ -638,7 +637,7 @@ static struct smc_buf_desc *smc_new_buf_create(struct smc_link_group *lgr,
 			       is_rmb ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	/* SMC protocol depends on mapping to one DMA address only */
 	if (rc != 1)  {
-		smc_buf_free(buf_desc, lnk, is_rmb);
+		smc_buf_free(lgr, is_rmb, buf_desc);
 		return ERR_PTR(-EAGAIN);
 	}
 
@@ -649,7 +648,7 @@ static struct smc_buf_desc *smc_new_buf_create(struct smc_link_group *lgr,
 					      IB_ACCESS_LOCAL_WRITE,
 					      buf_desc);
 		if (rc) {
-			smc_buf_free(buf_desc, lnk, is_rmb);
+			smc_buf_free(lgr, is_rmb, buf_desc);
 			return ERR_PTR(rc);
 		}
 	}
@@ -775,8 +774,7 @@ int smc_buf_create(struct smc_sock *smc)
 	/* create rmb */
 	rc = __smc_buf_create(smc, true);
 	if (rc)
-		smc_buf_free(smc->conn.sndbuf_desc,
-			     &smc->conn.lgr->lnk[SMC_SINGLE_LINK], false);
+		smc_buf_free(smc->conn.lgr, false, smc->conn.sndbuf_desc);
 	return rc;
 }
 
-- 
2.16.3
