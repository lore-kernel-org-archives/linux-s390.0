Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729746AbgB0RI2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 12:08:28 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RH6787086833
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkfarp3e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 12:08:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Feb 2020 17:08:25 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/8] s390/qeth: remove dead code in qeth_l3_iqd_read_initial_mac()
Date: Thu, 27 Feb 2020 18:08:09 +0100
In-Reply-To: <20200227170816.101286-1-jwi@linux.ibm.com>
References: <20200227170816.101286-1-jwi@linux.ibm.com>
Message-Id: <20200227170816.101286-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

card->info.unique_id is always 0 for IQD devices, so don't bother with
copying it into the 0-initialized cmd.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 317d56647a4a..1c953981f73f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -930,7 +930,6 @@ static int qeth_l3_iqd_read_initial_mac(struct qeth_card *card)
 {
 	int rc = 0;
 	struct qeth_cmd_buffer *iob;
-	struct qeth_ipa_cmd *cmd;
 
 	QETH_CARD_TEXT(card, 2, "hsrmac");
 
@@ -938,9 +937,6 @@ static int qeth_l3_iqd_read_initial_mac(struct qeth_card *card)
 				 IPA_DATA_SIZEOF(create_destroy_addr));
 	if (!iob)
 		return -ENOMEM;
-	cmd = __ipa_cmd(iob);
-	*((__u16 *) &cmd->data.create_destroy_addr.unique_id[6]) =
-			card->info.unique_id;
 
 	rc = qeth_send_ipa_cmd(card, iob, qeth_l3_iqd_read_initial_mac_cb,
 				NULL);
-- 
2.17.1
