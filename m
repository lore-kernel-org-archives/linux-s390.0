Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/4] net/smc: fewer parameters for smc_llc_send_confirm_link()
Date: Wed, 25 Jul 2018 16:35:30 +0200
In-Reply-To: <20180725143533.7082-1-ubraun@linux.ibm.com>
References: <20180725143533.7082-1-ubraun@linux.ibm.com>
Message-Id: <20180725143533.7082-2-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Link confirmation will always be sent across the new link being
confirmed. This allows to shrink the parameter list.
No functional change.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  | 10 ++--------
 net/smc/smc_llc.c |  9 +++++----
 net/smc/smc_llc.h |  2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7fc810ec31c5..7883f70f7c6d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -352,10 +352,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 		return SMC_CLC_DECL_INTERR;
 
 	/* send CONFIRM LINK response over RoCE fabric */
-	rc = smc_llc_send_confirm_link(link,
-				       link->smcibdev->mac[link->ibport - 1],
-				       &link->smcibdev->gid[link->ibport - 1],
-				       SMC_LLC_RESP);
+	rc = smc_llc_send_confirm_link(link, SMC_LLC_RESP);
 	if (rc < 0)
 		return SMC_CLC_DECL_TCL;
 
@@ -951,10 +948,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 		return SMC_CLC_DECL_INTERR;
 
 	/* send CONFIRM LINK request to client over the RoCE fabric */
-	rc = smc_llc_send_confirm_link(link,
-				       link->smcibdev->mac[link->ibport - 1],
-				       &link->smcibdev->gid[link->ibport - 1],
-				       SMC_LLC_REQ);
+	rc = smc_llc_send_confirm_link(link, SMC_LLC_REQ);
 	if (rc < 0)
 		return SMC_CLC_DECL_TCL;
 
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index b7944aa1ffc3..f2ba99c2e69a 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -182,8 +182,7 @@ static int smc_llc_add_pending_send(struct smc_link *link,
 }
 
 /* high-level API to send LLC confirm link */
-int smc_llc_send_confirm_link(struct smc_link *link, u8 mac[],
-			      union ib_gid *gid,
+int smc_llc_send_confirm_link(struct smc_link *link,
 			      enum smc_llc_reqresp reqresp)
 {
 	struct smc_link_group *lgr = smc_get_lgr(link);
@@ -202,8 +201,10 @@ int smc_llc_send_confirm_link(struct smc_link *link, u8 mac[],
 	confllc->hd.flags |= SMC_LLC_FLAG_NO_RMBE_EYEC;
 	if (reqresp == SMC_LLC_RESP)
 		confllc->hd.flags |= SMC_LLC_FLAG_RESP;
-	memcpy(confllc->sender_mac, mac, ETH_ALEN);
-	memcpy(confllc->sender_gid, gid, SMC_GID_SIZE);
+	memcpy(confllc->sender_mac, link->smcibdev->mac[link->ibport - 1],
+	       ETH_ALEN);
+	memcpy(confllc->sender_gid, &link->smcibdev->gid[link->ibport - 1],
+	       SMC_GID_SIZE);
 	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
 	confllc->link_num = link->link_id;
 	memcpy(confllc->link_uid, lgr->id, SMC_LGR_ID_SIZE);
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 65c8645e96a1..9a29fcbbcea8 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -36,7 +36,7 @@ enum smc_llc_msg_type {
 };
 
 /* transmit */
-int smc_llc_send_confirm_link(struct smc_link *lnk, u8 mac[], union ib_gid *gid,
+int smc_llc_send_confirm_link(struct smc_link *lnk,
 			      enum smc_llc_reqresp reqresp);
 int smc_llc_send_add_link(struct smc_link *link, u8 mac[], union ib_gid *gid,
 			  enum smc_llc_reqresp reqresp);
-- 
2.16.4
