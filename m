Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50914 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgKQQQh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:16:37 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/9] s390/qeth: remove useless if/else
Date: Tue, 17 Nov 2020 17:15:14 +0100
Message-Id: <20201117161520.1089-4-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Kaixu Xia <kaixuxia@tencent.com>

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle report:

./drivers/s390/net/qeth_l3_main.c:107:2-4: WARNING: possible condition with no effect (if == else)

Both branches are the same since
commit ab29c480b194 ("s390/qeth: replace deprecated simple_stroul()"),
so remove them.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
[jwi: point to the commit that introduced this]
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
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
2.17.1
