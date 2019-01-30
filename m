Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/9] net/smc: fix another sizeof to int comparison
Date: Wed, 30 Jan 2019 18:51:00 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result. kernel_sendmsg can return a negative
error code.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 776e9dfc915d..d53fd588d1f5 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -378,7 +378,7 @@ int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info)
 	vec.iov_len = sizeof(struct smc_clc_msg_decline);
 	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
 			     sizeof(struct smc_clc_msg_decline));
-	if (len < sizeof(struct smc_clc_msg_decline))
+	if (len < 0 || len < sizeof(struct smc_clc_msg_decline))
 		len = -EPROTO;
 	return len > 0 ? 0 : len;
 }
-- 
2.16.4
