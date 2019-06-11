Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405613AbfFKQiQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:16 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGR71d102396
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2eug3vrb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:14 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:12 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 12/13] s390/qeth: command-chain the IDX sequence
Date: Tue, 11 Jun 2019 18:37:59 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-13-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The current IDX sequence first sends one WRITE cmd to activate the
device, and then sends a second cmd that READs the response.

Using qeth_alloc_cmd(), we can combine this into a single IO with two
command-chained CCWs.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 58 ++++++++-----------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 671754a0e591..11e6a3820421 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1709,9 +1709,6 @@ static void qeth_idx_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob,
 				  unsigned int length)
 {
-	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, length,
-		       iob->data);
-
 	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data), &card->seqno.trans_hdr,
 	       QETH_SEQ_NO_LENGTH);
 	if (iob->channel == &card->write)
@@ -1731,6 +1728,8 @@ static void qeth_mpc_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob,
 				  unsigned int length)
 {
+	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, length,
+		       iob->data);
 	qeth_idx_finalize_cmd(card, iob, length);
 
 	memcpy(QETH_PDU_HEADER_SEQ_NO(iob->data),
@@ -1920,8 +1919,8 @@ static int qeth_idx_check_activate_response(struct qeth_card *card,
 	}
 }
 
-static void qeth_idx_query_read_cb(struct qeth_card *card,
-				   struct qeth_cmd_buffer *iob)
+static void qeth_idx_activate_read_channel_cb(struct qeth_card *card,
+					      struct qeth_cmd_buffer *iob)
 {
 	struct qeth_channel *channel = iob->channel;
 	u16 peer_level;
@@ -1953,8 +1952,8 @@ static void qeth_idx_query_read_cb(struct qeth_card *card,
 	qeth_release_buffer(iob);
 }
 
-static void qeth_idx_query_write_cb(struct qeth_card *card,
-				    struct qeth_cmd_buffer *iob)
+static void qeth_idx_activate_write_channel_cb(struct qeth_card *card,
+					       struct qeth_cmd_buffer *iob)
 {
 	struct qeth_channel *channel = iob->channel;
 	u16 peer_level;
@@ -1980,30 +1979,19 @@ static void qeth_idx_query_write_cb(struct qeth_card *card,
 	qeth_release_buffer(iob);
 }
 
-static void qeth_idx_finalize_query_cmd(struct qeth_card *card,
-					struct qeth_cmd_buffer *iob,
-					unsigned int length)
-{
-	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_READ, 0, length, iob->data);
-}
-
-static void qeth_idx_activate_cb(struct qeth_card *card,
-				 struct qeth_cmd_buffer *iob)
-{
-	qeth_notify_reply(iob->reply, 0);
-	qeth_release_buffer(iob);
-}
-
 static void qeth_idx_setup_activate_cmd(struct qeth_card *card,
 					struct qeth_cmd_buffer *iob)
 {
 	u16 addr = (card->info.cula << 8) + card->info.unit_addr2;
 	u8 port = ((u8)card->dev->dev_port) | 0x80;
+	struct ccw1 *ccw = __ccw_from_cmd(iob);
 	struct ccw_dev_id dev_id;
 
+	qeth_setup_ccw(&ccw[0], CCW_CMD_WRITE, CCW_FLAG_CC, IDX_ACTIVATE_SIZE,
+		       iob->data);
+	qeth_setup_ccw(&ccw[1], CCW_CMD_READ, 0, iob->length, iob->data);
 	ccw_device_get_id(CARD_DDEV(card), &dev_id);
 	iob->finalize = qeth_idx_finalize_cmd;
-	iob->callback = qeth_idx_activate_cb;
 
 	memcpy(QETH_IDX_ACT_PNO(iob->data), &port, 1);
 	memcpy(QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
@@ -2022,27 +2010,18 @@ static int qeth_idx_activate_read_channel(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "idxread");
 
-	iob = qeth_get_buffer(channel);
+	iob = qeth_alloc_cmd(channel, QETH_BUFSIZE, 2, QETH_TIMEOUT);
 	if (!iob)
 		return -ENOMEM;
 
 	memcpy(iob->data, IDX_ACTIVATE_READ, IDX_ACTIVATE_SIZE);
 	qeth_idx_setup_activate_cmd(card, iob);
+	iob->callback = qeth_idx_activate_read_channel_cb;
 
 	rc = qeth_send_control_data(card, IDX_ACTIVATE_SIZE, iob, NULL, NULL);
 	if (rc)
 		return rc;
 
-	iob = qeth_get_buffer(channel);
-	if (!iob)
-		return -ENOMEM;
-
-	iob->finalize = qeth_idx_finalize_query_cmd;
-	iob->callback = qeth_idx_query_read_cb;
-	rc = qeth_send_control_data(card, QETH_BUFSIZE, iob, NULL, NULL);
-	if (rc)
-		return rc;
-
 	channel->state = CH_STATE_UP;
 	return 0;
 }
@@ -2055,27 +2034,18 @@ static int qeth_idx_activate_write_channel(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "idxwrite");
 
-	iob = qeth_get_buffer(channel);
+	iob = qeth_alloc_cmd(channel, QETH_BUFSIZE, 2, QETH_TIMEOUT);
 	if (!iob)
 		return -ENOMEM;
 
 	memcpy(iob->data, IDX_ACTIVATE_WRITE, IDX_ACTIVATE_SIZE);
 	qeth_idx_setup_activate_cmd(card, iob);
+	iob->callback = qeth_idx_activate_write_channel_cb;
 
 	rc = qeth_send_control_data(card, IDX_ACTIVATE_SIZE, iob, NULL, NULL);
 	if (rc)
 		return rc;
 
-	iob = qeth_get_buffer(channel);
-	if (!iob)
-		return -ENOMEM;
-
-	iob->finalize = qeth_idx_finalize_query_cmd;
-	iob->callback = qeth_idx_query_write_cb;
-	rc = qeth_send_control_data(card, QETH_BUFSIZE, iob, NULL, NULL);
-	if (rc)
-		return rc;
-
 	channel->state = CH_STATE_UP;
 	return 0;
 }
-- 
2.17.1
