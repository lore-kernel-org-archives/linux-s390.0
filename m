Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgEAKse (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 06:48:34 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 12/13] net/smc: allocate index for a new link
Date: Fri,  1 May 2020 12:48:12 +0200
Message-Id: <20200501104813.76601-13-kgraul@linux.ibm.com>
In-Reply-To: <20200501104813.76601-1-kgraul@linux.ibm.com>
References: <20200501104813.76601-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Add smc_llc_alloc_alt_link() to find a free link index for a new link,
depending on the new link group type. And update constants for the
maximum number of links to 3 (2 symmetric and 1 dangling asymmetric link).
These maximum numbers are the same as used by other implementations of the
SMC-R protocol.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h |  2 +-
 net/smc/smc_llc.c  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index da3cddbd1651..eb27f2eb7c8c 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -128,7 +128,7 @@ struct smc_link {
 /* For now we just allow one parallel link per link group. The SMC protocol
  * allows more (up to 8).
  */
-#define SMC_LINKS_PER_LGR_MAX	1
+#define SMC_LINKS_PER_LGR_MAX	3
 #define SMC_SINGLE_LINK		0
 
 #define SMC_FIRST_CONTACT	1		/* first contact to a peer */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index e478a4c11877..3a25b6ebe3a8 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -541,6 +541,30 @@ static int smc_llc_send_message(struct smc_link *link, void *llcbuf)
 
 /********************************* receive ***********************************/
 
+static int smc_llc_alloc_alt_link(struct smc_link_group *lgr,
+				  enum smc_lgr_type lgr_new_t)
+{
+	int i;
+
+	if (lgr->type == SMC_LGR_SYMMETRIC ||
+	    (lgr->type != SMC_LGR_SINGLE &&
+	     (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
+	      lgr_new_t == SMC_LGR_ASYMMETRIC_PEER)))
+		return -EMLINK;
+
+	if (lgr_new_t == SMC_LGR_ASYMMETRIC_LOCAL ||
+	    lgr_new_t == SMC_LGR_ASYMMETRIC_PEER) {
+		for (i = SMC_LINKS_PER_LGR_MAX - 1; i >= 0; i--)
+			if (lgr->lnk[i].state == SMC_LNK_UNUSED)
+				return i;
+	} else {
+		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++)
+			if (lgr->lnk[i].state == SMC_LNK_UNUSED)
+				return i;
+	}
+	return -EMLINK;
+}
+
 static void smc_llc_rx_delete_link(struct smc_link *link,
 				   struct smc_llc_msg_del_link *llc)
 {
-- 
2.17.1
