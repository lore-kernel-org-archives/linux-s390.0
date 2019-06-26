Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZPsH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 11:48:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QFgtCa145383
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 11:48:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tc9hvxph9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 11:48:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 26 Jun 2019 16:48:02 +0100
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 2/2] net/smc: Fix error path in smc_init
Date: Wed, 26 Jun 2019 17:47:50 +0200
In-Reply-To: <20190626154750.46127-1-ubraun@linux.ibm.com>
References: <20190626154750.46127-1-ubraun@linux.ibm.com>
Message-Id: <20190626154750.46127-3-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com, zhp@smail.nju.edu.cn, yuehaibing@huawei.com

From: YueHaibing <yuehaibing@huawei.com>

If register_pernet_subsys success in smc_init,
we should cleanup it in case any other error.

Fixes: 64e28b52c7a6 (net/smc: add pnet table namespace support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 0c874e996f85..7621ec2f539c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2029,7 +2029,7 @@ static int __init smc_init(void)
 
 	rc = smc_pnet_init();
 	if (rc)
-		return rc;
+		goto out_pernet_subsys;
 
 	rc = smc_llc_init();
 	if (rc) {
@@ -2080,6 +2080,9 @@ static int __init smc_init(void)
 	proto_unregister(&smc_proto);
 out_pnet:
 	smc_pnet_exit();
+out_pernet_subsys:
+	unregister_pernet_subsys(&smc_net_ops);
+
 	return rc;
 }
 
-- 
2.17.1
