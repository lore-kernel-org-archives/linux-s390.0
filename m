From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 07/10] net/smc: handle all error codes from smc_conn_create()
Date: Tue, 15 May 2018 17:05:00 +0200
Message-ID: <20180515150503.47265-8-ubraun@linux.ibm.com>
References: <20180515150503.47265-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515150503.47265-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

Always set a reason_code when smc_conn_create() returns an error code.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 397ba2182453..ecf9ba68501b 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -463,6 +463,8 @@ static int smc_connect_rdma(struct smc_sock *smc)
 			reason_code = SMC_CLC_DECL_MEM;/* insufficient memory*/
 		else if (rc == -ENOLINK)
 			reason_code = SMC_CLC_DECL_SYNCERR; /* synchr. error */
+		else
+			reason_code = SMC_CLC_DECL_INTERR; /* other error */
 		goto decline_rdma_unlock;
 	}
 	link = &smc->conn.lgr->lnk[SMC_SINGLE_LINK];
-- 
2.16.3
