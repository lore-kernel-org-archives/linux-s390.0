Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/10] s390/qeth: enable only required csum offload features
Date: Tue, 12 Feb 2019 18:33:18 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Current code attempts to enable all advertised HW csum offload features.
Future-proof this by enabling only those features that we actually use.

Also, the IPv4 header csum feature is only needed for TX on L3 devices.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5f450df886c6..31720044656a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6329,8 +6329,11 @@ static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
 	struct qeth_checksum_cmd chksum_cb;
 	int rc;
 
-	if (prot == QETH_PROT_IPV4)
+	/* some L3 HW requires combined L3+L4 csum offload: */
+	if (IS_LAYER3(card) && prot == QETH_PROT_IPV4 &&
+	    cstype == IPA_OUTBOUND_CHECKSUM)
 		required_features |= QETH_IPA_CHECKSUM_IP_HDR;
+
 	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_START, 0,
 				       &chksum_cb, prot);
 	if (!rc) {
@@ -6351,8 +6354,12 @@ static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
 			 prot, QETH_CARD_IFNAME(card));
 		return rc;
 	}
+
+	if (chksum_cb.supported & QETH_IPA_CHECKSUM_LP2LP)
+		required_features |= QETH_IPA_CHECKSUM_LP2LP;
+
 	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_ENABLE,
-				       chksum_cb.supported, &chksum_cb,
+				       required_features, &chksum_cb,
 				       prot);
 	if (!rc) {
 		if ((required_features & chksum_cb.enabled) !=
-- 
2.16.4
