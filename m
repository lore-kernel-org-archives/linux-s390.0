Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] net/smc: Fix error path in smc_init
Date: Tue, 14 May 2019 14:39:21 +0800
Message-ID: <20190514063921.41088-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net, ubraun@linux.ibm.com, kgraul@linux.ibm.com, hwippel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

If register_pernet_subsys success in smc_init,
we should cleanup it in case any other error.

Fixes: 64e28b52c7a6 (net/smc: add pnet table namespace support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/smc/af_smc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 6f869ef..7d3207f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2019,7 +2019,7 @@ static int __init smc_init(void)
 
 	rc = smc_pnet_init();
 	if (rc)
-		return rc;
+		goto out_pernet_subsys;
 
 	rc = smc_llc_init();
 	if (rc) {
@@ -2070,6 +2070,9 @@ static int __init smc_init(void)
 	proto_unregister(&smc_proto);
 out_pnet:
 	smc_pnet_exit();
+out_pernet_subsys:
+	unregister_pernet_subsys(&smc_net_ops);
+
 	return rc;
 }
 
-- 
1.8.3.1
