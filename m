Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726668AbfLSLvY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 06:51:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJBlcQ5131310
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 06:51:23 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x03hccv47-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 06:51:23 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 19 Dec 2019 11:51:21 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: unregister ib devices in reboot_event
Date: Thu, 19 Dec 2019 12:51:13 +0100
Message-Id: <20191219115113.49414-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

In the reboot_event handler, unregister the ib devices and enable
the IB layer to release the devices before the reboot.

Fixes: a33a803cfe64 ("net/smc: guarantee removal of link groups in reboot")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index c16b8d3e200b..2249de5379ee 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1287,7 +1287,7 @@ static int smc_core_reboot_event(struct notifier_block *this,
 				 unsigned long event, void *ptr)
 {
 	smc_lgrs_shutdown();
-
+	smc_ib_unregister_client();
 	return 0;
 }
 
-- 
2.21.0
