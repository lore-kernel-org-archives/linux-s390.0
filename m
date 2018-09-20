From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] smc: generic netlink family should be __ro_after_init
Date: Thu, 20 Sep 2018 09:27:30 +0200
Message-ID: <20180920072730.17584-1-johannes@sipsolutions.net>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>, Johannes Berg <johannes.berg@intel.com>
List-ID: <linux-s390.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The generic netlink family is only initialized during module init,
so it should be __ro_after_init like all other generic netlink
families.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 01c6ce042a1c..7cb3e4f07c10 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -461,7 +461,7 @@ static const struct genl_ops smc_pnet_ops[] = {
 };
 
 /* SMC_PNETID family definition */
-static struct genl_family smc_pnet_nl_family = {
+static struct genl_family smc_pnet_nl_family __ro_after_init = {
 	.hdrsize = 0,
 	.name = SMCR_GENL_FAMILY_NAME,
 	.version = SMCR_GENL_FAMILY_VERSION,
-- 
2.14.4
