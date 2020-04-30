Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728620AbgD3N4L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:11 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 04/14] net/smc: add logic to evaluate CONFIRM_LINK messages to LLC layer
Date: Thu, 30 Apr 2020 15:55:41 +0200
Message-Id: <20200430135551.26267-5-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Introduce smc_llc_eval_conf_link() to evaluate the CONFIRM_LINK message
contents. This implements this logic at the LLC layer. The function will
be used by af_smc.c to process the received LLC layer messages.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 11 +++++++++++
 net/smc/smc_llc.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index a146b3b43580..9248b90fe37e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -946,6 +946,17 @@ int smc_llc_do_delete_rkey(struct smc_link *link,
 	return rc;
 }
 
+/* evaluate confirm link request or response */
+int smc_llc_eval_conf_link(struct smc_llc_qentry *qentry,
+			   enum smc_llc_reqresp type)
+{
+	if (type == SMC_LLC_REQ)	/* SMC server assigns link_id */
+		qentry->link->link_id = qentry->msg.confirm_link.link_num;
+	if (!(qentry->msg.raw.hdr.flags & SMC_LLC_FLAG_NO_RMBE_EYEC))
+		return -ENOTSUPP;
+	return 0;
+}
+
 /***************************** init, exit, misc ******************************/
 
 static struct smc_wr_rx_handler smc_llc_rx_handlers[] = {
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 49e99ff00ee7..637acf91ffb7 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -66,6 +66,8 @@ int smc_llc_do_delete_rkey(struct smc_link *link,
 int smc_llc_flow_initiate(struct smc_link_group *lgr,
 			  enum smc_llc_flowtype type);
 void smc_llc_flow_stop(struct smc_link_group *lgr, struct smc_llc_flow *flow);
+int smc_llc_eval_conf_link(struct smc_llc_qentry *qentry,
+			   enum smc_llc_reqresp type);
 struct smc_llc_qentry *smc_llc_wait(struct smc_link_group *lgr,
 				    struct smc_link *lnk,
 				    int time_out, u8 exp_msg);
-- 
2.17.1
