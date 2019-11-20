Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727998AbfKTNVH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKDILL1024848
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 08:21:06 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf489n0e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 08:21:06 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 20 Nov 2019 13:21:04 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/2] s390/qeth: return proper errno on IO error
Date: Wed, 20 Nov 2019 14:20:57 +0100
In-Reply-To: <20191120132057.1788-1-jwi@linux.ibm.com>
References: <20191120132057.1788-1-jwi@linux.ibm.com>
Message-Id: <20191120132057.1788-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When propagating IO errors back to userspace, one error path in
qeth_irq() currently returns '1' instead of a proper errno.

Fixes: 54daaca7024d ("s390/qeth: cancel cmd on early error")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index dda274351c21..83794d7494d4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -901,30 +901,30 @@ static int qeth_get_problem(struct qeth_card *card, struct ccw_device *cdev,
 				 CCW_DEVID(cdev), dstat, cstat);
 		print_hex_dump(KERN_WARNING, "qeth: irb ", DUMP_PREFIX_OFFSET,
 				16, 1, irb, 64, 1);
-		return 1;
+		return -EIO;
 	}
 
 	if (dstat & DEV_STAT_UNIT_CHECK) {
 		if (sense[SENSE_RESETTING_EVENT_BYTE] &
 		    SENSE_RESETTING_EVENT_FLAG) {
 			QETH_CARD_TEXT(card, 2, "REVIND");
-			return 1;
+			return -EIO;
 		}
 		if (sense[SENSE_COMMAND_REJECT_BYTE] &
 		    SENSE_COMMAND_REJECT_FLAG) {
 			QETH_CARD_TEXT(card, 2, "CMDREJi");
-			return 1;
+			return -EIO;
 		}
 		if ((sense[2] == 0xaf) && (sense[3] == 0xfe)) {
 			QETH_CARD_TEXT(card, 2, "AFFE");
-			return 1;
+			return -EIO;
 		}
 		if ((!sense[0]) && (!sense[1]) && (!sense[2]) && (!sense[3])) {
 			QETH_CARD_TEXT(card, 2, "ZEROSEN");
 			return 0;
 		}
 		QETH_CARD_TEXT(card, 2, "DGENCHK");
-			return 1;
+			return -EIO;
 	}
 	return 0;
 }
-- 
2.17.1
