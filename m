Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 13/14] net/smc: remove handling of CONFIRM_RKEY_CONTINUE
Date: Thu, 30 Apr 2020 15:55:50 +0200
Message-Id: <20200430135551.26267-14-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The new SMC-R multiple link support will support a maximum of 3 links,
and one CONFIRM_RKEY LLC message can transport 3 rkeys of an rmb buffer.
There is no need for the LLC message type CONFIRM_RKEY_CONTINUE which is
needed when more than 3 rkeys per rmb buffer needs to be exchanged.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index e458207bde9e..92c9a8a8aaf9 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -98,12 +98,6 @@ struct smc_llc_msg_confirm_rkey {	/* type 0x06 */
 	u8 reserved;
 };
 
-struct smc_llc_msg_confirm_rkey_cont {	/* type 0x08 */
-	struct smc_llc_hdr hd;
-	u8 num_rkeys;
-	struct smc_rmb_rtoken rtoken[SMC_LLC_RKEYS_PER_MSG];
-};
-
 #define SMC_LLC_DEL_RKEY_MAX	8
 #define SMC_LLC_FLAG_RKEY_RETRY	0x10
 #define SMC_LLC_FLAG_RKEY_NEG	0x20
@@ -123,7 +117,6 @@ union smc_llc_msg {
 	struct smc_llc_msg_del_link delete_link;
 
 	struct smc_llc_msg_confirm_rkey confirm_rkey;
-	struct smc_llc_msg_confirm_rkey_cont confirm_rkey_cont;
 	struct smc_llc_msg_delete_rkey delete_rkey;
 
 	struct smc_llc_msg_test_link test_link;
@@ -628,14 +621,6 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
 }
 
-static void smc_llc_rx_confirm_rkey_cont(struct smc_link *link,
-				      struct smc_llc_msg_confirm_rkey_cont *llc)
-{
-	/* ignore rtokens for other links, we have only one link */
-	llc->hd.flags |= SMC_LLC_FLAG_RESP;
-	smc_llc_send_message(link, llc);
-}
-
 /* flush the llc event queue */
 static void smc_llc_event_flush(struct smc_link_group *lgr)
 {
@@ -701,7 +686,9 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 		}
 		return;
 	case SMC_LLC_CONFIRM_RKEY_CONT:
-		smc_llc_rx_confirm_rkey_cont(link, &llc->confirm_rkey_cont);
+		/* not used because max links is 3, and 3 rkeys fit into
+		 * one CONFIRM_RKEY message
+		 */
 		break;
 	case SMC_LLC_DELETE_RKEY:
 		/* new request from remote, assign to remote flow */
@@ -770,7 +757,7 @@ static void smc_llc_rx_response(struct smc_link *link,
 			smc_lgr_schedule_free_work_fast(link->lgr);
 		break;
 	case SMC_LLC_CONFIRM_RKEY_CONT:
-		/* unused as long as we don't send this type of msg */
+		/* not used because max links is 3 */
 		break;
 	}
 	kfree(qentry);
-- 
2.17.1
