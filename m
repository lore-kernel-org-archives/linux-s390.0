Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728309AbgECMjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 May 2020 08:39:48 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v2 06/11] net/smc: final part of add link processing as SMC server
Date: Sun,  3 May 2020 14:38:45 +0200
Message-Id: <20200503123850.57261-7-kgraul@linux.ibm.com>
In-Reply-To: <20200503123850.57261-1-kgraul@linux.ibm.com>
References: <20200503123850.57261-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

This patch finalizes the ADD_LINK processing of new links. Send the
CONFIRM_LINK request to the peer, receive the response and set link
state to ACTIVE.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index de73432bd72f..1fefee55e293 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -904,6 +904,33 @@ static int smc_llc_srv_rkey_exchange(struct smc_link *link,
 	return rc;
 }
 
+static int smc_llc_srv_conf_link(struct smc_link *link,
+				 struct smc_link *link_new,
+				 enum smc_lgr_type lgr_new_t)
+{
+	struct smc_link_group *lgr = link->lgr;
+	struct smc_llc_qentry *qentry = NULL;
+	int rc;
+
+	/* send CONFIRM LINK request over the RoCE fabric */
+	rc = smc_llc_send_confirm_link(link_new, SMC_LLC_REQ);
+	if (rc)
+		return -ENOLINK;
+	/* receive CONFIRM LINK response over the RoCE fabric */
+	qentry = smc_llc_wait(lgr, link, SMC_LLC_WAIT_FIRST_TIME,
+			      SMC_LLC_CONFIRM_LINK);
+	if (!qentry) {
+		/* send DELETE LINK */
+		smc_llc_send_delete_link(link, link_new->link_id, SMC_LLC_REQ,
+					 false, SMC_LLC_DEL_LOST_PATH);
+		return -ENOLINK;
+	}
+	smc_llc_link_active(link_new);
+	lgr->type = lgr_new_t;
+	smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
+	return 0;
+}
+
 int smc_llc_srv_add_link(struct smc_link *link)
 {
 	enum smc_lgr_type lgr_new_t = SMC_LGR_SYMMETRIC;
@@ -967,7 +994,7 @@ int smc_llc_srv_add_link(struct smc_link *link)
 	rc = smc_llc_srv_rkey_exchange(link, link_new);
 	if (rc)
 		goto out_err;
-	/* tbd: rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t); */
+	rc = smc_llc_srv_conf_link(link, link_new, lgr_new_t);
 	if (rc)
 		goto out_err;
 	return 0;
-- 
2.17.1
