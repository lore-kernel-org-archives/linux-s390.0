From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/13] s390/qeth: extend Checksum Offload Assists for IPv6
Date: Thu, 26 Apr 2018 09:42:21 +0200
Message-ID: <20180426074224.100432-11-jwi@linux.ibm.com>
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

Add some wrappers to make the protocol-specific Assist code a little
more generic, and use them for sending protocol-agnostic commands in
the Checksum Offload Assist code.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 23 ++++++++++++--
 drivers/s390/net/qeth_core_main.c | 65 +++++++++++++++++++++------------------
 drivers/s390/net/qeth_l3_main.c   | 24 +++------------
 3 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index e8108f6891b2..7cbc9bf5d6b0 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -900,6 +900,27 @@ static inline int qeth_is_diagass_supported(struct qeth_card *card,
 	return card->info.diagass_support & (__u32)cmd;
 }
 
+int qeth_send_simple_setassparms_prot(struct qeth_card *card,
+				      enum qeth_ipa_funcs ipa_func,
+				      u16 cmd_code, long data,
+				      enum qeth_prot_versions prot);
+/* IPv4 variant */
+static inline int qeth_send_simple_setassparms(struct qeth_card *card,
+					       enum qeth_ipa_funcs ipa_func,
+					       u16 cmd_code, long data)
+{
+	return qeth_send_simple_setassparms_prot(card, ipa_func, cmd_code,
+						 data, QETH_PROT_IPV4);
+}
+
+static inline int qeth_send_simple_setassparms_v6(struct qeth_card *card,
+						  enum qeth_ipa_funcs ipa_func,
+						  u16 cmd_code, long data)
+{
+	return qeth_send_simple_setassparms_prot(card, ipa_func, cmd_code,
+						 data, QETH_PROT_IPV6);
+}
+
 extern struct qeth_discipline qeth_l2_discipline;
 extern struct qeth_discipline qeth_l3_discipline;
 extern const struct attribute_group *qeth_generic_attr_groups[];
@@ -994,8 +1015,6 @@ int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
 int qeth_query_ipassists(struct qeth_card *, enum qeth_prot_versions prot);
 void qeth_trace_features(struct qeth_card *);
 void qeth_close_dev(struct qeth_card *);
