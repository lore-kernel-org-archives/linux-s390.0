Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728335AbgBQPZH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:07 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFJvKj075761
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dp8aq0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:06 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:04 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 3/6] net/smc: do not delete lgr from list twice
Date: Mon, 17 Feb 2020 16:24:52 +0100
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
Message-Id: <20200217152455.15341-4-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>

When 2 callers call smc_lgr_terminate() at the same time
for the same lgr, one gets the lgr_lock and deletes the lgr from the
list and releases the lock. Then the second caller gets the lock and
tries to delete it again.
In smc_lgr_terminate() add a check if the link group lgr is already
deleted from the link group list and prevent to try to delete it a
second time.
And add a check if the lgr is marked as freeing, which means that a
termination is already pending.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 8f3c1fced334..9b92b52952dd 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -629,7 +629,7 @@ void smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 
 	smc_lgr_list_head(lgr, &lgr_lock);
 	spin_lock_bh(lgr_lock);
-	if (lgr->terminating) {
+	if (list_empty(&lgr->list) || lgr->terminating || lgr->freeing) {
 		spin_unlock_bh(lgr_lock);
 		return;	/* lgr already terminating */
 	}
-- 
2.17.1
