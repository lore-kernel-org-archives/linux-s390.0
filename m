Return-Path: <SRS0=wH8C=SN=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 4/5] net/smc: fix return code from FLUSH command
Date: Thu, 11 Apr 2019 11:17:33 +0200
In-Reply-To: <20190411091734.4263-1-ubraun@linux.ibm.com>
References: <20190411091734.4263-1-ubraun@linux.ibm.com>
Message-Id: <20190411091734.4263-5-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Karsten Graul <kgraul@linux.ibm.com>

The FLUSH command is used to empty the pnet table. No return code is
expected from the command. Commit a9d8b0b1e3d6 added namespace support
for the pnet table and changed the FLUSH command processing to call
smc_pnet_remove_by_pnetid() to remove the pnet entries. This function
returns -ENOENT when no entry was deleted, which is now the return code
of the FLUSH command. As a result the FLUSH command will return an error
when the pnet table is already empty.
Restore the expected behavior and let FLUSH always return 0.

Fixes: a9d8b0b1e3d6 ("net/smc: add pnet table namespace support")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_pnet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 8d2f6296279c..0285c7f9e79b 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -603,7 +603,8 @@ static int smc_pnet_flush(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = genl_info_net(info);
 
-	return smc_pnet_remove_by_pnetid(net, NULL);
+	smc_pnet_remove_by_pnetid(net, NULL);
+	return 0;
 }
 
 /* SMC_PNETID generic netlink operation definition */
-- 
2.16.4
