Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgGTO0R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 10:26:17 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/2] net/smc: put slot when connection is killed
Date: Mon, 20 Jul 2020 16:24:28 +0200
Message-Id: <20200720142429.17916-2-kgraul@linux.ibm.com>
In-Reply-To: <20200720142429.17916-1-kgraul@linux.ibm.com>
References: <20200720142429.17916-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

To get a send slot smc_wr_tx_get_free_slot() is called, which might
wait for a free slot. When smc_wr_tx_get_free_slot() returns there is a
check if the connection was killed in the meantime. In that case don't
only return an error, but also put back the free slot.

Fixes: b290098092e4 ("net/smc: cancel send and receive for terminated socket")
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_cdc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index a47e8855e045..ce468ff62a19 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -66,9 +66,13 @@ int smc_cdc_get_free_slot(struct smc_connection *conn,
 	rc = smc_wr_tx_get_free_slot(link, smc_cdc_tx_handler, wr_buf,
 				     wr_rdma_buf,
 				     (struct smc_wr_tx_pend_priv **)pend);
-	if (conn->killed)
+	if (conn->killed) {
 		/* abnormal termination */
+		if (!rc)
+			smc_wr_tx_put_slot(link,
+					   (struct smc_wr_tx_pend_priv *)pend);
 		rc = -EPIPE;
+	}
 	return rc;
 }
 
-- 
2.17.1
