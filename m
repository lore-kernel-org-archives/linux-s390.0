Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729892AbgB0RIb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 12:08:31 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RH6ePT027744
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqfw7xsc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:30 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Feb 2020 17:08:28 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: reset seqnos on connection startup
Date: Thu, 27 Feb 2020 18:08:13 +0100
In-Reply-To: <20200227170816.101286-1-jwi@linux.ibm.com>
References: <20200227170816.101286-1-jwi@linux.ibm.com>
Message-Id: <20200227170816.101286-6-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

This let's us start every new IDX connection with clean seqnos.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5efcaa43615b..ba1e50ed50ec 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1624,17 +1624,16 @@ static void qeth_set_blkt_defaults(struct qeth_card *card)
 	}
 }
 
-static void qeth_init_tokens(struct qeth_card *card)
+static void qeth_idx_init(struct qeth_card *card)
 {
+	memset(&card->seqno, 0, sizeof(card->seqno));
+
 	card->token.issuer_rm_w = 0x00010103UL;
 	card->token.cm_filter_w = 0x00010108UL;
 	card->token.cm_connection_w = 0x0001010aUL;
 	card->token.ulp_filter_w = 0x0001010bUL;
 	card->token.ulp_connection_w = 0x0001010dUL;
-}
 
-static void qeth_init_func_level(struct qeth_card *card)
-{
 	switch (card->info.type) {
 	case QETH_CARD_TYPE_IQD:
 		card->info.func_level =	QETH_IDX_FUNC_LEVEL_IQD;
@@ -4952,9 +4951,9 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 		else
 			goto retry;
 	}
+
 	qeth_determine_capabilities(card);
-	qeth_init_tokens(card);
-	qeth_init_func_level(card);
+	qeth_idx_init(card);
 
 	rc = qeth_idx_activate_read_channel(card);
 	if (rc == -EINTR) {
-- 
2.17.1
