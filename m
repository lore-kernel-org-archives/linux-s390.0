Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgD3N4Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:25 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 09/14] net/smc: move the TEST_LINK response processing into event handler
Date: Thu, 30 Apr 2020 15:55:46 +0200
Message-Id: <20200430135551.26267-10-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Get rid of the extra function and move the two-liner for the TEST_LINK
response processing into the event handler function.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index f9ec270818fa..4945abbad111 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -563,13 +563,6 @@ static void smc_llc_rx_delete_link(struct smc_link *link,
 	smc_lgr_terminate_sched(lgr);
 }
 
-static void smc_llc_rx_test_link(struct smc_link *link,
-				 struct smc_llc_msg_test_link *llc)
-{
-	llc->hd.flags |= SMC_LLC_FLAG_RESP;
-	smc_llc_send_message(link, llc);
-}
-
 static void smc_llc_rx_confirm_rkey(struct smc_link *link,
 				    struct smc_llc_msg_confirm_rkey *llc)
 {
@@ -640,7 +633,8 @@ static void smc_llc_event_handler(struct smc_llc_qentry *qentry)
 
 	switch (llc->raw.hdr.common.type) {
 	case SMC_LLC_TEST_LINK:
-		smc_llc_rx_test_link(link, &llc->test_link);
+		llc->test_link.hd.flags |= SMC_LLC_FLAG_RESP;
+		smc_llc_send_message(link, llc);
 		break;
 	case SMC_LLC_ADD_LINK:
 		if (list_empty(&lgr->list))
-- 
2.17.1
