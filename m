From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 15/15] s390/qeth: reduce 0-initializing when building IPA cmds
Date: Mon, 17 Sep 2018 17:36:09 +0200
Message-ID: <20180917153609.94628-16-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_get_ipacmd_buffer() obtains its buffers for building IPA cmds from
__qeth_get_buffer(), where they are fully cleared. So get rid of all the
additional zero-ing in various other places.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 100b6f4a3fb8..89e09e7b8fff 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -780,7 +780,6 @@ void qeth_release_buffer(struct qeth_channel *channel,
 
 	QETH_CARD_TEXT(CARD_FROM_CDEV(channel->ccwdev), 6, "relbuff");
 	spin_lock_irqsave(&channel->iob_lock, flags);
-	memset(iob->data, 0, QETH_BUFSIZE);
 	iob->state = BUF_STATE_FREE;
 	iob->callback = qeth_send_control_data_cb;
 	iob->rc = 0;
@@ -1334,8 +1333,8 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 		return 0;
 
 	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++) {
-		channel->iob[cnt].data =
-			kzalloc(QETH_BUFSIZE, GFP_DMA|GFP_KERNEL);
+		channel->iob[cnt].data = kmalloc(QETH_BUFSIZE,
+						 GFP_KERNEL | GFP_DMA);
 		if (channel->iob[cnt].data == NULL)
 			break;
 		channel->iob[cnt].state = BUF_STATE_FREE;
@@ -2888,10 +2887,10 @@ static __u8 qeth_get_ipa_adp_type(enum qeth_link_types link_type)
 }
 
 static void qeth_fill_ipacmd_header(struct qeth_card *card,
-		struct qeth_ipa_cmd *cmd, __u8 command,
-		enum qeth_prot_versions prot)
+				    struct qeth_ipa_cmd *cmd,
+				    enum qeth_ipa_cmds command,
+				    enum qeth_prot_versions prot)
 {
-	memset(cmd, 0, sizeof(struct qeth_ipa_cmd));
 	cmd->hdr.command = command;
 	cmd->hdr.initiator = IPA_CMD_INITIATOR_HOST;
 	/* cmd->hdr.seqno is set by qeth_send_control_data() */
@@ -2903,8 +2902,6 @@ static void qeth_fill_ipacmd_header(struct qeth_card *card,
 		cmd->hdr.prim_version_no = 1;
 	cmd->hdr.param_count = 1;
 	cmd->hdr.prot_version = prot;
-	cmd->hdr.ipa_supported = 0;
-	cmd->hdr.ipa_enabled = 0;
 }
 
 struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
@@ -5494,8 +5491,6 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *card,
 		cmd->data.setassparms.hdr.assist_no = ipa_func;
 		cmd->data.setassparms.hdr.length = 8 + len;
 		cmd->data.setassparms.hdr.command_code = cmd_code;
-		cmd->data.setassparms.hdr.return_code = 0;
-		cmd->data.setassparms.hdr.seq_no = 0;
 	}
 
 	return iob;
-- 
2.16.4
