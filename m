Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728682AbgGPPiE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 11:38:04 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 02/10] net/smc: clear link during SMC client link down processing
Date: Thu, 16 Jul 2020 17:37:38 +0200
Message-Id: <20200716153746.77303-3-kgraul@linux.ibm.com>
In-Reply-To: <20200716153746.77303-1-kgraul@linux.ibm.com>
References: <20200716153746.77303-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

In a link-down condition we notify the SMC server and expect that the
server will finally trigger the link clear processing on the client
side. This could fail when anything along this notification path goes
wrong. Clear the link as part of SMC client link-down processing to
prevent dangling links.

Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Fixes: 541afa10c126 ("net/smc: add smcr_port_err() and smcr_link_down() processing")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index f69d205b3e11..e286b3c8c962 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1204,10 +1204,12 @@ static void smcr_link_down(struct smc_link *lnk)
 				SMC_LLC_WAIT_TIME);
 			mutex_lock(&lgr->llc_conf_mutex);
 		}
-		if (!list_empty(&lgr->list))
+		if (!list_empty(&lgr->list)) {
 			smc_llc_send_delete_link(to_lnk, del_link_id,
 						 SMC_LLC_REQ, true,
 						 SMC_LLC_DEL_LOST_PATH);
+			smcr_link_clear(lnk, true);
+		}
 		wake_up(&lgr->llc_flow_waiter);	/* wake up next waiter */
 	}
 }
-- 
2.17.1