-int qeth_send_simple_setassparms(struct qeth_card *, enum qeth_ipa_funcs,
-				 __u16, long);
 int qeth_send_setassparms(struct qeth_card *, struct qeth_cmd_buffer *, __u16,
 			  long,
 			  int (*reply_cb)(struct qeth_card *,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9ec1bb7f8b84..5e4a509822f1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5513,26 +5513,26 @@ int qeth_send_setassparms(struct qeth_card *card,
 }
 EXPORT_SYMBOL_GPL(qeth_send_setassparms);
 
-int qeth_send_simple_setassparms(struct qeth_card *card,
-				 enum qeth_ipa_funcs ipa_func,
-				 __u16 cmd_code, long data)
+int qeth_send_simple_setassparms_prot(struct qeth_card *card,
+				      enum qeth_ipa_funcs ipa_func,
+				      u16 cmd_code, long data,
+				      enum qeth_prot_versions prot)
 {
 	int rc;
 	int length = 0;
 	struct qeth_cmd_buffer *iob;
 
-	QETH_CARD_TEXT(card, 4, "simassp4");
+	QETH_CARD_TEXT_(card, 4, "simassp%i", prot);
 	if (data)
 		length = sizeof(__u32);
-	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code,
-				       length, QETH_PROT_IPV4);
+	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code, length, prot);
 	if (!iob)
 		return -ENOMEM;
 	rc = qeth_send_setassparms(card, iob, length, data,
 				   qeth_setassparms_cb, NULL);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(qeth_send_simple_setassparms);
+EXPORT_SYMBOL_GPL(qeth_send_simple_setassparms_prot);
 
 static void qeth_unregister_dbf_views(void)
 {
@@ -6330,14 +6330,15 @@ static int qeth_ipa_checksum_run_cmd_cb(struct qeth_card *card,
 static int qeth_ipa_checksum_run_cmd(struct qeth_card *card,
 				     enum qeth_ipa_funcs ipa_func,
 				     __u16 cmd_code, long data,
-				     struct qeth_checksum_cmd *chksum_cb)
+				     struct qeth_checksum_cmd *chksum_cb,
+				     enum qeth_prot_versions prot)
 {
 	struct qeth_cmd_buffer *iob;
 	int rc = -ENOMEM;
 
 	QETH_CARD_TEXT(card, 4, "chkdocmd");
 	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code,
-				       sizeof(__u32), QETH_PROT_IPV4);
+				       sizeof(__u32), prot);
 	if (iob)
 		rc = qeth_send_setassparms(card, iob, sizeof(__u32), data,
 					   qeth_ipa_checksum_run_cmd_cb,
@@ -6345,7 +6346,8 @@ static int qeth_ipa_checksum_run_cmd(struct qeth_card *card,
 	return rc;
 }
 
-static int qeth_send_checksum_on(struct qeth_card *card, int cstype)
+static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
+				 enum qeth_prot_versions prot)
 {
 	const __u32 required_features = QETH_IPA_CHECKSUM_IP_HDR |
 					QETH_IPA_CHECKSUM_UDP |
@@ -6354,7 +6356,7 @@ static int qeth_send_checksum_on(struct qeth_card *card, int cstype)
 	int rc;
 
 	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_START, 0,
-				       &chksum_cb);
+				       &chksum_cb, prot);
 	if (!rc) {
 		if ((required_features & chksum_cb.supported) !=
 		    required_features)
@@ -6366,37 +6368,42 @@ static int qeth_send_checksum_on(struct qeth_card *card, int cstype)
 				 QETH_CARD_IFNAME(card));
 	}
 	if (rc) {
-		qeth_send_simple_setassparms(card, cstype, IPA_CMD_ASS_STOP, 0);
+		qeth_send_simple_setassparms_prot(card, cstype,
+						  IPA_CMD_ASS_STOP, 0, prot);
 		dev_warn(&card->gdev->dev,
-			 "Starting HW checksumming for %s failed, using SW checksumming\n",
-			 QETH_CARD_IFNAME(card));
+			 "Starting HW IPv%d checksumming for %s failed, using SW checksumming\n",
+			 prot, QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_ENABLE,
-				       chksum_cb.supported, &chksum_cb);
+				       chksum_cb.supported, &chksum_cb,
+				       prot);
 	if (!rc) {
 		if ((required_features & chksum_cb.enabled) !=
 		    required_features)
 			rc = -EIO;
 	}
 	if (rc) {
-		qeth_send_simple_setassparms(card, cstype, IPA_CMD_ASS_STOP, 0);
+		qeth_send_simple_setassparms_prot(card, cstype,
+						  IPA_CMD_ASS_STOP, 0, prot);
 		dev_warn(&card->gdev->dev,
-			 "Enabling HW checksumming for %s failed, using SW checksumming\n",
-			 QETH_CARD_IFNAME(card));
+			 "Enabling HW IPv%d checksumming for %s failed, using SW checksumming\n",
+			 prot, QETH_CARD_IFNAME(card));
 		return rc;
 	}
 
-	dev_info(&card->gdev->dev, "HW Checksumming (%sbound) enabled\n",
-		 cstype == IPA_INBOUND_CHECKSUM ? "in" : "out");
+	dev_info(&card->gdev->dev, "HW Checksumming (%sbound IPv%d) enabled\n",
+		 cstype == IPA_INBOUND_CHECKSUM ? "in" : "out", prot);
 	return 0;
 }
 
