From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 10/10] net/smc: unregister rkeys of unused buffer
Date: Thu, 22 Nov 2018 10:26:43 +0100
Message-ID: <20181122092643.26820-11-ubraun@linux.ibm.com>
References: <20181122092643.26820-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181122092643.26820-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

When an rmb is no longer in use by a connection, unregister its rkey at
the remote peer with an LLC DELETE RKEY message. With this change,
unused buffers held in the buffer pool are no longer registered at the
remote peer. They are registered before the buffer is actually used and
unregistered when they are no longer used by a connection.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c   | 22 +++++++++++-----------
 net/smc/smc_core.c |  7 ++++++-
 net/smc/smc_core.h |  2 +-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7657e249f526..4b865250e238 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -299,14 +299,17 @@ static void smc_copy_sock_settings_to_smc(struct smc_sock *smc)
 	smc_copy_sock_settings(&smc->sk, smc->clcsock->sk, SK_FLAGS_CLC_TO_SMC);
 }
 
-/* register a new rmb, optionally send confirm_rkey msg to register with peer */
+/* register a new rmb, send confirm_rkey msg to register with peer */
 static int smc_reg_rmb(struct smc_link *link, struct smc_buf_desc *rmb_desc,
 		       bool conf_rkey)
 {
-	/* register memory region for new rmb */
-	if (smc_wr_reg_send(link, rmb_desc->mr_rx[SMC_SINGLE_LINK])) {
-		rmb_desc->regerr = 1;
-		return -EFAULT;
+	if (!rmb_desc->wr_reg) {
+		/* register memory region for new rmb */
+		if (smc_wr_reg_send(link, rmb_desc->mr_rx[SMC_SINGLE_LINK])) {
+			rmb_desc->regerr = 1;
+			return -EFAULT;
+		}
+		rmb_desc->wr_reg = 1;
 	}
 	if (!conf_rkey)
 		return 0;
@@ -581,8 +584,7 @@ static int smc_connect_rdma(struct smc_sock *smc,
 			return smc_connect_abort(smc, SMC_CLC_DECL_ERR_RDYLNK,
 						 local_contact);
 	} else {
-		if (!smc->conn.rmb_desc->reused &&
-		    smc_reg_rmb(link, smc->conn.rmb_desc, true))
+		if (smc_reg_rmb(link, smc->conn.rmb_desc, true))
 			return smc_connect_abort(smc, SMC_CLC_DECL_ERR_REGRMB,
 						 local_contact);
 	}
@@ -1143,10 +1145,8 @@ static int smc_listen_rdma_reg(struct smc_sock *new_smc, int local_contact)
 	struct smc_link *link = &new_smc->conn.lgr->lnk[SMC_SINGLE_LINK];
 
 	if (local_contact != SMC_FIRST_CONTACT) {
-		if (!new_smc->conn.rmb_desc->reused) {
-			if (smc_reg_rmb(link, new_smc->conn.rmb_desc, true))
-				return SMC_CLC_DECL_ERR_REGRMB;
-		}
+		if (smc_reg_rmb(link, new_smc->conn.rmb_desc, true))
+			return SMC_CLC_DECL_ERR_REGRMB;
 	}
 	smc_rmb_sync_sg_for_device(&new_smc->conn);
 
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index ec7a7ed3b968..1382ddae591e 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -298,8 +298,13 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		conn->sndbuf_desc->used = 0;
 	if (conn->rmb_desc) {
 		if (!conn->rmb_desc->regerr) {
-			conn->rmb_desc->reused = 1;
 			conn->rmb_desc->used = 0;
+			if (!lgr->is_smcd) {
+				/* unregister rmb with peer */
+				smc_llc_do_delete_rkey(
+						&lgr->lnk[SMC_SINGLE_LINK],
+						conn->rmb_desc);
+			}
 		} else {
 			/* buf registration failed, reuse not possible */
 			write_lock_bh(&lgr->rmbs_lock);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index bce39d6df45a..e177c6675038 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -130,7 +130,7 @@ struct smc_buf_desc {
 	struct page		*pages;
 	int			len;		/* length of buffer */
 	u32			used;		/* currently used / unused */
-	u8			reused	: 1;	/* new created / reused */
+	u8			wr_reg	: 1;	/* mem region registered */
 	u8			regerr	: 1;	/* err during registration */
 	union {
 		struct { /* SMC-R */
-- 
2.16.4
