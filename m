Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727012AbgKQQPi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:38 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/9] s390/qeth: use QUERY OAT for initial link info
Date: Tue, 17 Nov 2020 17:15:19 +0100
Message-Id: <20201117161520.1089-9-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Improve the initial link info with data obtained from QUERY OAT.
Doing so _only_ at initialization time avoids
1. dealing with multi-part replies, and
2. sifting through all the data that may get returned at runtime.

This allows us to determine the correct port type for the 1000BT variant
of recent OSA adapter generations (where the .card_type field in
QUERY CARD INFO is no longer sufficient).

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 107 ++++++++++++++++++++++++++++++
 drivers/s390/net/qeth_core_mpc.h  |  40 ++++++++++-
 2 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index aac38ade024b..57dad31aab4d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4950,6 +4950,86 @@ int qeth_query_card_info(struct qeth_card *card,
 	return qeth_send_ipa_cmd(card, iob, qeth_query_card_info_cb, link_info);
 }
 
+static int qeth_init_link_info_oat_cb(struct qeth_card *card,
+				      struct qeth_reply *reply_priv,
+				      unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
+	struct qeth_link_info *link_info = reply_priv->param;
+	struct qeth_query_oat_physical_if *phys_if;
+	struct qeth_query_oat_reply *reply;
+
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return -EIO;
+
+	/* Multi-part reply is unexpected, don't bother: */
+	if (cmd->data.setadapterparms.hdr.used_total > 1)
+		return -EINVAL;
+
+	/* Expect the reply to start with phys_if data: */
+	reply = &cmd->data.setadapterparms.data.query_oat.reply[0];
+	if (reply->type != QETH_QOAT_REPLY_TYPE_PHYS_IF ||
+	    reply->length < sizeof(*reply))
+		return -EINVAL;
+
+	phys_if = &reply->phys_if;
+
+	switch (phys_if->speed_duplex) {
+	case QETH_QOAT_PHYS_SPEED_10M_HALF:
+		link_info->speed = SPEED_10;
+		link_info->duplex = DUPLEX_HALF;
+		break;
+	case QETH_QOAT_PHYS_SPEED_10M_FULL:
+		link_info->speed = SPEED_10;
+		link_info->duplex = DUPLEX_FULL;
+		break;
+	case QETH_QOAT_PHYS_SPEED_100M_HALF:
+		link_info->speed = SPEED_100;
+		link_info->duplex = DUPLEX_HALF;
+		break;
+	case QETH_QOAT_PHYS_SPEED_100M_FULL:
+		link_info->speed = SPEED_100;
+		link_info->duplex = DUPLEX_FULL;
+		break;
+	case QETH_QOAT_PHYS_SPEED_1000M_HALF:
+		link_info->speed = SPEED_1000;
+		link_info->duplex = DUPLEX_HALF;
+		break;
+	case QETH_QOAT_PHYS_SPEED_1000M_FULL:
+		link_info->speed = SPEED_1000;
+		link_info->duplex = DUPLEX_FULL;
+		break;
+	case QETH_QOAT_PHYS_SPEED_10G_FULL:
+		link_info->speed = SPEED_10000;
+		link_info->duplex = DUPLEX_FULL;
+		break;
+	case QETH_QOAT_PHYS_SPEED_25G_FULL:
+		link_info->speed = SPEED_25000;
+		link_info->duplex = DUPLEX_FULL;
+		break;
+	case QETH_QOAT_PHYS_SPEED_UNKNOWN:
+	default:
+		link_info->speed = SPEED_UNKNOWN;
+		link_info->duplex = DUPLEX_UNKNOWN;
+		break;
+	}
+
+	switch (phys_if->media_type) {
+	case QETH_QOAT_PHYS_MEDIA_COPPER:
+		link_info->port = PORT_TP;
+		break;
+	case QETH_QOAT_PHYS_MEDIA_FIBRE_SHORT:
+	case QETH_QOAT_PHYS_MEDIA_FIBRE_LONG:
+		link_info->port = PORT_FIBRE;
+		break;
+	default:
+		link_info->port = PORT_OTHER;
+		break;
+	}
+
+	return 0;
+}
+
 static void qeth_init_link_info(struct qeth_card *card)
 {
 	card->info.link_info.duplex = DUPLEX_FULL;
@@ -4984,6 +5064,33 @@ static void qeth_init_link_info(struct qeth_card *card)
 			card->info.link_info.port = PORT_OTHER;
 		}
 	}
