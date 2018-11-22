From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 09/10] net/smc: add infrastructure to send delete rkey messages
Date: Thu, 22 Nov 2018 10:26:42 +0100
Message-ID: <20181122092643.26820-10-ubraun@linux.ibm.com>
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

Add the infrastructure to send LLC messages of type DELETE RKEY to
unregister a shared memory region at the peer.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h |  3 +++
 net/smc/smc_llc.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 net/smc/smc_llc.h  |  2 ++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 07364c0b41a1..bce39d6df45a 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -109,6 +109,9 @@ struct smc_link {
 	int			llc_testlink_time; /* testlink interval */
 	struct completion	llc_confirm_rkey; /* wait 4 rx of cnf rkey */
 	int			llc_confirm_rkey_rc; /* rc from cnf rkey msg */
+	struct completion	llc_delete_rkey; /* wait 4 rx of del rkey */
+	int			llc_delete_rkey_rc; /* rc from del rkey msg */
+	struct mutex		llc_delete_rkey_mutex; /* serialize usage */
 };
 
 /* For now we just allow one parallel link per link group. The SMC protocol
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 132c6a8e49f8..a6d3623d06f4 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -238,6 +238,29 @@ static int smc_llc_send_confirm_rkey(struct smc_link *link,
 	return rc;
 }
 
+/* send LLC delete rkey request */
+static int smc_llc_send_delete_rkey(struct smc_link *link,
+				    struct smc_buf_desc *rmb_desc)
+{
+	struct smc_llc_msg_delete_rkey *rkeyllc;
+	struct smc_wr_tx_pend_priv *pend;
+	struct smc_wr_buf *wr_buf;
+	int rc;
+
+	rc = smc_llc_add_pending_send(link, &wr_buf, &pend);
+	if (rc)
+		return rc;
+	rkeyllc = (struct smc_llc_msg_delete_rkey *)wr_buf;
+	memset(rkeyllc, 0, sizeof(*rkeyllc));
+	rkeyllc->hd.common.type = SMC_LLC_DELETE_RKEY;
+	rkeyllc->hd.length = sizeof(struct smc_llc_msg_delete_rkey);
+	rkeyllc->num_rkeys = 1;
+	rkeyllc->rkey[0] = htonl(rmb_desc->mr_rx[SMC_SINGLE_LINK]->rkey);
+	/* send llc message */
+	rc = smc_wr_tx_send(link, pend);
+	return rc;
+}
+
 /* prepare an add link message */
 static void smc_llc_prep_add_link(struct smc_llc_msg_add_link *addllc,
 				  struct smc_link *link, u8 mac[], u8 gid[],
@@ -509,7 +532,9 @@ static void smc_llc_rx_delete_rkey(struct smc_link *link,
 	int i, max;
 
 	if (llc->hd.flags & SMC_LLC_FLAG_RESP) {
-		/* unused as long as we don't send this type of msg */
+		link->llc_delete_rkey_rc = llc->hd.flags &
+					    SMC_LLC_FLAG_RKEY_NEG;
+		complete(&link->llc_delete_rkey);
 	} else {
 		max = min_t(u8, llc->num_rkeys, SMC_LLC_DEL_RKEY_MAX);
 		for (i = 0; i < max; i++) {
@@ -610,6 +635,8 @@ int smc_llc_link_init(struct smc_link *link)
 	init_completion(&link->llc_add);
 	init_completion(&link->llc_add_resp);
 	init_completion(&link->llc_confirm_rkey);
+	init_completion(&link->llc_delete_rkey);
+	mutex_init(&link->llc_delete_rkey_mutex);
 	init_completion(&link->llc_testlink_resp);
 	INIT_DELAYED_WORK(&link->llc_testlink_wrk, smc_llc_testlink_work);
 	return 0;
@@ -650,6 +677,7 @@ int smc_llc_do_confirm_rkey(struct smc_link *link,
 {
 	int rc;
 
+	/* protected by mutex smc_create_lgr_pending */
 	reinit_completion(&link->llc_confirm_rkey);
 	rc = smc_llc_send_confirm_rkey(link, rmb_desc);
 	if (rc)
@@ -662,6 +690,29 @@ int smc_llc_do_confirm_rkey(struct smc_link *link,
 	return 0;
 }
 
+/* unregister an rtoken at the remote peer */
+int smc_llc_do_delete_rkey(struct smc_link *link,
+			   struct smc_buf_desc *rmb_desc)
+{
+	int rc;
+
+	mutex_lock(&link->llc_delete_rkey_mutex);
+	reinit_completion(&link->llc_delete_rkey);
+	rc = smc_llc_send_delete_rkey(link, rmb_desc);
+	if (rc)
+		goto out;
+	/* receive DELETE RKEY response from server over RoCE fabric */
+	rc = wait_for_completion_interruptible_timeout(&link->llc_delete_rkey,
+						       SMC_LLC_WAIT_TIME);
+	if (rc <= 0 || link->llc_delete_rkey_rc)
+		rc = -EFAULT;
+	else
+		rc = 0;
+out:
+	mutex_unlock(&link->llc_delete_rkey_mutex);
+	return rc;
+}
+
 /***************************** init, exit, misc ******************************/
 
 static struct smc_wr_rx_handler smc_llc_rx_handlers[] = {
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 9e2ff088e301..461c0c3ef76e 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -49,6 +49,8 @@ void smc_llc_link_inactive(struct smc_link *link);
 void smc_llc_link_clear(struct smc_link *link);
 int smc_llc_do_confirm_rkey(struct smc_link *link,
 			    struct smc_buf_desc *rmb_desc);
+int smc_llc_do_delete_rkey(struct smc_link *link,
+			   struct smc_buf_desc *rmb_desc);
 int smc_llc_init(void) __init;
 
 #endif /* SMC_LLC_H */
-- 
2.16.4
