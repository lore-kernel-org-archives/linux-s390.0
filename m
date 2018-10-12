From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/4] s390/qeth: make TSO controls protocol-agnostic
Date: Fri, 12 Oct 2018 17:27:12 +0200
Message-ID: <20181012152715.6153-2-jwi@linux.ibm.com>
References: <20181012152715.6153-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181012152715.6153-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

In preparation for IPv6 TSO, turn the protocol version into a parameter
for the TSO control code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 41 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 1771d0073c0c..92e539d1fbd3 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6396,27 +6396,27 @@ static int qeth_set_ipa_csum(struct qeth_card *card, bool on, int cstype,
 	return rc ? -EIO : 0;
 }
 
-static int qeth_set_ipa_tso(struct qeth_card *card, int on)
+static int qeth_set_tso_off(struct qeth_card *card,
+			    enum qeth_prot_versions prot)
 {
-	int rc;
+	return qeth_send_simple_setassparms_prot(card, IPA_OUTBOUND_TSO,
+						 IPA_CMD_ASS_STOP, 0, prot);
+}
 
-	QETH_CARD_TEXT(card, 3, "sttso");
+static int qeth_set_tso_on(struct qeth_card *card,
+			   enum qeth_prot_versions prot)
+{
+	return qeth_send_simple_setassparms_prot(card, IPA_OUTBOUND_TSO,
+						 IPA_CMD_ASS_START, 0, prot);
+}
 
-	if (on) {
-		rc = qeth_send_simple_setassparms(card, IPA_OUTBOUND_TSO,
-						  IPA_CMD_ASS_START, 0);
-		if (rc) {
-			dev_warn(&card->gdev->dev,
-				 "Starting outbound TCP segmentation offload for %s failed\n",
-				 QETH_CARD_IFNAME(card));
-			return -EIO;
-		}
-		dev_info(&card->gdev->dev, "Outbound TSO enabled\n");
-	} else {
-		rc = qeth_send_simple_setassparms(card, IPA_OUTBOUND_TSO,
-						  IPA_CMD_ASS_STOP, 0);
-	}
-	return rc;
+static int qeth_set_ipa_tso(struct qeth_card *card, bool on,
+			    enum qeth_prot_versions prot)
+{
+	int rc = on ? qeth_set_tso_on(card, prot) :
+		      qeth_set_tso_off(card, prot);
+
+	return rc ? -EIO : 0;
 }
 
 static int qeth_set_ipa_rx_csum(struct qeth_card *card, bool on)
@@ -6493,8 +6493,9 @@ int qeth_set_features(struct net_device *dev, netdev_features_t features)
 		if (rc)
 			changed ^= NETIF_F_RXCSUM;
 	}
-	if ((changed & NETIF_F_TSO)) {
-		rc = qeth_set_ipa_tso(card, features & NETIF_F_TSO ? 1 : 0);
+	if (changed & NETIF_F_TSO) {
+		rc = qeth_set_ipa_tso(card, features & NETIF_F_TSO,
+				      QETH_PROT_IPV4);
 		if (rc)
 			changed ^= NETIF_F_TSO;
 	}
-- 
2.16.4
