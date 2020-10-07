Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbgJGU6A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 16:58:00 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 3/3] net/smc: restore smcd_version when all ISM V2 devices failed to init
Date: Wed,  7 Oct 2020 22:57:43 +0200
Message-Id: <20201007205743.83535-4-kgraul@linux.ibm.com>
In-Reply-To: <20201007205743.83535-1-kgraul@linux.ibm.com>
References: <20201007205743.83535-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Field ini->smcd_version is set to SMC_V2 before calling
smc_listen_ism_init(). This clears the V1 bit that may be set. When all
matching ISM V2 devices fail to initialize then the smcd_version field
needs to get restored to allow any possible V1 devices to initialize.
And be consistent, always go to the not_found label when no device was
found.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/af_smc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f481f0ed2b78..82be0bd0f6e8 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1481,11 +1481,12 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	struct smc_clc_v2_extension *smc_v2_ext;
 	struct smc_clc_msg_smcd *pclc_smcd;
 	unsigned int matches = 0;
+	u8 smcd_version;
 	u8 *eid = NULL;
 	int i;
 
 	if (!(ini->smcd_version & SMC_V2) || !smcd_indicated(ini->smc_type_v2))
-		return;
+		goto not_found;
 
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
 	smc_v2_ext = smc_get_clc_v2_ext(pclc);
@@ -1519,6 +1520,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	}
 
 	/* separate - outside the smcd_dev_list.lock */
+	smcd_version = ini->smcd_version;
 	for (i = 0; i < matches; i++) {
 		ini->smcd_version = SMC_V2;
 		ini->is_smcd = true;
@@ -1528,6 +1530,8 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 			continue;
 		return; /* matching and usable V2 ISM device found */
 	}
+	/* no V2 ISM device could be initialized */
+	ini->smcd_version = smcd_version;	/* restore original value */
 
 not_found:
 	ini->smcd_version &= ~SMC_V2;
-- 
2.17.1
