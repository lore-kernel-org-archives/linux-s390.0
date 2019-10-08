Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728465AbfJHQVR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Oct 2019 12:21:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x98GD2jw017039
        for <linux-s390@vger.kernel.org>; Tue, 8 Oct 2019 12:21:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vgvsjtrht-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 08 Oct 2019 12:21:15 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 8 Oct 2019 17:21:14 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/2] s390/qeth: Fix error handling during VNICC initialization
Date: Tue,  8 Oct 2019 18:21:06 +0200
In-Reply-To: <20191008162107.95259-1-jwi@linux.ibm.com>
References: <20191008162107.95259-1-jwi@linux.ibm.com>
Message-Id: <20191008162107.95259-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

From: Alexandra Winter <wintera@linux.ibm.com>

Smatch discovered the use of uninitialized variable sup_cmds
in error paths.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index b8799cd3e7aa..de62a9ccc882 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2021,10 +2021,10 @@ static bool qeth_l2_vnicc_recover_char(struct qeth_card *card, u32 vnicc,
 static void qeth_l2_vnicc_init(struct qeth_card *card)
 {
 	u32 *timeout = &card->options.vnicc.learning_timeout;
+	bool enable, error = false;
 	unsigned int chars_len, i;
 	unsigned long chars_tmp;
 	u32 sup_cmds, vnicc;
-	bool enable, error;
 
 	QETH_CARD_TEXT(card, 2, "vniccini");
 	/* reset rx_bcast */
@@ -2045,7 +2045,10 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 	chars_len = sizeof(card->options.vnicc.sup_chars) * BITS_PER_BYTE;
 	for_each_set_bit(i, &chars_tmp, chars_len) {
 		vnicc = BIT(i);
-		qeth_l2_vnicc_query_cmds(card, vnicc, &sup_cmds);
+		if (qeth_l2_vnicc_query_cmds(card, vnicc, &sup_cmds)) {
+			sup_cmds = 0;
+			error = true;
+		}
 		if (!(sup_cmds & IPA_VNICC_SET_TIMEOUT) ||
 		    !(sup_cmds & IPA_VNICC_GET_TIMEOUT))
 			card->options.vnicc.getset_timeout_sup &= ~vnicc;
@@ -2054,8 +2057,8 @@ static void qeth_l2_vnicc_init(struct qeth_card *card)
 			card->options.vnicc.set_char_sup &= ~vnicc;
 	}
 	/* enforce assumed default values and recover settings, if changed  */
-	error = qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
-					      timeout);
+	error |= qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
+					       timeout);
 	chars_tmp = card->options.vnicc.wanted_chars ^ QETH_VNICC_DEFAULT;
 	chars_tmp |= QETH_VNICC_BRIDGE_INVISIBLE;
 	chars_len = sizeof(card->options.vnicc.wanted_chars) * BITS_PER_BYTE;
-- 
2.17.1
