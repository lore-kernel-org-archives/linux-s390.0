Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727257AbfKFJuS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 04:50:18 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA69lCoW004996
        for <linux-s390@vger.kernel.org>; Wed, 6 Nov 2019 04:50:17 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3rk8q1dr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 04:50:17 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 6 Nov 2019 09:50:15 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: fix ethernet interface refcounting
Date: Wed,  6 Nov 2019 10:49:57 +0100
Message-Id: <20191106094957.94521-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

If a pnet table entry is to be added mentioning a valid ethernet
interface, but an invalid infiniband or ISM device, the dev_put()
operation for the ethernet interface is called twice, resulting
in a negative refcount for the ethernet interface, which disables
removal of such a network interface.

This patch removes one of the dev_put() calls.

Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_pnet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 2920b006f65c..571e6d84da3b 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -376,8 +376,6 @@ static int smc_pnet_fill_entry(struct net *net,
 	return 0;
 
 error:
-	if (pnetelem->ndev)
-		dev_put(pnetelem->ndev);
 	return rc;
 }
 
-- 
2.17.1
