Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405903AbfJWNoY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 09:44:24 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NDiItL047517
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 09:44:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtprgbfhv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 09:44:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Wed, 23 Oct 2019 14:44:18 +0100
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/2] net/smc: keep vlan_id for SMC-R in smc_listen_work()
Date: Wed, 23 Oct 2019 15:44:06 +0200
In-Reply-To: <20191023134406.66319-1-kgraul@linux.ibm.com>
References: <20191023134406.66319-1-kgraul@linux.ibm.com>
Message-Id: <20191023134406.66319-3-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Creating of an SMC-R connection with vlan-id fails, because
smc_listen_work() determines the vlan_id of the connection,
saves it in struct smc_init_info ini, but clears the ini area
again if SMC-D is not applicable.
This patch just resets the ISM device before investigating
SMC-R availability.

Fixes: bc36d2fc93eb ("net/smc: consolidate function parameters")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d9566e84f2f9..cea3c36ea0da 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1298,8 +1298,8 @@ static void smc_listen_work(struct work_struct *work)
 	/* check if RDMA is available */
 	if (!ism_supported) { /* SMC_TYPE_R or SMC_TYPE_B */
 		/* prepare RDMA check */
-		memset(&ini, 0, sizeof(ini));
 		ini.is_smcd = false;
+		ini.ism_dev = NULL;
 		ini.ib_lcl = &pclc->lcl;
 		rc = smc_find_rdma_device(new_smc, &ini);
 		if (rc) {
-- 
2.17.1
