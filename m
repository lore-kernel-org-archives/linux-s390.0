Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgKHGe4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Nov 2020 01:34:56 -0500
From: xiakaixu1987@gmail.com
Subject: [PATCH] s390/qeth: remove useless if/else
Date: Sun,  8 Nov 2020 14:34:47 +0800
Message-Id: <1604817287-11258-1-git-send-email-kaixuxia@tencent.com>
List-ID: <linux-s390.vger.kernel.org>
To: hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle report:

./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition with no effect (if == else)

Both branches are the same, so remove them.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/s390/net/qeth_l3_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b1c1d2510d55..264b6c782382 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -104,10 +104,7 @@ static bool qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
 		qeth_l3_convert_addr_to_bits(ipatoe->addr, ipatoe_bits,
 					  (ipatoe->proto == QETH_PROT_IPV4) ?
 					  4 : 16);
-		if (addr->proto == QETH_PROT_IPV4)
-			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
-		else
-			rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
+		rc = !memcmp(addr_bits, ipatoe_bits, ipatoe->mask_bits);
 		if (rc)
 			break;
 	}
-- 
2.20.0
