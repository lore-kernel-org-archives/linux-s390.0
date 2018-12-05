Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 098/123] s390/qeth: fix length check in SNMP processing
Date: Wed,  5 Dec 2018 04:35:30 -0500
Message-Id: <20181205093555.5386-98-sashal@kernel.org>
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 9a764c1e59684c0358e16ccaafd870629f2cfe67 ]

The response for a SNMP request can consist of multiple parts, which
the cmd callback stages into a kernel buffer until all parts have been
received. If the callback detects that the staging buffer provides
insufficient space, it bails out with error.
This processing is buggy for the first part of the response - while it
initially checks for a length of 'data_len', it later copies an
additional amount of 'offsetof(struct qeth_snmp_cmd, data)' bytes.

Fix the calculation of 'data_len' for the first part of the response.
This also nicely cleans up the memcpy code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ffce6f39828a..b03515d43745 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4524,8 +4524,8 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_info *qinfo;
-	struct qeth_snmp_cmd *snmp;
 	unsigned char *data;
+	void *snmp_data;
 	__u16 data_len;
 
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
@@ -4533,7 +4533,6 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 	cmd = (struct qeth_ipa_cmd *) sdata;
 	data = (unsigned char *)((char *)cmd - reply->offset);
 	qinfo = (struct qeth_arp_query_info *) reply->param;
-	snmp = &cmd->data.setadapterparms.data.snmp;
 
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%x", cmd->hdr.return_code);
@@ -4546,10 +4545,15 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 		return 0;
 	}
 	data_len = *((__u16 *)QETH_IPA_PDU_LEN_PDU1(data));
-	if (cmd->data.setadapterparms.hdr.seq_no == 1)
-		data_len -= (__u16)((char *)&snmp->data - (char *)cmd);
-	else
-		data_len -= (__u16)((char *)&snmp->request - (char *)cmd);
+	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
+		snmp_data = &cmd->data.setadapterparms.data.snmp;
+		data_len -= offsetof(struct qeth_ipa_cmd,
+				     data.setadapterparms.data.snmp);
+	} else {
+		snmp_data = &cmd->data.setadapterparms.data.snmp.request;
+		data_len -= offsetof(struct qeth_ipa_cmd,
+				     data.setadapterparms.data.snmp.request);
+	}
 
 	/* check if there is enough room in userspace */
 	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
@@ -4562,16 +4566,9 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 	QETH_CARD_TEXT_(card, 4, "sseqn%i",
 		cmd->data.setadapterparms.hdr.seq_no);
 	/*copy entries to user buffer*/
-	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)snmp,
-		       data_len + offsetof(struct qeth_snmp_cmd, data));
-		qinfo->udata_offset += offsetof(struct qeth_snmp_cmd, data);
-	} else {
-		memcpy(qinfo->udata + qinfo->udata_offset,
-		       (char *)&snmp->request, data_len);
-	}
+	memcpy(qinfo->udata + qinfo->udata_offset, snmp_data, data_len);
 	qinfo->udata_offset += data_len;
+
 	/* check if all replies received ... */
 		QETH_CARD_TEXT_(card, 4, "srtot%i",
 			       cmd->data.setadapterparms.hdr.used_total);
-- 
2.17.1
