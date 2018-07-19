From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/11] s390/qeth: don't cache HW port number
Date: Thu, 19 Jul 2018 12:43:52 +0200
Message-ID: <20180719104358.79696-6-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The netdevice is always available now, so get the portno from there.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 7 +++----
 drivers/s390/net/qeth_core_sys.c  | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 4d6827c8aba4..04b900c7060d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -658,7 +658,6 @@ struct qeth_card_info {
 	char mcl_level[QETH_MCL_LENGTH + 1];
 	int guestlan;
 	int mac_bits;
-	int portno;
 	enum qeth_card_types type;
 	enum qeth_link_types link_type;
 	int initial_mtu;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 6df2226417f1..39c429787c4d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1920,7 +1920,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 		memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
 		       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
 	}
-	tmp = ((__u8)card->info.portno) | 0x80;
+	tmp = ((u8)card->dev->dev_port) | 0x80;
 	memcpy(QETH_IDX_ACT_PNO(iob->data), &tmp, 1);
 	memcpy(QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
 	       &card->token.issuer_rm_w, QETH_MPC_TOKEN_LENGTH);
@@ -2389,8 +2389,7 @@ static int qeth_ulp_enable(struct qeth_card *card)
 	iob = qeth_wait_for_buffer(&card->write);
 	memcpy(iob->data, ULP_ENABLE, ULP_ENABLE_SIZE);
 
-	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) =
-		(__u8) card->info.portno;
+	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) = (u8) card->dev->dev_port;
 	if (card->options.layer2)
 		if (card->info.type == QETH_CARD_TYPE_OSN)
 			prot_type = QETH_PROT_OSN2;
@@ -2918,7 +2917,7 @@ static void qeth_fill_ipacmd_header(struct qeth_card *card,
 	cmd->hdr.initiator = IPA_CMD_INITIATOR_HOST;
 	/* cmd->hdr.seqno is set by qeth_send_control_data() */
 	cmd->hdr.adapter_type = qeth_get_ipa_adp_type(card->info.link_type);
-	cmd->hdr.rel_adapter_no = (__u8) card->info.portno;
+	cmd->hdr.rel_adapter_no = (u8) card->dev->dev_port;
 	if (card->options.layer2)
 		cmd->hdr.prim_version_no = 2;
 	else
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 9bef19ed7e04..25d0be25bcb3 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -112,7 +112,7 @@ static ssize_t qeth_dev_portno_show(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	return sprintf(buf, "%i\n", card->info.portno);
+	return sprintf(buf, "%i\n", card->dev->dev_port);
 }
 
 static ssize_t qeth_dev_portno_store(struct device *dev,
@@ -143,7 +143,6 @@ static ssize_t qeth_dev_portno_store(struct device *dev,
 		rc = -EINVAL;
 		goto out;
 	}
-	card->info.portno = portno;
 	card->dev->dev_port = portno;
 out:
 	mutex_unlock(&card->conf_mutex);
-- 
2.16.4
