Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727695AbfKPQrq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 Nov 2019 11:47:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAGGl5O6127113
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wadv3j1my-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 16 Nov 2019 11:47:45 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Sat, 16 Nov 2019 16:47:43 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 4/4] net/smc: remove unused constant
Date: Sat, 16 Nov 2019 17:47:32 +0100
In-Reply-To: <20191116164732.47059-1-kgraul@linux.ibm.com>
References: <20191116164732.47059-1-kgraul@linux.ibm.com>
Message-Id: <20191116164732.47059-5-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Constant SMC_CLOSE_WAIT_LISTEN_CLCSOCK_TIME is defined, but since
commit 3d502067599f ("net/smc: simplify wait when closing listen socket")
no longer used. Remove it.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_close.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index d205b2114006..290270c821ca 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -20,8 +20,6 @@
 #include "smc_cdc.h"
 #include "smc_close.h"
 
-#define SMC_CLOSE_WAIT_LISTEN_CLCSOCK_TIME	(5 * HZ)
-
 /* release the clcsock that is assigned to the smc_sock */
 void smc_clcsock_release(struct smc_sock *smc)
 {
-- 
2.17.1
