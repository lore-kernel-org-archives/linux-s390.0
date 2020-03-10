Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbgCJIdy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 04:33:54 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02A8PFQW046950
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 04:33:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ynraxcmca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 04:33:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Tue, 10 Mar 2020 08:33:52 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH v2 net] net/smc: cancel event worker during device removal
Date: Tue, 10 Mar 2020 09:33:30 +0100
Message-Id: <20200310083330.90427-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: leon@kernel.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

During IB device removal, cancel the event worker before the device
structure is freed.

Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
Reported-by: syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_ib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index d6ba186f67e2..05b825b3cfa4 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -582,6 +582,7 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 	smc_smcr_terminate_all(smcibdev);
 	smc_ib_cleanup_per_ibdev(smcibdev);
 	ib_unregister_event_handler(&smcibdev->event_handler);
+	cancel_work_sync(&smcibdev->port_event_work);
 	kfree(smcibdev);
 }
 
-- 
2.17.1
