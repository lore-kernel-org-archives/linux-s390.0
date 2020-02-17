Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728791AbgBQPZH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:25:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HFKqgd144906
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:07 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1gh68r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:25:06 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Mon, 17 Feb 2020 15:25:04 -0000
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 2/6] net/smc: use termination worker under send_lock
Date: Mon, 17 Feb 2020 16:24:51 +0100
In-Reply-To: <20200217152455.15341-1-ubraun@linux.ibm.com>
References: <20200217152455.15341-1-ubraun@linux.ibm.com>
Message-Id: <20200217152455.15341-3-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

From: Karsten Graul <kgraul@linux.ibm.com>

smc_tx_rdma_write() is called under the send_lock and should not call
smc_lgr_terminate() directly. Call smc_lgr_terminate_sched() instead
which schedules a worker.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 0d42e7716b91..9f1ade86d70e 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -284,7 +284,7 @@ static int smc_tx_rdma_write(struct smc_connection *conn, int peer_rmbe_offset,
 	rdma_wr->rkey = lgr->rtokens[conn->rtoken_idx][SMC_SINGLE_LINK].rkey;
 	rc = ib_post_send(link->roce_qp, &rdma_wr->wr, NULL);
 	if (rc)
-		smc_lgr_terminate(lgr, true);
+		smc_lgr_terminate_sched(lgr);
 	return rc;
 }
 
-- 
2.17.1
