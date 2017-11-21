From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 1/2] net/smc: use sk_rcvbuf as start for rmb creation
Date: Tue, 21 Nov 2017 13:23:53 +0100
Message-ID: <20171121122354.44006-2-ubraun@linux.vnet.ibm.com>
References: <20171121122354.44006-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171121122354.44006-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, jwi@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.vnet.ibm.com, geert@linux-m68k.org, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Commit 3e034725c0d8 ("net/smc: common functions for RMBs and send buffers")
merged handling of SMC receive and send buffers. It introduced sk_buf_size
as merged start value for size determination. But since sk_buf_size is not
used at all, sk_sndbuf is erroneously used as start for rmb creation.
This patch makes sure, sk_buf_size is really used as intended, and
sk_rcvbuf is used as start value for rmb creation.

Fixes: 3e034725c0d8 ("net/smc: common functions for RMBs and send buffers")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2578fbd95664..3b5e5d4bc763 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -575,7 +575,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_rmb)
 		/* use socket send buffer size (w/o overhead) as start value */
 		sk_buf_size = smc->sk.sk_sndbuf / 2;
 
-	for (bufsize_short = smc_compress_bufsize(smc->sk.sk_sndbuf / 2);
+	for (bufsize_short = smc_compress_bufsize(sk_buf_size);
 	     bufsize_short >= 0; bufsize_short--) {
 
 		if (is_rmb) {
-- 
2.13.5
