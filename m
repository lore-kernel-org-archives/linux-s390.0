Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgCFNpf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 08:45:35 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026DcbjL054385
        for <linux-s390@vger.kernel.org>; Fri, 6 Mar 2020 08:45:34 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ykgnfqjpn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 08:45:33 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 6 Mar 2020 13:45:28 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net] net/smc: cancel event worker during device removal
Date: Fri,  6 Mar 2020 14:45:18 +0100
Message-Id: <20200306134518.84416-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

During IB device removal, cancel the event worker before the device
structure is freed. In the worker, check if the device is being
terminated and do not proceed with the event work in that case.

Fixes: a4cf0443c414 ("smc: introduce SMC as an IB-client")
Reported-by: syzbot+b297c6825752e7a07272@syzkaller.appspotmail.com
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_ib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index d6ba186f67e2..5e4e64a9aa4b 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -240,6 +240,9 @@ static void smc_ib_port_event_work(struct work_struct *work)
 		work, struct smc_ib_device, port_event_work);
 	u8 port_idx;
 
+	if (list_empty(&smcibdev->list))
+		return;
+
 	for_each_set_bit(port_idx, &smcibdev->port_event_mask, SMC_MAX_PORTS) {
 		smc_ib_remember_port_attr(smcibdev, port_idx + 1);
 		clear_bit(port_idx, &smcibdev->port_event_mask);
@@ -582,6 +585,7 @@ static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 	smc_smcr_terminate_all(smcibdev);
 	smc_ib_cleanup_per_ibdev(smcibdev);
 	ib_unregister_event_handler(&smcibdev->event_handler);
+	cancel_work_sync(&smcibdev->port_event_work);
 	kfree(smcibdev);
 }
 
-- 
2.17.1
