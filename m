Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgH0IRQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Aug 2020 04:17:16 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/8] s390/qeth: don't disable address events during initialization
Date: Thu, 27 Aug 2020 10:17:01 +0200
Message-Id: <20200827081705.21922-5-jwi@linux.ibm.com>
In-Reply-To: <20200827081705.21922-1-jwi@linux.ibm.com>
References: <20200827081705.21922-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

A newly initialized device is disabled for address events, there's no
need to explicitly disable them.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8b342a88ff5c..ea966713ce7e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -810,8 +810,6 @@ static void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
 	if (card->options.sbp.hostnotification) {
 		if (qeth_bridgeport_an_set(card, 1))
 			card->options.sbp.hostnotification = 0;
-	} else {
-		qeth_bridgeport_an_set(card, 0);
 	}
 }
 
-- 
2.17.1
