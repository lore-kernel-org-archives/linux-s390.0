Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgL3Ath (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Dec 2020 19:49:37 -0500
From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] smc: fix out of bound access in smc_nl_get_sys_info()
Date: Tue, 29 Dec 2020 16:48:41 -0800
Message-Id: <20201230004841.1472141-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: kgraul@linux.ibm.com, guvenc@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com

smc_clc_get_hostname() sets the host pointer to a buffer
which is not NULL-terminated (see smc_clc_init()).

Reported-by: syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com
Fixes: 099b990bd11a ("net/smc: Add support for obtaining system information")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/smc/smc_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 59342b519e34..8d866b4ed8f6 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -246,7 +246,8 @@ int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
 		goto errattr;
 	smc_clc_get_hostname(&host);
 	if (host) {
-		snprintf(hostname, sizeof(hostname), "%s", host);
+		memcpy(hostname, host, SMC_MAX_HOSTNAME_LEN);
+		hostname[SMC_MAX_HOSTNAME_LEN] = 0;
 		if (nla_put_string(skb, SMC_NLA_SYS_LOCAL_HOST, hostname))
 			goto errattr;
 	}
-- 
2.26.2
