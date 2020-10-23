Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755068AbgJWSso (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Oct 2020 14:48:44 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 3/3] s390/ism: fix incorrect system EID
Date: Fri, 23 Oct 2020 20:48:30 +0200
Message-Id: <20201023184830.59548-4-kgraul@linux.ibm.com>
In-Reply-To: <20201023184830.59548-1-kgraul@linux.ibm.com>
References: <20201023184830.59548-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The system EID that is defined by the ISM driver is not correct. Using
an incorrect system EID allows to communicate with remote Linux systems
that use the same incorrect system EID, but when it comes to
interoperability with other operating systems then the system EIDs do
never match which prevents SMC-Dv2 communication.
Using the correct system EID fixes this problem.

Fixes: 201091ebb2a1 ("net/smc: introduce System Enterprise ID (SEID)")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index fe96ca3c88a5..26cc943d2034 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -390,7 +390,7 @@ static int ism_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 }
 
 static struct ism_systemeid SYSTEM_EID = {
-	.seid_string = "IBM-SYSZ-IBMSEID00000000",
+	.seid_string = "IBM-SYSZ-ISMSEID00000000",
 	.serial_number = "0000",
 	.type = "0000",
 };
-- 
2.17.1