+
+	/* Get more accurate data via QUERY OAT: */
+	if (qeth_adp_supported(card, IPA_SETADP_QUERY_OAT)) {
+		struct qeth_link_info link_info;
+		struct qeth_cmd_buffer *iob;
+
+		iob = qeth_get_adapter_cmd(card, IPA_SETADP_QUERY_OAT,
+					   SETADP_DATA_SIZEOF(query_oat));
+		if (iob) {
+			struct qeth_ipa_cmd *cmd = __ipa_cmd(iob);
+			struct qeth_query_oat *oat_req;
+
+			oat_req = &cmd->data.setadapterparms.data.query_oat;
+			oat_req->subcmd_code = QETH_QOAT_SCOPE_INTERFACE;
+
+			if (!qeth_send_ipa_cmd(card, iob,
+					       qeth_init_link_info_oat_cb,
+					       &link_info)) {
+				if (link_info.speed != SPEED_UNKNOWN)
+					card->info.link_info.speed = link_info.speed;
+				if (link_info.duplex != DUPLEX_UNKNOWN)
+					card->info.link_info.duplex = link_info.duplex;
+				if (link_info.port != PORT_OTHER)
+					card->info.link_info.port = link_info.port;
+			}
+		}
+	}
 }
 
 /**
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 6541bab96822..e4bde7daf083 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -489,9 +489,45 @@ struct qeth_set_access_ctrl {
 	__u8 reserved[8];
 } __attribute__((packed));
 
+#define QETH_QOAT_PHYS_SPEED_UNKNOWN		0x00
+#define QETH_QOAT_PHYS_SPEED_10M_HALF		0x01
+#define QETH_QOAT_PHYS_SPEED_10M_FULL		0x02
+#define QETH_QOAT_PHYS_SPEED_100M_HALF		0x03
+#define QETH_QOAT_PHYS_SPEED_100M_FULL		0x04
+#define QETH_QOAT_PHYS_SPEED_1000M_HALF		0x05
+#define QETH_QOAT_PHYS_SPEED_1000M_FULL		0x06
+// n/a						0x07
+#define QETH_QOAT_PHYS_SPEED_10G_FULL		0x08
+// n/a						0x09
+#define QETH_QOAT_PHYS_SPEED_25G_FULL		0x0A
+
+#define QETH_QOAT_PHYS_MEDIA_COPPER		0x01
+#define QETH_QOAT_PHYS_MEDIA_FIBRE_SHORT	0x02
+#define QETH_QOAT_PHYS_MEDIA_FIBRE_LONG		0x04
+
+struct qeth_query_oat_physical_if {
+	u8 res_head[33];
+	u8 speed_duplex;
+	u8 media_type;
+	u8 res_tail[29];
+};
+
+#define QETH_QOAT_REPLY_TYPE_PHYS_IF		0x0004
+
+struct qeth_query_oat_reply {
+	u16 type;
+	u16 length;
+	u16 version;
+	u8 res[10];
+	struct qeth_query_oat_physical_if phys_if;
+};
+
+#define QETH_QOAT_SCOPE_INTERFACE		0x00000001
+
 struct qeth_query_oat {
-	__u32 subcmd_code;
-	__u8 reserved[12];
+	u32 subcmd_code;
+	u8 reserved[12];
+	struct qeth_query_oat_reply reply[];
 } __packed;
 
 struct qeth_qoat_priv {
-- 
2.17.1
