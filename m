Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65184 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbgGCNVb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:31 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 1/7] zfcp: use prandom_u32_max() for backoff
Date: Fri,  3 Jul 2020 15:19:57 +0200
Message-Id: <8fc7c4c4069ff1783f4a9ccd84a923f581a09ec5.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, George Spelvin <lkml@sdf.org>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: George Spelvin <lkml@sdf.org>

We don't need crypto-grade random numbers for randomized backoffs.
Instead use prandom_u32_max(ep_ro) which generates a pseudo-random
number uniformly distributed in the interval [0, ep_ro).

Signed-off-by: George Spelvin <lkml@sdf.org>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index b018b61bd168..d24cafe02708 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -48,7 +48,7 @@ unsigned int zfcp_fc_port_scan_backoff(void)
 {
 	if (!port_scan_backoff)
 		return 0;
-	return get_random_int() % port_scan_backoff;
+	return prandom_u32_max(port_scan_backoff);
 }
 
 static void zfcp_fc_port_scan_time(struct zfcp_adapter *adapter)
-- 
2.26.2
