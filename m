Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/10] s390/qeth: reduce data length for ARP cache query
Date: Tue, 12 Feb 2019 18:33:16 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_l3_query_arp_cache_info() indicates a data length that's much
larger than the actual length of its request (ie. the value passed to
qeth_get_setassparms_cmd()). The confusion presumably comes from the
fact that the cmd _response_ can be quite large - but that's no concern
for the initial request IO.

Fixing this up allows us to use the generic qeth_send_ipa_cmd()
infrastructure.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  3 ---
 drivers/s390/net/qeth_core_main.c | 13 ++++++-------
 drivers/s390/net/qeth_core_mpc.h  |  5 -----
 drivers/s390/net/qeth_l3_main.c   |  4 +---
 4 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 71d27a804920..f35e0b58ba4e 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1004,9 +1004,6 @@ void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob);
 struct qeth_cmd_buffer *qeth_wait_for_buffer(struct qeth_channel *);
 int qeth_query_switch_attributes(struct qeth_card *card,
 				  struct qeth_switch_info *sw_info);
-int qeth_send_control_data(struct qeth_card *, int, struct qeth_cmd_buffer *,
-	int (*reply_cb)(struct qeth_card *, struct qeth_reply*, unsigned long),
-	void *reply_param);
 unsigned int qeth_count_elements(struct sk_buff *skb, unsigned int data_offset);
 int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			struct sk_buff *skb, struct qeth_hdr *hdr,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6ef0c89370b5..47927613d43c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2020,12 +2020,12 @@ EXPORT_SYMBOL_GPL(qeth_prepare_control_data);
  * field 'param' of the structure qeth_reply.
  */
 
-int qeth_send_control_data(struct qeth_card *card, int len,
-		struct qeth_cmd_buffer *iob,
-		int (*reply_cb)(struct qeth_card *cb_card,
-				struct qeth_reply *cb_reply,
-				unsigned long cb_cmd),
-		void *reply_param)
+static int qeth_send_control_data(struct qeth_card *card, int len,
+				  struct qeth_cmd_buffer *iob,
+				  int (*reply_cb)(struct qeth_card *cb_card,
+						  struct qeth_reply *cb_reply,
+						  unsigned long cb_cmd),
+				  void *reply_param)
 {
 	struct qeth_channel *channel = iob->channel;
 	int rc;
@@ -2116,7 +2116,6 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	qeth_put_reply(reply);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(qeth_send_control_data);
 
 static int qeth_cm_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 		unsigned long data)
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index c7fb14a61eed..07a48ee95dba 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -834,15 +834,10 @@ enum qeth_ipa_arp_return_codes {
 extern const char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc);
 extern const char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd);
 
-#define QETH_SETASS_BASE_LEN (IPA_PDU_HEADER_SIZE + \
-			      sizeof(struct qeth_ipacmd_hdr) + \
-			      sizeof(struct qeth_ipacmd_setassparms_hdr))
 #define QETH_SETADP_BASE_LEN (sizeof(struct qeth_ipacmd_hdr) + \
 			      sizeof(struct qeth_ipacmd_setadpparms_hdr))
 #define QETH_SNMP_SETADP_CMDLENGTH 16
 
-#define QETH_ARP_DATA_SIZE 3968
-#define QETH_ARP_CMD_LEN (QETH_ARP_DATA_SIZE + 8)
 /* Helper functions */
 #define IS_IPA_REPLY(cmd) ((cmd->hdr.initiator == IPA_CMD_INITIATOR_HOST) || \
 			   (cmd->hdr.initiator == IPA_CMD_INITIATOR_OSA_REPLY))
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f7d0623999ba..f0b790810ebc 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1696,9 +1696,7 @@ static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
 		return -ENOMEM;
 	cmd = __ipa_cmd(iob);
 	cmd->data.setassparms.data.query_arp.request_bits = 0x000F;
-	rc = qeth_send_control_data(card,
-				    QETH_SETASS_BASE_LEN + QETH_ARP_CMD_LEN,
-				    iob, qeth_l3_arp_query_cb, qinfo);
+	rc = qeth_send_ipa_cmd(card, iob, qeth_l3_arp_query_cb, qinfo);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "Error while querying ARP cache on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
-- 
2.16.4
