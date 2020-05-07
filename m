Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgEGOYd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 10:24:33 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next] net/smc: remove set but not used variables 'del_llc, del_llc_resp'
Date: Thu,  7 May 2020 16:24:06 +0200
Message-Id: <20200507142406.14638-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

net/smc/smc_llc.c: In function 'smc_llc_cli_conf_link':
net/smc/smc_llc.c:753:31: warning:
 variable 'del_llc' set but not used [-Wunused-but-set-variable]
  struct smc_llc_msg_del_link *del_llc;
                               ^
net/smc/smc_llc.c: In function 'smc_llc_process_srv_delete_link':
net/smc/smc_llc.c:1311:33: warning:
 variable 'del_llc_resp' set but not used [-Wunused-but-set-variable]
    struct smc_llc_msg_del_link *del_llc_resp;
                                 ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 4cc583678ac7..391237b601fe 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -750,7 +750,6 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 				 enum smc_lgr_type lgr_new_t)
 {
 	struct smc_link_group *lgr = link->lgr;
-	struct smc_llc_msg_del_link *del_llc;
 	struct smc_llc_qentry *qentry = NULL;
 	int rc = 0;
 
@@ -764,7 +763,6 @@ static int smc_llc_cli_conf_link(struct smc_link *link,
 	}
 	if (qentry->msg.raw.hdr.common.type != SMC_LLC_CONFIRM_LINK) {
 		/* received DELETE_LINK instead */
-		del_llc = &qentry->msg.delete_link;
 		qentry->msg.raw.hdr.flags |= SMC_LLC_FLAG_RESP;
 		smc_llc_send_message(link, &qentry->msg);
 		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
@@ -1308,16 +1306,12 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
 		 * enqueued DELETE_LINK request (forward it)
 		 */
 		if (!smc_llc_send_message(lnk, &qentry->msg)) {
-			struct smc_llc_msg_del_link *del_llc_resp;
 			struct smc_llc_qentry *qentry2;
 
 			qentry2 = smc_llc_wait(lgr, lnk, SMC_LLC_WAIT_TIME,
 					       SMC_LLC_DELETE_LINK);
-			if (!qentry2) {
-			} else {
-				del_llc_resp = &qentry2->msg.delete_link;
+			if (qentry2)
 				smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
-			}
 		}
 	}
 	smcr_link_clear(lnk_del, true);
-- 
2.17.1
