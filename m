Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFZPsK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Jun 2019 11:48:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QFm30q009254
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 11:48:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tc9y8d88r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Jun 2019 11:48:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 26 Jun 2019 16:48:03 +0100
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/2] net/smc: hold conns_lock before calling smc_lgr_register_conn()
Date: Wed, 26 Jun 2019 17:47:49 +0200
In-Reply-To: <20190626154750.46127-1-ubraun@linux.ibm.com>
References: <20190626154750.46127-1-ubraun@linux.ibm.com>
Message-Id: <20190626154750.46127-2-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com, zhp@smail.nju.edu.cn, yuehaibing@huawei.com

From: Huaping Zhou <zhp@smail.nju.edu.cn>

After smc_lgr_create(), the newly created link group is added
to smc_lgr_list, thus is accessible from other context.
Although link group creation is serialized by
smc_create_lgr_pending, the new link group may still be accessed
concurrently. For example, if ib_device is no longer active,
smc_ib_port_event_work() will call smc_port_terminate(), which
in turn will call __smc_lgr_terminate() on every link group of
this device. So conns_lock is required here.

Signed-off-by: Huaping Zhou <zhp@smail.nju.edu.cn>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 2d2850adc2a3..4ca50ddf8d16 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -652,7 +652,10 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 		rc = smc_lgr_create(smc, ini);
 		if (rc)
 			goto out;
+		lgr = conn->lgr;
+		write_lock_bh(&lgr->conns_lock);
 		smc_lgr_register_conn(conn); /* add smc conn to lgr */
+		write_unlock_bh(&lgr->conns_lock);
 	}
 	conn->local_tx_ctrl.common.type = SMC_CDC_MSG_TYPE;
 	conn->local_tx_ctrl.len = SMC_WR_TX_SIZE;
-- 
2.17.1
