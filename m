Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 5/5] net/smc: fix sizeof to int comparison
Date: Tue, 18 Sep 2018 15:46:38 +0200
In-Reply-To: <20180918134638.90271-1-ubraun@linux.ibm.com>
References: <20180918134638.90271-1-ubraun@linux.ibm.com>
Message-Id: <20180918134638.90271-6-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: YueHaibing <yuehaibing@huawei.com>

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result. kernel_sendmsg can return a negative
error code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_clc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 83aba9ade060..52241d679cc9 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -446,14 +446,12 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
 	vec[i++].iov_len = sizeof(trl);
 	/* due to the few bytes needed for clc-handshake this cannot block */
 	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
-	if (len < sizeof(pclc)) {
-		if (len >= 0) {
-			reason_code = -ENETUNREACH;
-			smc->sk.sk_err = -reason_code;
-		} else {
-			smc->sk.sk_err = smc->clcsock->sk->sk_err;
-			reason_code = -smc->sk.sk_err;
-		}
+	if (len < 0) {
+		smc->sk.sk_err = smc->clcsock->sk->sk_err;
+		reason_code = -smc->sk.sk_err;
+	} else if (len < (int)sizeof(pclc)) {
+		reason_code = -ENETUNREACH;
+		smc->sk.sk_err = -reason_code;
 	}
 
 	return reason_code;
-- 
2.16.4
