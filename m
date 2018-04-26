From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 12/13] s390/qeth: add IPv6 RX checksum offload support
Date: Thu, 26 Apr 2018 09:42:23 +0200
Message-ID: <20180426074224.100432-13-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

Check if a qeth device supports IPv6 RX checksum offload, and hook it up
into the existing NETIF_F_RXCSUM support.
As NETIF_F_RXCSUM is now backed by a combination of HW Assists, we need
to be a little smarter when dealing with errors during a configuration
change:
- switching on NETIF_F_RXCSUM only makes sense if at least one HW Assist
  was enabled successfully.
- for switching off NETIF_F_RXCSUM, all available HW Assists need to be
  deactivated.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 31 +++++++++++++++++++++++++++----
 drivers/s390/net/qeth_core_mpc.h  |  1 +
 drivers/s390/net/qeth_l2_main.c   |  9 +++++----
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 55b05d9c1cb6..06415b6a8f68 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6430,6 +6430,29 @@ static int qeth_set_ipa_tso(struct qeth_card *card, int on)
 	return rc;
 }
 
+static int qeth_set_ipa_rx_csum(struct qeth_card *card, bool on)
+{
+	int rc_ipv4 = (on) ? -EOPNOTSUPP : 0;
+	int rc_ipv6;
+
+	if (qeth_is_supported(card, IPA_INBOUND_CHECKSUM))
+		rc_ipv4 = qeth_set_ipa_csum(card, on, IPA_INBOUND_CHECKSUM,
+					    QETH_PROT_IPV4);
+	if (!qeth_is_supported6(card, IPA_INBOUND_CHECKSUM_V6))
+		/* no/one Offload Assist available, so the rc is trivial */
+		return rc_ipv4;
+
+	rc_ipv6 = qeth_set_ipa_csum(card, on, IPA_INBOUND_CHECKSUM,
+				    QETH_PROT_IPV6);
+
+	if (on)
+		/* enable: success if any Assist is active */
+		return (rc_ipv6) ? rc_ipv4 : 0;
+
+	/* disable: failure if any Assist is still active */
+	return (rc_ipv6) ? rc_ipv6 : rc_ipv4;
+}
+
 #define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO | \
 			  NETIF_F_IPV6_CSUM)
 /**
@@ -6477,9 +6500,8 @@ int qeth_set_features(struct net_device *dev, netdev_features_t features)
 		if (rc)
 			changed ^= NETIF_F_IPV6_CSUM;
 	}
-	if ((changed & NETIF_F_RXCSUM)) {
-		rc = qeth_set_ipa_csum(card, features & NETIF_F_RXCSUM,
-				       IPA_INBOUND_CHECKSUM, QETH_PROT_IPV4);
+	if (changed & NETIF_F_RXCSUM) {
+		rc = qeth_set_ipa_rx_csum(card, features & NETIF_F_RXCSUM);
 		if (rc)
 			changed ^= NETIF_F_RXCSUM;
 	}
@@ -6508,7 +6530,8 @@ netdev_features_t qeth_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_IP_CSUM;
 	if (!qeth_is_supported6(card, IPA_OUTBOUND_CHECKSUM_V6))
 		features &= ~NETIF_F_IPV6_CSUM;
-	if (!qeth_is_supported(card, IPA_INBOUND_CHECKSUM))
+	if (!qeth_is_supported(card, IPA_INBOUND_CHECKSUM) &&
+	    !qeth_is_supported6(card, IPA_INBOUND_CHECKSUM_V6))
 		features &= ~NETIF_F_RXCSUM;
 	if (!qeth_is_supported(card, IPA_OUTBOUND_TSO))
 		features &= ~NETIF_F_TSO;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index af3c35fbfa9e..878e62f35169 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -246,6 +246,7 @@ enum qeth_ipa_funcs {
 	IPA_QUERY_ARP_ASSIST	= 0x00040000L,
 	IPA_INBOUND_TSO         = 0x00080000L,
 	IPA_OUTBOUND_TSO        = 0x00100000L,
+	IPA_INBOUND_CHECKSUM_V6 = 0x00400000L,
 	IPA_OUTBOUND_CHECKSUM_V6 = 0x00800000L,
 };
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5b1780fa4cb5..810d69bd9991 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -992,15 +992,16 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 			card->dev->hw_features |= NETIF_F_IP_CSUM;
 			card->dev->vlan_features |= NETIF_F_IP_CSUM;
 		}
-		if (qeth_is_supported(card, IPA_INBOUND_CHECKSUM)) {
-			card->dev->hw_features |= NETIF_F_RXCSUM;
-			card->dev->vlan_features |= NETIF_F_RXCSUM;
-		}
 	}
 	if (qeth_is_supported6(card, IPA_OUTBOUND_CHECKSUM_V6)) {
 		card->dev->hw_features |= NETIF_F_IPV6_CSUM;
 		card->dev->vlan_features |= NETIF_F_IPV6_CSUM;
 	}
+	if (qeth_is_supported(card, IPA_INBOUND_CHECKSUM) ||
+	    qeth_is_supported6(card, IPA_INBOUND_CHECKSUM_V6)) {
+		card->dev->hw_features |= NETIF_F_RXCSUM;
+		card->dev->vlan_features |= NETIF_F_RXCSUM;
+	}
 
 	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
-- 
2.13.5
