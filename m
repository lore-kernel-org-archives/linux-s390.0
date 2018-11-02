From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 5/6] s390/qeth: sanitize ARP requests
Date: Fri,  2 Nov 2018 19:04:12 +0100
Message-ID: <20181102180413.53020-6-jwi@linux.ibm.com>
References: <20181102180413.53020-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181102180413.53020-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The ARP_{ADD,REMOVE}_ENTRY cmd structs contain reserved fields.
Introduce a common helper that doesn't raw-copy the user-provided data
into the cmd, but only sets those fields that are strictly needed for
the command.

This also sets the correct command length for ARP_REMOVE_ENTRY.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  5 ---
 drivers/s390/net/qeth_core_main.c | 12 ++---
 drivers/s390/net/qeth_core_mpc.h  |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 94 +++++++++++----------------------------
 4 files changed, 34 insertions(+), 79 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 90cb213b0d55..04e294d1d16d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1046,11 +1046,6 @@ int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
 void qeth_trace_features(struct qeth_card *);
 void qeth_close_dev(struct qeth_card *);
-int qeth_send_setassparms(struct qeth_card *, struct qeth_cmd_buffer *, __u16,
-			  long,
-			  int (*reply_cb)(struct qeth_card *,
-					  struct qeth_reply *, unsigned long),
-			  void *);
 int qeth_setassparms_cb(struct qeth_card *, struct qeth_reply *, unsigned long);
 struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *,
 						 enum qeth_ipa_funcs,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index aed1a7961553..82282b2092d8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5477,11 +5477,12 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *card,
 }
 EXPORT_SYMBOL_GPL(qeth_get_setassparms_cmd);
 
