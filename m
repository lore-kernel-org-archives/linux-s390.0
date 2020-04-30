Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbgD3N4O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:14 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 14/14] net/smc: remove obsolete link state DELETING
Date: Thu, 30 Apr 2020 15:55:51 +0200
Message-Id: <20200430135551.26267-15-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The connection layer in af_smc.c is now using the new LLC flow
framework, which made the link state DELETING obsolete. Remove the state
and the respective helpers.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 4 +---
 net/smc/smc_core.h | 1 -
 net/smc/smc_llc.c  | 7 -------
 net/smc/smc_llc.h  | 1 -
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 096dce92ee2b..3539ceef9a97 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -200,7 +200,6 @@ static int smcr_link_send_delete(struct smc_link *lnk, bool orderly)
 {
 	if (lnk->state == SMC_LNK_ACTIVE &&
 	    !smc_llc_send_delete_link(lnk, SMC_LLC_REQ, orderly)) {
-		smc_llc_link_deleting(lnk);
 		return 0;
 	}
 	return -ENOTCONN;
@@ -767,8 +766,7 @@ void smc_port_terminate(struct smc_ib_device *smcibdev, u8 ibport)
 			continue;
 		/* tbd - terminate only when no more links are active */
 		for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
-			if (!smc_link_usable(&lgr->lnk[i]) ||
-			    lgr->lnk[i].state == SMC_LNK_DELETING)
+			if (!smc_link_usable(&lgr->lnk[i]))
 				continue;
 			if (lgr->lnk[i].smcibdev == smcibdev &&
 			    lgr->lnk[i].ibport == ibport) {
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 0be26386057f..f12474cc666c 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -36,7 +36,6 @@ enum smc_link_state {			/* possible states of a link */
 	SMC_LNK_INACTIVE,	/* link is inactive */
 	SMC_LNK_ACTIVATING,	/* link is being activated */
 	SMC_LNK_ACTIVE,		/* link is active */
-	SMC_LNK_DELETING,	/* link is being deleted */
 };
 
 #define SMC_WR_BUF_SIZE		48	/* size of work request buffer */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 92c9a8a8aaf9..327cf30b98cc 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -545,7 +545,6 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 	struct smc_link_group *lgr = smc_get_lgr(link);
 
 	smc_lgr_forget(lgr);
-	smc_llc_link_deleting(link);
 	if (lgr->role == SMC_SERV) {
 		/* client asks to delete this link, send request */
 		smc_llc_prep_delete_link(llc, link, SMC_LLC_REQ, true);
@@ -878,12 +877,6 @@ void smc_llc_link_active(struct smc_link *link)
 	}
 }
 
-void smc_llc_link_deleting(struct smc_link *link)
-{
-	link->state = SMC_LNK_DELETING;
-	smc_wr_wakeup_tx_wait(link);
-}
-
 /* called in worker context */
 void smc_llc_link_clear(struct smc_link *link)
 {
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index e9f23affece6..48029a5e14c3 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -57,7 +57,6 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc);
 void smc_llc_lgr_clear(struct smc_link_group *lgr);
 int smc_llc_link_init(struct smc_link *link);
 void smc_llc_link_active(struct smc_link *link);
-void smc_llc_link_deleting(struct smc_link *link);
 void smc_llc_link_clear(struct smc_link *link);
 int smc_llc_do_confirm_rkey(struct smc_link *send_link,
 			    struct smc_buf_desc *rmb_desc);
-- 
2.17.1
