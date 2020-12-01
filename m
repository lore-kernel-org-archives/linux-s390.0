Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next v7 02/14] net/smc: Use active link of the connection
Date: Tue,  1 Dec 2020 20:20:37 +0100
Message-Id: <20201201192049.53517-3-kgraul@linux.ibm.com>
In-Reply-To: <20201201192049.53517-1-kgraul@linux.ibm.com>
References: <20201201192049.53517-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

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
