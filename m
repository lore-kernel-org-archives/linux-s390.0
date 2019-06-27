Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbfF0PCi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 11:02:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RF2BFK142487
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:02:36 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcy4rbq3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:02:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Jun 2019 16:01:40 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/12] s390/qeth: dynamically allocate MPC cmds
Date: Thu, 27 Jun 2019 17:01:27 +0200
In-Reply-To: <20190627150133.58746-1-jwi@linux.ibm.com>
References: <20190627150133.58746-1-jwi@linux.ibm.com>
Message-Id: <20190627150133.58746-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The base MPC cmds are the last remaining user of the static cmd buffers.
Port them over to use dynamic allocation, and stop backing the write
channel's cmd buffers with pages.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 36 ++++++++++++++++---------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 22074890835e..b4c200eec707 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1454,7 +1454,7 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 		goto out_read_cmd;
 	if (qeth_setup_channel(&card->read, false))
 		goto out_read;
-	if (qeth_setup_channel(&card->write, true))
+	if (qeth_setup_channel(&card->write, false))
 		goto out_write;
 	if (qeth_setup_channel(&card->data, false))
 		goto out_data;
@@ -1737,8 +1737,6 @@ static void qeth_mpc_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob,
 				  unsigned int length)
 {
-	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, length,
-		       iob->data);
 	qeth_idx_finalize_cmd(card, iob, length);
 
 	memcpy(QETH_PDU_HEADER_SEQ_NO(iob->data),
@@ -1751,13 +1749,20 @@ static void qeth_mpc_finalize_cmd(struct qeth_card *card,
 	iob->callback = qeth_release_buffer_cb;
 }
 
-static struct qeth_cmd_buffer *qeth_mpc_get_cmd_buffer(struct qeth_card *card)
+static struct qeth_cmd_buffer *qeth_mpc_alloc_cmd(struct qeth_card *card,
+						  void *data,
+						  unsigned int data_length)
 {
 	struct qeth_cmd_buffer *iob;
 
-	iob = qeth_get_buffer(&card->write);
-	if (iob)
-		iob->finalize = qeth_mpc_finalize_cmd;
+	iob = qeth_alloc_cmd(&card->write, data_length, 1, QETH_TIMEOUT);
+	if (!iob)
+		return NULL;
+
+	memcpy(iob->data, data, data_length);
+	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, data_length,
+		       iob->data);
+	iob->finalize = qeth_mpc_finalize_cmd;
 	return iob;
 }
 
@@ -2080,11 +2085,10 @@ static int qeth_cm_enable(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "cmenable");
 
-	iob = qeth_mpc_get_cmd_buffer(card);
+	iob = qeth_mpc_alloc_cmd(card, CM_ENABLE, CM_ENABLE_SIZE);
 	if (!iob)
 		return -ENOMEM;
 
-	memcpy(iob->data, CM_ENABLE, CM_ENABLE_SIZE);
 	memcpy(QETH_CM_ENABLE_ISSUER_RM_TOKEN(iob->data),
 	       &card->token.issuer_rm_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_CM_ENABLE_FILTER_TOKEN(iob->data),
@@ -2116,11 +2120,10 @@ static int qeth_cm_setup(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "cmsetup");
 
-	iob = qeth_mpc_get_cmd_buffer(card);
+	iob = qeth_mpc_alloc_cmd(card, CM_SETUP, CM_SETUP_SIZE);
 	if (!iob)
 		return -ENOMEM;
 
-	memcpy(iob->data, CM_SETUP, CM_SETUP_SIZE);
 	memcpy(QETH_CM_SETUP_DEST_ADDR(iob->data),
 	       &card->token.issuer_rm_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_CM_SETUP_CONNECTION_TOKEN(iob->data),
@@ -2235,11 +2238,10 @@ static int qeth_ulp_enable(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "ulpenabl");
 
-	iob = qeth_mpc_get_cmd_buffer(card);
+	iob = qeth_mpc_alloc_cmd(card, ULP_ENABLE, ULP_ENABLE_SIZE);
 	if (!iob)
 		return -ENOMEM;
 
-	memcpy(iob->data, ULP_ENABLE, ULP_ENABLE_SIZE);
 	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) = (u8) card->dev->dev_port;
 	memcpy(QETH_ULP_ENABLE_PROT_TYPE(iob->data), &prot_type, 1);
 	memcpy(QETH_ULP_ENABLE_DEST_ADDR(iob->data),
@@ -2283,11 +2285,10 @@ static int qeth_ulp_setup(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "ulpsetup");
 
-	iob = qeth_mpc_get_cmd_buffer(card);
+	iob = qeth_mpc_alloc_cmd(card, ULP_SETUP, ULP_SETUP_SIZE);
 	if (!iob)
 		return -ENOMEM;
 
-	memcpy(iob->data, ULP_SETUP, ULP_SETUP_SIZE);
 	memcpy(QETH_ULP_SETUP_DEST_ADDR(iob->data),
 	       &card->token.cm_connection_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_ULP_SETUP_CONNECTION_TOKEN(iob->data),
@@ -2473,11 +2474,10 @@ static int qeth_dm_act(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "dmact");
 
-	iob = qeth_mpc_get_cmd_buffer(card);
+	iob = qeth_mpc_alloc_cmd(card, DM_ACT, DM_ACT_SIZE);
 	if (!iob)
 		return -ENOMEM;
 
-	memcpy(iob->data, DM_ACT, DM_ACT_SIZE);
 	memcpy(QETH_DM_ACT_DEST_ADDR(iob->data),
 	       &card->token.cm_connection_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_DM_ACT_CONNECTION_TOKEN(iob->data),
@@ -2770,6 +2770,8 @@ void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 	u16 total_length = IPA_PDU_HEADER_SIZE + cmd_length;
 	u8 prot_type = qeth_mpc_select_prot_type(card);
 
+	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, total_length,
+		       iob->data);
 	iob->finalize = qeth_ipa_finalize_cmd;
 	iob->timeout = QETH_IPA_TIMEOUT;
 
-- 
2.17.1
