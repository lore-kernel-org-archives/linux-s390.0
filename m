Return-Path: <SRS0=auZG=QG=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/9] net/smc: allow 16 byte pnetids in netlink policy
Date: Wed, 30 Jan 2019 18:51:01 +0100
In-Reply-To: <20190130175108.103221-1-ubraun@linux.ibm.com>
References: <20190130175108.103221-1-ubraun@linux.ibm.com>
Message-Id: <20190130175108.103221-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

Currently, users can only send pnetids with a maximum length of 15 bytes
over the SMC netlink interface although the maximum pnetid length is 16
bytes. This patch changes the SMC netlink policy to accept 16 byte
pnetids.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 7cb3e4f07c10..632c3109dee5 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -27,7 +27,7 @@
 static struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
 	[SMC_PNETID_NAME] = {
 		.type = NLA_NUL_STRING,
-		.len = SMC_MAX_PNETID_LEN - 1
+		.len = SMC_MAX_PNETID_LEN
 	},
 	[SMC_PNETID_ETHNAME] = {
 		.type = NLA_NUL_STRING,
-- 
2.16.4