-int qeth_send_setassparms(struct qeth_card *card,
-			  struct qeth_cmd_buffer *iob, __u16 len, long data,
-			  int (*reply_cb)(struct qeth_card *,
-					  struct qeth_reply *, unsigned long),
-			  void *reply_param)
+static int qeth_send_setassparms(struct qeth_card *card,
+				 struct qeth_cmd_buffer *iob, u16 len,
+				 long data, int (*reply_cb)(struct qeth_card *,
+							    struct qeth_reply *,
+							    unsigned long),
+				 void *reply_param)
 {
 	int rc;
 	struct qeth_ipa_cmd *cmd;
@@ -5497,7 +5498,6 @@ int qeth_send_setassparms(struct qeth_card *card,
 	rc = qeth_send_ipa_cmd(card, iob, reply_cb, reply_param);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(qeth_send_setassparms);
 
 int qeth_send_simple_setassparms_prot(struct qeth_card *card,
 				      enum qeth_ipa_funcs ipa_func,
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index e85090467afe..80c036acf563 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -436,7 +436,7 @@ struct qeth_ipacmd_setassparms {
 		__u32 flags_32bit;
 		struct qeth_ipa_caps caps;
 		struct qeth_checksum_cmd chksum;
-		struct qeth_arp_cache_entry add_arp_entry;
+		struct qeth_arp_cache_entry arp_entry;
 		struct qeth_arp_query_data query_arp;
 		struct qeth_tso_start_data tso;
 		__u8 ip[16];
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b26f7d7a2ca0..f08b745c2007 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1777,13 +1777,18 @@ static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
 	return rc;
 }
 
-static int qeth_l3_arp_add_entry(struct qeth_card *card,
-				struct qeth_arp_cache_entry *entry)
+static int qeth_l3_arp_modify_entry(struct qeth_card *card,
+				    struct qeth_arp_cache_entry *entry,
+				    enum qeth_arp_process_subcmds arp_cmd)
 {
+	struct qeth_arp_cache_entry *cmd_entry;
 	struct qeth_cmd_buffer *iob;
 	int rc;
 
-	QETH_CARD_TEXT(card, 3, "arpadent");
+	if (arp_cmd == IPA_CMD_ASS_ARP_ADD_ENTRY)
+		QETH_CARD_TEXT(card, 3, "arpadd");
+	else
+		QETH_CARD_TEXT(card, 3, "arpdel");
 
 	/*
 	 * currently GuestLAN only supports the ARP assist function
@@ -1796,54 +1801,19 @@ static int qeth_l3_arp_add_entry(struct qeth_card *card,
 		return -EOPNOTSUPP;
 	}
 
-	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING,
-				       IPA_CMD_ASS_ARP_ADD_ENTRY,
-				       sizeof(struct qeth_arp_cache_entry),
-				       QETH_PROT_IPV4);
+	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING, arp_cmd,
+				       sizeof(*cmd_entry), QETH_PROT_IPV4);
 	if (!iob)
 		return -ENOMEM;
-	rc = qeth_send_setassparms(card, iob,
-				   sizeof(struct qeth_arp_cache_entry),
-				   (unsigned long) entry,
-				   qeth_setassparms_cb, NULL);
-	if (rc)
-		QETH_DBF_MESSAGE(2, "Could not add ARP entry on device %x: %#x\n",
-				 CARD_DEVID(card), rc);
-	return qeth_l3_arp_makerc(rc);
-}
-
-static int qeth_l3_arp_remove_entry(struct qeth_card *card,
-				struct qeth_arp_cache_entry *entry)
-{
-	struct qeth_cmd_buffer *iob;
-	char buf[16] = {0, };
-	int rc;
 
-	QETH_CARD_TEXT(card, 3, "arprment");
-
-	/*
-	 * currently GuestLAN only supports the ARP assist function
-	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_REMOVE_ENTRY;
-	 * thus we say EOPNOTSUPP for this ARP function
-	 */
-	if (card->info.guestlan)
-		return -EOPNOTSUPP;
-	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
-		return -EOPNOTSUPP;
-	}
-	memcpy(buf, entry, 12);
-	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING,
-				       IPA_CMD_ASS_ARP_REMOVE_ENTRY,
-				       12,
-				       QETH_PROT_IPV4);
-	if (!iob)
-		return -ENOMEM;
-	rc = qeth_send_setassparms(card, iob,
-				   12, (unsigned long)buf,
-				   qeth_setassparms_cb, NULL);
+	cmd_entry = &__ipa_cmd(iob)->data.setassparms.data.arp_entry;
+	ether_addr_copy(cmd_entry->macaddr, entry->macaddr);
+	memcpy(cmd_entry->ipaddr, entry->ipaddr, 4);
+	rc = qeth_send_ipa_cmd(card, iob, qeth_setassparms_cb, NULL);
 	if (rc)
-		QETH_DBF_MESSAGE(2, "Could not delete ARP entry on device %x: %#x\n",
-				 CARD_DEVID(card), rc);
+		QETH_DBF_MESSAGE(2, "Could not modify (cmd: %#x) ARP entry on device %x: %#x\n",
+				 arp_cmd, CARD_DEVID(card), rc);
+
 	return qeth_l3_arp_makerc(rc);
 }
 
@@ -1875,6 +1845,7 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct qeth_card *card = dev->ml_priv;
 	struct qeth_arp_cache_entry arp_entry;
+	enum qeth_arp_process_subcmds arp_cmd;
 	int rc = 0;
 
 	switch (cmd) {
@@ -1893,27 +1864,16 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		rc = qeth_l3_arp_query(card, rq->ifr_ifru.ifru_data);
 		break;
 	case SIOC_QETH_ARP_ADD_ENTRY:
-		if (!capable(CAP_NET_ADMIN)) {
-			rc = -EPERM;
-			break;
-		}
-		if (copy_from_user(&arp_entry, rq->ifr_ifru.ifru_data,
-				   sizeof(struct qeth_arp_cache_entry)))
-			rc = -EFAULT;
-		else
-			rc = qeth_l3_arp_add_entry(card, &arp_entry);
-		break;
 	case SIOC_QETH_ARP_REMOVE_ENTRY:
-		if (!capable(CAP_NET_ADMIN)) {
-			rc = -EPERM;
-			break;
-		}
-		if (copy_from_user(&arp_entry, rq->ifr_ifru.ifru_data,
-				   sizeof(struct qeth_arp_cache_entry)))
-			rc = -EFAULT;
-		else
-			rc = qeth_l3_arp_remove_entry(card, &arp_entry);
-		break;
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (copy_from_user(&arp_entry, rq->ifr_data, sizeof(arp_entry)))
+			return -EFAULT;
+
+		arp_cmd = (cmd == SIOC_QETH_ARP_ADD_ENTRY) ?
+				IPA_CMD_ASS_ARP_ADD_ENTRY :
+				IPA_CMD_ASS_ARP_REMOVE_ENTRY;
+		return qeth_l3_arp_modify_entry(card, &arp_entry, arp_cmd);
 	case SIOC_QETH_ARP_FLUSH_CACHE:
 		if (!capable(CAP_NET_ADMIN)) {
 			rc = -EPERM;
-- 
2.16.4
