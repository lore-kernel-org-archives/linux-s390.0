Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731645AbgKIPSZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 10:18:25 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v4 02/15] net/smc: Use active link of the connection
Date: Mon,  9 Nov 2020 16:18:01 +0100
Message-Id: <20201109151814.15040-3-kgraul@linux.ibm.com>
In-Reply-To: <20201109151814.15040-1-kgraul@linux.ibm.com>
References: <20201109151814.15040-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, raspl@linux.ibm.com

From: Guvenc Gulce <guvenc@linux.ibm.com>

Use active link of the connection directly and not
via linkgroup array structure when obtaining link
data of the connection.

Signed-off-by: Guvenc Gulce <guvenc@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_diag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index f15fca59b4b2..c2225231f679 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -160,17 +160,17 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	    !list_empty(&smc->conn.lgr->list)) {
 		struct smc_diag_lgrinfo linfo = {
 			.role = smc->conn.lgr->role,
-			.lnk[0].ibport = smc->conn.lgr->lnk[0].ibport,
-			.lnk[0].link_id = smc->conn.lgr->lnk[0].link_id,
+			.lnk[0].ibport = smc->conn.lnk->ibport,
+			.lnk[0].link_id = smc->conn.lnk->link_id,
 		};
 
 		memcpy(linfo.lnk[0].ibname,
 		       smc->conn.lgr->lnk[0].smcibdev->ibdev->name,
-		       sizeof(smc->conn.lgr->lnk[0].smcibdev->ibdev->name));
+		       sizeof(smc->conn.lnk->smcibdev->ibdev->name));
 		smc_gid_be16_convert(linfo.lnk[0].gid,
-				     smc->conn.lgr->lnk[0].gid);
+				     smc->conn.lnk->gid);
 		smc_gid_be16_convert(linfo.lnk[0].peer_gid,
-				     smc->conn.lgr->lnk[0].peer_gid);
+				     smc->conn.lnk->peer_gid);
 
 		if (nla_put(skb, SMC_DIAG_LGRINFO, sizeof(linfo), &linfo) < 0)
 			goto errout;
-- 
2.17.1
