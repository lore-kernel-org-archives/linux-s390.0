From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net,stable] s390/qeth: fix length check in SNMP processing
Date: Wed, 28 Nov 2018 16:20:50 +0100
Message-ID: <20181128152050.36500-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

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
---
 drivers/s390/net/qeth_core_main.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4bce5ae65a55..254065271867 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4518,8 +4518,8 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_info *qinfo;
-	struct qeth_snmp_cmd *snmp;
 	unsigned char *data;
+	void *snmp_data;
 	__u16 data_len;
 
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
@@ -4527,7 +4527,6 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 	cmd = (struct qeth_ipa_cmd *) sdata;
 	data = (unsigned char *)((char *)cmd - reply->offset);
 	qinfo = (struct qeth_arp_query_info *) reply->param;
-	snmp = &cmd->data.setadapterparms.data.snmp;
 
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%x", cmd->hdr.return_code);
@@ -4540,10 +4539,15 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
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
@@ -4556,16 +4560,9 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
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
2.16.4
