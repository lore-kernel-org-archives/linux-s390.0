Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx.sdf.org ([205.166.94.20]:50199 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgC1QnV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:21 -0400
Message-Id: <202003281643.02SGhHN7015213@sdf.org>
From: George Spelvin <lkml@sdf.org>
Date: Fri, 29 Nov 2019 15:39:41 -0500
Subject: [RFC PATCH v1 27/50] drivers/s390/scsi/zcsp_fc.c: Use
 prandom_u32_max() for backoff
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, lkml@sdf.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

We don't need crypto-grade random numbers for randomized backoffs.

(We could skip the if() if we wanted to rely on the undocumented fact
that prandom_u32_max(0) always returns 0.  That would be a net time
saving it port_scan_backoff == 0 is rare; if it's common, the if()
is false often enough to pay for itself. Not sure which applies here.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/scsi/zfcp_fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index b018b61bd168e..d24cafe02708f 100644
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
2.26.0
