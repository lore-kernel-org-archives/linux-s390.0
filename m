Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730902AbfLLVfx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 16:35:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCLYHX4009079
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 16:35:52 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wusmjykx2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 16:35:51 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Thu, 12 Dec 2019 21:35:50 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next] net/smc: shorten lgr_cnt initialization
Date: Thu, 12 Dec 2019 22:35:41 +0100
Message-Id: <20191212213541.10485-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Save a line of code by making use of ATOMIC_INIT() for lgr_cnt.

Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index bb92c7c6214c..c16b8d3e200b 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -41,7 +41,7 @@ static struct smc_lgr_list smc_lgr_list = {	/* established link groups */
 	.num = 0,
 };
 
-static atomic_t lgr_cnt;		/* number of existing link groups */
+static atomic_t lgr_cnt = ATOMIC_INIT(0); /* number of existing link groups */
 static DECLARE_WAIT_QUEUE_HEAD(lgrs_deleted);
 
 static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
@@ -1297,7 +1297,6 @@ static struct notifier_block smc_reboot_notifier = {
 
 int __init smc_core_init(void)
 {
-	atomic_set(&lgr_cnt, 0);
 	return register_reboot_notifier(&smc_reboot_notifier);
 }
 
-- 
2.21.0
