Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728094AbgD3N4W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:22 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 03/14] net/smc: introduce link group type
Date: Thu, 30 Apr 2020 15:55:40 +0200
Message-Id: <20200430135551.26267-4-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Add a type field to the link group which reflects the current link group
redundancy state.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 70399217ad6f..51366a9f4980 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -197,6 +197,14 @@ struct smc_rtoken {				/* address/key of remote RMB */
 
 struct smcd_dev;
 
+enum smc_lgr_type {				/* redundancy state of lgr */
+	SMC_LGR_NONE,			/* no active links, lgr to be deleted */
+	SMC_LGR_SINGLE,			/* 1 active RNIC on each peer */
+	SMC_LGR_SYMMETRIC,		/* 2 active RNICs on each peer */
+	SMC_LGR_ASYMMETRIC_PEER,	/* local has 2, peer 1 active RNICs */
+	SMC_LGR_ASYMMETRIC_LOCAL,	/* local has 1, peer 2 active RNICs */
+};
+
 enum smc_llc_flowtype {
 	SMC_LLC_FLOW_NONE	= 0,
 	SMC_LLC_FLOW_ADD_LINK	= 2,
@@ -246,6 +254,8 @@ struct smc_link_group {
 			DECLARE_BITMAP(rtokens_used_mask, SMC_RMBS_PER_LGR_MAX);
 						/* used rtoken elements */
 			u8			next_link_id;
+			enum smc_lgr_type	type;
+						/* redundancy state */
 			struct list_head	llc_event_q;
 						/* queue for llc events */
 			spinlock_t		llc_event_q_lock;
-- 
2.17.1
