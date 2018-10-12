From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/4] s390/qeth: enhance TSO control sequence
Date: Fri, 12 Oct 2018 17:27:13 +0200
Message-ID: <20181012152715.6153-3-jwi@linux.ibm.com>
References: <20181012152715.6153-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181012152715.6153-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

TSO6 requires the full programming sequence, and not just a simple
START command. This implements the additional ENABLE command, and adds
some sanity checks that were missing for the START command.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 77 ++++++++++++++++++++++++++++++++++++++-
 drivers/s390/net/qeth_core_mpc.h  | 26 +++++++++++++
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 92e539d1fbd3..ab022b6a41ea 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5394,6 +5394,21 @@ static int qeth_setassparms_inspect_rc(struct qeth_ipa_cmd *cmd)
 	return cmd->hdr.return_code;
 }
 
+static int qeth_setassparms_get_caps_cb(struct qeth_card *card,
+					struct qeth_reply *reply,
+					unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+	struct qeth_ipa_caps *caps = reply->param;
+
+	if (qeth_setassparms_inspect_rc(cmd))
+		return 0;
+
+	caps->supported = cmd->data.setassparms.data.caps.supported;
+	caps->enabled = cmd->data.setassparms.data.caps.enabled;
+	return 0;
+}
+
 int qeth_setassparms_cb(struct qeth_card *card,
 			struct qeth_reply *reply, unsigned long data)
 {
@@ -6396,6 +6411,20 @@ static int qeth_set_ipa_csum(struct qeth_card *card, bool on, int cstype,
 	return rc ? -EIO : 0;
 }
 
+static int qeth_start_tso_cb(struct qeth_card *card, struct qeth_reply *reply,
+			     unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+	struct qeth_tso_start_data *tso_data = reply->param;
+
+	if (qeth_setassparms_inspect_rc(cmd))
+		return 0;
+
+	tso_data->mss = cmd->data.setassparms.data.tso.mss;
+	tso_data->supported = cmd->data.setassparms.data.tso.supported;
+	return 0;
+}
+
 static int qeth_set_tso_off(struct qeth_card *card,
 			    enum qeth_prot_versions prot)
 {
@@ -6406,8 +6435,52 @@ static int qeth_set_tso_off(struct qeth_card *card,
 static int qeth_set_tso_on(struct qeth_card *card,
 			   enum qeth_prot_versions prot)
 {
-	return qeth_send_simple_setassparms_prot(card, IPA_OUTBOUND_TSO,
-						 IPA_CMD_ASS_START, 0, prot);
+	struct qeth_tso_start_data tso_data;
+	struct qeth_cmd_buffer *iob;
+	struct qeth_ipa_caps caps;
+	int rc;
+
+	iob = qeth_get_setassparms_cmd(card, IPA_OUTBOUND_TSO,
+				       IPA_CMD_ASS_START, 0, prot);
+	if (!iob)
+		return -ENOMEM;
+
+	rc = qeth_send_setassparms(card, iob, 0, 0 /* unused */,
+				   qeth_start_tso_cb, &tso_data);
+	if (rc)
+		return rc;
+
+	if (!tso_data.mss || !(tso_data.supported & QETH_IPA_LARGE_SEND_TCP)) {
+		qeth_set_tso_off(card, prot);
+		return -EOPNOTSUPP;
+	}
+
+	iob = qeth_get_setassparms_cmd(card, IPA_OUTBOUND_TSO,
+				       IPA_CMD_ASS_ENABLE, sizeof(caps), prot);
+	if (!iob) {
+		qeth_set_tso_off(card, prot);
+		return -ENOMEM;
+	}
+
+	/* enable TSO capability */
+	caps.supported = 0;
+	caps.enabled = QETH_IPA_LARGE_SEND_TCP;
+	rc = qeth_send_setassparms(card, iob, sizeof(caps), (long) &caps,
+				   qeth_setassparms_get_caps_cb, &caps);
+	if (rc) {
+		qeth_set_tso_off(card, prot);
+		return rc;
+	}
+
+	if (!qeth_ipa_caps_supported(&caps, QETH_IPA_LARGE_SEND_TCP) ||
+	    !qeth_ipa_caps_enabled(&caps, QETH_IPA_LARGE_SEND_TCP)) {
+		qeth_set_tso_off(card, prot);
+		return -EOPNOTSUPP;
+	}
+
+	dev_info(&card->gdev->dev, "TSOv%u enabled (MSS: %u)\n", prot,
+		 tso_data.mss);
+	return 0;
 }
 
 static int qeth_set_ipa_tso(struct qeth_card *card, bool on,
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index aa5de1fe01e1..e85090467afe 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -56,6 +56,21 @@ static inline bool qeth_intparm_is_iob(unsigned long intparm)
 #define IPA_CMD_INITIATOR_OSA_REPLY   0x81
 #define IPA_CMD_PRIM_VERSION_NO 0x01
 
+struct qeth_ipa_caps {
+	u32 supported;
+	u32 enabled;
+};
+
+static inline bool qeth_ipa_caps_supported(struct qeth_ipa_caps *caps, u32 mask)
+{
+	return (caps->supported & mask) == mask;
+}
+
+static inline bool qeth_ipa_caps_enabled(struct qeth_ipa_caps *caps, u32 mask)
+{
+	return (caps->enabled & mask) == mask;
+}
+
 enum qeth_card_types {
 	QETH_CARD_TYPE_OSD     = 1,
 	QETH_CARD_TYPE_IQD     = 5,
@@ -405,14 +420,25 @@ struct qeth_checksum_cmd {
 	__u32 enabled;
 } __packed;
 
+enum qeth_ipa_large_send_caps {
+	QETH_IPA_LARGE_SEND_TCP		= 0x00000001,
+};
+
+struct qeth_tso_start_data {
+	u32 mss;
+	u32 supported;
+};
+
 /* SETASSPARMS IPA Command: */
 struct qeth_ipacmd_setassparms {
 	struct qeth_ipacmd_setassparms_hdr hdr;
 	union {
 		__u32 flags_32bit;
+		struct qeth_ipa_caps caps;
 		struct qeth_checksum_cmd chksum;
 		struct qeth_arp_cache_entry add_arp_entry;
 		struct qeth_arp_query_data query_arp;
+		struct qeth_tso_start_data tso;
 		__u8 ip[16];
 	} data;
 } __attribute__ ((packed));
-- 
2.16.4
