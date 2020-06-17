Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19748 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgFQOzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 10:55:04 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/2] s390/qeth: fix error handling for isolation mode cmds
Date: Wed, 17 Jun 2020 16:54:52 +0200
Message-Id: <20200617145453.61382-2-jwi@linux.ibm.com>
In-Reply-To: <20200617145453.61382-1-jwi@linux.ibm.com>
References: <20200617145453.61382-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Current(?) OSA devices also store their cmd-specific return codes for
SET_ACCESS_CONTROL cmds into the top-level cmd->hdr.return_code.
So once we added stricter checking for the top-level field a while ago,
none of the error logic that rolls back the user's configuration to its
old state is applied any longer.

For this specific cmd, go back to the old model where we peek into the
cmd structure even though the top-level field indicated an error.

Fixes: 686c97ee29c8 ("s390/qeth: fix error handling in adapter command callbacks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 18a0fb75a710..9636415f810b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4544,9 +4544,6 @@ static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 	int fallback = *(int *)reply->param;
 
 	QETH_CARD_TEXT(card, 4, "setaccb");
-	if (cmd->hdr.return_code)
-		return -EIO;
-	qeth_setadpparms_inspect_rc(cmd);
 
 	access_ctrl_req = &cmd->data.setadapterparms.data.set_access_ctrl;
 	QETH_CARD_TEXT_(card, 2, "rc=%d",
@@ -4556,7 +4553,7 @@ static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 		QETH_DBF_MESSAGE(3, "ERR:SET_ACCESS_CTRL(%#x) on device %x: %#x\n",
 				 access_ctrl_req->subcmd_code, CARD_DEVID(card),
 				 cmd->data.setadapterparms.hdr.return_code);
-	switch (cmd->data.setadapterparms.hdr.return_code) {
+	switch (qeth_setadpparms_inspect_rc(cmd)) {
 	case SET_ACCESS_CTRL_RC_SUCCESS:
 		if (card->options.isolation == ISOLATION_MODE_NONE) {
 			dev_info(&card->gdev->dev,
-- 
2.17.1
