Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbgEDMTQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 08:19:16 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 09/12] net/smc: add termination reason and handle LLC protocol violation
Date: Mon,  4 May 2020 14:18:45 +0200
Message-Id: <20200504121848.46585-10-kgraul@linux.ibm.com>
In-Reply-To: <20200504121848.46585-1-kgraul@linux.ibm.com>
References: <20200504121848.46585-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Allow to set the reason code for the link group termination, and set
meaningful values before termination processing is triggered. This
reason code is sent to the peer in the final delete link message.
When the LLC request or response layer receives a message type that was
not handled, drop a warning and terminate the link group.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c |  8 ++++++--
 net/smc/smc_core.h |  2 ++
 net/smc/smc_llc.c  | 14 ++++++++++++++
 net/smc/smc_llc.h  |  8 ++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index be15b30a1234..b6f93b44f9c7 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -878,8 +878,11 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
 		put_device(&lgr->smcd->dev);
 	} else {
-		smc_llc_send_link_delete_all(lgr, false,
-					     SMC_LLC_DEL_OP_INIT_TERM);
+		u32 rsn = lgr->llc_termination_rsn;
+
+		if (!rsn)
+			rsn = SMC_LLC_DEL_PROG_INIT_TERM;
+		smc_llc_send_link_delete_all(lgr, false, rsn);
 		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
 			struct smc_link *lnk = &lgr->lnk[i];
 
@@ -1018,6 +1021,7 @@ void smc_smcr_terminate_all(struct smc_ib_device *smcibdev)
 
 	list_for_each_entry_safe(lgr, lg, &lgr_free_list, list) {
 		list_del_init(&lgr->list);
+		smc_llc_set_termination_rsn(lgr, SMC_LLC_DEL_OP_INIT_TERM);
 		__smc_lgr_terminate(lgr, false);
 	}
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 6ed7ab6d89d5..32bc45af9a1a 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -271,6 +271,8 @@ struct smc_link_group {
 						/* protects llc flow */
 			int			llc_testlink_time;
 						/* link keep alive time */
+			u32			llc_termination_rsn;
+						/* rsn code for termination */
 		};
 		struct { /* SMC-D */
 			u64			peer_gid;
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index f65b2aac6b52..482acf80e26e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1420,6 +1420,14 @@ static void smc_llc_rmt_delete_rkey(struct smc_link_group *lgr)
 	smc_llc_flow_qentry_del(&lgr->llc_flow_rmt);
 }
 
+static void smc_llc_protocol_violation(struct smc_link_group *lgr, u8 type)
+{
+	pr_warn_ratelimited("smc: SMC-R lg %*phN LLC protocol violation: "
+			    "llc_type %d\n", SMC_LGR_ID_SIZE, &lgr->id, type);
+	smc_llc_set_termination_rsn(lgr, SMC_LLC_DEL_PROT_VIOL);
+	smc_lgr_terminate_sched(lgr);
+}
+
 /* flush the llc event queue */
 static void smc_llc_event_flush(struct smc_link_group *lgr)
 {
@@ -1520,6 +1528,9 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 			smc_llc_flow_stop(lgr, &lgr->llc_flow_rmt);
 		}
 		return;
+	default:
+		smc_llc_protocol_violation(lgr, llc->raw.hdr.common.type);
+		break;
 	}
 out:
 	kfree(qentry);
@@ -1579,6 +1590,9 @@ static void smc_llc_rx_response(struct smc_link *link,
 	case SMC_LLC_CONFIRM_RKEY_CONT:
 		/* not used because max links is 3 */
 		break;
+	default:
+		smc_llc_protocol_violation(link->lgr, llc_type);
+		break;
 	}
 	kfree(qentry);
 }
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 6d2a5d943b83..f5882ebf357b 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -60,6 +60,14 @@ static inline struct smc_link *smc_llc_usable_link(struct smc_link_group *lgr)
 	return NULL;
 }
 
+/* set the termination reason code for the link group */
+static inline void smc_llc_set_termination_rsn(struct smc_link_group *lgr,
+					       u32 rsn)
+{
+	if (!lgr->llc_termination_rsn)
+		lgr->llc_termination_rsn = rsn;
+}
+
 /* transmit */
 int smc_llc_send_confirm_link(struct smc_link *lnk,
 			      enum smc_llc_reqresp reqresp);
-- 
2.17.1
