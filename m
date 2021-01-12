Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406223AbhALQYS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 11:24:18 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/2] smc: fix out of bound access in smc_nl_get_sys_info()
Date: Tue, 12 Jan 2021 17:21:21 +0100
Message-Id: <20210112162122.26832-2-kgraul@linux.ibm.com>
In-Reply-To: <20210112162122.26832-1-kgraul@linux.ibm.com>
References: <20210112162122.26832-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

smc_clc_get_hostname() sets the host pointer to a buffer
which is not NULL-terminated (see smc_clc_init()).

Reported-by: syzbot+f4708c391121cfc58396@syzkaller.appspotmail.com
Fixes: 099b990bd11a ("net/smc: Add support for obtaining system information")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
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
2.17.1