-static int qeth_set_ipa_csum(struct qeth_card *card, int on, int cstype)
+static int qeth_set_ipa_csum(struct qeth_card *card, bool on, int cstype,
+			     enum qeth_prot_versions prot)
 {
-	int rc = (on) ? qeth_send_checksum_on(card, cstype)
-		      : qeth_send_simple_setassparms(card, cstype,
-						     IPA_CMD_ASS_STOP, 0);
+	int rc = (on) ? qeth_send_checksum_on(card, cstype, prot)
+		      : qeth_send_simple_setassparms_prot(card, cstype,
+							  IPA_CMD_ASS_STOP, 0,
+							  prot);
 	return rc ? -EIO : 0;
 }
 
@@ -6459,16 +6466,14 @@ int qeth_set_features(struct net_device *dev, netdev_features_t features)
 	QETH_DBF_HEX(SETUP, 2, &features, sizeof(features));
 
 	if ((changed & NETIF_F_IP_CSUM)) {
-		rc = qeth_set_ipa_csum(card,
-				       features & NETIF_F_IP_CSUM ? 1 : 0,
-				       IPA_OUTBOUND_CHECKSUM);
+		rc = qeth_set_ipa_csum(card, features & NETIF_F_IP_CSUM,
+				       IPA_OUTBOUND_CHECKSUM, QETH_PROT_IPV4);
 		if (rc)
 			changed ^= NETIF_F_IP_CSUM;
 	}
 	if ((changed & NETIF_F_RXCSUM)) {
-		rc = qeth_set_ipa_csum(card,
-					features & NETIF_F_RXCSUM ? 1 : 0,
-					IPA_INBOUND_CHECKSUM);
+		rc = qeth_set_ipa_csum(card, features & NETIF_F_RXCSUM,
+				       IPA_INBOUND_CHECKSUM, QETH_PROT_IPV4);
 		if (rc)
 			changed ^= NETIF_F_RXCSUM;
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 9d9c743e7433..dd233fe3d6c4 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -735,22 +735,6 @@ static int qeth_l3_setadapter_parms(struct qeth_card *card)
 	return rc;
 }
 
-static int qeth_l3_send_simple_setassparms_ipv6(struct qeth_card *card,
-		enum qeth_ipa_funcs ipa_func, __u16 cmd_code)
-{
-	int rc;
-	struct qeth_cmd_buffer *iob;
-
-	QETH_CARD_TEXT(card, 4, "simassp6");
-	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code,
-				       0, QETH_PROT_IPV6);
-	if (!iob)
-		return -ENOMEM;
-	rc = qeth_send_setassparms(card, iob, 0, 0,
-				   qeth_setassparms_cb, NULL);
-	return rc;
-}
-
 static int qeth_l3_start_ipa_arp_processing(struct qeth_card *card)
 {
 	int rc;
@@ -862,16 +846,16 @@ static int qeth_l3_softsetup_ipv6(struct qeth_card *card)
 			QETH_CARD_IFNAME(card));
 		return rc;
 	}
-	rc = qeth_l3_send_simple_setassparms_ipv6(card, IPA_IPV6,
-					       IPA_CMD_ASS_START);
+	rc = qeth_send_simple_setassparms_v6(card, IPA_IPV6,
+					     IPA_CMD_ASS_START, 0);
 	if (rc) {
 		dev_err(&card->gdev->dev,
 			"Activating IPv6 support for %s failed\n",
 			 QETH_CARD_IFNAME(card));
 		return rc;
 	}
-	rc = qeth_l3_send_simple_setassparms_ipv6(card, IPA_PASSTHRU,
-					       IPA_CMD_ASS_START);
+	rc = qeth_send_simple_setassparms_v6(card, IPA_PASSTHRU,
+					     IPA_CMD_ASS_START, 0);
 	if (rc) {
 		dev_warn(&card->gdev->dev,
 			"Enabling the passthrough mode for %s failed\n",
-- 
2.13.5
