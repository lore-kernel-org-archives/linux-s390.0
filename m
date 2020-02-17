Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgBQPZI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:08 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFKqLO144889
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gh690-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:05 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/6] net/smc: improve smc_lgr_cleanup()
Date: Mon, 17 Feb 2020 16:24:50 +0100
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
Message-Id: <20200217152455.15341-2-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>

smc_lgr_cleanup() is called during termination processing, there is no
need to send a DELETE_LINK at that time. A DELETE_LINK should have been
sent before the termination is initiated, if needed.
And remove the extra call to wake_up(&lnk->wr_reg_wait) because
smc_llc_link_inactive() already calls the related helper function
smc_wr_wakeup_reg_wait().

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2249de5379ee..8f3c1fced334 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -576,11 +576,8 @@ static void smc_lgr_cleanup(struct smc_link_group *lgr)
 	} else {
 		struct smc_link *lnk = &lgr->lnk[SMC_SINGLE_LINK];
 
-		wake_up(&lnk->wr_reg_wait);
-		if (lnk->state != SMC_LNK_INACTIVE) {
-			smc_link_send_delete(lnk, false);
+		if (lnk->state != SMC_LNK_INACTIVE)
 			smc_llc_link_inactive(lnk);
-		}
 	}
 }
 
-- 
2.17.1
