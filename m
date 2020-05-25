Return-Path: <netdev-owner@vger.kernel.org>
Date: Mon, 25 May 2020 17:31:58 +0200
Message-Id: <20200525153158.247394-1-dvyukov@google.com>
Mime-Version: 1.0
Subject: [PATCH] net/smc: mark smc_pnet_policy as const
From: Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: ubraun@linux.ibm.com, kgraul@linux.ibm.com, linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>

Netlink policies are generally declared as const.
This is safer and prevents potential bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 2a5ed47c3e08..45d5ea570293 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -32,7 +32,7 @@
 
 static struct net_device *pnet_find_base_ndev(struct net_device *ndev);
 
-static struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
+static const struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
 	[SMC_PNETID_NAME] = {
 		.type = NLA_NUL_STRING,
 		.len = SMC_MAX_PNETID_LEN
-- 
2.27.0.rc0.183.gde8f92d652-goog
