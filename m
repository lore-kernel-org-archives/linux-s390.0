Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726017AbgJBPJl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 11:09:41 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 2/2] net/smc: use an array to check fields in system EID
Date: Fri,  2 Oct 2020 17:09:27 +0200
Message-Id: <20201002150927.72261-3-kgraul@linux.ibm.com>
In-Reply-To: <20201002150927.72261-1-kgraul@linux.ibm.com>
References: <20201002150927.72261-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The check for old hardware versions that did not have SMCDv2 support was
using suspicious pointer magic. Address the fields using an array.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_ism.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index e9a6487a42cb..6abbdd09a580 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -335,7 +335,7 @@ int smcd_register_dev(struct smcd_dev *smcd)
 		u8 *system_eid = NULL;
 
 		smc_ism_get_system_eid(smcd, &system_eid);
-		if ((*system_eid) + 24 != '0' || (*system_eid) + 28 != '0')
+		if (system_eid[24] != '0' || system_eid[28] != '0')
 			smc_ism_v2_capable = true;
 	}
 	/* sort list: devices without pnetid before devices with pnetid */
-- 
2.17.1
