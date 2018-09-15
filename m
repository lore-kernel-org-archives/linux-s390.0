Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net/smc: cast sizeof to int for comparison
Date: Sat, 15 Sep 2018 18:00:36 +0800
Message-ID: <20180915100036.20100-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, ubraun@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result. kernel_sendmsg can return a negative
error code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/smc/smc_clc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 83aba9a..fd0f5ce 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -446,7 +446,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
 	vec[i++].iov_len = sizeof(trl);
 	/* due to the few bytes needed for clc-handshake this cannot block */
 	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
-	if (len < sizeof(pclc)) {
+	if (len < (int)sizeof(pclc)) {
 		if (len >= 0) {
 			reason_code = -ENETUNREACH;
 			smc->sk.sk_err = -reason_code;
-- 
1.8.3.1
