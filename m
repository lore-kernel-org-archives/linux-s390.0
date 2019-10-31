Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46780 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbfJaMm7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:59 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCeSC7052635
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxwmq9bea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 31 Oct 2019 12:42:29 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/8] s390/qeth: don't set card state in qeth_qdio_clear_card()
Date: Thu, 31 Oct 2019 13:42:19 +0100
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Message-Id: <20191031124221.34028-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Any change to the card state should only be driven by
qeth_l?_set_online() and qeth_l?_stop_card().

qeth_qdio_clear_card() currently also gets called from
(a) qeth_core_shutdown(), where we haven't walked through the whole
    teardown sequence. So changing the state to DOWN is not accurate.
(b) qeth_core_hardsetup_card(), which is only called while the card is
    still in DOWN state. No change in behaviour here.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d51dcb3c5a01..9e8bd8e08146 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1513,7 +1513,6 @@ int qeth_qdio_clear_card(struct qeth_card *card, int use_halt)
 	rc = qeth_clear_halt_card(card, use_halt);
 	if (rc)
 		QETH_CARD_TEXT_(card, 3, "2err%d", rc);
-	card->state = CARD_STATE_DOWN;
 	return rc;
 }
 EXPORT_SYMBOL_GPL(qeth_qdio_clear_card);
-- 
2.17.1
